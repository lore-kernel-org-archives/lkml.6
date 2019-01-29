Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B1AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C38F2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfA2Ebr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:31:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:64599 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727283AbfA2Ebo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:31:44 -0500
X-UUID: d3d0cc45a47347b694d92884ffd9f587-20190129
X-UUID: d3d0cc45a47347b694d92884ffd9f587-20190129
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1045938451; Tue, 29 Jan 2019 12:31:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 12:31:33 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 12:31:34 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <roychl666@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 7/7] arm: dts: mediatek: add basic support for MT7629 SoC
Date:   Tue, 29 Jan 2019 12:31:19 +0800
Message-ID: <6bda890b763ca0f2fceaca4f7480de7ce8bef637.1548735271.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
References: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic support for MT7629 reference board.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
The I2C node depends on https://patchwork.kernel.org/patch/10772837/
The PCIe node depends on https://patchwork.kernel.org/patch/10773637/
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/mt7629-rfb.dts          | 234 +++++++++++++++++
 arch/arm/boot/dts/mt7629.dtsi             | 416 ++++++++++++++++++++++++++++++
 include/dt-bindings/reset/mt7629-resets.h |  71 +++++
 4 files changed, 722 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7629-rfb.dts
 create mode 100644 arch/arm/boot/dts/mt7629.dtsi
 create mode 100644 include/dt-bindings/reset/mt7629-resets.h

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148..a5a6d9f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1231,6 +1231,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7623a-rfb-nand.dtb \
 	mt7623n-rfb-emmc.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
