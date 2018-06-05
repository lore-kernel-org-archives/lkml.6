Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeFEGRm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:17:42 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:42687 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeFEGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:48 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 5/8] dt-bindings: mailbox: ti,message-manager: Add support for secure proxy threads
Date: Tue, 5 Jun 2018 01:16:26 -0500
Message-ID: <20180605061629.4759-6-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure Proxy is another communication scheme in Texas Instrument's
devices intended to provide an unique communication path from various
processors in the System on Chip(SoC) to a central System Controller.

Secure proxy is, in effect, an evolution of current generation Message
Manager hardware block found in K2G devices. However the following
changes have taken place:

Secure Proxy instance exposes "threads" or "proxies" which is
primary representation of "a" communication channel. Each thread is
preconfigured by System controller configuration based on SoC usage
requirements. Secure proxy by itself represents a single "queue" of
communication but allows the proxies to be independently operated.

Each Secure proxy thread can uniquely have their own error and threshold
interrupts allowing for more fine control of IRQ handling.

Provide an hardware description of the same for device tree
representation.

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/mailbox/ti,message-manager.txt        | 58 +++++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
index ebf0e3710cee..de796e90cac6 100644
--- a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
+++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
@@ -7,22 +7,40 @@ manager is broken up into queues in different address regions that are called
 "proxies" - each instance is unidirectional and is instantiated at SoC
 integration level to indicate receive or transmit path.
 
+This can also be used to describe Texas Instrument's Secure Proxy
+controller that allows for individually configurable "threads" or
+"proxies" which allow for independent communication scheme.
+
 Message Manager Device Node:
 ===========================
 Required properties:
 --------------------
-- compatible:		Shall be: "ti,k2g-message-manager"
-- reg-names 		queue_proxy_region - Map the queue proxy region.
-			queue_state_debug_region - Map the queue state debug
-			region.
+- compatible:		Shall be one of: "ti,k2g-message-manager",
+			"ti,am654-secure-proxy"
+- reg-names 		for ti,k2g-message-manager, the following shall exist:
+				queue_proxy_region - Map the queue proxy region.
+				queue_state_debug_region - Map the queue state
+					debug region.
+			for ti,am654-secure-proxy, the following shall exist:
+				target_data - Map the proxy data region
+				rt - Map the realtime status region
+				scfg - Map the configuration region
 - reg:			Contains the register map per reg-names.
-- #mbox-cells		Shall be 2. Contains the queue ID and proxy ID in that
-		        order referring to the transfer path.
+- #mbox-cells		for ti,k2g-message-manager, Shall be 2. Contains the
+			queue ID and proxy ID in the following order referring
+			to the transfer path:
+				queue_proxy_region - Map the queue proxy region.
+				queue_state_debug_region - Map the queue state
+					debug region.
+			for ti,am654-secure-proxy, Shall be 1 and shall refer
+		        to the transfer path called thread.
 - interrupt-names:	Contains interrupt names matching the rx transfer path
 			for a given SoC. Receive interrupts shall be of the
-			format: "rx_<QID>".
-			For ti,k2g-message-manager, this shall contain:
+			format:
+			For ti,k2g-message-manager, this shall be: "rx_<QID>"
+			and shall contain:
 				"rx_005", "rx_057"
+			for ti,am654-secure-proxy, this shall be: "rx_<PID>".
 - interrupts:		Contains the interrupt information corresponding to
 			interrupt-names property.
 
@@ -48,3 +66,27 @@ Example(K2G):
 			<&msgmgr 0 0>;
 		[...]
 	};
+
+Example(AM654):
+------------
+
+	secure_proxy: secure_proxy@32c00000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x32c00000 0x0 0x100000>,
+		      <0x0 0x32400000 0x0 0x100000>,
+		      <0x0 0x32800000 0x0 0x100000>;
+		interrupt-names = "rx_011";
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	dmsc: dmsc {
+		[...]
+		mbox-names = "rx", "tx";
+		# RX Thread ID is 11
+		# TX Thread ID is 13
+		mboxes= <&secure_proxy 11>,
+			<&secure_proxy 13>;
+		[...]
+	};
-- 
2.15.1
