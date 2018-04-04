Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDDLNL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:13:11 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59427 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751352AbeDDLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:11:54 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 6/6] arm: dts: modify Nuvoton NPCM7xx device tree structure
Date: Wed,  4 Apr 2018 14:11:02 +0300
Message-Id: <1522840262-21635-7-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
References: <1522840262-21635-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify Nuvoton NPCM7xx device tree structure by adding
nuvoton common nNPCM7xx device tree structure that
include all common modules.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 187 ++++++++++++++++++++++++++
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |   2 +-
 arch/arm/boot/dts/nuvoton-npcm750.dtsi        | 179 +-----------------------
 3 files changed, 190 insertions(+), 178 deletions(-)
 create mode 100644 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
new file mode 100644
index 000000000000..d2d0761295a4
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com
+// Copyright 2018 Google, Inc.
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	/* external reference clock */
+	clk_refclk: clk_refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "refclk";
+	};
+
+	/* external reference clock for cpu. float in normal operation */
+	clk_sysbypck: clk_sysbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "sysbypck";
+	};
+
+	/* external reference clock for MC. float in normal operation */
+	clk_mcbypck: clk_mcbypck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <800000000>;
+		clock-output-names = "mcbypck";
+	};
+
+	 /* external clock signal rg1refck, supplied by the phy */
+	clk_rg1refck: clk_rg1refck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_rg1refck";
+	};
+
+	 /* external clock signal rg2refck, supplied by the phy */
+	clk_rg2refck: clk_rg2refck {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_rg2refck";
+	};
+
+	clk_xin: clk_xin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+		clock-output-names = "clk_xin";
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges = <0x0 0xf0000000 0x00900000>;
+
+		gcr: gcr@800000 {
+			compatible = "nuvoton,npcm750-gcr", "syscon",
+				"simple-mfd";
+			reg = <0x800000 0x1000>;
+		};
+
+		scu: scu@3fe000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0x3fe000 0x1000>;
+		};
+
+		l2: cache-controller@3fc000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x3fc000 0x1000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+			clocks = <&clk 10>;
+			arm,shared-override;
+		};
+
+		gic: interrupt-controller@3ff000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x3ff000 0x1000>,
+				<0x3fe100 0x100>;
+		};
+	};
+
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		clk: clock-controller@f0801000 {
+			compatible = "nuvoton,npcm750-clk", "syscon";
+			#clock-cells = <1>;
+			clock-controller;
+			reg = <0xf0801000 0x1000>;
+			clock-names = "refclk", "sysbypck", "mcbypck";
+			clocks = <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
+		};
+
+		apb {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			interrupt-parent = <&gic>;
+			ranges = <0x0 0xf0000000 0x00300000>;
+
+			timer0: timer@8000 {
+				compatible = "nuvoton,npcm750-timer";
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x8000 0x50>;
+				clocks = <&clk 5>;
+			};
+
+			watchdog0: watchdog@801C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x801C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			watchdog1: watchdog@901C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x901C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			watchdog2: watchdog@a01C {
+				compatible = "nuvoton,npcm750-wdt";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xa01C 0x4>;
+				status = "disabled";
+				clocks = <&clk 5>;
+			};
+
+			serial0: serial@1000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x1000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			serial1: serial@2000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x2000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			serial2: serial@3000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x3000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+
+			serial3: serial@4000 {
+				compatible = "nuvoton,npcm750-uart";
+				reg = <0x4000 0x1000>;
+				clocks = <&clk 6>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				reg-shift = <2>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 4416dd6c7c17..15f744f1beea 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Nuvoton Technology corporation.
+// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com
 // Copyright 2018 Google, Inc.
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
index d53eccfe44cb..6ac340533587 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Nuvoton Technology corporation.
+// Copyright (c) 2018 Nuvoton Technology tomer.maimon@nuvoton.com
 // Copyright 2018 Google, Inc.
 
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "nuvoton-common-npcm7xx.dtsi"
 
 / {
 	#address-cells = <1>;
@@ -32,90 +32,7 @@
 			next-level-cache = <&l2>;
 		};
 	};
-
-	/* external reference clock */
-	clk-refclk: clk-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-		clock-output-names = "refclk";
-	};
-
-	/* external reference clock for cpu. float in normal operation */
-	clk-sysbypck: clk-sysbypck {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <800000000>;
-		clock-output-names = "sysbypck";
-	};
-
-	/* external reference clock for MC. float in normal operation */
-	clk-mcbypck: clk-mcbypck {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <800000000>;
-		clock-output-names = "mcbypck";
-	};
-
-	 /* external clock signal rg1refck, supplied by the phy */
-	clk-rg1refck: clk-rg1refck {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "clk-rg1refck";
-	};
-
-	/* external clock signal rg2refck, supplied by the phy */
-	clk-rg2refck: clk-rg2refck {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "clk-rg2refck";
-	};
-
-	clk-xin: clk-xin {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <50000000>;
-		clock-output-names = "clk-xin";
-	};
-
 	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
