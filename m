Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933208AbeEHIZJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933009AbeEHIZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:25:01 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 3/3] ARM: dts: tegra: Add support for 256 MB Colibri-T20 (plus such board on Iris)
Date: Tue,  8 May 2018 10:24:41 +0200
Message-Id: <1525767881-28516-4-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525767881-28516-1-git-send-email-krzk@kernel.org>
References: <1525767881-28516-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB RAM
(with 1024 MB NAND) flavors.  Add support for the 256 MB version on Iris
evaluation board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Do not add new compatible but use everywhere existing
   "toradex,colibri_t20-512" (suggested by Rob).

Changes since v1:
1. Fix memory size in tegra20-colibri-256.dtsi (was working fine because
   my bootloader uses mem= argument).
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/tegra20-colibri-256.dtsi |  11 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 532 +---------------------------
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 536 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-iris-256.dts     |   9 +
 arch/arm/boot/dts/tegra20-iris-512.dts     |  99 +-----
 arch/arm/boot/dts/tegra20-iris-common.dtsi | 107 ++++++
 7 files changed, 666 insertions(+), 629 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-256.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-iris-256.dts
 create mode 100644 arch/arm/boot/dts/tegra20-iris-common.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ec2024ea8b1e..38b986ec2fa1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1030,6 +1030,7 @@ dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-harmony.dtb \
+	tegra20-iris-256.dtb \
 	tegra20-iris-512.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
