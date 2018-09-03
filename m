Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338D9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75EF2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75EF2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeICNxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:53:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbeICNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:53:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 350E922A40; Mon,  3 Sep 2018 11:33:54 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03B0C22A44;
        Mon,  3 Sep 2018 11:33:25 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v2 07/11] dt-bindings: phy: add DT binding for Microsemi Ocelot SerDes muxing
Date:   Mon,  3 Sep 2018 11:33:04 +0200
Message-Id: <20180903093308.24366-8-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903093308.24366-1-quentin.schulz@bootlin.com>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 .../bindings/phy/phy-ocelot-serdes.txt        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
new file mode 100644
index 000000000000..2a88cc346162
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
@@ -0,0 +1,40 @@
+Microsemi Ocelot SerDes muxing driver
+-------------------------------------
+
+On Microsemi Ocelot, there is a handful of registers in HSIO address
+space for setting up the SerDes to switch port muxing.
+
+A SerDes X can be "muxed" to work with switch port Y or Z for example.
+One specific SerDes can also be used as a PCIe interface.
+
+Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
+
+There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
+half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
+10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
+
+Also, SERDES6G number (aka "macro") 0 is the only interface supporting
+QSGMII.
+
+Required properties:
+
+- compatible: should be "mscc,vsc7514-serdes"
+- #phy-cells : from the generic phy bindings, must be 2.
+	       The first number defines the input port to use for a given
+	       SerDes macro. The second defines the macro to use. They are
+	       defined in dt-bindings/phy/phy-ocelot-serdes.h
+
+Example:
+
+	serdes: serdes {
+		compatible = "mscc,vsc7514-serdes";
+		#phy-cells = <2>;
+	};
+
+	ethernet {
+		port1 {
+			phy-handle = <&phy_foo>;
+			/* Link SERDES1G_5 to port1 */
+			phys = <&serdes 1 SERDES1G_5>;
+		};
+	};
-- 
2.17.1