-		ranges = <0x0 0xf0000000 0x00900000>;
-
-		gcr: gcr@800000 {
-			compatible = "nuvoton,npcm750-gcr", "syscon",
-				"simple-mfd";
-			reg = <0x800000 0x1000>;
-		};
-
-		scu: scu@3fe000 {
-			compatible = "arm,cortex-a9-scu";
-			reg = <0x3fe000 0x1000>;
-		};
-
-		l2: cache-controller@3fc000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x3fc000 0x1000>;
-			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			cache-unified;
-			cache-level = <2>;
-			clocks = <&clk 10>;
-			arm,shared-override;
-		};
-
-		gic: interrupt-controller@3ff000 {
-			compatible = "arm,cortex-a9-gic";
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			reg = <0x3ff000 0x1000>,
-			    <0x3fe100 0x100>;
-		};
-
 		timer@3fe600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x3fe600 0x20>;
@@ -124,96 +41,4 @@
 			clocks = <&clk 5>;
 		};
 	};
-
-	ahb {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
-		ranges;
-
-		clk: clock-controller@f0801000 {
-			compatible = "nuvoton,npcm750-clk", "syscon";
-			#clock-cells = <1>;
-			clock-controller;
-			reg = <0xf0801000 0x1000>;
-			clock-names = "refclk", "sysbypck", "mcbypck";
-			clocks = <&clk-refclk>, <&clk-sysbypck>, <&clk-mcbypck>;
-		};
-
-		apb {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges = <0x0 0xf0000000 0x00300000>;
-
-			timer0: timer@8000 {
-				compatible = "nuvoton,npcm750-timer";
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x50>;
-				clocks = <&clk 5>;
-			};
-
-			watchdog0: watchdog@801C {
-				compatible = "nuvoton,npcm750-wdt";
-				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x801C 0x4>;
-				status = "disabled";
-				clocks = <&clk 5>;
-			};
-
-			watchdog1: watchdog@901C {
-				compatible = "nuvoton,npcm750-wdt";
-				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x901C 0x4>;
-				status = "disabled";
-				clocks = <&clk 5>;
-			};
-
-			watchdog2: watchdog@a01C {
-				compatible = "nuvoton,npcm750-wdt";
-				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0xa01C 0x4>;
-				status = "disabled";
-				clocks = <&clk 5>;
-			};
-
-			serial0: serial@1000 {
-				compatible = "nuvoton,npcm750-uart";
-				reg = <0x1000 0x1000>;
-				clocks = <&clk 6>;
-				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				reg-shift = <2>;
-				status = "disabled";
-			};
-
-			serial1: serial@2000 {
-				compatible = "nuvoton,npcm750-uart";
-				reg = <0x2000 0x1000>;
-				clocks = <&clk 6>;
-				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-				reg-shift = <2>;
-				status = "disabled";
-			};
-
-			serial2: serial@3000 {
-				compatible = "nuvoton,npcm750-uart";
-				reg = <0x3000 0x1000>;
-				clocks = <&clk 6>;
-				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-				reg-shift = <2>;
-				status = "disabled";
-			};
-
-			serial3: serial@4000 {
-				compatible = "nuvoton,npcm750-uart";
-				reg = <0x4000 0x1000>;
-				clocks = <&clk 6>;
-				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-				reg-shift = <2>;
-				status = "disabled";
-			};
-		};
-	};
 };
-- 
2.14.1
