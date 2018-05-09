Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbeEIR2d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:28:33 -0400
Received: from vern.gendns.com ([206.190.152.46]:52123 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965695AbeEIR1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:21 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 27/27] ARM: dts: da850: Add clocks
Date: Wed,  9 May 2018 12:26:06 -0500
Message-Id: <20180509172606.29387-28-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds clock provider nodes for da850 and wires them up to all of the
devices.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- change compatible to "ti,da830-timer" and add interrupt and interrupt-names
  properties to new clocksource timer node

v9 changes:
- change mcasp and vpif nodes from clocks to power-domains

v8 changes:
- fix typo in clock-names property of psc0
- added power-domains properties to nodes that define that property in their
  device tree bindings

v7 changes:
- move ref_clk frequency to board-specific DT files
- enable sata_refclk in da850-lcdk.dts
- drop async2 fixed factor clock
- add power-domains for devices that use them
- fix USB PHY clock-names property
- move assigned-clocks to PSC device node
- drop clocks property from devices that don't use it (e.g. EDMA)
- add clock to RTC node
- add clock-ranges to usb0 and aemif nodes
- add clock-names property to aemif node
- fix typo in psc1 clock-names

v6 changes:
- updated for device tree bindings changes earlier in this series
- use single async2 clock instead of duplicate fixed factor clocks
- add clock-names property to mdio node



 arch/arm/boot/dts/da850-enbw-cmc.dts |   4 +
 arch/arm/boot/dts/da850-evm.dts      |   4 +
 arch/arm/boot/dts/da850-lcdk.dts     |   9 ++
 arch/arm/boot/dts/da850-lego-ev3.dts |   4 +
 arch/arm/boot/dts/da850.dtsi         | 168 +++++++++++++++++++++++++++
 5 files changed, 189 insertions(+)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index 14dff3e188ed..0102ffc5aa53 100644
--- a/arch/arm/boot/dts/da850-enbw-cmc.dts
+++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
@@ -35,6 +35,10 @@
 	};
 };
 
+&ref_clk {
+	clock-frequency = <24000000>;
+};
+
 &edma0 {
 	ti,edma-reserved-slot-ranges = <32 50>;
 };
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 11cf3765214f..48f6318f4c69 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -200,6 +200,10 @@
 	};
 };
 
+&ref_clk {
+	clock-frequency = <24000000>;
+};
+
 /include/ "tps6507x.dtsi"
 
 &tps {
diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 0edf769ea95c..0177e3ed20fe 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -123,6 +123,10 @@
 	};
 };
 
+&ref_clk {
+	clock-frequency = <24000000>;
+};
+
 &pmx_core {
 	status = "okay";
 
@@ -175,6 +179,11 @@
 	status = "okay";
 };
 
+&sata_refclk {
+	status = "okay";
+	clock-frequency = <100000000>;
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 0a7cfa48b17e..9252ea2c3d3b 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -193,6 +193,10 @@
 	};
 };
 
+&ref_clk {
+	clock-frequency = <24000000>;
+};
+
 &pmx_core {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f6f1597b03df..de9a8bea100e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -32,6 +32,25 @@
 			reg = <0xfffee000 0x2000>;
 		};
 	};