+	mt7629-rfb.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
diff --git a/arch/arm/boot/dts/mt7629-rfb.dts b/arch/arm/boot/dts/mt7629-rfb.dts
new file mode 100644
index 0000000..0878a14
--- /dev/null
+++ b/arch/arm/boot/dts/mt7629-rfb.dts
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "mt7629.dtsi"
+
+/ {
+	model = "MediaTek MT7629 reference board";
+	compatible = "mediatek,mt7629-rfb", "mediatek,mt7629";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		bootargs = "earlycon=uart8250,mmio32,0x11002000";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		reset {
+			label = "factory";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 58 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x10000000>;
+	};
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
+};
+
+&i2c {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c_pins>;
+	status = "okay";
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@00000 {
+			label = "Bootloader";
+			reg = <0x00000 0x0060000>;
+		};
+
+		partition@60000 {
+			label = "Config";
+			reg = <0x60000 0x0010000>;
+		};
+
+		partition@70000 {
+			label = "Factory";
+			reg = <0x70000 0x0040000>;
+		};
+
+		partition@b0000 {
+			label = "Kernel";
+			reg = <0xb0000 0xb50000>;
+		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+
+	pcie@1,0 {
+		status = "okay";
+	};
+};
+
+&pio {
+	eth_pins: eth-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio";
+		};
+	};
+
+	ephy_leds_pins: ephy-leds-pins {
+		mux {
+			function = "led";
+			groups = "gphy_leds_0", "ephy_leds";
+		};
+	};
+
+	i2c_pins: i2c-pins {
+		mux {
+			function = "i2c";
+			groups =  "i2c_0";
+		};
+
+		conf {
+			pins = "I2C_SDA", "I2C_SCL";
+			drive-strength = <4>;
+			bias-disable;
+		};
+	};
+
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clkreq",
+				 "pcie_pereset",
+				 "pcie_wake";
+		};
+	};
+
+	pwm_pins: pwm-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm_0";
+		};
+	};
+
+	/* Serial NAND is shared pin with SPI-NOR */
+	serial_nand_pins: serial-nand-pins {
+		mux {
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+
+	spi_pins: spi-pins {
+		mux {
+			function = "spi";
+			groups = "spi_0";
+		};
+	};
+
+	/* SPI-NOR is shared pin with serial NAND */
+	qspi_pins: qspi-pins {
+		mux {
+			function = "flash";
+			groups = "spi_nor";
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		mux {
+			function = "uart";
+			groups = "uart0_txd_rxd" ;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		mux {
+			function = "uart";
+			groups = "uart1_0_tx_rx" ;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		mux {
+			function = "uart";
+			groups = "uart2_0_txd_rxd" ;
+		};
+	};
+
+	watchdog_pins: watchdog-pins {
+		mux {
+			function = "watchdog";
+			groups = "watchdog";
+		};
+	};
+};
+
+&spi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_pins>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&ssusb {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&watchdog {
+	pinctrl-names = "default";
+	pinctrl-0 = <&watchdog_pins>;
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
new file mode 100644
index 0000000..2b4410a
--- /dev/null
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ *
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mt7629-clk.h>
+#include <dt-bindings/power/mt7622-power.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/reset/mt7629-resets.h>
+
+/ {
+	compatible = "mediatek,mt7629";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "mediatek,mt6589-smp";
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			clock-frequency = <1250000000>;
+			cci-control-port = <&cci_control2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x1>;
+			clock-frequency = <1250000000>;
+			cci-control-port = <&cci_control2>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
+	clk20m: oscillator@0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+		clock-output-names = "clk20m";
+	};
+
+	clk40m: oscillator@1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clock-frequency = <20000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	infracfg: syscon@10000000 {
+		compatible = "mediatek,mt7629-infracfg", "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	pericfg: syscon@10002000 {
+		compatible = "mediatek,mt7629-pericfg", "syscon";
+		reg = <0 0x10002000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	scpsys: scpsys@10006000 {
+		compatible = "mediatek,mt7629-scpsys",
+			     "mediatek,mt7622-scpsys";
+		#power-domain-cells = <1>;
+		reg = <0 0x10006000 0 0x1000>;
+		clocks = <&topckgen CLK_TOP_HIF_SEL>;
+		clock-names = "hif_sel";
+		assigned-clocks = <&topckgen CLK_TOP_HIF_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+		infracfg = <&infracfg>;
+	};
+
+	timer: timer@10009000 {
+		compatible = "mediatek,mt7629-timer",
+			     "mediatek,mt6765-timer";
+		reg = <0 0x10009000 0 0x60>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk20m>;
+		clock-names = "clk20m";
+	};
+
+	sysirq: interrupt-controller@10200a80 {
+		compatible = "mediatek,mt7629-sysirq",
+			     "mediatek,mt6577-sysirq";
+		reg = <0 0x10200a80 0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+	};
+
+	apmixedsys: syscon@10209000 {
+		compatible = "mediatek,mt7629-apmixedsys", "syscon";
+		reg = <0 0x10209000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	rng: rng@1020f000 {
+		compatible = "mediatek,mt7629-rng",
+			     "mediatek,mt7623-rng";
+		reg = <0 0x1020f000 0 0x100>;
+		clocks = <&infracfg CLK_INFRA_TRNG_PD>;
+		clock-names = "rng";
+	};
+
+	topckgen: syscon@10210000 {
+		compatible = "mediatek,mt7629-topckgen", "syscon";
+		reg = <0 0x10210000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	watchdog: watchdog@10212000 {
+		compatible = "mediatek,mt7629-wdt",
+			     "mediatek,mt6589-wdt";
+		reg = <0 0x10212000 0 0x100>;
+	};
+
+	pio: pinctrl@10217000 {
+		compatible = "mediatek,mt7629-pinctrl";
+		reg = <0 0x10217000 0 0x8000>,
+		      <0 0x10005000 0 0x1000>;
+		reg-names = "base", "eint";
+		gpio-controller;
+		gpio-ranges = <&pio 0 0 79>;
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+	};
+
+	gic: interrupt-controller@10300000 {
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x10310000 0 0x1000>,
+		      <0 0x10320000 0 0x1000>,
+		      <0 0x10340000 0 0x2000>,
+		      <0 0x10360000 0 0x2000>;
+	};
+
+	cci: cci@10390000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0x10390000 0 0x1000>;
+		ranges = <0 0 0x10390000 0x10000>;
+
+		cci_control0: slave-if@1000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace-lite";
+			reg = <0x1000 0x1000>;
+		};
+
+		cci_control1: slave-if@4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control2: slave-if@5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+
+		pmu@9000 {
+			compatible = "arm,cci-400-pmu,r1";
+			reg = <0x9000 0x5000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	uart0: serial@11002000 {
+		compatible = "mediatek,mt7629-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11002000 0 0x400>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART0_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart1: serial@11003000 {
+		compatible = "mediatek,mt7629-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x400>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART1_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart2: serial@11004000 {
+		compatible = "mediatek,mt7629-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11004000 0 0x400>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UART_SEL>,
+			 <&pericfg CLK_PERI_UART2_PD>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	i2c: i2c@11007000 {
+		compatible = "mediatek,mt7629-i2c",
+			     "mediatek,mt2712-i2c";
+		reg = <0 0x11007000 0 0x90>,
+		      <0 0x11000100 0 0x80>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <4>;
+		clocks = <&pericfg CLK_PERI_I2C0_PD>,
+			 <&pericfg CLK_PERI_AP_DMA_PD>;
+		clock-names = "main", "dma";
+		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi: spi@1100a000 {
+		compatible = "mediatek,mt7629-spi",
+			     "mediatek,mt7622-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x1100a000 0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+			 <&topckgen CLK_TOP_SPI0_SEL>,
+			 <&pericfg CLK_PERI_SPI0_PD>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	qspi: spi@11014000 {
+		compatible = "mediatek,mt7629-nor",
+			     "mediatek,mt8173-nor";
+		reg = <0 0x11014000 0 0xe0>;
+		clocks = <&pericfg CLK_PERI_FLASH_PD>,
+			 <&topckgen CLK_TOP_FLASH_SEL>;
+		clock-names = "spi", "sf";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	ssusbsys: syscon@1a000000 {
+		compatible = "mediatek,mt7629-ssusbsys", "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	ssusb: usb@1a0c0000 {
+		compatible = "mediatek,mt7629-xhci",
+			     "mediatek,mtk-xhci";
+		reg = <0 0x1a0c0000 0 0x01000>,
+		      <0 0x1a0c3e00 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ssusbsys CLK_SSUSB_SYS_EN>,
+			 <&ssusbsys CLK_SSUSB_REF_EN>,
+			 <&ssusbsys CLK_SSUSB_MCU_EN>,
+			 <&ssusbsys CLK_SSUSB_DMA_EN>;
+		clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
+		assigned-clocks = <&topckgen CLK_TOP_AXI_SEL>,
+				  <&topckgen CLK_TOP_SATA_SEL>,
+				  <&topckgen CLK_TOP_HIF_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_SYSPLL1_D2>,
+					 <&topckgen CLK_TOP_UNIVPLL2_D4>,
+					 <&topckgen CLK_TOP_UNIVPLL1_D2>;
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF1>;
+		phys = <&u2port0 PHY_TYPE_USB2>,
+		       <&u3port0 PHY_TYPE_USB3>;
+		status = "disabled";
+	};
+
+	u3phy1: usb-phy@1a0c4000 {
+		compatible = "mediatek,generic-tphy-v1";
+		reg = <0 0x1a0c4000 0 0x300>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port0: usb-phy@1a0c4300 {
+			reg = <0 0x1a0c4300 0 0x100>;
+			clocks = <&ssusbsys CLK_SSUSB_U2_PHY_EN>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port0: usb-phy@1a1c4900 {
+			reg = <0 0x1a1c4900 0 0x700>;
+			clocks = <&clk20m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
+	pciesys: syscon@1a100800 {
+		compatible = "mediatek,mt7629-pciesys", "syscon";
+		reg = <0 0x1a100800 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pcie: pcie@1a140000 {
+		compatible = "mediatek,mt7629-pcie";
+		device_type = "pci";
+		reg = <0 0x1a140000 0 0x1000>,
+		      <0 0x1a145000 0 0x1000>;
+		reg-names = "subsys", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pciesys CLK_PCIE_P1_MAC_EN>,
+			 <&pciesys CLK_PCIE_P0_AHB_EN>,
+			 <&pciesys CLK_PCIE_P1_AUX_EN>,
+			 <&pciesys CLK_PCIE_P1_AXI_EN>,
+			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
+			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
+		clock-names = "sys_ck1", "ahb_ck1",
+			      "aux_ck1", "axi_ck1",
+			      "obff_ck1", "pipe_ck1";
+		assigned-clocks = <&topckgen CLK_TOP_SATA_SEL>,
+				  <&topckgen CLK_TOP_AXI_SEL>,
+				  <&topckgen CLK_TOP_HIF_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+					 <&topckgen CLK_TOP_SYSPLL1_D2>,
+					 <&topckgen CLK_TOP_UNIVPLL1_D2>;
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+		bus-range = <0x00 0xff>;
+		status = "disabled";
+		ranges = <0x82000000 0 0x20000000 0 0x20000000 0 0x10000000>;
+
+		pcie@1,0 {
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	ethsys: syscon@1b000000 {
+		compatible = "mediatek,mt7629-ethsys", "syscon";
+		reg = <0 0x1b000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	sgmiisys0: syscon@1b128000 {
+		compatible = "mediatek,mt7629-sgmiisys", "syscon";
+		reg = <0 0x1b128000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	sgmiisys1: syscon@1b130000 {
+		compatible = "mediatek,mt7629-sgmiisys", "syscon";
+		reg = <0 0x1b130000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/reset/mt7629-resets.h b/include/dt-bindings/reset/mt7629-resets.h
new file mode 100644
index 0000000..6bb8573
--- /dev/null
+++ b/include/dt-bindings/reset/mt7629-resets.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT7629
+#define _DT_BINDINGS_RESET_CONTROLLER_MT7629
+
+/* INFRACFG resets */
+#define MT7629_INFRA_EMI_MPU_RST		0
+#define MT7629_INFRA_UART5_RST			2
+#define MT7629_INFRA_CIRQ_EINT_RST		3
+#define MT7629_INFRA_APXGPT_RST			4
+#define MT7629_INFRA_SCPSYS_RST			5
+#define MT7629_INFRA_KP_RST			6
+#define MT7629_INFRA_SPI1_RST			7
+#define MT7629_INFRA_SPI4_RST			8
+#define MT7629_INFRA_SYSTIMER_RST		9
+#define MT7629_INFRA_IRRX_RST			10
+#define MT7629_INFRA_AO_BUS_RST			16
+#define MT7629_INFRA_EMI_RST			32
+#define MT7629_INFRA_APMIXED_RST		35
+#define MT7629_INFRA_MIPI_RST			36
+#define MT7629_INFRA_TRNG_RST			37
+#define MT7629_INFRA_SYSCIRQ_RST		38
+#define MT7629_INFRA_MIPI_CSI_RST		39
+#define MT7629_INFRA_GCE_FAXI_RST		40
+#define MT7629_INFRA_I2C_SRAM_RST		41
+#define MT7629_INFRA_IOMMU_RST			47
+
+/* PERICFG resets */
+#define MT7629_PERI_UART0_SW_RST		0
+#define MT7629_PERI_UART1_SW_RST		1
+#define MT7629_PERI_UART2_SW_RST		2
+#define MT7629_PERI_BTIF_SW_RST			6
+#define MT7629_PERI_PWN_SW_RST			8
+#define MT7629_PERI_DMA_SW_RST			11
+#define MT7629_PERI_NFI_SW_RST			14
+#define MT7629_PERI_I2C0_SW_RST			22
+#define MT7629_PERI_SPI0_SW_RST			33
+#define MT7629_PERI_SPI1_SW_RST			34
+#define MT7629_PERI_FLASHIF_SW_RST		36
+
+/* PCIe Subsystem resets */
+#define MT7629_PCIE1_CORE_RST			19
+#define MT7629_PCIE1_MMIO_RST			20
+#define MT7629_PCIE1_HRST			21
+#define MT7629_PCIE1_USER_RST			22
+#define MT7629_PCIE1_PIPE_RST			23
+#define MT7629_PCIE0_CORE_RST			27
+#define MT7629_PCIE0_MMIO_RST			28
+#define MT7629_PCIE0_HRST			29
+#define MT7629_PCIE0_USER_RST			30
+#define MT7629_PCIE0_PIPE_RST			31
+
+/* SSUSB Subsystem resets */
+#define MT7629_SSUSB_PHY_PWR_RST		3
+#define MT7629_SSUSB_MAC_PWR_RST		4
+
+/* ETH Subsystem resets */
+#define MT7629_ETHSYS_SYS_RST			0
+#define MT7629_ETHSYS_MCM_RST			2
+#define MT7629_ETHSYS_HSDMA_RST			5
+#define MT7629_ETHSYS_FE_RST			6
+#define MT7629_ETHSYS_ESW_RST			16
+#define MT7629_ETHSYS_GMAC_RST			23
+#define MT7629_ETHSYS_EPHY_RST			24
+#define MT7629_ETHSYS_CRYPTO_RST		29
+#define MT7629_ETHSYS_PPE_RST			31
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7629 */
-- 
1.9.1

