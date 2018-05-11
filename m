Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeEKDB1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:01:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39147 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751430AbeEKDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:01:26 -0400
X-ME-Sender: <xms:hQf1Wm098pmOC3NpJ1YBwZjTZBjNirVvnP0lqftjYYxFt7itiAWf5A>
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] arm64: dts: allwinner: a64: Update Orange Pi Win/Win Plus
Date: Thu, 10 May 2018 22:01:23 -0500
Message-Id: <20180511030124.9356-1-samuel@sholland.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the following board hardware features:
- Gigabit Ethernet
- SDIO Wi-Fi on mmc1
- SPI flash on spi0
- Status LED
- Dual-role micro-USB connection

Also provide nodes for the UARTs exposed by the 40-pin GPIO header.

A couple of fixes were made:
- Updating a couple of regulators from the schematic
- Marking the CPU's power supply as such

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 141 ++++++++++++++++++++-
 1 file changed, 134 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index bf42690a3361..fd0636381d7f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
+ * Copyright (C) 2017-2018 Samuel Holland <samuel@sholland.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -51,23 +52,97 @@
 	compatible = "xunlong,orangepi-win", "allwinner,sun50i-a64";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status {
+			label = "orangepi:green:status";
+			gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+		};
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
+		status = "okay";
+	};
+
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
+		status = "okay";
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
 };
 
 &ehci1 {
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_3v3>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_dldo2>;
+	vqmmc-supply = <&reg_dldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
 	status = "okay";
 };
 
@@ -89,10 +164,9 @@
 #include "axp803.dtsi"
 
 &reg_aldo1 {
-	regulator-always-on;
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "afvcc-csi";
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-csi";
 };
 
 &reg_aldo2 {
@@ -166,7 +240,13 @@
 &reg_eldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-	regulator-name = "cpvdd";
+	regulator-name = "vcc-pc";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-csi";
 };
 
 &reg_fldo1 {
@@ -191,13 +271,60 @@
 	regulator-name = "vcc-rtc";
 };
 
+&spi0 {
+	status = "okay";
+
+	spi-flash@0 {
+		compatible = "mxicy,mx25l1606e", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		m25p,fast-read;
+		status = "okay";
+	};
+};
+
+/* On debug connector */
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
 
-&usbphy {
+/* Wi-Fi/BT */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "disabled";
+};
+
+/* On Pi-2 connector, RTS/CTS optional */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+/* On Pi-2 connector, RTS/CTS optional */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
+/* On Pi-2 connector (labeled for SPI1), RTS/CTS optional */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+	status = "disabled";
+};
+
+&usb_otg {
+	dr_mode = "otg";
 	status = "okay";
 };
 
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.16.1
