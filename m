Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeDDLMA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:12:00 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59422 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751332AbeDDLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:11:54 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 4/6] arm: dts: modify clock binding in NPCM750 device tree
Date: Wed,  4 Apr 2018 14:11:00 +0300
Message-Id: <1522840262-21635-5-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
References: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify clock binding in a common device tree for all Nuvoton
NPCM750 BMCs.

Modify NPCM750 modules clock numbers accourding the new
clock driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton-npcm750.dtsi | 58 ++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
index c7d80d2152ae..d53eccfe44cb 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -17,7 +17,7 @@
 		cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			clocks = <&clk 10>;
+			clocks = <&clk 0>;
 			clock-names = "clk_cpu";
 			reg = <0>;
 			next-level-cache = <&l2>;
@@ -26,31 +26,58 @@
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-			clocks = <&clk 10>;
+			clocks = <&clk 0>;
 			clock-names = "clk_cpu";
 			reg = <1>;
 			next-level-cache = <&l2>;
 		};
 	};
 
-	/* external clock signal rg1refck, supplied by the phy */
-	clk-rg1refck {
+	/* external reference clock */
+	clk-refclk: clk-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "refclk";
+	};
+
+	/* external reference clock for cpu. float in normal operation */
+	clk-sysbypck: clk-sysbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "sysbypck";
+	};
+
+	/* external reference clock for MC. float in normal operation */
+	clk-mcbypck: clk-mcbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "mcbypck";
+	};
+
+	 /* external clock signal rg1refck, supplied by the phy */
+	clk-rg1refck: clk-rg1refck {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
+		clock-output-names = "clk-rg1refck";
 	};
 
 	/* external clock signal rg2refck, supplied by the phy */
-	clk-rg2refck {
+	clk-rg2refck: clk-rg2refck {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
+		clock-output-names = "clk-rg2refck";
 	};
 
-	clk-xin {
+	clk-xin: clk-xin {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <50000000>;
+		clock-output-names = "clk-xin";
 	};
 
 	soc {
@@ -77,7 +104,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
-			clocks = <&clk 22>;
+			clocks = <&clk 10>;
 			arm,shared-override;
 		};
 
@@ -94,7 +121,7 @@
 			reg = <0x3fe600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
 						  IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&clk 15>;
+			clocks = <&clk 5>;
 		};
 	};
 
@@ -106,9 +133,12 @@
 		ranges;
 
 		clk: clock-controller@f0801000 {
-			compatible = "nuvoton,npcm750-clk";
+			compatible = "nuvoton,npcm750-clk", "syscon";
 			#clock-cells = <1>;
+			clock-controller;
 			reg = <0xf0801000 0x1000>;
+			clock-names = "refclk", "sysbypck", "mcbypck";
+			clocks = <&clk-refclk>, <&clk-sysbypck>, <&clk-mcbypck>;
 		};
 
 		apb {
@@ -122,7 +152,7 @@
 				compatible = "nuvoton,npcm750-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x8000 0x50>;
-				clocks = <&clk 15>;
+				clocks = <&clk 5>;
 			};
 
 			watchdog0: watchdog@801C {
@@ -152,7 +182,7 @@
 			serial0: serial@1000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x1000 0x1000>;
-				clocks = <&clk 14>;
+				clocks = <&clk 6>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
@@ -161,7 +191,7 @@
 			serial1: serial@2000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x2000 0x1000>;
-				clocks = <&clk 14>;
+				clocks = <&clk 6>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
@@ -170,7 +200,7 @@
 			serial2: serial@3000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x3000 0x1000>;
-				clocks = <&clk 14>;
+				clocks = <&clk 6>;
 				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
@@ -179,7 +209,7 @@
 			serial3: serial@4000 {
 				compatible = "nuvoton,npcm750-uart";
 				reg = <0x4000 0x1000>;
-				clocks = <&clk 14>;
+				clocks = <&clk 6>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				reg-shift = <2>;
 				status = "disabled";
-- 
2.14.1
