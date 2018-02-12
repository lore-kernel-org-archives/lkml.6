Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934096AbeBLLco (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:32:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51527 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933981AbeBLLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:32:43 -0500
X-UUID: 55dff24b89774f5f8b93457883620e89-20180212
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] arm: dts: mt7623: add PCIe related nodes
Date: Mon, 12 Feb 2018 19:32:37 +0800
Message-ID: <3b3a4d73d7b33a9318b8db1033d2f7e4c32b0136.1518400130.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some device nodes for the PCIe function block and updates
related pinmux.

Moreover, we add interrupt-map properties in both parent and children as
the chip only has one IRQ per slot that is connected to all INTx and get
propagated through the bridges and it also represents the root ports own
interrupts.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
Please refer to the previous discussion:
https://patchwork.ozlabs.org/patch/829108/
https://patchwork.kernel.org/patch/10193391/
---
 arch/arm/boot/dts/mt7623.dtsi                 | 105 ++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  22 ++++++
 2 files changed, 127 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b750da5..c2541a0 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -670,6 +670,111 @@
 		#reset-cells = <1>;
 	};
 
+	pcie: pcie-controller@1a140000 {
+		compatible = "mediatek,mt7623-pcie";
+		device_type = "pci";
+		reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
+		      <0 0x1a142000 0 0x1000>, /* Port0 registers */
+		      <0 0x1a143000 0 0x1000>, /* Port1 registers */
+		      <0 0x1a144000 0 0x1000>; /* Port2 registers */
+		reg-names = "subsys", "port0", "port1", "port2";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 0>;
+		interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
+				<0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
+				<0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+			 <&hifsys CLK_HIFSYS_PCIE0>,
+			 <&hifsys CLK_HIFSYS_PCIE1>,
+			 <&hifsys CLK_HIFSYS_PCIE2>;
+		clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
+		resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
+			 <&hifsys MT2701_HIFSYS_PCIE1_RST>,
+			 <&hifsys MT2701_HIFSYS_PCIE2_RST>;
+		reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
+		phys = <&pcie0_port PHY_TYPE_PCIE>,
+		       <&pcie1_port PHY_TYPE_PCIE>,
+		       <&u3port1 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		bus-range = <0x00 0xff>;
+		status = "disabled";
+		ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000
+			  0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;
+
+		pcie@0,0 {
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
+			ranges;
+			num-lanes = <1>;
+			status = "disabled";
+		};
+
+		pcie@1,0 {
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+			ranges;
+			num-lanes = <1>;
+			status = "disabled";
+		};
+
+		pcie@2,0 {
+			reg = <0x1000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+			ranges;
+			num-lanes = <1>;
+			status = "disabled";
+		};
+	};
+
+	pcie0_phy: pcie-phy@1a149000 {
+		compatible = "mediatek,generic-tphy-v1";
+		reg = <0 0x1a149000 0 0x0700>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		pcie0_port: pcie-phy@1a149900 {
+			reg = <0 0x1a149900 0 0x0700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
+	pcie1_phy: pcie-phy@1a14a000 {
+		compatible = "mediatek,generic-tphy-v1";
+		reg = <0 0x1a14a000 0 0x0700>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		pcie1_port: pcie-phy@1a14a900 {
+			reg = <0 0x1a14a900 0 0x0700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
 	usb1: usb@1a1c0000 {
 		compatible = "mediatek,mt7623-xhci",
 			     "mediatek,mt8173-xhci";
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 7bf5aa2..b077808 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -209,6 +209,20 @@
 	vqmmc-supply = <&mt6323_vio18_reg>;
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_default>;
+	status = "okay";
+
+	pcie@0,0 {
+		status = "okay";
+	};
+
+	pcie@1,0 {
+		status = "okay";
+	};
+};
+
 &pio {
 	cir_pins_a:cir@0 {
 		pins_cir {
@@ -376,6 +390,14 @@
 		};
 	};
 
+	pcie_default: pcie_pin_default {
+		pins_cmd_dat {
+			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
+				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
+			bias-disable;
+		};
+	};
+
 	pwm_pins_a: pwm@0 {
 		pins_pwm {
 			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
-- 
1.9.1
