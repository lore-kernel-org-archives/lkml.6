Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeBFEvM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:51:12 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50305 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbeBFEvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:51:02 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 05/10] ARM: sun8i: h3: add operating-points-v2 table for CPU
Date: Tue,  6 Feb 2018 12:49:00 +0800
Message-Id: <20180206044905.30508-6-icenowy@aosc.io>
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU on Allwinner H3 can do dynamic frequency scaling.

Add a DVFS table based on the one shipped with Allwinner's H3 SDK. The
voltage-frequency relationship seems to be conservative, and Armbian has
another DVFS table which uses lower voltage at a certain frequency.
However, the official one is chosen for safety.

Frequencies higher than 1008MHz are temporarily dropped in the table, as
they may lead to over voltage on boards without proper regulator
settings or over temperature on boards with proper regulator settings.
They will be added back once regulator settings are ready and thermal
sensor driver is merged.

In order to satisfy all different regulators (SY8106A which is 50mV per
level, SY8113B which have two states: 1.1V and 1.3V, and some board with
non-tweakable regulators), all the OPPs are defined with a range which has
the target value as the minimum allowed value, and 1.3V (the highest
VDD-CPUX voltage suggested by the datasheet) as the maximum allowed value.
It's proven to work well with a board with SY8113B.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Switch to BSP OPP table, which is more conservative.

 arch/arm/boot/dts/sun8i-h3.dtsi | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 8495deecedad..36608c03f02b 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -43,32 +43,62 @@
 #include "sunxi-h3-h5.dtsi"
 
 / {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <1040000 1040000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1100000 1100000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1200000 1200000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <0x2>;
 		};
 
 		cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
-- 
2.15.1
