Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2786C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCC2217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfBZNme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:42:34 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41376 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfBZNm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:42:28 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 894DF1A0171;
        Tue, 26 Feb 2019 14:42:26 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CBD31A02F2;
        Tue, 26 Feb 2019 14:42:26 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F33F205EB;
        Tue, 26 Feb 2019 14:42:26 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     alexandru.marginean@nxp.com, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 4/4] dt-bindings: net: freescale: enetc: Add connection bindings for ENETC ethernet nodes
Date:   Tue, 26 Feb 2019 15:42:23 +0200
Message-Id: <1551188543-28867-5-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
References: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define connection bindings (external PHY connections and internal links)
for the ENETC on-chip ethernet controllers.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v3 - added this patch to the set
v4 - documented strictly the enetc node bindings, changed node type
     from "pci" to "ethernet" and added compatible string (Rob H.)

 .../devicetree/bindings/net/fsl-enetc.txt          | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt

diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
new file mode 100644
index 0000000..c812e25
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
@@ -0,0 +1,69 @@
+* ENETC ethernet device tree bindings
+
+Depending on board design and ENETC port type (internal or
+external) there are two supported link modes specified by
+below device tree bindings.
+
+Required properties:
+
+- reg		: Specifies PCIe Device Number and Function
+		  Number of the ENETC endpoint device, according
+		  to parent node bindings.
+- compatible	: Should be "fsl,enetc".
+
+1) The ENETC external port is connected to a MDIO configurable phy:
+
+In this case, the ENETC node should include a "mdio" sub-node
+that in turn should contain the "ethernet-phy" node describing the
+external phy.  Below properties are required, their bindings
+already defined in ethernet.txt or phy.txt, under
+Documentation/devicetree/bindings/net/*.
+
+Required:
+
+- phy-handle		: Phandle to a PHY on the MDIO bus.
+			  Defined in ethernet.txt.
+
+- phy-connection-type	: Defined in ethernet.txt.
+
+- mdio			: "mdio" node, defined in mdio.txt.
+
+- ethernet-phy		: "ethernet-phy" node, defined in phy.txt.
+
+Example:
+
+	ethernet@0,0 {
+		compatible = "fsl,enetc";
+		reg = <0x000000 0 0 0 0>;
+		phy-handle = <&sgmii_phy0>;
+		phy-connection-type = "sgmii";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			sgmii_phy0: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+		};
+	};
+
+2) The ENETC port is an internal port or has a fixed-link external
+connection:
+
+In this case, the ENETC port node defines a fixed link connection,
+as specified by "fixed-link.txt", under
+Documentation/devicetree/bindings/net/*.
+
+Required:
+
+- fixed-link	: "fixed-link" node, defined in "fixed-link.txt".
+
+Example:
+	ethernet@0,2 {
+		compatible = "fsl,enetc";
+		reg = <0x000200 0 0 0 0>;
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+		};
+	};
-- 
2.7.4

