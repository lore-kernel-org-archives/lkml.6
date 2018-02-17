Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeBQT5k (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:57:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49706 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751131AbeBQTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:08 -0500
X-UUID: f79d34dba692497bbc78a44f0e3f718d-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 13/15] arm64: dts: mt7622: add usb device nodes
Date: Sun, 18 Feb 2018 03:54:48 +0800
Message-ID: <cce598c3aa18c71b8d2d9ac7e8c4529d0613803a.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

add xhci node and usb3 phy nodes

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Jumin Li <jumin.li@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 28 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 51 ++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 6715ffa..cc89e2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -52,6 +52,24 @@
 	memory {
 		reg = <0 0x40000000 0 0x3F000000>;
 	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &pcie {
@@ -343,6 +361,16 @@
 	status = "okay";
 };
 
+&ssusb {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&u3phy {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 881bc17..bad1e99 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -535,6 +535,57 @@
 		#reset-cells = <1>;
 	};
 
+	ssusb: usb@1a0c0000 {
+		compatible = "mediatek,mt7622-xhci",
+			     "mediatek,mtk-xhci";
+		reg = <0 0x1a0c0000 0 0x01000>,
+		      <0 0x1a0c4700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF1>;
+		clocks = <&ssusbsys CLK_SSUSB_SYS_EN>,
+			 <&ssusbsys CLK_SSUSB_REF_EN>,
+			 <&ssusbsys CLK_SSUSB_MCU_EN>,
+			 <&ssusbsys CLK_SSUSB_DMA_EN>;
+		clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+		phys = <&u2port0 PHY_TYPE_USB2>,
+		       <&u3port0 PHY_TYPE_USB3>,
+		       <&u2port1 PHY_TYPE_USB2>;
+
+		status = "disabled";
+	};
+
+	u3phy: usb-phy@1a0c4000 {
+		compatible = "mediatek,mt7622-u3phy",
+			     "mediatek,generic-tphy-v1";
+		reg = <0 0x1a0c4000 0 0x700>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port0: usb-phy@1a0c4800 {
+			reg = <0 0x1a0c4800 0 0x0100>;
+			#phy-cells = <1>;
+			clocks = <&ssusbsys CLK_SSUSB_U2_PHY_EN>;
+			clock-names = "ref";
+		};
+
+		u3port0: usb-phy@1a0c4900 {
+			reg = <0 0x1a0c4900 0 0x0700>;
+			#phy-cells = <1>;
+			clocks = <&clk25m>;
+			clock-names = "ref";
+		};
+
+		u2port1: usb-phy@1a0c5000 {
+			reg = <0 0x1a0c5000 0 0x0100>;
+			#phy-cells = <1>;
+			clocks = <&ssusbsys CLK_SSUSB_U2_PHY_1P_EN>;
+			clock-names = "ref";
+		};
+	};
+
 	pciesys: pciesys@1a100800 {
 		compatible = "mediatek,mt7622-pciesys",
 			     "syscon";
-- 
2.7.4
