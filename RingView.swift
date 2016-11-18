//
//  RingView.swift
//
//  Created by Ryan Han on 11/17/16.
//  Copyright © 2016 trick14@gmail.com. All rights reserved.
//

import UIKit

class RingView: UIView {
    var depth: CGFloat = 1
    var fromColor: UIColor = UIColor.black
    var toColor: UIColor = UIColor.black
    
    // dx and dy of from and to must be between 0-1
    var from: CGVector = CGVector.zero
    var to: CGVector = CGVector(dx: 1.0, dy: 1.0)
    
    convenience init(frame: CGRect, depth: CGFloat, fromColor: UIColor, toColor: UIColor, from: CGVector, to: CGVector) {
        self.init(frame: frame)
        self.depth = depth
        self.fromColor = fromColor
        self.toColor = toColor
        self.from = from
        self.to = to
        
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let outerRadius: CGFloat = bounds.size.width / 2 - depth / 2
        let kCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        let context = UIGraphicsGetCurrentContext()!
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        context.setLineWidth(depth)
        context.setLineJoin(.round)
        context.setLineCap(.round)
        
        let outer = UIBezierPath(arcCenter: kCenter,
                                 radius: outerRadius,
                                 startAngle: 0,
                                 endAngle: 2.0 * CGFloat(M_PI),
                                 clockwise: true)
        context.addPath(outer.cgPath)
        context.saveGState()
        context.replacePathWithStrokedPath()
        context.clip()
        
        let colors = [fromColor.cgColor, toColor.cgColor]
        let location: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: location)!
        
        context.drawLinearGradient(gradient,
                                   start: CGPoint(x: bounds.size.width * from.dx, y: bounds.size.height * from.dy),
                                   end: CGPoint(x: bounds.size.width * to.dx, y: bounds.size.height * to.dy),
                                   options: [])
        
        context.restoreGState()
        context.fillPath()
    }
}
