//
//  Connector.swift
//  Todo
//
//  Created by 김유림 on 2022/10/05.
//  Copyright © 2022 Brian Advent. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Connector: NSObject, MCSessionDelegate {
    let serviceName = "foobar"
    
    var peerID: MCPeerID!
    var session: MCSession!
    var advertiserAssistant: MCAdvertiserAssistant!
    var receiveHandler: ((Data) -> ())? = nil
    
    override init() {
        super.init()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
    }
    
    func start() {
        advertiserAssistant = MCAdvertiserAssistant(serviceType: serviceName, discoveryInfo: nil, session: session)
        advertiserAssistant.start()
    }
    
    // MARK: - MCSessionDelegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        receiveHandler?(data)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
