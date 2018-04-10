Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDJIgs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:36:48 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:31984 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752147AbeDJIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:36:46 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517842800";
   d="scan'208";a="277754479"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 6/8] ARM: dts: Renesas RZ/N1 SoC base device tree file
Date: Tue, 10 Apr 2018 09:30:06 +0100
Message-Id: <1523349015-37985-7-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Renesas RZ/N1D (Part #R9A06G032) SoC bare
bone support.

This currently only handles generic parts (gic, architected timer)
and a UART.
For simplicity sake, this also relies on the bootloader to set the
pinctrl and clocks.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
new file mode 100644
index 0000000..7d84b38
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Base Device Tree Source for the Renesas RZ/N1D (R9A06G032)
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r9a06g032", "renesas,rzn1";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	clkuarts: clkuarts {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <47619047>;
+	};
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
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&gic>;
+		ranges;
+
+		sysctrl: sysctrl@4000c000 {
+			compatible = "renesas,r9a06g032-sysctrl",
+					"renesas,rzn1-sysctrl",
+					"syscon", "simple-mfd";
+			reg = <0x4000c000 0x1000>;
+
+			reboot {
+				compatible = "renesas,r9a06g032-reboot",
+						"renesas,rzn1-reboot";
+			};
+		};
+
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
+				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	timer {
+		compatible = "arm,cortex-a7-timer",
+			     "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+		interrupts =
+			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.7.4