diff --git a/arch/arm/boot/dts/tegra20-colibri-256.dtsi b/arch/arm/boot/dts/tegra20-colibri-256.dtsi
new file mode 100644
index 000000000000..aeb6033f8f2f
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-colibri-256.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tegra20-colibri.dtsi"
+
+/ {
+	model = "Toradex Colibri T20 256MB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 305efb275b48..c0544f506a46 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -1,541 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "tegra20.dtsi"
+#include "tegra20-colibri.dtsi"
 
 / {
 	model = "Toradex Colibri T20 512MB";
-	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
-
-	aliases {
-		rtc0 = "/i2c@7000d000/tps6586x@34";
-		rtc1 = "/rtc@7000e000";
-	};
 
 	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
-
-	host1x@50000000 {
-		hdmi@54280000 {
-			vdd-supply = <&hdmi_vdd_reg>;
-			pll-supply = <&hdmi_pll_reg>;
-
-			nvidia,ddc-i2c-bus = <&i2c_ddc>;
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
-				GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	pinmux@70000014 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&state_default>;
-
-		state_default: pinmux {
-			audio_refclk {
-				nvidia,pins = "cdev1";
-				nvidia,function = "plla_out";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			crt {
-				nvidia,pins = "crtp";
-				nvidia,function = "crt";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			dap3 {
-				nvidia,pins = "dap3";
-				nvidia,function = "dap3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			displaya {
-				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
-					"ld4", "ld5", "ld6", "ld7", "ld8",
-					"ld9", "ld10", "ld11", "ld12", "ld13",
-					"ld14", "ld15", "ld16", "ld17",
-					"lhs", "lpw0", "lpw2", "lsc0",
-					"lsc1", "lsck", "lsda", "lspi", "lvs";
-				nvidia,function = "displaya";
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			gpio_dte {
-				nvidia,pins = "dte";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			gpio_gmi {
-				nvidia,pins = "ata", "atc", "atd", "ate",
-					"dap1", "dap2", "dap4", "gpu", "irrx",
-					"irtx", "spia", "spib", "spic";
-				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			gpio_pta {
-				nvidia,pins = "pta";
-				nvidia,function = "rsvd4";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			gpio_uac {
-				nvidia,pins = "uac";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			hdint {
-				nvidia,pins = "hdint";
-				nvidia,function = "hdmi";
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			i2c1 {
-				nvidia,pins = "rm";
-				nvidia,function = "i2c1";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			i2c3 {
-				nvidia,pins = "dtf";
-				nvidia,function = "i2c3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			i2cddc {
-				nvidia,pins = "ddc";
-				nvidia,function = "i2c2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			i2cp {
-				nvidia,pins = "i2cp";
-				nvidia,function = "i2cp";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			irda {
-				nvidia,pins = "uad";
-				nvidia,function = "irda";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			nand {
-				nvidia,pins = "kbca", "kbcc", "kbcd",
-					"kbce", "kbcf";
-				nvidia,function = "nand";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			owc {
-				nvidia,pins = "owc";
-				nvidia,function = "owr";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			pmc {
-				nvidia,pins = "pmc";
-				nvidia,function = "pwr_on";
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			pwm {
-				nvidia,pins = "sdb", "sdc", "sdd";
-				nvidia,function = "pwm";
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			sdio4 {
-				nvidia,pins = "atb", "gma", "gme";
-				nvidia,function = "sdio4";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			spi1 {
-				nvidia,pins = "spid", "spie", "spif";
-				nvidia,function = "spi1";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			spi4 {
-				nvidia,pins = "slxa", "slxc", "slxd", "slxk";
-				nvidia,function = "spi4";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			uarta {
-				nvidia,pins = "sdio1";
-				nvidia,function = "uarta";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			uartd {
-				nvidia,pins = "gmc";
-				nvidia,function = "uartd";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			ulpi {
-				nvidia,pins = "uaa", "uab", "uda";
-				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			ulpi_refclk {
-				nvidia,pins = "cdev2";
-				nvidia,function = "pllp_out4";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			usb_gpio {
-				nvidia,pins = "spig", "spih";
-				nvidia,function = "spi2_alt";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-			vi {
-				nvidia,pins = "dta", "dtb", "dtc", "dtd";
-				nvidia,function = "vi";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-			vi_sc {
-				nvidia,pins = "csus";
-				nvidia,function = "vi_sensor_clk";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-		};
-	};
-
-	ac97: ac97@70002000 {
-		status = "okay";
-		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
-			GPIO_ACTIVE_HIGH>;
-		nvidia,codec-sync-gpio = <&gpio TEGRA_GPIO(P, 0)
-			GPIO_ACTIVE_HIGH>;
-	};
-
-	/*
-	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
-	 * board)
-	 */
-	i2c@7000c000 {
-		clock-frequency = <400000>;
-	};
-
-	/* DDC_SCL/SDA on X3 pin 15/16 (e.g. display EDID) */
-	i2c_ddc: i2c@7000c400 {
-		clock-frequency = <10000>;
-	};
-
-	/* GEN2_I2C: unused */
-
-	/* CAM/GEN3_I2C: used as EXT_IO1/2 GPIOs on SODIMM pin 133/127 */
-
-	/* PWR_I2C: power I2C to PMIC and temperature sensor (On-module) */
-	i2c@7000d000 {
-		status = "okay";
-		clock-frequency = <100000>;
-
-		pmic: tps6586x@34 {
-			compatible = "ti,tps6586x";
-			reg = <0x34>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-
-			ti,system-power-controller;
-
-			#gpio-cells = <2>;
-			gpio-controller;
-
-			sys-supply = <&vdd_3v3_reg>;
-			vin-sm0-supply = <&sys_reg>;
-			vin-sm1-supply = <&sys_reg>;
-			vin-sm2-supply = <&sys_reg>;
-			vinldo01-supply = <&sm2_reg>;
-			vinldo23-supply = <&vdd_3v3_reg>;
-			vinldo4-supply = <&vdd_3v3_reg>;
-			vinldo678-supply = <&vdd_3v3_reg>;
-			vinldo9-supply = <&vdd_3v3_reg>;
-
-			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				sys_reg: regulator@0 {
-					reg = <0>;
-					regulator-compatible = "sys";
-					regulator-name = "vdd_sys";
-					regulator-always-on;
-				};
-
-				regulator@1 {
-					reg = <1>;
-					regulator-compatible = "sm0";
-					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-					regulator-always-on;
-				};
-
-				regulator@2 {
-					reg = <2>;
-					regulator-compatible = "sm1";
-					regulator-name = "vdd_sm1,vdd_cpu";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
-					regulator-always-on;
-				};
-
-				sm2_reg: regulator@3 {
-					reg = <3>;
-					regulator-compatible = "sm2";
-					regulator-name = "vdd_sm2,vin_ldo*";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				/* LDO0 is not connected to anything */
-
-				regulator@5 {
-					reg = <5>;
-					regulator-compatible = "ldo1";
-					regulator-name = "vdd_ldo1,avdd_pll*";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
-					regulator-always-on;
-				};
-
-				regulator@6 {
-					reg = <6>;
-					regulator-compatible = "ldo2";
-					regulator-name = "vdd_ldo2,vdd_rtc";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
-				};
-
-				/* LDO3 is not connected to anything */
-
-				regulator@8 {
-					reg = <8>;
-					regulator-compatible = "ldo4";
-					regulator-name = "vdd_ldo4,avdd_osc,vddio_sys";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-					regulator-always-on;
-				};
-
-				ldo5_reg: regulator@9 {
-					reg = <9>;
-					regulator-compatible = "ldo5";
-					regulator-name = "vdd_ldo5,vdd_fuse";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-				};
-
-				regulator@10 {
-					reg = <10>;
-					regulator-compatible = "ldo6";
-					regulator-name = "vdd_ldo6,avdd_vdac,vddio_vi,vddio_cam";
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-				};
-
-				hdmi_vdd_reg: regulator@11 {
-					reg = <11>;
-					regulator-compatible = "ldo7";
-					regulator-name = "vdd_ldo7,avdd_hdmi";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-				};
-
-				hdmi_pll_reg: regulator@12 {
-					reg = <12>;
-					regulator-compatible = "ldo8";
-					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
-				};
-
-				regulator@13 {
-					reg = <13>;
-					regulator-compatible = "ldo9";
-					regulator-name = "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
-					regulator-min-microvolt = <2850000>;
-					regulator-max-microvolt = <2850000>;
-					regulator-always-on;
-				};
-
-				regulator@14 {
-					reg = <14>;
-					regulator-compatible = "ldo_rtc";
-					regulator-name = "vdd_rtc_out,vdd_cell";
-					regulator-min-microvolt = <3300000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
-				};
-			};
-		};
-
-		temperature-sensor@4c {
-			compatible = "national,lm95245";
-			reg = <0x4c>;
-		};
-	};
-
-	pmc@7000e400 {
-		nvidia,suspend-mode = <1>;
-		nvidia,cpu-pwr-good-time = <5000>;
-		nvidia,cpu-pwr-off-time = <5000>;
-		nvidia,core-pwr-good-time = <3845 3845>;
-		nvidia,core-pwr-off-time = <3875>;
-		nvidia,sys-clock-req-active-high;
-	};
-
-	memory-controller@7000f400 {
-		emc-table@83250 {
-			reg = <83250>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <83250>;
-			nvidia,emc-registers =   <0x00000005 0x00000011
-				0x00000004 0x00000002 0x00000004 0x00000004
-				0x00000001 0x0000000a 0x00000002 0x00000002
-				0x00000001 0x00000001 0x00000003 0x00000004
-				0x00000003 0x00000009 0x0000000c 0x0000025f
-				0x00000000 0x00000003 0x00000003 0x00000002
-				0x00000002 0x00000001 0x00000008 0x000000c8
-				0x00000003 0x00000005 0x00000003 0x0000000c
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0x00520006
-				0x00000010 0x00000008 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-		emc-table@133200 {
-			reg = <133200>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <133200>;
-			nvidia,emc-registers =   <0x00000008 0x00000019
-				0x00000006 0x00000002 0x00000004 0x00000004
-				0x00000001 0x0000000a 0x00000002 0x00000002
-				0x00000002 0x00000001 0x00000003 0x00000004
-				0x00000003 0x00000009 0x0000000c 0x0000039f
-				0x00000000 0x00000003 0x00000003 0x00000002
-				0x00000002 0x00000001 0x00000008 0x000000c8
-				0x00000003 0x00000007 0x00000003 0x0000000c
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0x00510006
-				0x00000010 0x00000008 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-		emc-table@166500 {
-			reg = <166500>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <166500>;
-			nvidia,emc-registers =   <0x0000000a 0x00000021
-				0x00000008 0x00000003 0x00000004 0x00000004
-				0x00000002 0x0000000a 0x00000003 0x00000003
-				0x00000002 0x00000001 0x00000003 0x00000004
-				0x00000003 0x00000009 0x0000000c 0x000004df
-				0x00000000 0x00000003 0x00000003 0x00000003
-				0x00000003 0x00000001 0x00000009 0x000000c8
-				0x00000003 0x00000009 0x00000004 0x0000000c
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0x004f0006
-				0x00000010 0x00000008 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-		emc-table@333000 {
-			reg = <333000>;
-			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = <333000>;
-			nvidia,emc-registers =   <0x00000014 0x00000041
-				0x0000000f 0x00000005 0x00000004 0x00000005
-				0x00000003 0x0000000a 0x00000005 0x00000005
-				0x00000004 0x00000001 0x00000003 0x00000004
-				0x00000003 0x00000009 0x0000000c 0x000009ff
-				0x00000000 0x00000003 0x00000003 0x00000005
-				0x00000005 0x00000001 0x0000000e 0x000000c8
-				0x00000003 0x00000011 0x00000006 0x0000000c
-				0x00000002 0x00000000 0x00000000 0x00000002
-				0x00000000 0x00000000 0x00000083 0x00380006
-				0x00000010 0x00000008 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000>;
-		};
-	};
-
-	usb@c5004000 {
-		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
-	};
-
-	usb-phy@c5004000 {
-		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
-	};
-
-	sdhci@c8000600 {
-		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
-	};
-
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		clk32k_in: clock@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
-	};
-
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd_3v3_reg: regulator@100 {
-			compatible = "regulator-fixed";
-			reg = <100>;
-			regulator-name = "vdd_3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		regulator@101 {
-			compatible = "regulator-fixed";
-			reg = <101>;
-			regulator-name = "internal_usb";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-boot-on;
-			regulator-always-on;
-			gpio = <&gpio TEGRA_GPIO(BB, 1) GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	sound {
-		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
-			         "nvidia,tegra-audio-wm9712";
-		nvidia,model = "Colibri T20 AC97 Audio";
-
-		nvidia,audio-routing =
-			"Headphone", "HPOUTL",
-			"Headphone", "HPOUTR",
-			"LineIn", "LINEINL",
-			"LineIn", "LINEINR",
-			"Mic", "MIC1";
-
-		nvidia,ac97-controller = <&ac97>;
-
-		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
-			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA20_CLK_CDEV1>;
-		clock-names = "pll_a", "pll_a_out0", "mclk";
-	};
 };
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
new file mode 100644
index 000000000000..a567ea6d442f
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tegra20.dtsi"
+
+/ {
+	model = "Toradex Colibri T20 512MB";
+	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
+
+	aliases {
+		rtc0 = "/i2c@7000d000/tps6586x@34";
+		rtc1 = "/rtc@7000e000";
+	};
+
+	host1x@50000000 {
+		hdmi@54280000 {
+			vdd-supply = <&hdmi_vdd_reg>;
+			pll-supply = <&hdmi_pll_reg>;
+
+			nvidia,ddc-i2c-bus = <&i2c_ddc>;
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	pinmux@70000014 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinmux {
+			audio_refclk {
+				nvidia,pins = "cdev1";
+				nvidia,function = "plla_out";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			crt {
+				nvidia,pins = "crtp";
+				nvidia,function = "crt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			dap3 {
+				nvidia,pins = "dap3";
+				nvidia,function = "dap3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			displaya {
+				nvidia,pins = "ld0", "ld1", "ld2", "ld3",
+					"ld4", "ld5", "ld6", "ld7", "ld8",
+					"ld9", "ld10", "ld11", "ld12", "ld13",
+					"ld14", "ld15", "ld16", "ld17",
+					"lhs", "lpw0", "lpw2", "lsc0",
+					"lsc1", "lsck", "lsda", "lspi", "lvs";
+				nvidia,function = "displaya";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			gpio_dte {
+				nvidia,pins = "dte";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			gpio_gmi {
+				nvidia,pins = "ata", "atc", "atd", "ate",
+					"dap1", "dap2", "dap4", "gpu", "irrx",
+					"irtx", "spia", "spib", "spic";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			gpio_pta {
+				nvidia,pins = "pta";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			gpio_uac {
+				nvidia,pins = "uac";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			hdint {
+				nvidia,pins = "hdint";
+				nvidia,function = "hdmi";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			i2c1 {
+				nvidia,pins = "rm";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			i2c3 {
+				nvidia,pins = "dtf";
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			i2cddc {
+				nvidia,pins = "ddc";
+				nvidia,function = "i2c2";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			i2cp {
+				nvidia,pins = "i2cp";
+				nvidia,function = "i2cp";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			irda {
+				nvidia,pins = "uad";
+				nvidia,function = "irda";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			nand {
+				nvidia,pins = "kbca", "kbcc", "kbcd",
+					"kbce", "kbcf";
+				nvidia,function = "nand";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			owc {
+				nvidia,pins = "owc";
+				nvidia,function = "owr";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			pmc {
+				nvidia,pins = "pmc";
+				nvidia,function = "pwr_on";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			pwm {
+				nvidia,pins = "sdb", "sdc", "sdd";
+				nvidia,function = "pwm";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			sdio4 {
+				nvidia,pins = "atb", "gma", "gme";
+				nvidia,function = "sdio4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			spi1 {
+				nvidia,pins = "spid", "spie", "spif";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			spi4 {
+				nvidia,pins = "slxa", "slxc", "slxd", "slxk";
+				nvidia,function = "spi4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			uarta {
+				nvidia,pins = "sdio1";
+				nvidia,function = "uarta";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			uartd {
+				nvidia,pins = "gmc";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi {
+				nvidia,pins = "uaa", "uab", "uda";
+				nvidia,function = "ulpi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi_refclk {
+				nvidia,pins = "cdev2";
+				nvidia,function = "pllp_out4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			usb_gpio {
+				nvidia,pins = "spig", "spih";
+				nvidia,function = "spi2_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			vi {
+				nvidia,pins = "dta", "dtb", "dtc", "dtd";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+			vi_sc {
+				nvidia,pins = "csus";
+				nvidia,function = "vi_sensor_clk";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
+	ac97: ac97@70002000 {
+		status = "okay";
+		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
+		nvidia,codec-sync-gpio = <&gpio TEGRA_GPIO(P, 0)
+			GPIO_ACTIVE_HIGH>;
+	};
+
+	/*
+	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
+	 * board)
+	 */
+	i2c@7000c000 {
+		clock-frequency = <400000>;
+	};
+
+	/* DDC_SCL/SDA on X3 pin 15/16 (e.g. display EDID) */
+	i2c_ddc: i2c@7000c400 {
+		clock-frequency = <10000>;
+	};
+
+	/* GEN2_I2C: unused */
+
+	/* CAM/GEN3_I2C: used as EXT_IO1/2 GPIOs on SODIMM pin 133/127 */
+
+	/* PWR_I2C: power I2C to PMIC and temperature sensor (On-module) */
+	i2c@7000d000 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		pmic: tps6586x@34 {
+			compatible = "ti,tps6586x";
+			reg = <0x34>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+
+			ti,system-power-controller;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			sys-supply = <&vdd_3v3_reg>;
+			vin-sm0-supply = <&sys_reg>;
+			vin-sm1-supply = <&sys_reg>;
+			vin-sm2-supply = <&sys_reg>;
+			vinldo01-supply = <&sm2_reg>;
+			vinldo23-supply = <&vdd_3v3_reg>;
+			vinldo4-supply = <&vdd_3v3_reg>;
+			vinldo678-supply = <&vdd_3v3_reg>;
+			vinldo9-supply = <&vdd_3v3_reg>;
+
+			regulators {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sys_reg: regulator@0 {
+					reg = <0>;
+					regulator-compatible = "sys";
+					regulator-name = "vdd_sys";
+					regulator-always-on;
+				};
+
+				regulator@1 {
+					reg = <1>;
+					regulator-compatible = "sm0";
+					regulator-name = "vdd_sm0,vdd_core";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+				};
+
+				regulator@2 {
+					reg = <2>;
+					regulator-compatible = "sm1";
+					regulator-name = "vdd_sm1,vdd_cpu";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+				};
+
+				sm2_reg: regulator@3 {
+					reg = <3>;
+					regulator-compatible = "sm2";
+					regulator-name = "vdd_sm2,vin_ldo*";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				/* LDO0 is not connected to anything */
+
+				regulator@5 {
+					reg = <5>;
+					regulator-compatible = "ldo1";
+					regulator-name = "vdd_ldo1,avdd_pll*";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1100000>;
+					regulator-always-on;
+				};
+
+				regulator@6 {
+					reg = <6>;
+					regulator-compatible = "ldo2";
+					regulator-name = "vdd_ldo2,vdd_rtc";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				/* LDO3 is not connected to anything */
+
+				regulator@8 {
+					reg = <8>;
+					regulator-compatible = "ldo4";
+					regulator-name = "vdd_ldo4,avdd_osc,vddio_sys";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				ldo5_reg: regulator@9 {
+					reg = <9>;
+					regulator-compatible = "ldo5";
+					regulator-name = "vdd_ldo5,vdd_fuse";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+
+				regulator@10 {
+					reg = <10>;
+					regulator-compatible = "ldo6";
+					regulator-name = "vdd_ldo6,avdd_vdac,vddio_vi,vddio_cam";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+				};
+
+				hdmi_vdd_reg: regulator@11 {
+					reg = <11>;
+					regulator-compatible = "ldo7";
+					regulator-name = "vdd_ldo7,avdd_hdmi";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				hdmi_pll_reg: regulator@12 {
+					reg = <12>;
+					regulator-compatible = "ldo8";
+					regulator-name = "vdd_ldo8,avdd_hdmi_pll";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				regulator@13 {
+					reg = <13>;
+					regulator-compatible = "ldo9";
+					regulator-name = "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-always-on;
+				};
+
+				regulator@14 {
+					reg = <14>;
+					regulator-compatible = "ldo_rtc";
+					regulator-name = "vdd_rtc_out,vdd_cell";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+				};
+			};
+		};
+
+		temperature-sensor@4c {
+			compatible = "national,lm95245";
+			reg = <0x4c>;
+		};
+	};
+
+	pmc@7000e400 {
+		nvidia,suspend-mode = <1>;
+		nvidia,cpu-pwr-good-time = <5000>;
+		nvidia,cpu-pwr-off-time = <5000>;
+		nvidia,core-pwr-good-time = <3845 3845>;
+		nvidia,core-pwr-off-time = <3875>;
+		nvidia,sys-clock-req-active-high;
+	};
+
+	memory-controller@7000f400 {
+		emc-table@83250 {
+			reg = <83250>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <83250>;
+			nvidia,emc-registers =   <0x00000005 0x00000011
+				0x00000004 0x00000002 0x00000004 0x00000004
+				0x00000001 0x0000000a 0x00000002 0x00000002
+				0x00000001 0x00000001 0x00000003 0x00000004
+				0x00000003 0x00000009 0x0000000c 0x0000025f
+				0x00000000 0x00000003 0x00000003 0x00000002
+				0x00000002 0x00000001 0x00000008 0x000000c8
+				0x00000003 0x00000005 0x00000003 0x0000000c
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0x00520006
+				0x00000010 0x00000008 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
+		emc-table@133200 {
+			reg = <133200>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <133200>;
+			nvidia,emc-registers =   <0x00000008 0x00000019
+				0x00000006 0x00000002 0x00000004 0x00000004
+				0x00000001 0x0000000a 0x00000002 0x00000002
+				0x00000002 0x00000001 0x00000003 0x00000004
+				0x00000003 0x00000009 0x0000000c 0x0000039f
+				0x00000000 0x00000003 0x00000003 0x00000002
+				0x00000002 0x00000001 0x00000008 0x000000c8
+				0x00000003 0x00000007 0x00000003 0x0000000c
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0x00510006
+				0x00000010 0x00000008 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
+		emc-table@166500 {
+			reg = <166500>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <166500>;
+			nvidia,emc-registers =   <0x0000000a 0x00000021
+				0x00000008 0x00000003 0x00000004 0x00000004
+				0x00000002 0x0000000a 0x00000003 0x00000003
+				0x00000002 0x00000001 0x00000003 0x00000004
+				0x00000003 0x00000009 0x0000000c 0x000004df
+				0x00000000 0x00000003 0x00000003 0x00000003
+				0x00000003 0x00000001 0x00000009 0x000000c8
+				0x00000003 0x00000009 0x00000004 0x0000000c
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0x004f0006
+				0x00000010 0x00000008 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
+		emc-table@333000 {
+			reg = <333000>;
+			compatible = "nvidia,tegra20-emc-table";
+			clock-frequency = <333000>;
+			nvidia,emc-registers =   <0x00000014 0x00000041
+				0x0000000f 0x00000005 0x00000004 0x00000005
+				0x00000003 0x0000000a 0x00000005 0x00000005
+				0x00000004 0x00000001 0x00000003 0x00000004
+				0x00000003 0x00000009 0x0000000c 0x000009ff
+				0x00000000 0x00000003 0x00000003 0x00000005
+				0x00000005 0x00000001 0x0000000e 0x000000c8
+				0x00000003 0x00000011 0x00000006 0x0000000c
+				0x00000002 0x00000000 0x00000000 0x00000002
+				0x00000000 0x00000000 0x00000083 0x00380006
+				0x00000010 0x00000008 0x00000000 0x00000000
+				0x00000000 0x00000000 0x00000000 0x00000000>;
+		};
+	};
+
+	usb@c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_LOW>;
+	};
+
+	usb-phy@c5004000 {
+		status = "okay";
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_LOW>;
+	};
+
+	sdhci@c8000600 {
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		clk32k_in: clock@0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdd_3v3_reg: regulator@100 {
+			compatible = "regulator-fixed";
+			reg = <100>;
+			regulator-name = "vdd_3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		regulator@101 {
+			compatible = "regulator-fixed";
+			reg = <101>;
+			regulator-name = "internal_usb";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-boot-on;
+			regulator-always-on;
+			gpio = <&gpio TEGRA_GPIO(BB, 1) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
+			         "nvidia,tegra-audio-wm9712";
+		nvidia,model = "Colibri T20 AC97 Audio";
+
+		nvidia,audio-routing =
+			"Headphone", "HPOUTL",
+			"Headphone", "HPOUTR",
+			"LineIn", "LINEINL",
+			"LineIn", "LINEINR",
+			"Mic", "MIC1";
+
+		nvidia,ac97-controller = <&ac97>;
+
+		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
+			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA20_CLK_CDEV1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+	};
+};
diff --git a/arch/arm/boot/dts/tegra20-iris-256.dts b/arch/arm/boot/dts/tegra20-iris-256.dts
new file mode 100644
index 000000000000..aee619b80c23
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-iris-256.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra20-colibri-256.dtsi"
+#include "tegra20-iris-common.dtsi"
+
+/ {
+	model = "Toradex Colibri T20 256MB on Iris";
+};
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
index 40126388946d..67894f699abf 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -2,105 +2,8 @@
 /dts-v1/;
 
 #include "tegra20-colibri-512.dtsi"
+#include "tegra20-iris-common.dtsi"
 
 / {
 	model = "Toradex Colibri T20 512MB on Iris";
-	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
-
-	aliases {
-		serial0 = &uarta;
-		serial1 = &uartd;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	host1x@50000000 {
-		hdmi@54280000 {
-			status = "okay";
-		};
-	};
-
-	pinmux@70000014 {
-		state_default: pinmux {
-			hdint {
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-
-			i2cddc {
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-
-			sdio4 {
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-
-			uarta {
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-
-			uartd {
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-		};
-	};
-
-	serial@70006000 {
-		status = "okay";
-	};
-
-	serial@70006300 {
-		status = "okay";
-	};
-
-	i2c_ddc: i2c@7000c400 {
-		status = "okay";
-	};
-
-	usb@c5000000 {
-		status = "okay";
-	};
-
-	usb-phy@c5000000 {
-		status = "okay";
-	};
-
-	usb@c5008000 {
-		status = "okay";
-	};
-
-	usb-phy@c5008000 {
-		status = "okay";
-	};
-
-	sdhci@c8000600 {
-		status = "okay";
-		bus-width = <4>;
-		vmmc-supply = <&vcc_sd_reg>;
-		vqmmc-supply = <&vcc_sd_reg>;
-	};
-
-	regulators {
-		regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_host_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-boot-on;
-			regulator-always-on;
-			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
-		};
-
-		vcc_sd_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "vcc_sd";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/tegra20-iris-common.dtsi b/arch/arm/boot/dts/tegra20-iris-common.dtsi
new file mode 100644
index 000000000000..6ed817257cdb
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-iris-common.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// This DTSI does not include specific Colibri DTSI but just configures
+// common Iris properties. This DTSI shall be included after including
+// specific Colibri DTSI.
+
+/ {
+	model = "Toradex Colibri T20 256MB/512MB on Iris";
+	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
+
+	aliases {
+		serial0 = &uarta;
+		serial1 = &uartd;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	host1x@50000000 {
+		hdmi@54280000 {
+			status = "okay";
+		};
+	};
+
+	pinmux@70000014 {
+		state_default: pinmux {
+			hdint {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			i2cddc {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			sdio4 {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			uarta {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			uartd {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	serial@70006000 {
+		status = "okay";
+	};
+
+	serial@70006300 {
+		status = "okay";
+	};
+
+	i2c_ddc: i2c@7000c400 {
+		status = "okay";
+	};
+
+	usb@c5000000 {
+		status = "okay";
+	};
+
+	usb-phy@c5000000 {
+		status = "okay";
+	};
+
+	usb@c5008000 {
+		status = "okay";
+	};
+
+	usb-phy@c5008000 {
+		status = "okay";
+	};
+
+	sdhci@c8000600 {
+		status = "okay";
+		bus-width = <4>;
+		vmmc-supply = <&vcc_sd_reg>;
+		vqmmc-supply = <&vcc_sd_reg>;
+	};
+
+	regulators {
+		regulator@0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_host_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-boot-on;
+			regulator-always-on;
+			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
+		};
+
+		vcc_sd_reg: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vcc_sd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+};
-- 
2.7.4
