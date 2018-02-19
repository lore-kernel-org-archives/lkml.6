Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbeBSVtx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 16:49:53 -0500
Received: from vern.gendns.com ([206.190.152.46]:33354 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932095AbeBSVtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 16:49:51 -0500
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
Subject: [PATCH v7 42/42] ARM: dts: da850: Add clocks
Date: Mon, 19 Feb 2018 14:22:03 -0600
Message-Id: <1519071723-31790-43-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
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
 arch/arm/boot/dts/da850.dtsi         | 159 +++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index 14dff3e..0102ffc 100644
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
index a86a8a1..6e13613 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -195,6 +195,10 @@
 	};
 };
 
+&ref_clk {
+	clock-frequency = <24000000>;
+};
+
 /include/ "tps6507x.dtsi"
 
 &tps {
diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index a1f4d6d..90b917c 100644
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
index 81942ae..dd3bf93 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -186,6 +186,10 @@
 	};
 };
 
+&ref_clk {
+	clock-frequency = <24000000>;
+};
+
 &pmx_core {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c66cf78..85f760d 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -21,6 +21,26 @@
 			#interrupt-cells = <1>;
 			ti,intc-size = <101>;
 			reg = <0xfffee000 0x2000>;
+			clocks = <&psc0 6>;
+		};
+	};
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
 		};
 	};
 	dsp: dsp@11800000 {
@@ -33,6 +53,7 @@
 		reg-names = "l2sram", "l1pram", "l1dram", "host1cfg", "chipsig";
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
+		clocks = <&psc0 15>;
 		status = "disabled";
 	};
 	soc@1c00000 {
@@ -43,6 +64,37 @@
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
+			clock_names = "pll0_sysclk1", "pll0_sysclk2",
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
@@ -264,8 +316,41 @@
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
@@ -313,6 +398,8 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <25>;
+			clocks = <&psc0 9>;
+			power-domains = <&psc0 9>;
 			status = "disabled";
 		};
 		serial1: serial@10c000 {
@@ -321,6 +408,8 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <53>;
+			clocks = <&psc1 12>;
+			power-domains = <&psc1 12>;
 			status = "disabled";
 		};
 		serial2: serial@10d000 {
@@ -329,6 +418,8 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <61>;
+			clocks = <&psc1 13>;
+			power-domains = <&psc1 13>;
 			status = "disabled";
 		};
 		rtc0: rtc@23000 {
@@ -336,6 +427,8 @@
 			reg = <0x23000 0x1000>;
 			interrupts = <19
 				      19>;
+			clocks = <&pll0_auxclk>;
+			clock-names = "int-clk";
 			status = "disabled";
 		};
 		i2c0: i2c@22000 {
@@ -344,6 +437,7 @@
 			interrupts = <15>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&pll0_auxclk>;
 			status = "disabled";
 		};
 		i2c1: i2c@228000 {
@@ -352,11 +446,18 @@
 			interrupts = <51>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&psc1 11>;
 			status = "disabled";
 		};
+		clocksource: timer@20000 {
+			compatible = "ti,davinci-timer";
+			reg = <0x20000 0x1000>;
+			clocks = <&pll0_auxclk>;
+		};
 		wdt: wdt@21000 {
 			compatible = "ti,davinci-wdt";
 			reg = <0x21000 0x1000>;
+			clocks = <&pll0_auxclk>;
 			status = "disabled";
 		};
 		mmc0: mmc@40000 {
@@ -367,12 +468,14 @@
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
+			clocks = <&psc1 9>;
 			status = "disabled";
 
 			/* VPIF capture port */
@@ -395,6 +498,7 @@
 			interrupts = <72>;
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc1 18>;
 			status = "disabled";
 		};
 		ehrpwm0: pwm@300000 {
@@ -402,6 +506,8 @@
 				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
+			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
 		ehrpwm1: pwm@302000 {
@@ -409,6 +515,8 @@
 				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
+			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
 		ecap0: ecap@306000 {
@@ -416,6 +524,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		ecap1: ecap@307000 {
@@ -423,6 +533,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		ecap2: ecap@308000 {
@@ -430,6 +542,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		spi0: spi@41000 {
@@ -442,6 +556,7 @@
 			interrupts = <20>;
 			dmas = <&edma0 14 0>, <&edma0 15 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc0 4>;
 			status = "disabled";
 		};
 		spi1: spi@30e000 {
@@ -454,6 +569,7 @@
 			interrupts = <56>;
 			dmas = <&edma0 18 0>, <&edma0 19 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc1 10>;
 			status = "disabled";
 		};
 		usb0: usb@200000 {
@@ -465,6 +581,8 @@
 			dr_mode = "otg";
 			phys = <&usb_phy 0>;
 			phy-names = "usb-phy";
+			clocks = <&psc1 1>;
+			clock-ranges;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -495,13 +613,31 @@
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
@@ -517,6 +653,8 @@
 					35
 					36
 					>;
+			clocks = <&psc1 5>;
+			power-domains = <&psc1 5>;
 			status = "disabled";
 		};
 		usb1: usb@225000 {
@@ -525,6 +663,7 @@
 			interrupts = <59>;
 			phys = <&usb_phy 1>;
 			phy-names = "usb-phy";
+			clocks = <&psc1 2>;
 			status = "disabled";
 		};
 		gpio: gpio@226000 {
@@ -542,6 +681,19 @@
 			status = "disabled";
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&psc1 3>;
+			clock-names = "gpio";
+		};
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
 		};
 		pinconf: pin-controller@22c00c {
 			compatible = "ti,da850-pupd";
@@ -560,6 +712,7 @@
 			dmas = <&edma0 1 1>,
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
+			clocks = <&psc1 7>;
 		};
 
 		lcdc: display@213000 {
@@ -567,6 +720,9 @@
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
 			max-pixelclock = <37500>;
+			clocks = <&psc1 16>;
+			clock-names = "fck";
+			power-domains = <&psc1 16>;
 			status = "disabled";
 		};
 	};
@@ -578,6 +734,9 @@
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
2.7.4
