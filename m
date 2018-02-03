Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBCLYw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:24:52 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50283 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbeBCLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:24:45 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] Revert "ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2"
Date: Sat,  3 Feb 2018 19:23:53 +0800
Message-Id: <20180203112353.13497-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7daa213700758b5b08fc0daab09bb139dd334165.

The original commit has several problems:

- vdd-cpus and aldo3 (AVCC of the SoC) are not set to always-on, which
leads to system hang when disabling unused regulators.
- GMAC (which uses dldo1 and aldo2) and Wi-Fi (which uses aldo1) are not
considered, and will fail to work after adding this commit.

This indicates that this patch should be not tested at all.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 57 ------------------------
 1 file changed, 57 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 51e6f1d21c32..a565316eb340 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -86,10 +86,6 @@
 	};
 };
 
-&cpu0 {
-	cpu-supply = <&reg_dcdc3>;
-};
-
 &ehci0 {
 	status = "okay";
 };
@@ -155,17 +151,6 @@
 	status = "okay";
 };
 
-&p2wi {
-	status = "okay";
-
-	axp22x: pmic@68 {
-		compatible = "x-powers,axp221";
-		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
 &pio {
 	gmac_phy_reset_pin_bpi_m2: gmac_phy_reset_pin@0 {
 		pins = "PA21";
@@ -191,48 +176,6 @@
 	};
 };
 
-#include "axp22x.dtsi"
-
-&reg_dc5ldo {
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-cpus";
-};
-
-&reg_dcdc1 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "vdd-3v0";
-};
-
-&reg_dcdc2 {
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-gpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc4 {
-	regulator-always-on;
-	regulator-min-microvolt = <700000>;
-	regulator-max-microvolt = <1320000>;
-	regulator-name = "vdd-sys-dll";
-};
-
-&reg_dcdc5 {
-	regulator-always-on;
-	regulator-min-microvolt = <1500000>;
-	regulator-max-microvolt = <1500000>;
-	regulator-name = "vcc-dram";
-};
-
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.15.1
