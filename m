Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6AAC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C3B2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBVPE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:04:28 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40554 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfBVPEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:04:25 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A89612000AA;
        Fri, 22 Feb 2019 16:04:22 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A289200036;
        Fri, 22 Feb 2019 16:04:22 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EE442062B;
        Fri, 22 Feb 2019 16:04:22 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     alexandru.marginean@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] dt-bindings: net: freescale: enetc: Add connection bindings for ENETC ethernet nodes
Date:   Fri, 22 Feb 2019 17:04:19 +0200
Message-Id: <1550847859-17346-5-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
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

 .../devicetree/bindings/net/fsl-enetc.txt          | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt

diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
new file mode 100644
index 0000000..2fbb998
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
@@ -0,0 +1,109 @@
+* ENETC ethernet nodes - external connection bindings
+
+The ENETC ethernet controllers are PCIe integrated endpoints
+(IEPs), on-chip devices discoverable as standard PCIe endpoints,
+integrated into Freescale SoCs.  The ENETC devices are self
+contained, the information needed for device initialization
+is available in hardware (PCIe ECAM area).  However, depending
+on board design, their external connections are configurable.
+As usual for SoCs, device tree nodes may be used to define these
+external connections.  The rest of the document specifies how
+external connections for ENETC ethernet controllers may be
+defined via device tree nodes.
+
+Silicon (SoC) availability (<SoC name>: <SoC DT path/name>)
+	- LS1028A: [arch/arm64]	[...]freescale/fsl-ls1028a.dtsi
+
+
+* ENETC nodes
+
+Defined in the SoC device tree as "pci" child nodes of the
+"pci-host-ecam-generic" compatible "pcie" parent node also known
+as the Integrated Endpoint Root Complex (IERC) SoC node.
+
+Structure - example (LS1028A):
+
+	pcie@1f0000000 {
+		compatible = "pci-host-ecam-generic";
+		device_type = "pci";
+		...
+		enetc_port0: pci@0,0 {
+			reg = <0x000000 0 0 0 0>;
+		};
+		enetc_port1: pci@0,1 {
+			reg = <0x000100 0 0 0 0>;
+		};
+		...
+	}
+
+Each ENETC node has a device number and a function number (expressed
+by its "reg" property and pci node name, i.e. "pci@0,1" represents
+device number 0 and functions number 1).  Only the standard pci "reg"
+property is needed here.
+For easy reference, each ENETC node is tagged by a handle having the
+following format:
+
+	"enetc_port<idx>"   where, idx = 0 .. n-1;
+			    n - #of available ENETC nodes (Ports) on
+				the given SoC.
+
+NOTES
+i. The SoC H/W Reference Manual provides a mapping of the ENETC Port
+numbers to the PCIe Device Number/ Function Number.
+Example (LS1028):
+	All ENETC PFs (PCIe Physical Functions) have Device Number 0.
+	Port 0 - PF0 (pci@0,0)
+	Port 1 - PF1 (pci@0,1)
+	Port 2 - PF2 (pci@0,2)
+	Port 3 - PF6 (pci@0,6)
+
+ii. The SoC H/W Reference Manual also defines which ENETC Ports may have
+external connections (external ports) and which ones are internally
+connected to a on-chip L2 switch for instance (internal ports).
+
+
+* Defining connections for ENETC nodes
+
+To define external connections for the external ENETC Ports on a given
+board/platform, the board device tree should include the SoC device tree
+and reference the external ports by their "enetc_port<idx>" handle.
+
+Following cases arise, defining all possible connection bindings:
+
+1) The ENETC Port is connected to a MDIO configurable PHY:
+
+	In this case, the ENETC node should include a "mdio" sub-node
+	that in turn should contain the "phy" node describing the
+	external phy.  ENETC Port node structure (example):
+
+	&enetc_port0 {
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
+	All properties are mandatory for this case, their bindings already
+	defined (see ethernet.txt and phy.txt).
+
+2) The ENETC Port has a fixed-link connection:
+
+	In this case, the ENETC Port node defines a fixed link connection,
+	with the following structure (example):
+
+	&enetc_port2 {
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+		};
+	};
+
+	The "fixed-link" node properties are standard (as defined in
+	fixed-link.txt).
+	This connection type also applies to the internal ENETC Ports.
-- 
2.7.4

