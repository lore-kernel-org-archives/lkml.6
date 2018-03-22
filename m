Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbeCVLuo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:50:44 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:7694 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752580AbeCVLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:50:39 -0400
X-IronPort-AV: E=Sophos;i="5.48,344,1517842800";
   d="scan'208";a="274538265"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree file
Date: Thu, 22 Mar 2018 11:44:43 +0000
Message-Id: <1521719091-25157-7-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
bare bone support.

This currently only handles generic parts (gic, architected timer)
and a UART.
For simplicity sake, this also relies on the bootloader to set the
pinctrl and clocks.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g0xx.dtsi | 96 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi

diff --git a/arch/arm/boot/dts/r9a06g0xx.dtsi b/arch/arm/boot/dts/r9a06g0xx.dtsi
new file mode 100644
index 0000000..c6eeee3
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g0xx.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base Device Tree Source for the Renesas RZ/N1 SoC Family of devices
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,rzn1";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+		};
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+		};
+	};
+	clocks {
+		/*
+		 * this is fixed clock for now,
+		 * until the clock driver is merged
+		 */
+		clkuarts: clkuarts {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <47619047>;
+		};
+	};
+	arch-timer {
+		compatible = "arm,cortex-a7-timer",
+			     "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		arm,cpu-registers-not-fw-configured;
+		interrupts =
+			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+				IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+				IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
+				IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
+				IRQ_TYPE_LEVEL_LOW)>;
+	};
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		gic: gic@44101000 {
+			compatible = "arm,cortex-a7-gic", "arm,gic-400";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x44101000 0x1000>, /* Distributer */
+			      <0x44102000 0x2000>, /* CPU interface */
+			      <0x44104000 0x2000>, /* Virt interface control */
+			      <0x44106000 0x2000>; /* Virt CPU interface */
+			interrupts =
+				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
+					IRQ_TYPE_LEVEL_HIGH)>;
+		};
+		sysctrl: sysctrl@4000c000 {
+			compatible = "renesas,rzn1-sysctrl", "syscon",
+					"simple-mfd";
+			reg = <0x4000c000 0x1000>;
+
+			reboot {
+				compatible = "renesas,rzn1-reboot";
+			};
+		};
+		uart0: serial@40060000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x40060000 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&clkuarts>;
+			clock-names = "baudclk";
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4
