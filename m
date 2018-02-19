Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbeBSW3m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:29:42 -0500
Received: from vern.gendns.com ([206.190.152.46]:34417 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932154AbeBSW3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:29:40 -0500
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: [PATCH] ARM: dts: da850: use gpio-ranges
Date: Mon, 19 Feb 2018 16:29:31 -0600
Message-Id: <1519079371-25493-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
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

This makes use of the gpio-ranges feature that connects GPIO
controllers and PINMUX controllers.

In da850.dtsi, pinctrl-single,gpio-range is added to the pinmux node
and gpio-ranges is added to the GPIO node. Unfortunately, the way the
pinctrl-single driver enumerates the pins (starting with LSB) causes
them to be in reverse order compared to the way the gpios are assigned.
As a result, we have to declare the mapping for each GPIO individually.

This also lets us remove all of the GPIO pinmuxes from
da850-lego-ev3.dts. (Other da850 boards do not currently have any
GPIO pinmuxes declared.)

Signed-off-by: David Lechner <david@lechnology.com>
---

There are a couple of dependencies needed for this to actually work.

- "gpio: davinci: add support for pinmux gpio ranges" [1]
- "pinctrl: pinctrl-single: Fix pcs_request_gpio() when bits_per_mux != 0" [2]

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=for-next&id=3c87d7c874b2119c1cff4eee5586b9a6bc0b7fe9
[2]: https://patchwork.kernel.org/patch/10229139/

 arch/arm/boot/dts/da850-lego-ev3.dts |  81 +-----------------
 arch/arm/boot/dts/da850.dtsi         | 154 +++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 77 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index fa21add..401d808 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -37,7 +37,7 @@
 		#size-cells = <0>;
 		label = "EV3 Brick Buttons";
 		pinctrl-names = "default";
-		pinctrl-0 = <&button_pins>, <&button_bias>;
+		pinctrl-0 = <&button_bias>;
 
 		center {
 			label = "Center";
@@ -81,8 +81,6 @@
 	 */
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins>;
 
 		left_green {
 			label = "led0:green:brick-status";
@@ -119,8 +117,6 @@
 	gpio-poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio 107 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&system_power_pin>;
 	};
 
 	sound {
@@ -145,8 +141,6 @@
 	 * the sensor (input) ports, the motor (output) ports and the A/DC.
 	 */
 	vcc5v: regulator1 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v_pins>;
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v";
 		regulator-min-microvolt = <5000000>;
@@ -174,8 +168,6 @@
 	 * This is the amplifier for the speaker.
 	 */
 	amp: regulator3 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&amp_pins>;
 		compatible = "regulator-fixed";
 		regulator-name = "amp";
 		gpio = <&gpio 111 GPIO_ACTIVE_HIGH>;
@@ -186,8 +178,6 @@
 	 * The EV3 can use 6-AA batteries or a rechargeable Li-ion battery pack.
 	 */
 	battery {
-		pinctrl-names = "default";
-		pinctrl-0 = <&battery_pins>;
 		compatible = "lego,ev3-battery";
 		io-channels = <&adc 4>, <&adc 3>;
 		io-channel-names = "voltage", "current";
@@ -223,73 +213,10 @@
 &pmx_core {
 	status = "okay";
 
-	mmc0_cd_pin: pinmux_mmc0_cd {
-		pinctrl-single,bits = <
-			/* GP5[14] */
-			0x2C 0x00000080 0x000000f0
-		>;
-	};
-
-	button_pins: pinmux_button_pins {
-		pinctrl-single,bits = <
-			/* GP1[13] */
-			0x8 0x00000800 0x00000f00
-			/* GP6[10] */
-			0x34 0x00800000 0x00f00000
-			/* GP6[6] */
-			0x38 0x00000080 0x000000f0
-			/* GP7[12], GP7[14], GP7[15] */
-			0x40 0x00808800 0x00f0ff00
-		>;
-	};
-
-	led_pins: pinmux_led_pins {
-		pinctrl-single,bits = <
-			/* GP6[12], GP6[13], GP6[14] */
-			0x34 0x00008880 0x0000fff0
-			/* GP6[7] */
-			0x38 0x00000008 0x0000000f
-		>;
-	};
-
-	system_power_pin: pinmux_system_power {
-		pinctrl-single,bits = <
-			/* GP6[11] */
-			0x34 0x00080000 0x000f0000
-		>;
-	};
-
-	vcc5v_pins: pinmux_vcc5v {
-		pinctrl-single,bits = <
-			/* GP6[5] */
-			0x40 0x00000080 0x000000f0
-			/* GP6[3] */
-			0x4c 0x00008000 0x0000f000
-		>;
-	};
-
-	amp_pins: pinmux_amp_pins {
-		pinctrl-single,bits = <
-			/* GP6[15] */
-			0x34 0x00000008 0x0000000f
-		>;
-	};
-
-	battery_pins: pinmux_battery_pins {
-		pinctrl-single,bits = <
-			/* GP0[6] */
-			0x04 0x00000080 0x000000f0
-			/* GP8[8] */
-			0x4c 0x00000080 0x000000f0
-		>;
-	};
-
 	ev3_lcd_pins: pinmux_lcd {
 		pinctrl-single,bits = <
-			/* SIMO, GP2[11], GP2[12], CLK */
-			0x14 0x00188100 0x00ffff00
-			/* GP5[0] */
-			0x30 0x80000000 0xf0000000
+			/* SIMO, CLK */
+			0x14 0x00100100 0x00f00f00
 		>;
 	};
 };
@@ -344,7 +271,7 @@
 	bus-width = <4>;
 	cd-gpios = <&gpio 94 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pins>;
 };
 
 &spi0 {
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4bc6eb8..a6a4c75 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -160,8 +160,18 @@
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0xf>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range   0 17 0x8>,
+						    <&range  17  8 0x4>,
+						    <&range  26  8 0x4>,
+						    <&range  34 80 0x8>,
+						    <&range 129 31 0x8>;
 			status = "disabled";
 
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+
 			serial0_rtscts_pins: pinmux_serial0_rtscts_pins {
 				pinctrl-single,bits = <
 					/* UART0_RTS UART0_CTS */
@@ -739,6 +749,150 @@
 			#interrupt-cells = <2>;
 			clocks = <&psc1 3>;
 			clock-names = "gpio";
+			gpio-ranges = <&pmx_core   0  15 1>,
+				      <&pmx_core   1  14 1>,
+				      <&pmx_core   2  13 1>,
+				      <&pmx_core   3  12 1>,
+				      <&pmx_core   4  11 1>,
+				      <&pmx_core   5  10 1>,
+				      <&pmx_core   6   9 1>,
+				      <&pmx_core   7   8 1>,
+				      <&pmx_core   8   7 1>,
+				      <&pmx_core   9   6 1>,
+				      <&pmx_core  10   5 1>,
+				      <&pmx_core  11   4 1>,
+				      <&pmx_core  12   3 1>,
+				      <&pmx_core  13   2 1>,
+				      <&pmx_core  14   1 1>,
+				      <&pmx_core  15   0 1>,
+				      <&pmx_core  16  39 1>,
+				      <&pmx_core  17  38 1>,
+				      <&pmx_core  18  37 1>,
+				      <&pmx_core  19  36 1>,
+				      <&pmx_core  20  35 1>,
+				      <&pmx_core  21  34 1>,
+				      <&pmx_core  22  33 1>,
+				      <&pmx_core  23  32 1>,
+				      <&pmx_core  24  24 1>,
+				      <&pmx_core  25  22 1>,
+				      <&pmx_core  26  21 1>,
+				      <&pmx_core  27  20 1>,
+				      <&pmx_core  28  19 1>,
+				      <&pmx_core  29  18 1>,
+				      <&pmx_core  30  17 1>,
+				      <&pmx_core  31  16 1>,
+				      <&pmx_core  32  55 1>,
+				      <&pmx_core  33  54 1>,
+				      <&pmx_core  34  53 1>,
+				      <&pmx_core  35  52 1>,
+				      <&pmx_core  36  51 1>,
+				      <&pmx_core  37  50 1>,
+				      <&pmx_core  38  49 1>,
+				      <&pmx_core  39  48 1>,
+				      <&pmx_core  40  47 1>,
+				      <&pmx_core  41  46 1>,
+				      <&pmx_core  42  45 1>,
+				      <&pmx_core  43  44 1>,
+				      <&pmx_core  44  43 1>,
+				      <&pmx_core  45  42 1>,
+				      <&pmx_core  46  41 1>,
+				      <&pmx_core  47  40 1>,
+				      <&pmx_core  48  71 1>,
+				      <&pmx_core  49  70 1>,
+				      <&pmx_core  50  69 1>,
+				      <&pmx_core  51  68 1>,
+				      <&pmx_core  52  67 1>,
+				      <&pmx_core  53  66 1>,
+				      <&pmx_core  54  65 1>,
+				      <&pmx_core  55  64 1>,
+				      <&pmx_core  56  63 1>,
+				      <&pmx_core  57  62 1>,
+				      <&pmx_core  58  61 1>,
+				      <&pmx_core  59  60 1>,
+				      <&pmx_core  60  59 1>,
+				      <&pmx_core  61  58 1>,
+				      <&pmx_core  62  57 1>,
+				      <&pmx_core  63  56 1>,
+				      <&pmx_core  64  87 1>,
+				      <&pmx_core  65  86 1>,
+				      <&pmx_core  66  85 1>,
+				      <&pmx_core  67  84 1>,
+				      <&pmx_core  68  83 1>,
+				      <&pmx_core  69  82 1>,
+				      <&pmx_core  70  81 1>,
+				      <&pmx_core  71  80 1>,
+				      <&pmx_core  72  70 1>,
+				      <&pmx_core  73  78 1>,
+				      <&pmx_core  74  77 1>,
+				      <&pmx_core  75  76 1>,
+				      <&pmx_core  76  75 1>,
+				      <&pmx_core  77  74 1>,
+				      <&pmx_core  78  73 1>,
+				      <&pmx_core  79  72 1>,
+				      <&pmx_core  80 103 1>,
+				      <&pmx_core  81 102 1>,
+				      <&pmx_core  82 101 1>,
+				      <&pmx_core  83 100 1>,
+				      <&pmx_core  84  99 1>,
+				      <&pmx_core  85  98 1>,
+				      <&pmx_core  86  97 1>,
+				      <&pmx_core  87  96 1>,
+				      <&pmx_core  88  95 1>,
+				      <&pmx_core  89  94 1>,
+				      <&pmx_core  90  93 1>,
+				      <&pmx_core  91  92 1>,
+				      <&pmx_core  92  91 1>,
+				      <&pmx_core  93  90 1>,
+				      <&pmx_core  94  89 1>,
+				      <&pmx_core  95  88 1>,
+				      <&pmx_core  96 158 1>,
+				      <&pmx_core  97 157 1>,
+				      <&pmx_core  98 156 1>,
+				      <&pmx_core  99 155 1>,
+				      <&pmx_core 100 154 1>,
+				      <&pmx_core 101 129 1>,
+				      <&pmx_core 102 113 1>,
+				      <&pmx_core 103 112 1>,
+				      <&pmx_core 104 111 1>,
+				      <&pmx_core 105 110 1>,
+				      <&pmx_core 106 109 1>,
+				      <&pmx_core 107 108 1>,
+				      <&pmx_core 108 107 1>,
+				      <&pmx_core 109 106 1>,
+				      <&pmx_core 110 105 1>,
+				      <&pmx_core 111 104 1>,
+				      <&pmx_core 112 145 1>,
+				      <&pmx_core 113 144 1>,
+				      <&pmx_core 114 143 1>,
+				      <&pmx_core 115 142 1>,
+				      <&pmx_core 116 141 1>,
+				      <&pmx_core 117 140 1>,
+				      <&pmx_core 118 139 1>,
+				      <&pmx_core 119 138 1>,
+				      <&pmx_core 120 137 1>,
+				      <&pmx_core 121 136 1>,
+				      <&pmx_core 122 135 1>,
+				      <&pmx_core 123 134 1>,
+				      <&pmx_core 124 133 1>,
+				      <&pmx_core 125 132 1>,
+				      <&pmx_core 126 131 1>,
+				      <&pmx_core 127 130 1>,
+				      <&pmx_core 128 159 1>,
+				      <&pmx_core 129  31 1>,
+				      <&pmx_core 130  30 1>,
+				      <&pmx_core 131  20 1>,
+				      <&pmx_core 132  28 1>,
+				      <&pmx_core 133  27 1>,
+				      <&pmx_core 134  26 1>,
+				      <&pmx_core 135  23 1>,
+				      <&pmx_core 136 153 1>,
+				      <&pmx_core 137 152 1>,
+				      <&pmx_core 138 151 1>,
+				      <&pmx_core 139 150 1>,
+				      <&pmx_core 140 149 1>,
+				      <&pmx_core 141 148 1>,
+				      <&pmx_core 142 147 1>,
+				      <&pmx_core 143 146 1>;
 		};
 		psc1: clock-controller@227000 {
 			compatible = "ti,da850-psc1";
-- 
2.7.4
