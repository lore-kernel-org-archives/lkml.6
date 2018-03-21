Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeCUPiI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:38:08 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:58924 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752637AbeCUPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:37:47 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/1] arm: dts: add Nuvoton NPCM750 device tree
Date: Wed, 21 Mar 2018 17:36:17 +0200
Message-Id: <1521646577-10773-2-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1521646577-10773-1-git-send-email-tmaimon77@gmail.com>
References: <1521646577-10773-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common device tree for all Nuvoton NPCM7xx BMCs and a board
specific device tree for the NPCM750 (Poleg) evaluation board.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 187 ++++++++++++++++++++++++++
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |  39 ++++++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        |  45 +++++++
 4 files changed, 273 insertions(+)
 create mode 100644 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..ba3bfa674e32 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -304,6 +304,8 @@ dtb-$(CONFIG_ARCH_LPC18XX) += \
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	lpc3250-ea3250.dtb \
 	lpc3250-phy3250.dtb
+dtb-$(CONFIG_ARCH_NPCM7XX) += \
+	nuvoton-npcm750-evb.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
 dtb-$(CONFIG_MACH_MESON8) += \
diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
new file mode 100644
index 000000000000..d2d0761295a4
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com
+// Copyright 2018 Google, Inc.
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	/* external reference clock */
+	clk_refclk: clk_refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "refclk";
+	};
+
+	/* external reference clock for cpu. float in normal operation */
+	clk_sysbypck: clk_sysbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "sysbypck";
+	};
+
+	/* external reference clock for MC. float in normal operation */
+	clk_mcbypck: clk_mcbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "mcbypck";
+	};
+
+	 /* external clock signal rg1refck, supplied by the phy */
+	clk_rg1refck: clk_rg1refck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_rg1refck";
+	};
+
+	 /* external clock signal rg2refck, supplied by the phy */
+	clk_rg2refck: clk_rg2refck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_rg2refck";
+	};
+
+	clk_xin: clk_xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "clk_xin";
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges = <0x0 0xf0000000 0x00900000>;
+
+		gcr: gcr@800000 {
+			compatible = "nuvoton,npcm750-gcr", "syscon",
+				"simple-mfd";
+			reg = <0x800000 0x1000>;
+		};
+
+		scu: scu@3fe000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0x3fe000 0x1000>;
+		};
+
+		l2: cache-controller@3fc000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x3fc000 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+			clocks = <&clk 10>;
+			arm,shared-override;
+		};
+
+		gic: interrupt-controller@3ff000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x3ff000 0x1000>,
+				<0x3fe100 0x100>;
+		};
+	};
+
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		clk: clock-controller@f0801000 {
+			compatible = "nuvoton,npcm750-clk", "syscon";
+			#clock-cells = <1>;
+			clock-controller;
+			reg = <0xf0801000 0x1000>;
+			clock-names = "refclk", "sysbypck", "mcbypck";
+			clocks = <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			interrupt-parent = <&gic>;
+			ranges = <0x0 0xf0000000 0x00300000>;
+
+			timer0: timer@8000 {
+				compatible = "nuvoton,npcm750-timer";
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x8000 0x50>;
+				clocks = <&clk 5>;
+			};
+
+			watchdog0: watchdog@801C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x801C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			watchdog1: watchdog@901C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x901C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			watchdog2: watchdog@a01C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xa01C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			serial0: serial@1000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x1000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			serial1: serial@2000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x2000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			serial2: serial@3000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x3000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			serial3: serial@4000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x4000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
new file mode 100644
index 000000000000..15f744f1beea
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com
+// Copyright 2018 Google, Inc.
+
+/dts-v1/;
+#include "nuvoton-npcm750.dtsi"
+
+/ {
+	model = "Nuvoton npcm750 Development Board (Device Tree)";
+	compatible = "nuvoton,npcm750";
+
+	chosen {
+		stdout-path = &serial3;
+	};
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
new file mode 100644
index 000000000000..5afdc730fc4a
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com
+// Copyright 2018 Google, Inc.
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "nuvoton-common-npcm7xx.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "nuvoton,npcm750-smp";
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			clocks = <&clk 0>;
+			clock-names = "clk_cpu";
+			reg = <0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			clocks = <&clk 0>;
+			clock-names = "clk_cpu";
+			reg = <1>;
+			next-level-cache = <&l2>;
+		};
+	};
+	soc {
+		timer@3fe600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x3fe600 0x20>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+						  IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&clk 5>;
+		};
+	};
+};
-- 
2.14.1
