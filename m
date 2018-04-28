Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933363AbeD1Fm4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 01:42:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34430 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeD1Fmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 01:42:52 -0400
X-Google-Smtp-Source: AB8JxZqw3uOcrkJRx88eS0DV7+Nmyg2R/6tTovIo6ZpUgXN24je/s0Yb6zogf3rk4aCO4y5xd1K51w==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 1/2] arm64: dts: Add msm8998 SoC and MTP board support
Date: Fri, 27 Apr 2018 22:42:47 -0700
Message-Id: <20180428054248.22387-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonwoo Park <joonwoop@codeaurora.org>

Add initial device tree support for the Qualcomm MSM8998 SoC and
MTP8998 evaluation board.

Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
Signed-off-by: Imran Khan <kimran@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
[bjorn: Restructured, removed its node and moved to SPDX headers]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Cleaned up interrupts
- Added options to stdout-path

 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts  |  13 ++
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi |  20 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 340 ++++++++++++++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 55ec5ee7f7e8..f658595bb347 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
new file mode 100644
index 000000000000..f1853e020e57
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
+
+/dts-v1/;
+
+#include "msm8998-mtp.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. MSM 8998 v1 MTP";
+	compatible = "qcom,msm8998-mtp";
+
+	qcom,board-id = <8 0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
new file mode 100644
index 000000000000..e30c95f63a05
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
+
+#include "msm8998.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp2_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&soc {
+	serial@c1b0000 {
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
new file mode 100644
index 000000000000..d6665e4f801f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-msm8998.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. MSM 8998";
+
+	interrupt-parent = <&intc>;
+
+	qcom,msm-id = <292 0x0>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "arm,arch-cache";
+				cache-level = <2>;
+			};
+			L1_I_0: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_0: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L1_I_1: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_1: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L1_I_2: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_2: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L1_I_3: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_3: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			efficiency = <1536>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				compatible = "arm,arch-cache";
+				cache-level = <2>;
+			};
+			L1_I_100: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_100: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			efficiency = <1536>;
+			next-level-cache = <&L2_1>;
+			L1_I_101: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_101: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+			efficiency = <1536>;
+			next-level-cache = <&L2_1>;
+			L1_I_102: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_102: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+			efficiency = <1536>;
+			next-level-cache = <&L2_1>;
+			L1_I_103: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_103: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+
+				core1 {
+					cpu = <&CPU5>;
+				};
+
+				core2 {
+					cpu = <&CPU6>;
+				};
+
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	clocks {
+		xo_board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+		};
+
+		sleep_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc: soc {};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0 0 0xffffffff>;
+	compatible = "simple-bus";
+
+	intc: interrupt-controller@17a00000 {
+		compatible = "arm,gic-v3";
+		reg = <0x17a00000 0x10000>,       /* GICD */
+		      <0x17b00000 0x100000>;      /* GICR * 8 */
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-controller;
+		#redistributor-regions = <1>;
+		redistributor-stride = <0x0 0x20000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gcc: clock-controller@100000 {
+		compatible = "qcom,gcc-msm8998";
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+		reg = <0x100000 0xb0000>;
+	};
+
+	blsp2_uart1: serial@c1b0000 {
+		compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+		reg = <0xc1b0000 0x1000>;
+		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
+			 <&gcc GCC_BLSP2_AHB_CLK>;
+		clock-names = "core", "iface";
+		status = "disabled";
+	};
+
+	timer@17920000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "arm,armv7-timer-mem";
+		reg = <0x17920000 0x1000>;
+
+		frame@17921000 {
+			frame-number = <0>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17921000 0x1000>,
+			      <0x17922000 0x1000>;
+		};
+
+		frame@17923000 {
+			frame-number = <1>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17923000 0x1000>;
+			status = "disabled";
+		};
+
+		frame@17924000 {
+			frame-number = <2>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17924000 0x1000>;
+			status = "disabled";
+		};
+
+		frame@17925000 {
+			frame-number = <3>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17925000 0x1000>;
+			status = "disabled";
+		};
+
+		frame@17926000 {
+			frame-number = <4>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17926000 0x1000>;
+			status = "disabled";
+		};
+
+		frame@17927000 {
+			frame-number = <5>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17927000 0x1000>;
+			status = "disabled";
+		};
+
+		frame@17928000 {
+			frame-number = <6>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x17928000 0x1000>;
+			status = "disabled";
+		};
+	};
+
+	spmi_bus: qcom,spmi@800f000 {
+		compatible = "qcom,spmi-pmic-arb";
+		reg =	<0x800f000 0x1000>,
+			<0x8400000 0x1000000>,
+			<0x9400000 0x1000000>,
+			<0xa400000 0x220000>,
+			<0x800a000 0x3000>;
+		reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+		interrupt-names = "periph_irq";
+		interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
+		qcom,ee = <0>;
+		qcom,channel = <0>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+		interrupt-controller;
+		#interrupt-cells = <4>;
+		cell-index = <0>;
+	};
+};
-- 
2.16.2
