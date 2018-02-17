Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeBQTzN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:55:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14702 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751280AbeBQTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:09 -0500
X-UUID: 6c6a3422872544dd83fd073285ace98f-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 10/15] arm64: dts: mt7622: add ethernet device nodes
Date: Sun, 18 Feb 2018 03:54:45 +0800
Message-ID: <c53c28525ef104c6d3c54d2538e771afdf8c836a.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add ethernet device nodes which enable GMAC1 with SGMII interface

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 22 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 31 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 48c5ba4..e2bd93e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -249,6 +249,28 @@
 	status = "okay";
 };
 
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth_pins>;
+	status = "okay";
+
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy5: ethernet-phy@5 {
+			reg = <5>;
+			phy-mode = "sgmii";
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index d287d75..95f947e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -550,6 +550,37 @@
 		#reset-cells = <1>;
 	};
 
+	eth: ethernet@1b100000 {
+		compatible = "mediatek,mt7622-eth",
+			     "mediatek,mt2701-eth",
+			     "syscon";
+		reg = <0 0x1b100000 0 0x20000>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 225 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETH_SEL>,
+			 <&ethsys CLK_ETH_ESW_EN>,
+			 <&ethsys CLK_ETH_GP0_EN>,
+			 <&ethsys CLK_ETH_GP1_EN>,
+			 <&ethsys CLK_ETH_GP2_EN>,
+			 <&sgmiisys CLK_SGMII_TX250M_EN>,
+			 <&sgmiisys CLK_SGMII_RX250M_EN>,
+			 <&sgmiisys CLK_SGMII_CDR_REF>,
+			 <&sgmiisys CLK_SGMII_CDR_FB>,
+			 <&topckgen CLK_TOP_SGMIIPLL>,
+			 <&apmixedsys CLK_APMIXED_ETH2PLL>;
+		clock-names = "ethif", "esw", "gp0", "gp1", "gp2",
+			      "sgmii_tx250m", "sgmii_rx250m",
+			      "sgmii_cdr_ref", "sgmii_cdr_fb", "sgmii_ck",
+			      "eth2pll";
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,sgmiisys = <&sgmiisys>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sgmiisys: sgmiisys@1b128000 {
 		compatible = "mediatek,mt7622-sgmiisys",
 			     "syscon";
-- 
2.7.4
