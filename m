Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B65A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B65A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbeGXRo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:44:58 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56467 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388330AbeGXRo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:44:57 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4FA8A9F734;
        Tue, 24 Jul 2018 16:37:29 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to rebase on M2 Ultra
Date:   Wed, 25 Jul 2018 00:36:55 +0800
Message-Id: <20180724163655.61365-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Banana Pi designs the BPi M2 Berry board to be software compatible with
BPi M2 Ultra, so it's based on M2 Ultra with some function cuts,
including:

- 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
- dropped a LED;
- dropped eMMC;
- dropped USB2 and connect USB1 to a 4-port HUB.

Thus we can make the M2 Berry device tree based on the M2 Ultra, rather
than write one from scratch.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  | 141 +++---------------
 1 file changed, 24 insertions(+), 117 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 35859d8f3267..b740c659e623 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -40,143 +40,50 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/dts-v1/;
-#include "sun8i-r40.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
+#include "sun8i-r40-bananapi-m2-ultra.dts"
 
 / {
 	model = "Banana Pi M2 Berry";
 	compatible = "sinovoip,bpi-m2-berry", "allwinner,sun8i-r40";
 
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	leds {
-		compatible = "gpio-leds";
-
-		pwr-led {
-			label = "bananapi:red:pwr";
-			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		user-led {
-			label = "bananapi:green:user";
-			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	reg_vcc5v0: vcc5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>; /* PH23 */
-		enable-active-high;
-	};
-
-	wifi_pwrseq: wifi_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
+		/* M2 Berry dropped blue LED due to size */
+		/delete-node/ user-led-blue;
 	};
 };
 
 &ehci1 {
 	/* Terminus Tech FE 1.1s 4-port USB 2.0 hub here */
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp22x: pmic@68 {
-		compatible = "x-powers,axp221";
-		reg = <0x34>;
-		interrupt-parent = <&nmi_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-#include "axp22x.dtsi"
-
-&reg_aldo3 {
-	regulator-always-on;
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "avcc";
-};
-
-&reg_dcdc1 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vcc-3v0";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1300000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1300000>;
-	regulator-name = "vdd-sys";
-};
-
-&reg_dcdc5 {
-	regulator-always-on;
-	regulator-min-microvolt = <1500000>;
-	regulator-max-microvolt = <1500000>;
-	regulator-name = "vcc-dram";
-};
-
-&reg_dldo1 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi-io";
 };
 
-&reg_dldo2 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
+&ehci2 {
+	/*
+	 * M2 Berry dropped wiring out USB2, due to all USB port is
+	 * from a hub at USB1.
+	 */
+	status = "disabled";
 };
 
-&mmc0 {
-	vmmc-supply = <&reg_dcdc1>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 13 GPIO_ACTIVE_LOW>; /* PH13 */
-	status = "okay";
+&mmc2 {
+	/* M2 Berry has no eMMC */
+	status = "disabled";
 };
 
-&mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pg_pins>;
-	vmmc-supply = <&reg_dldo2>;
-	vqmmc-supply = <&reg_dldo1>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
+&ohci1 {
+	/*
+	 * M2 Berry have a Hub connected to the USB1 pins, so no USB1.1 device
+	 * can be directly connected to the USB1 port, thus the OHCI controller
+	 * can be disabled.
+	 */
+	status = "disabled";
 };
 
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
+&ohci2 {
+	/* See comments at &ehci2 */
+	status = "disabled";
 };
 
 &usbphy {
-	usb1_vbus-supply = <&reg_vcc5v0>;
-	status = "okay";
+	/* See comments at &ehci2 */
+	/delete-property/ usb2_vbus-supply;
 };
-- 
2.18.0

