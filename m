Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeBTMBs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:01:48 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11255 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeBTMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:00:28 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 04:00:27 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pombredanne@nexb.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 6/7] arm64: tegra: Add Tegra194 chip device tree
Date: Tue, 20 Feb 2018 13:58:11 +0200
Message-ID: <20180220115812.24108-7-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220115812.24108-1-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the chip-level device tree, including binding headers, for the
NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
are initially available, enough to boot to UART console.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---

Notes:
    v4:
    - fixed copyright headers according to license-rules.rst
    - removed comments from clock bindings
    
    v3:
    - added hypervisor-related apertures to GIC node
    - removed GPL boilerplate in favor of SPDX and harmonized
      copyright headers

 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 344 +++++++++++++++++++++++++
 include/dt-bindings/clock/tegra194-clock.h     | 321 +++++++++++++++++++++++
 include/dt-bindings/gpio/tegra194-gpio.h       |  61 +++++
 include/dt-bindings/power/tegra194-powergate.h |  35 +++
 include/dt-bindings/reset/tegra194-reset.h     | 152 +++++++++++
 5 files changed, 913 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
 create mode 100644 include/dt-bindings/clock/tegra194-clock.h
 create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
 create mode 100644 include/dt-bindings/power/tegra194-powergate.h
 create mode 100644 include/dt-bindings/reset/tegra194-reset.h

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
new file mode 100644
index 000000000000..6322ef265c2f
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/clock/tegra194-clock.h>
+#include <dt-bindings/gpio/tegra194-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/tegra186-hsp.h>
+#include <dt-bindings/reset/tegra194-reset.h>
+
+/ {
+	compatible = "nvidia,tegra194";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	/* control backbone */
+	cbb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x40000000>;
+
+		uarta: serial@3100000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x03100000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTA>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTA>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		uartb: serial@3110000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x03110000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTB>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTB>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		uartd: serial@3130000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x03130000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTD>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTD>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		uarte: serial@3140000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x03140000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTE>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTE>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		uartf: serial@3150000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x03150000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTF>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTF>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		gen1_i2c: i2c@3160000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x03160000 0x10000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C1>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C1>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		uarth: serial@3170000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x03170000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTH>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTH>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		cam_i2c: i2c@3180000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x03180000 0x10000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C3>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C3>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		/* shares pads with dpaux1 */
+		dp_aux_ch1_i2c: i2c@3190000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x03190000 0x10000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C4>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C4>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		/* shares pads with dpaux0 */
+		dp_aux_ch0_i2c: i2c@31b0000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x031b0000 0x10000>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C6>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C6>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		gen7_i2c: i2c@31c0000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x031c0000 0x10000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C7>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C7>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		gen9_i2c: i2c@31e0000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x031e0000 0x10000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C9>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C9>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		sdmmc1: sdhci@3400000 {
+			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
+			reg = <0x03400000 0x10000>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_SDMMC1>;
+			clock-names = "sdhci";
+			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		sdmmc3: sdhci@3440000 {
+			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
+			reg = <0x03440000 0x10000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_SDMMC3>;
+			clock-names = "sdhci";
+			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		sdmmc4: sdhci@3460000 {
+			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
+			reg = <0x03460000 0x10000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_SDMMC4>;
+			clock-names = "sdhci";
+			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@3881000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x03881000 0x1000>,
+			      <0x03882000 0x2000>,
+			      <0x03884000 0x2000>,
+			      <0x03886000 0x2000>;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-parent = <&gic>;
+		};
+
+		hsp_top0: hsp@3c00000 {
+			compatible = "nvidia,tegra186-hsp";
+			reg = <0x03c00000 0xa0000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "doorbell";
+			#mbox-cells = <2>;
+		};
+
+		gen2_i2c: i2c@c240000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0c240000 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C2>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C2>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		gen8_i2c: i2c@c250000 {
+			compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0c250000 0x10000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_I2C8>;
+			clock-names = "div-clk";
+			resets = <&bpmp TEGRA194_RESET_I2C8>;
+			reset-names = "i2c";
+			status = "disabled";
+		};
+
+		uartc: serial@c280000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x0c280000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTC>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTC>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		uartg: serial@c290000 {
+			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+			reg = <0x0c290000 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_UARTG>;
+			clock-names = "serial";
+			resets = <&bpmp TEGRA194_RESET_UARTG>;
+			reset-names = "serial";
+			status = "disabled";
+		};
+
+		pmc@c360000 {
+			compatible = "nvidia,tegra194-pmc";
+			reg = <0x0c360000 0x10000>,
+			      <0x0c370000 0x10000>,
+			      <0x0c380000 0x10000>,
+			      <0x0c390000 0x10000>,
+			      <0x0c3a0000 0x10000>;
+			reg-names = "pmc", "wake", "aotag", "scratch", "misc";
+		};
+	};
+
+	sysram@40000000 {
+		compatible = "nvidia,tegra194-sysram", "mmio-sram";
+		reg = <0x0 0x40000000 0x0 0x50000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x40000000 0x50000>;
+
+		cpu_bpmp_tx: shmem@4e000 {
+			compatible = "nvidia,tegra194-bpmp-shmem";
+			reg = <0x4e000 0x1000>;
+			label = "cpu-bpmp-tx";
+			pool;
+		};
+
+		cpu_bpmp_rx: shmem@4f000 {
+			compatible = "nvidia,tegra194-bpmp-shmem";
+			reg = <0x4f000 0x1000>;
+			label = "cpu-bpmp-rx";
+			pool;
+		};
+	};
+
+	bpmp: bpmp {
+		compatible = "nvidia,tegra186-bpmp";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
+				    TEGRA_HSP_DB_MASTER_BPMP>;
+		shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+
+		bpmp_i2c: i2c {
+			compatible = "nvidia,tegra186-bpmp-i2c";
+			nvidia,bpmp-bus-id = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		bpmp_thermal: thermal {
+			compatible = "nvidia,tegra186-bpmp-thermal";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
+	};
+};
diff --git a/include/dt-bindings/clock/tegra194-clock.h b/include/dt-bindings/clock/tegra194-clock.h
new file mode 100644
index 000000000000..a2ff66342d69
--- /dev/null
+++ b/include/dt-bindings/clock/tegra194-clock.h
@@ -0,0 +1,321 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved. */
+
+#ifndef __ABI_MACH_T194_CLOCK_H
+#define __ABI_MACH_T194_CLOCK_H
+
+#define TEGRA194_CLK_ACTMON			1
+#define TEGRA194_CLK_ADSP			2
+#define TEGRA194_CLK_ADSPNEON			3
+#define TEGRA194_CLK_AHUB			4
+#define TEGRA194_CLK_APB2APE			5
+#define TEGRA194_CLK_APE			6
+#define TEGRA194_CLK_AUD_MCLK			7
+#define TEGRA194_CLK_AXI_CBB			8
+#define TEGRA194_CLK_CAN1			9
+#define TEGRA194_CLK_CAN1_HOST			10
+#define TEGRA194_CLK_CAN2			11
+#define TEGRA194_CLK_CAN2_HOST			12
+#define TEGRA194_CLK_CEC			13
+#define TEGRA194_CLK_CLK_M			14
+#define TEGRA194_CLK_DMIC1			15
+#define TEGRA194_CLK_DMIC2			16
+#define TEGRA194_CLK_DMIC3			17
+#define TEGRA194_CLK_DMIC4			18
+#define TEGRA194_CLK_DPAUX			19
+#define TEGRA194_CLK_DPAUX1			20
+#define TEGRA194_CLK_ACLK			21
+#define TEGRA194_CLK_MSS_ENCRYPT		22
+#define TEGRA194_CLK_EQOS_RX_INPUT		23
+#define TEGRA194_CLK_IQC2			24
+#define TEGRA194_CLK_AON_APB			25
+#define TEGRA194_CLK_AON_NIC			26
+#define TEGRA194_CLK_AON_CPU_NIC		27
+#define TEGRA194_CLK_PLLA1			28
+#define TEGRA194_CLK_DSPK1			29
+#define TEGRA194_CLK_DSPK2			30
+#define TEGRA194_CLK_EMC			31
+#define TEGRA194_CLK_EQOS_AXI			32
+#define TEGRA194_CLK_EQOS_PTP_REF		33
+#define TEGRA194_CLK_EQOS_RX			34
+#define TEGRA194_CLK_EQOS_TX			35
+#define TEGRA194_CLK_EXTPERIPH1			36
+#define TEGRA194_CLK_EXTPERIPH2			37
+#define TEGRA194_CLK_EXTPERIPH3			38
+#define TEGRA194_CLK_EXTPERIPH4			39
+#define TEGRA194_CLK_FUSE			40
+#define TEGRA194_CLK_GPCCLK			41
+#define TEGRA194_CLK_GPU_PWR			42
+#define TEGRA194_CLK_HDA			43
+#define TEGRA194_CLK_HDA2CODEC_2X		44
+#define TEGRA194_CLK_HDA2HDMICODEC		45
+#define TEGRA194_CLK_HOST1X			46
+#define TEGRA194_CLK_HSIC_TRK			47
+#define TEGRA194_CLK_I2C1			48
+#define TEGRA194_CLK_I2C2			49
+#define TEGRA194_CLK_I2C3			50
+#define TEGRA194_CLK_I2C4			51
+#define TEGRA194_CLK_I2C6			52
+#define TEGRA194_CLK_I2C7			53
+#define TEGRA194_CLK_I2C8			54
+#define TEGRA194_CLK_I2C9			55
+#define TEGRA194_CLK_I2S1			56
+#define TEGRA194_CLK_I2S1_SYNC_INPUT		57
+#define TEGRA194_CLK_I2S2			58
+#define TEGRA194_CLK_I2S2_SYNC_INPUT		59
+#define TEGRA194_CLK_I2S3			60
+#define TEGRA194_CLK_I2S3_SYNC_INPUT		61
+#define TEGRA194_CLK_I2S4			62
+#define TEGRA194_CLK_I2S4_SYNC_INPUT		63
+#define TEGRA194_CLK_I2S5			64
+#define TEGRA194_CLK_I2S5_SYNC_INPUT		65
+#define TEGRA194_CLK_I2S6			66
+#define TEGRA194_CLK_I2S6_SYNC_INPUT		67
+#define TEGRA194_CLK_IQC1			68
+#define TEGRA194_CLK_ISP			69
+#define TEGRA194_CLK_KFUSE			70
+#define TEGRA194_CLK_MAUD			71
+#define TEGRA194_CLK_MIPI_CAL			72
+#define TEGRA194_CLK_MPHY_CORE_PLL_FIXED	73
+#define TEGRA194_CLK_MPHY_L0_RX_ANA		74
+#define TEGRA194_CLK_MPHY_L0_RX_LS_BIT		75
+#define TEGRA194_CLK_MPHY_L0_RX_SYMB		76
+#define TEGRA194_CLK_MPHY_L0_TX_LS_3XBIT	77
+#define TEGRA194_CLK_MPHY_L0_TX_SYMB		78
+#define TEGRA194_CLK_MPHY_L1_RX_ANA		79
+#define TEGRA194_CLK_MPHY_TX_1MHZ_REF		80
+#define TEGRA194_CLK_NVCSI			81
+#define TEGRA194_CLK_NVCSILP			82
+#define TEGRA194_CLK_NVDEC			83
+#define TEGRA194_CLK_NVDISPLAYHUB		84
+#define TEGRA194_CLK_NVDISPLAY_DISP		85
+#define TEGRA194_CLK_NVDISPLAY_P0		86
+#define TEGRA194_CLK_NVDISPLAY_P1		87
+#define TEGRA194_CLK_NVDISPLAY_P2		88
+#define TEGRA194_CLK_NVENC			89
+#define TEGRA194_CLK_NVJPG			90
+#define TEGRA194_CLK_OSC			91
+#define TEGRA194_CLK_AON_TOUCH			92
+#define TEGRA194_CLK_PLLA			93
+#define TEGRA194_CLK_PLLAON			94
+#define TEGRA194_CLK_PLLD			95
+#define TEGRA194_CLK_PLLD2			96
+#define TEGRA194_CLK_PLLD3			97
+#define TEGRA194_CLK_PLLDP			98
+#define TEGRA194_CLK_PLLD4			99
+#define TEGRA194_CLK_PLLE			100
+#define TEGRA194_CLK_PLLP			101
+#define TEGRA194_CLK_PLLP_OUT0			102
+#define TEGRA194_CLK_UTMIPLL			103
+#define TEGRA194_CLK_PLLA_OUT0			104
+#define TEGRA194_CLK_PWM1			105
+#define TEGRA194_CLK_PWM2			106
+#define TEGRA194_CLK_PWM3			107
+#define TEGRA194_CLK_PWM4			108
+#define TEGRA194_CLK_PWM5			109
+#define TEGRA194_CLK_PWM6			110
+#define TEGRA194_CLK_PWM7			111
+#define TEGRA194_CLK_PWM8			112
+#define TEGRA194_CLK_RCE_CPU_NIC		113
+#define TEGRA194_CLK_RCE_NIC			114
+#define TEGRA194_CLK_SATA			115
+#define TEGRA194_CLK_SATA_OOB			116
+#define TEGRA194_CLK_AON_I2C_SLOW		117
+#define TEGRA194_CLK_SCE_CPU_NIC		118
+#define TEGRA194_CLK_SCE_NIC			119
+#define TEGRA194_CLK_SDMMC1			120
+#define TEGRA194_CLK_UPHY_PLL3			121
+#define TEGRA194_CLK_SDMMC3			122
+#define TEGRA194_CLK_SDMMC4			123
+#define TEGRA194_CLK_SE				124
+#define TEGRA194_CLK_SOR0_OUT			125
+#define TEGRA194_CLK_SOR0_REF			126
+#define TEGRA194_CLK_SOR0_PAD_CLKOUT		127
+#define TEGRA194_CLK_SOR1_OUT			128
+#define TEGRA194_CLK_SOR1_REF			129
+#define TEGRA194_CLK_SOR1_PAD_CLKOUT		130
+#define TEGRA194_CLK_SOR_SAFE			131
+#define TEGRA194_CLK_IQC1_IN			132
+#define TEGRA194_CLK_IQC2_IN			133
+#define TEGRA194_CLK_DMIC5			134
+#define TEGRA194_CLK_SPI1			135
+#define TEGRA194_CLK_SPI2			136
+#define TEGRA194_CLK_SPI3			137
+#define TEGRA194_CLK_I2C_SLOW			138
+#define TEGRA194_CLK_SYNC_DMIC1			139
+#define TEGRA194_CLK_SYNC_DMIC2			140
+#define TEGRA194_CLK_SYNC_DMIC3			141
+#define TEGRA194_CLK_SYNC_DMIC4			142
+#define TEGRA194_CLK_SYNC_DSPK1			143
+#define TEGRA194_CLK_SYNC_DSPK2			144
+#define TEGRA194_CLK_SYNC_I2S1			145
+#define TEGRA194_CLK_SYNC_I2S2			146
+#define TEGRA194_CLK_SYNC_I2S3			147
+#define TEGRA194_CLK_SYNC_I2S4			148
+#define TEGRA194_CLK_SYNC_I2S5			149
+#define TEGRA194_CLK_SYNC_I2S6			150
+#define TEGRA194_CLK_MPHY_FORCE_LS_MODE		151
+#define TEGRA194_CLK_TACH			152
+#define TEGRA194_CLK_TSEC			153
+#define TEGRA194_CLK_TSECB			154
+#define TEGRA194_CLK_UARTA			155
+#define TEGRA194_CLK_UARTB			156
+#define TEGRA194_CLK_UARTC			157
+#define TEGRA194_CLK_UARTD			158
+#define TEGRA194_CLK_UARTE			159
+#define TEGRA194_CLK_UARTF			160
+#define TEGRA194_CLK_UARTG			161
+#define TEGRA194_CLK_UART_FST_MIPI_CAL		162
+#define TEGRA194_CLK_UFSDEV_REF			163
+#define TEGRA194_CLK_UFSHC			164
+#define TEGRA194_CLK_USB2_TRK			165
+#define TEGRA194_CLK_VI				166
+#define TEGRA194_CLK_VIC			167
+#define TEGRA194_CLK_PVA0_AXI			168
+#define TEGRA194_CLK_PVA0_VPS0			169
+#define TEGRA194_CLK_PVA0_VPS1			170
+#define TEGRA194_CLK_PVA1_AXI			171
+#define TEGRA194_CLK_PVA1_VPS0			172
+#define TEGRA194_CLK_PVA1_VPS1			173
+#define TEGRA194_CLK_DLA0_FALCON		174
+#define TEGRA194_CLK_DLA0_CORE			175
+#define TEGRA194_CLK_DLA1_FALCON		176
+#define TEGRA194_CLK_DLA1_CORE			177
+#define TEGRA194_CLK_SOR2_OUT			178
+#define TEGRA194_CLK_SOR2_REF			179
+#define TEGRA194_CLK_SOR2_PAD_CLKOUT		180
+#define TEGRA194_CLK_SOR3_OUT			181
+#define TEGRA194_CLK_SOR3_REF			182
+#define TEGRA194_CLK_SOR3_PAD_CLKOUT		183
+#define TEGRA194_CLK_NVDISPLAY_P3		184
+#define TEGRA194_CLK_DPAUX2			185
+#define TEGRA194_CLK_DPAUX3			186
+#define TEGRA194_CLK_NVDEC1			187
+#define TEGRA194_CLK_NVENC1			188
+#define TEGRA194_CLK_SE_FREE			189
+#define TEGRA194_CLK_UARTH			190
+#define TEGRA194_CLK_FUSE_SERIAL		191
+#define TEGRA194_CLK_QSPI0			192
+#define TEGRA194_CLK_QSPI1			193
+#define TEGRA194_CLK_QSPI0_PM			194
+#define TEGRA194_CLK_QSPI1_PM			195
+#define TEGRA194_CLK_VI_CONST			196
+#define TEGRA194_CLK_NAFLL_BPMP			197
+#define TEGRA194_CLK_NAFLL_SCE			198
+#define TEGRA194_CLK_NAFLL_NVDEC		199
+#define TEGRA194_CLK_NAFLL_NVJPG		200
+#define TEGRA194_CLK_NAFLL_TSEC			201
+#define TEGRA194_CLK_NAFLL_TSECB		202
+#define TEGRA194_CLK_NAFLL_VI			203
+#define TEGRA194_CLK_NAFLL_SE			204
+#define TEGRA194_CLK_NAFLL_NVENC		205
+#define TEGRA194_CLK_NAFLL_ISP			206
+#define TEGRA194_CLK_NAFLL_VIC			207
+#define TEGRA194_CLK_NAFLL_NVDISPLAYHUB		208
+#define TEGRA194_CLK_NAFLL_AXICBB		209
+#define TEGRA194_CLK_NAFLL_DLA			210
+#define TEGRA194_CLK_NAFLL_PVA_CORE		211
+#define TEGRA194_CLK_NAFLL_PVA_VPS		212
+#define TEGRA194_CLK_NAFLL_CVNAS		213
+#define TEGRA194_CLK_NAFLL_RCE			214
+#define TEGRA194_CLK_NAFLL_NVENC1		215
+#define TEGRA194_CLK_NAFLL_DLA_FALCON		216
+#define TEGRA194_CLK_NAFLL_NVDEC1		217
+#define TEGRA194_CLK_NAFLL_GPU			218
+#define TEGRA194_CLK_SDMMC_LEGACY_TM		219
+#define TEGRA194_CLK_PEX0_CORE_0		220
+#define TEGRA194_CLK_PEX0_CORE_1		221
+#define TEGRA194_CLK_PEX0_CORE_2		222
+#define TEGRA194_CLK_PEX0_CORE_3		223
+#define TEGRA194_CLK_PEX0_CORE_4		224
+#define TEGRA194_CLK_PEX1_CORE_5		225
+#define TEGRA194_CLK_PEX_REF1			226
+#define TEGRA194_CLK_PEX_REF2			227
+#define TEGRA194_CLK_CSI_A			229
+#define TEGRA194_CLK_CSI_B			230
+#define TEGRA194_CLK_CSI_C			231
+#define TEGRA194_CLK_CSI_D			232
+#define TEGRA194_CLK_CSI_E			233
+#define TEGRA194_CLK_CSI_F			234
+#define TEGRA194_CLK_CSI_G			235
+#define TEGRA194_CLK_CSI_H			236
+#define TEGRA194_CLK_PLLC4			237
+#define TEGRA194_CLK_PLLC4_OUT			238
+#define TEGRA194_CLK_PLLC4_OUT1			239
+#define TEGRA194_CLK_PLLC4_OUT2			240
+#define TEGRA194_CLK_PLLC4_MUXED		241
+#define TEGRA194_CLK_PLLC4_VCO_DIV2		242
+#define TEGRA194_CLK_CSI_A_PAD			244
+#define TEGRA194_CLK_CSI_B_PAD			245
+#define TEGRA194_CLK_CSI_C_PAD			246
+#define TEGRA194_CLK_CSI_D_PAD			247
+#define TEGRA194_CLK_CSI_E_PAD			248
+#define TEGRA194_CLK_CSI_F_PAD			249
+#define TEGRA194_CLK_CSI_G_PAD			250
+#define TEGRA194_CLK_CSI_H_PAD			251
+#define TEGRA194_CLK_PEX_SATA_USB_RX_BYP	254
+#define TEGRA194_CLK_PEX_USB_PAD_PLL0_MGMT	255
+#define TEGRA194_CLK_PEX_USB_PAD_PLL1_MGMT	256
+#define TEGRA194_CLK_PEX_USB_PAD_PLL2_MGMT	257
+#define TEGRA194_CLK_PEX_USB_PAD_PLL3_MGMT	258
+#define TEGRA194_CLK_XUSB_CORE_DEV		265
+#define TEGRA194_CLK_XUSB_CORE_MUX		266
+#define TEGRA194_CLK_XUSB_CORE_HOST		267
+#define TEGRA194_CLK_XUSB_CORE_SS		268
+#define TEGRA194_CLK_XUSB_FALCON		269
+#define TEGRA194_CLK_XUSB_FALCON_HOST		270
+#define TEGRA194_CLK_XUSB_FALCON_SS		271
+#define TEGRA194_CLK_XUSB_FS			272
+#define TEGRA194_CLK_XUSB_FS_HOST		273
+#define TEGRA194_CLK_XUSB_FS_DEV		274
+#define TEGRA194_CLK_XUSB_SS			275
+#define TEGRA194_CLK_XUSB_SS_DEV		276
+#define TEGRA194_CLK_XUSB_SS_SUPERSPEED		277
+#define TEGRA194_CLK_PLLDISPHUB			278
+#define TEGRA194_CLK_PLLDISPHUB_DIV		279
+#define TEGRA194_CLK_NAFLL_CLUSTER0		280
+#define TEGRA194_CLK_NAFLL_CLUSTER1		281
+#define TEGRA194_CLK_NAFLL_CLUSTER2		282
+#define TEGRA194_CLK_NAFLL_CLUSTER3		283
+#define TEGRA194_CLK_CAN1_CORE			284
+#define TEGRA194_CLK_CAN2_CORE			285
+#define TEGRA194_CLK_PLLA1_OUT1			286
+#define TEGRA194_CLK_PLLREFE_VCOOUT		288
+#define TEGRA194_CLK_CLK_32K			289
+#define TEGRA194_CLK_SPDIFIN_SYNC_INPUT		290
+#define TEGRA194_CLK_UTMIPLL_CLKOUT48		291
+#define TEGRA194_CLK_UTMIPLL_CLKOUT480		292
+#define TEGRA194_CLK_CVNAS			293
+#define TEGRA194_CLK_PLLNVCSI			294
+#define TEGRA194_CLK_PVA0_CPU_AXI		295
+#define TEGRA194_CLK_PVA1_CPU_AXI		296
+#define TEGRA194_CLK_PVA0_VPS			297
+#define TEGRA194_CLK_PVA1_VPS			298
+#define TEGRA194_CLK_DLA0_FALCON_MUX		299
+#define TEGRA194_CLK_DLA1_FALCON_MUX		300
+#define TEGRA194_CLK_DLA0_CORE_MUX		301
+#define TEGRA194_CLK_DLA1_CORE_MUX		302
+#define TEGRA194_CLK_UTMIPLL_HPS		304
+#define TEGRA194_CLK_I2C5			305
+#define TEGRA194_CLK_I2C10			306
+#define TEGRA194_CLK_BPMP_CPU_NIC		307
+#define TEGRA194_CLK_BPMP_APB			308
+#define TEGRA194_CLK_TSC			309
+#define TEGRA194_CLK_EMCSA			310
+#define TEGRA194_CLK_EMCSB			311
+#define TEGRA194_CLK_EMCSC			312
+#define TEGRA194_CLK_EMCSD			313
+#define TEGRA194_CLK_PLLC			314
+#define TEGRA194_CLK_PLLC2			315
+#define TEGRA194_CLK_PLLC3			316
+#define TEGRA194_CLK_TSC_REF			317
+#define TEGRA194_CLK_FUSE_BURN			318
+#define TEGRA194_CLK_PEX0_CORE_0M		319
+#define TEGRA194_CLK_PEX0_CORE_1M		320
+#define TEGRA194_CLK_PEX0_CORE_2M		321
+#define TEGRA194_CLK_PEX0_CORE_3M		322
+#define TEGRA194_CLK_PEX0_CORE_4M		323
+#define TEGRA194_CLK_PEX1_CORE_5M		324
+#define TEGRA194_CLK_PLLE_HPS			326
+
+#endif
diff --git a/include/dt-bindings/gpio/tegra194-gpio.h b/include/dt-bindings/gpio/tegra194-gpio.h
new file mode 100644
index 000000000000..ede860225f6b
--- /dev/null
+++ b/include/dt-bindings/gpio/tegra194-gpio.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved. */
+
+/*
+ * This header provides constants for binding nvidia,tegra194-gpio*.
+ *
+ * The first cell in Tegra's GPIO specifier is the GPIO ID. The macros below
+ * provide names for this.
+ *
+ * The second cell contains standard flag values specified in gpio.h.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_TEGRA194_GPIO_H
+#define _DT_BINDINGS_GPIO_TEGRA194_GPIO_H
+
+#include <dt-bindings/gpio/gpio.h>
+
+/* GPIOs implemented by main GPIO controller */
+#define TEGRA194_MAIN_GPIO_PORT_A 0
+#define TEGRA194_MAIN_GPIO_PORT_B 1
+#define TEGRA194_MAIN_GPIO_PORT_C 2
+#define TEGRA194_MAIN_GPIO_PORT_D 3
+#define TEGRA194_MAIN_GPIO_PORT_E 4
+#define TEGRA194_MAIN_GPIO_PORT_F 5
+#define TEGRA194_MAIN_GPIO_PORT_G 6
+#define TEGRA194_MAIN_GPIO_PORT_H 7
+#define TEGRA194_MAIN_GPIO_PORT_I 8
+#define TEGRA194_MAIN_GPIO_PORT_J 9
+#define TEGRA194_MAIN_GPIO_PORT_K 10
+#define TEGRA194_MAIN_GPIO_PORT_L 11
+#define TEGRA194_MAIN_GPIO_PORT_M 12
+#define TEGRA194_MAIN_GPIO_PORT_N 13
+#define TEGRA194_MAIN_GPIO_PORT_O 14
+#define TEGRA194_MAIN_GPIO_PORT_P 15
+#define TEGRA194_MAIN_GPIO_PORT_Q 16
+#define TEGRA194_MAIN_GPIO_PORT_R 17
+#define TEGRA194_MAIN_GPIO_PORT_S 18
+#define TEGRA194_MAIN_GPIO_PORT_T 19
+#define TEGRA194_MAIN_GPIO_PORT_U 20
+#define TEGRA194_MAIN_GPIO_PORT_V 21
+#define TEGRA194_MAIN_GPIO_PORT_W 22
+#define TEGRA194_MAIN_GPIO_PORT_X 23
+#define TEGRA194_MAIN_GPIO_PORT_Y 24
+#define TEGRA194_MAIN_GPIO_PORT_Z 25
+#define TEGRA194_MAIN_GPIO_PORT_FF 26
+#define TEGRA194_MAIN_GPIO_PORT_GG 27
+
+#define TEGRA194_MAIN_GPIO(port, offset) \
+	((TEGRA194_MAIN_GPIO_PORT_##port * 8) + offset)
+
+/* GPIOs implemented by AON GPIO controller */
+#define TEGRA194_AON_GPIO_PORT_AA 0
+#define TEGRA194_AON_GPIO_PORT_BB 1
+#define TEGRA194_AON_GPIO_PORT_CC 2
+#define TEGRA194_AON_GPIO_PORT_DD 3
+#define TEGRA194_AON_GPIO_PORT_EE 4
+
+#define TEGRA194_AON_GPIO(port, offset) \
+	((TEGRA194_AON_GPIO_PORT_##port * 8) + offset)
+
+#endif
diff --git a/include/dt-bindings/power/tegra194-powergate.h b/include/dt-bindings/power/tegra194-powergate.h
new file mode 100644
index 000000000000..82253742a493
--- /dev/null
+++ b/include/dt-bindings/power/tegra194-powergate.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved. */
+
+#ifndef __ABI_MACH_T194_POWERGATE_T194_H_
+#define __ABI_MACH_T194_POWERGATE_T194_H_
+
+#define TEGRA194_POWER_DOMAIN_AUD	1
+#define TEGRA194_POWER_DOMAIN_DISP	2
+#define TEGRA194_POWER_DOMAIN_DISPB	3
+#define TEGRA194_POWER_DOMAIN_DISPC	4
+#define TEGRA194_POWER_DOMAIN_ISPA	5
+#define TEGRA194_POWER_DOMAIN_NVDECA	6
+#define TEGRA194_POWER_DOMAIN_NVJPG	7
+#define TEGRA194_POWER_DOMAIN_NVENCA	8
+#define TEGRA194_POWER_DOMAIN_NVENCB	9
+#define TEGRA194_POWER_DOMAIN_NVDECB	10
+#define TEGRA194_POWER_DOMAIN_SAX	11
+#define TEGRA194_POWER_DOMAIN_VE	12
+#define TEGRA194_POWER_DOMAIN_VIC	13
+#define TEGRA194_POWER_DOMAIN_XUSBA	14
+#define TEGRA194_POWER_DOMAIN_XUSBB	15
+#define TEGRA194_POWER_DOMAIN_XUSBC	16
+#define TEGRA194_POWER_DOMAIN_PCIEX8A	17
+#define TEGRA194_POWER_DOMAIN_PCIEX4A	18
+#define TEGRA194_POWER_DOMAIN_PCIEX1A	19
+#define TEGRA194_POWER_DOMAIN_PCIEX8B	21
+#define TEGRA194_POWER_DOMAIN_PVAA	22
+#define TEGRA194_POWER_DOMAIN_PVAB	23
+#define TEGRA194_POWER_DOMAIN_DLAA	24
+#define TEGRA194_POWER_DOMAIN_DLAB	25
+#define TEGRA194_POWER_DOMAIN_CV	26
+#define TEGRA194_POWER_DOMAIN_GPU	27
+#define TEGRA194_POWER_DOMAIN_MAX	27
+
+#endif
diff --git a/include/dt-bindings/reset/tegra194-reset.h b/include/dt-bindings/reset/tegra194-reset.h
new file mode 100644
index 000000000000..473afaa25bfb
--- /dev/null
+++ b/include/dt-bindings/reset/tegra194-reset.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved. */
+
+#ifndef __ABI_MACH_T194_RESET_H
+#define __ABI_MACH_T194_RESET_H
+
+#define TEGRA194_RESET_ACTMON			1
+#define TEGRA194_RESET_ADSP_ALL			2
+#define TEGRA194_RESET_AFI			3
+#define TEGRA194_RESET_CAN1			4
+#define TEGRA194_RESET_CAN2			5
+#define TEGRA194_RESET_DLA0			6
+#define TEGRA194_RESET_DLA1			7
+#define TEGRA194_RESET_DPAUX			8
+#define TEGRA194_RESET_DPAUX1			9
+#define TEGRA194_RESET_DPAUX2			10
+#define TEGRA194_RESET_DPAUX3			11
+#define TEGRA194_RESET_EQOS			17
+#define TEGRA194_RESET_GPCDMA			18
+#define TEGRA194_RESET_GPU			19
+#define TEGRA194_RESET_HDA			20
+#define TEGRA194_RESET_HDA2CODEC_2X		21
+#define TEGRA194_RESET_HDA2HDMICODEC		22
+#define TEGRA194_RESET_HOST1X			23
+#define TEGRA194_RESET_I2C1			24
+#define TEGRA194_RESET_I2C10			25
+#define TEGRA194_RESET_RSVD_26			26
+#define TEGRA194_RESET_RSVD_27			27
+#define TEGRA194_RESET_RSVD_28			28
+#define TEGRA194_RESET_I2C2			29
+#define TEGRA194_RESET_I2C3			30
+#define TEGRA194_RESET_I2C4			31
+#define TEGRA194_RESET_I2C6			32
+#define TEGRA194_RESET_I2C7			33
+#define TEGRA194_RESET_I2C8			34
+#define TEGRA194_RESET_I2C9			35
+#define TEGRA194_RESET_ISP			36
+#define TEGRA194_RESET_MIPI_CAL			37
+#define TEGRA194_RESET_MPHY_CLK_CTL		38
+#define TEGRA194_RESET_MPHY_L0_RX		39
+#define TEGRA194_RESET_MPHY_L0_TX		40
+#define TEGRA194_RESET_MPHY_L1_RX		41
+#define TEGRA194_RESET_MPHY_L1_TX		42
+#define TEGRA194_RESET_NVCSI			43
+#define TEGRA194_RESET_NVDEC			44
+#define TEGRA194_RESET_NVDISPLAY0_HEAD0		45
+#define TEGRA194_RESET_NVDISPLAY0_HEAD1		46
+#define TEGRA194_RESET_NVDISPLAY0_HEAD2		47
+#define TEGRA194_RESET_NVDISPLAY0_HEAD3		48
+#define TEGRA194_RESET_NVDISPLAY0_MISC		49
+#define TEGRA194_RESET_NVDISPLAY0_WGRP0		50
+#define TEGRA194_RESET_NVDISPLAY0_WGRP1		51
+#define TEGRA194_RESET_NVDISPLAY0_WGRP2		52
+#define TEGRA194_RESET_NVDISPLAY0_WGRP3		53
+#define TEGRA194_RESET_NVDISPLAY0_WGRP4		54
+#define TEGRA194_RESET_NVDISPLAY0_WGRP5		55
+#define TEGRA194_RESET_RSVD_56			56
+#define TEGRA194_RESET_RSVD_57			57
+#define TEGRA194_RESET_RSVD_58			58
+#define TEGRA194_RESET_NVENC			59
+#define TEGRA194_RESET_NVENC1			60
+#define TEGRA194_RESET_NVJPG			61
+#define TEGRA194_RESET_PCIE			62
+#define TEGRA194_RESET_PCIEXCLK			63
+#define TEGRA194_RESET_RSVD_64			64
+#define TEGRA194_RESET_RSVD_65			65
+#define TEGRA194_RESET_PVA0_ALL			66
+#define TEGRA194_RESET_PVA1_ALL			67
+#define TEGRA194_RESET_PWM1			68
+#define TEGRA194_RESET_PWM2			69
+#define TEGRA194_RESET_PWM3			70
+#define TEGRA194_RESET_PWM4			71
+#define TEGRA194_RESET_PWM5			72
+#define TEGRA194_RESET_PWM6			73
+#define TEGRA194_RESET_PWM7			74
+#define TEGRA194_RESET_PWM8			75
+#define TEGRA194_RESET_QSPI0			76
+#define TEGRA194_RESET_QSPI1			77
+#define TEGRA194_RESET_SATA			78
+#define TEGRA194_RESET_SATACOLD			79
+#define TEGRA194_RESET_SCE_ALL			80
+#define TEGRA194_RESET_RCE_ALL			81
+#define TEGRA194_RESET_SDMMC1			82
+#define TEGRA194_RESET_RSVD_83			83
+#define TEGRA194_RESET_SDMMC3			84
+#define TEGRA194_RESET_SDMMC4			85
+#define TEGRA194_RESET_SE			86
+#define TEGRA194_RESET_SOR0			87
+#define TEGRA194_RESET_SOR1			88
+#define TEGRA194_RESET_SOR2			89
+#define TEGRA194_RESET_SOR3			90
+#define TEGRA194_RESET_SPI1			91
+#define TEGRA194_RESET_SPI2			92
+#define TEGRA194_RESET_SPI3			93
+#define TEGRA194_RESET_SPI4			94
+#define TEGRA194_RESET_TACH			95
+#define TEGRA194_RESET_RSVD_96			96
+#define TEGRA194_RESET_TSCTNVI			97
+#define TEGRA194_RESET_TSEC			98
+#define TEGRA194_RESET_TSECB			99
+#define TEGRA194_RESET_UARTA			100
+#define TEGRA194_RESET_UARTB			101
+#define TEGRA194_RESET_UARTC			102
+#define TEGRA194_RESET_UARTD			103
+#define TEGRA194_RESET_UARTE			104
+#define TEGRA194_RESET_UARTF			105
+#define TEGRA194_RESET_UARTG			106
+#define TEGRA194_RESET_UARTH			107
+#define TEGRA194_RESET_UFSHC			108
+#define TEGRA194_RESET_UFSHC_AXI_M		109
+#define TEGRA194_RESET_UFSHC_LP_SEQ		110
+#define TEGRA194_RESET_RSVD_111			111
+#define TEGRA194_RESET_VI			112
+#define TEGRA194_RESET_VIC			113
+#define TEGRA194_RESET_XUSB_PADCTL		114
+#define TEGRA194_RESET_NVDEC1			115
+#define TEGRA194_RESET_PEX0_CORE_0		116
+#define TEGRA194_RESET_PEX0_CORE_1		117
+#define TEGRA194_RESET_PEX0_CORE_2		118
+#define TEGRA194_RESET_PEX0_CORE_3		119
+#define TEGRA194_RESET_PEX0_CORE_4		120
+#define TEGRA194_RESET_PEX0_CORE_0_APB		121
+#define TEGRA194_RESET_PEX0_CORE_1_APB		122
+#define TEGRA194_RESET_PEX0_CORE_2_APB		123
+#define TEGRA194_RESET_PEX0_CORE_3_APB		124
+#define TEGRA194_RESET_PEX0_CORE_4_APB		125
+#define TEGRA194_RESET_PEX0_COMMON_APB		126
+#define TEGRA194_RESET_PEX1_CORE_5		129
+#define TEGRA194_RESET_PEX1_CORE_5_APB		130
+#define TEGRA194_RESET_CVNAS			131
+#define TEGRA194_RESET_CVNAS_FCM		132
+#define TEGRA194_RESET_DMIC5			144
+#define TEGRA194_RESET_APE			145
+#define TEGRA194_RESET_PEX_USB_UPHY		146
+#define TEGRA194_RESET_PEX_USB_UPHY_L0		147
+#define TEGRA194_RESET_PEX_USB_UPHY_L1		148
+#define TEGRA194_RESET_PEX_USB_UPHY_L2		149
+#define TEGRA194_RESET_PEX_USB_UPHY_L3		150
+#define TEGRA194_RESET_PEX_USB_UPHY_L4		151
+#define TEGRA194_RESET_PEX_USB_UPHY_L5		152
+#define TEGRA194_RESET_PEX_USB_UPHY_L6		153
+#define TEGRA194_RESET_PEX_USB_UPHY_L7		154
+#define TEGRA194_RESET_PEX_USB_UPHY_L8		155
+#define TEGRA194_RESET_PEX_USB_UPHY_L9		156
+#define TEGRA194_RESET_PEX_USB_UPHY_L10		157
+#define TEGRA194_RESET_PEX_USB_UPHY_L11		158
+#define TEGRA194_RESET_PEX_USB_UPHY_PLL0	159
+#define TEGRA194_RESET_PEX_USB_UPHY_PLL1	160
+#define TEGRA194_RESET_PEX_USB_UPHY_PLL2	161
+#define TEGRA194_RESET_PEX_USB_UPHY_PLL3	162
+
+#endif
-- 
2.16.1
