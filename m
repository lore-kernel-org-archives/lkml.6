Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC18CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8462D20659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8462D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438874AbeKWHpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:45:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39414 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438844AbeKWHpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:45:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 620D420DC1; Thu, 22 Nov 2018 22:04:25 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id A93392072F;
        Thu, 22 Nov 2018 22:04:24 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/6] dt-bindings: phy: mvebu-comphy: extend the file to describe a3700 bindings
Date:   Thu, 22 Nov 2018 22:04:17 +0100
Message-Id: <20181122210420.14861-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122210420.14861-1-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current file describe COMPHY bindings for the IP available on the
CP110 of Armada 7k/8k. Bindings are very close (and serve the same
purpose) as the new Armada 3700 COMPHY driver so update this file to
describe both. Also add an example of how to use this second
compatible (same as for the ESPRESSObin).

While doing so, enhance a bit the file by adding upper case where
needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/phy/phy-mvebu-comphy.txt         | 65 +++++++++++++++----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
index bfcf80341657..cf2cd86db267 100644
--- a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
@@ -1,16 +1,27 @@
-mvebu comphy driver
--------------------
+MVEBU comphy drivers
+--------------------
 
-A comphy controller can be found on Marvell Armada 7k/8k on the CP110. It
-provides a number of shared PHYs used by various interfaces (network, sata,
-usb, PCIe...).
+COMPHY controllers can be found on the following Marvell MVEBU SoCs:
+* Armada 7k/8k (on the CP110)
+* Armada 3700
+It provides a number of shared PHYs used by various interfaces (network, SATA,
+USB, PCIe...).
 
 Required properties:
 
-- compatible: should be "marvell,comphy-cp110"
-- reg: should contain the comphy register location and length.
-- marvell,system-controller: should contain a phandle to the
-                             system controller node.
+- compatible: should be one of:
+  * "marvell,comphy-cp110" for Armada 7k/8k
+  * "marvell,comphy-a3700" for Armada 3700
+- reg: should contain the COMPHY register(s) location(s) and length(s).
+  * 1 entry for Armada 7k/8k
+  * 4 entries for Armada 3700 along with the corresponding reg-names
+    properties, memory areas are:
+    * Generic COMPHY registers
+    * Lane 1 (PCIe/GbE)
+    * Lane 0 (USB3/GbE)
+    * Lane 2 (SATA/USB3)
+- marvell,system-controller: should contain a phandle to the system
+			     controller node (only for Armada 7k/8k)
 - #address-cells: should be 1.
 - #size-cells: should be 0.
 
@@ -18,11 +29,11 @@ A sub-node is required for each comphy lane provided by the comphy.
 
 Required properties (child nodes):
 
-- reg: comphy lane number.
-- #phy-cells : from the generic phy bindings, must be 1. Defines the
+- reg: COMPHY lane number.
+- #phy-cells : from the generic PHY bindings, must be 1. Defines the
                input port to use for a given comphy lane.
 
-Example:
+Examples:
 
 	cpm_comphy: phy@120000 {
 		compatible = "marvell,comphy-cp110";
@@ -41,3 +52,33 @@ Example:
 			#phy-cells = <1>;
 		};
 	};
+
+	comphy: phy@18300 {
+		compatible = "marvell,comphy-a3700";
+		reg = <0x18300 0x300>,
+		<0x1F000 0x400>,
+		<0x5C000 0x400>,
+		<0xe0178 0x8>;
+		reg-names = "comphy",
+		"lane1_pcie_gbe",
+		"lane0_usb3_gbe",
+		"lane2_sata_usb3";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+
+		comphy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+
+		comphy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <1>;
+		};
+
+		comphy2: phy@2 {
+			reg = <2>;
+			#phy-cells = <1>;
+		};
+	};
-- 
2.19.1