+	clocks: clocks {
+		ref_clk: ref_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "ref_clk";
+		};
+		sata_refclk: sata_refclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "sata_refclk";
+			status = "disabled";
+		};
+		usb_refclkin: usb_refclkin {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "usb_refclkin";
+			status = "disabled";
+		};
+	};
 	dsp: dsp@11800000 {
 		compatible = "ti,da850-dsp";
 		reg = <0x11800000 0x40000>,
@@ -42,6 +61,7 @@
 		reg-names = "l2sram", "l1pram", "l1dram", "host1cfg", "chipsig";
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
+		clocks = <&psc0 15>;
 		status = "disabled";
 	};
 	soc@1c00000 {
@@ -52,6 +72,37 @@
 		ranges = <0x0 0x01c00000 0x400000>;
 		interrupt-parent = <&intc>;
 
+		psc0: clock-controller@10000 {
+			compatible = "ti,da850-psc0";
+			reg = <0x10000 0x1000>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
+				 <&pll0_sysclk 4>, <&pll0_sysclk 6>,
+				 <&async1_clk>;
+			clock-names = "pll0_sysclk1", "pll0_sysclk2",
+				      "pll0_sysclk4", "pll0_sysclk6",
+				      "async1";
+		};
+		pll0: clock-controller@11000 {
+			compatible = "ti,da850-pll0";
+			reg = <0x11000 0x1000>;
+			clocks = <&ref_clk>, <&pll1_sysclk 3>;
+			clock-names = "clksrc", "extclksrc";
+
+			pll0_pllout: pllout {
+				#clock-cells = <0>;
+			};
+			pll0_sysclk: sysclk {
+				#clock-cells = <1>;
+			};
+			pll0_auxclk: auxclk {
+				#clock-cells = <0>;
+			};
+			pll0_obsclk: obsclk {
+				#clock-cells = <0>;
+			};
+		};
 		pmx_core: pinmux@14120 {
 			compatible = "pinctrl-single";
 			reg = <0x14120 0x50>;
@@ -281,8 +332,41 @@
 			usb_phy: usb-phy {
 				compatible = "ti,da830-usb-phy";
 				#phy-cells = <1>;
+				clocks = <&usb_phy_clk 0>, <&usb_phy_clk 1>;
+				clock-names = "usb0_clk48", "usb1_clk48";
 				status = "disabled";
 			};
+			usb_phy_clk: usb-phy-clocks {
+				compatible = "ti,da830-usb-phy-clocks";
+				#clock-cells = <1>;
+				clocks = <&psc1 1>, <&usb_refclkin>,
+					 <&pll0_auxclk>;
+				clock-names = "fck", "usb_refclkin", "auxclk";
+			};
+			ehrpwm_tbclk: ehrpwm_tbclk {
+				compatible = "ti,da830-tbclksync";
+				#clock-cells = <0>;
+				clocks = <&psc1 17>;
+				clock-names = "fck";
+			};
+			div4p5_clk: div4.5 {
+				compatible = "ti,da830-div4p5ena";
+				#clock-cells = <0>;
+				clocks = <&pll0_pllout>;
+				clock-names = "pll0_pllout";
+			};
+			async1_clk: async1 {
+				compatible = "ti,da850-async1-clksrc";
+				#clock-cells = <0>;
+				clocks = <&pll0_sysclk 3>, <&div4p5_clk>;
+				clock-names = "pll0_sysclk3", "div4.5";
+			};
+			async3_clk: async3 {
+				compatible = "ti,da850-async3-clksrc";
+				#clock-cells = <0>;
+				clocks = <&pll0_sysclk 2>, <&pll1_sysclk 2>;
+				clock-names = "pll0_sysclk2", "pll1_sysclk2";
+			};
 		};
 		edma0: edma@0 {
 			compatible = "ti,edma3-tpcc";
@@ -294,18 +378,21 @@
 			#dma-cells = <2>;
 
 			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
+			power-domains = <&psc0 0>;
 		};
 		edma0_tptc0: tptc@8000 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x8000 0x400>;
 			interrupts = <13>;
 			interrupt-names = "edm3_tcerrint";
+			power-domains = <&psc0 1>;
 		};
 		edma0_tptc1: tptc@8400 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x8400 0x400>;
 			interrupts = <32>;
 			interrupt-names = "edm3_tcerrint";
+			power-domains = <&psc0 2>;
 		};
 		edma1: edma@230000 {
 			compatible = "ti,edma3-tpcc";
@@ -317,12 +404,14 @@
 			#dma-cells = <2>;
 
 			ti,tptcs = <&edma1_tptc0 7>;
+			power-domains = <&psc1 0>;
 		};
 		edma1_tptc0: tptc@238000 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x238000 0x400>;
 			interrupts = <95>;
 			interrupt-names = "edm3_tcerrint";
+			power-domains = <&psc1 21>;
 		};
 		serial0: serial@42000 {
 			compatible = "ti,da830-uart", "ns16550a";
@@ -330,6 +419,8 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <25>;
+			clocks = <&psc0 9>;
+			power-domains = <&psc0 9>;
 			status = "disabled";
 		};
 		serial1: serial@10c000 {
@@ -338,6 +429,8 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <53>;
+			clocks = <&psc1 12>;
+			power-domains = <&psc1 12>;
 			status = "disabled";
 		};
 		serial2: serial@10d000 {
@@ -346,6 +439,8 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <61>;
+			clocks = <&psc1 13>;
+			power-domains = <&psc1 13>;
 			status = "disabled";
 		};
 		rtc0: rtc@23000 {
@@ -353,6 +448,8 @@
 			reg = <0x23000 0x1000>;
 			interrupts = <19
 				      19>;
+			clocks = <&pll0_auxclk>;
+			clock-names = "int-clk";
 			status = "disabled";
 		};
 		i2c0: i2c@22000 {
@@ -361,6 +458,7 @@
 			interrupts = <15>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&pll0_auxclk>;
 			status = "disabled";
 		};
 		i2c1: i2c@228000 {
@@ -369,11 +467,21 @@
 			interrupts = <51>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&psc1 11>;
+			power-domains = <&psc1 11>;
 			status = "disabled";
 		};
