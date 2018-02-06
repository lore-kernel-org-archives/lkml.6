Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeBFEwQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:52:16 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50368 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeBFEvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:51:24 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 08/10] ARM: sun8i: h3: Add SY8106A regulator to Orange Pi PC
Date: Tue,  6 Feb 2018 12:49:03 +0800
Message-Id: <20180206044905.30508-9-icenowy@aosc.io>
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
Orange Pi PC, then set the power supply of the ARM cores to this
regulator, in order to enable DVFS.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Enable DVFS in this patch, slight changes and change commit
 message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Reduce maximum voltage to 1.3V.
- Slightly changed the comment at 1.0V minimum voltage for taking BSP
  DVFS table instead of Armbian one.

 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index d22546df1b82..ded9d8d6d008 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -98,6 +98,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_sy8106a>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -160,6 +164,29 @@
 	};
 };
 
+&r_i2c {
+	status = "okay";
+
+	reg_sy8106a: regulator@65 {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "vdd-cpux";
+		/*
+		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
+		 * however both the Armbian DVFS table and the official one
+		 * have operating points with voltage under 1.1V, and both
+		 * DVFS table are known to work properly at the lowest
+		 * operating point.
+		 *
+		 * Use 1.0V as the minimum voltage instead.
+		 */
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &r_pio {
 	leds_r_opc: led_pins {
 		pins = "PL10";
-- 
2.15.1
