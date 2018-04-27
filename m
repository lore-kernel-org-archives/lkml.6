Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757813AbeD0IQ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:16:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16422 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757615AbeD0IOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:14:54 -0400
X-UUID: f44a8326cdd64ba2afb21db56b956b64-20180427
From: <sean.wang@mediatek.com>
To: <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 6/6] arm: dts: mt7623: add Mali-450 and related device nodes
Date: Fri, 27 Apr 2018 16:14:47 +0800
Message-ID: <5373474c687996446dc80d2cd40143c061a499c0.1524816502.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add nodes for Mali-450 device, g3dsys device providing required clock
gate and reset control and larb3 offering an arbiter through iommu for
controlling access to external memory requested from Mali-450.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi  | 70 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi |  4 +++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 59139dd..1cd8208 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -276,6 +276,17 @@
 		clock-names = "system-clk", "rtc-clk";
 	};
 
+	smi_common: smi@1000c000 {
+		compatible = "mediatek,mt7623-smi-common",
+			     "mediatek,mt2701-smi-common";
+		reg = <0 0x1000c000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_SMI>,
+			 <&mmsys CLK_MM_SMI_COMMON>,
+			 <&infracfg CLK_INFRA_SMI>;
+		clock-names = "apb", "smi", "async";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
+	};
+
 	pwrap: pwrap@1000d000 {
 		compatible = "mediatek,mt7623-pwrap",
 			     "mediatek,mt2701-pwrap";
@@ -307,6 +318,17 @@
 		reg = <0 0x10200100 0 0x1c>;
 	};
 
+	iommu: iommu@10205000 {
+		compatible = "mediatek,mt7623-m4u",
+			     "mediatek,mt2701-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb3>;
+		#iommu-cells = <1>;
+	};
+
 	efuse: efuse@10206000 {
 		compatible = "mediatek,mt7623-efuse",
 			     "mediatek,mt8173-efuse";
@@ -682,6 +704,54 @@
 		status = "disabled";
 	};
 
+	g3dsys: clock-controller@13000000 {
+		compatible = "mediatek,mt7623-g3dsys",
+			     "mediatek,mt2701-g3dsys",
+			     "syscon";
+		reg = <0 0x13000000 0 0x200>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	larb3: larb@13010000 {
+		compatible = "mediatek,mt7623-smi-larb",
+			     "mediatek,mt2701-smi-larb";
+		reg = <0 0x13010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		mediatek,larb-id = <3>;
+		clocks = <&clk26m>, <&clk26m>;
+		clock-names = "apb", "smi";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
+	};
+
+	mali: gpu@13040000 {
+		compatible = "mediatek,mt7623-mali", "arm,mali-450";
+		reg = <0 0x13040000 0 0x30000>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 173 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 174 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pp1",
+				  "ppmmu1", "pp2", "ppmmu2", "pp";
+		clocks = <&topckgen CLK_TOP_MMPLL>,
+			 <&g3dsys CLK_G3DSYS_CORE>;
+		clock-names = "bus", "core";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_MFG>;
+		mediatek,larb = <&larb3>;
+		resets = <&g3dsys MT2701_G3DSYS_CORE_RST>;
+	};
+
+	mmsys: syscon@14000000 {
+		compatible = "mediatek,mt2701-mmsys", "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index 0735a1fb8..a42fd46 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -21,6 +21,10 @@
 	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
 };
 
+&mali {
+	status = "disabled";
+};
+
 &nandc {
 	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
 };
-- 
2.7.4