+		clocksource: timer@20000 {
+			compatible = "ti,da830-timer";
+			reg = <0x20000 0x1000>;
+			interrupts = <12>, <13>;
+			interrupt-names = "tint12", "tint34";
+			clocks = <&pll0_auxclk>;
+		};
 		wdt: wdt@21000 {
 			compatible = "ti,davinci-wdt";
 			reg = <0x21000 0x1000>;
+			clocks = <&pll0_auxclk>;
 			status = "disabled";
 		};
 		mmc0: mmc@40000 {
@@ -384,12 +492,14 @@
 			interrupts = <16>;
 			dmas = <&edma0 16 0>, <&edma0 17 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc0 5>;
 			status = "disabled";
 		};
 		vpif: video@217000 {
 			compatible = "ti,da850-vpif";
 			reg = <0x217000 0x1000>;
 			interrupts = <92>;
+			power-domains = <&psc1 9>;
 			status = "disabled";
 
 			/* VPIF capture port */
@@ -412,6 +522,7 @@
 			interrupts = <72>;
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc1 18>;
 			status = "disabled";
 		};
 		ehrpwm0: pwm@300000 {
@@ -419,6 +530,8 @@
 				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
+			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
 		ehrpwm1: pwm@302000 {
@@ -426,6 +539,8 @@
 				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
+			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
 		ecap0: ecap@306000 {
@@ -433,6 +548,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		ecap1: ecap@307000 {
@@ -440,6 +557,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		ecap2: ecap@308000 {
@@ -447,6 +566,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		spi0: spi@41000 {
@@ -459,6 +580,8 @@
 			interrupts = <20>;
 			dmas = <&edma0 14 0>, <&edma0 15 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc0 4>;
+			power-domains = <&psc0 4>;
 			status = "disabled";
 		};
 		spi1: spi@30e000 {
@@ -471,6 +594,8 @@
 			interrupts = <56>;
 			dmas = <&edma0 18 0>, <&edma0 19 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc1 10>;
+			power-domains = <&psc1 10>;
 			status = "disabled";
 		};
 		usb0: usb@200000 {
@@ -482,6 +607,8 @@
 			dr_mode = "otg";
 			phys = <&usb_phy 0>;
 			phy-names = "usb-phy";
+			clocks = <&psc1 1>;
+			clock-ranges;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -512,13 +639,31 @@
 			compatible = "ti,da850-ahci";
 			reg = <0x218000 0x2000>, <0x22c018 0x4>;
 			interrupts = <67>;
+			clocks = <&psc1 8>, <&sata_refclk>;
+			clock-names = "fck", "refclk";
 			status = "disabled";
 		};
+		pll1: clock-controller@21a000 {
+			compatible = "ti,da850-pll1";
+			reg = <0x21a000 0x1000>;
+			clocks = <&ref_clk>;
+			clock-names = "clksrc";
+
+			pll1_sysclk: sysclk {
+				#clock-cells = <1>;
+			};
+			pll1_obsclk: obsclk {
+				#clock-cells = <0>;
+			};
+		};
 		mdio: mdio@224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x224000 0x1000>;
+			clocks = <&psc1 5>;
+			clock-names = "fck";
+			power-domains = <&psc1 5>;
 			status = "disabled";
 		};
 		eth0: ethernet@220000 {
@@ -534,6 +679,8 @@
 					35
 					36
 					>;
+			clocks = <&psc1 5>;
+			power-domains = <&psc1 5>;
 			status = "disabled";
 		};
 		usb1: usb@225000 {
@@ -542,6 +689,7 @@
 			interrupts = <59>;
 			phys = <&usb_phy 1>;
 			phy-names = "usb-phy";
+			clocks = <&psc1 2>;
 			status = "disabled";
 		};
 		gpio: gpio@226000 {
@@ -556,6 +704,8 @@
 				49 IRQ_TYPE_EDGE_BOTH 50 IRQ_TYPE_EDGE_BOTH>;
 			ti,ngpio = <144>;
 			ti,davinci-gpio-unbanked = <0>;
+			clocks = <&psc1 3>;
+			clock-names = "gpio";
 			status = "disabled";
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -704,6 +854,17 @@
 				      <&pmx_core 142 147 1>,
 				      <&pmx_core 143 146 1>;
 		};
+		psc1: clock-controller@227000 {
+			compatible = "ti,da850-psc1";
+			reg = <0x227000 0x1000>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&pll0_sysclk 2>, <&pll0_sysclk 4>,
+				 <&async3_clk>;
+			clock-names = "pll0_sysclk2", "pll0_sysclk4", "async3";
+			assigned-clocks = <&async3_clk>;
+			assigned-clock-parents = <&pll1_sysclk 2>;
+		};
 		pinconf: pin-controller@22c00c {
 			compatible = "ti,da850-pupd";
 			reg = <0x22c00c 0x8>;
@@ -717,6 +878,7 @@
 			reg-names = "mpu", "dat";
 			interrupts = <54>;
 			interrupt-names = "common";
+			power-domains = <&psc1 7>;
 			status = "disabled";
 			dmas = <&edma0 1 1>,
 				<&edma0 0 1>;
@@ -728,6 +890,9 @@
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
 			max-pixelclock = <37500>;
+			clocks = <&psc1 16>;
+			clock-names = "fck";
+			power-domains = <&psc1 16>;
 			status = "disabled";
 		};
 	};
@@ -739,6 +904,9 @@
 		reg = <0x68000000 0x00008000>;
 		ranges = <0 0 0x60000000 0x08000000
 			  1 0 0x68000000 0x00008000>;
+		clocks = <&psc0 3>;
+		clock-names = "aemif";
+		clock-ranges;
 		status = "disabled";
 	};
 	memctrl: memory-controller@b0000000 {
-- 
2.17.0
