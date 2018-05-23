Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934913AbeEWUc2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:32:28 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35621 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeEWUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:32:24 -0400
X-Google-Smtp-Source: AB8JxZo4qlR2Xu+TRaBhC5pK/28IcaH+tzAhdmpjxpGrF0HboMqc01XPtoY6IXktDMkUlnpQccHlQg==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 1/6] Documentation: DT: Consolidate SP805 binding docs
Date: Wed, 23 May 2018 13:32:02 -0700
Message-Id: <1527107527-8093-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate two SP805 binding documents "arm,sp805.txt" and
"sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
desired compatible string to be used

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../devicetree/bindings/watchdog/arm,sp805.txt     | 20 +++++++++++---
 .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
 2 files changed, 16 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
index ca99d64..de93a4d 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
@@ -1,17 +1,29 @@
 ARM AMBA Primecell SP805 Watchdog
 
+SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
+can be used to identify the peripheral type, vendor, and revision.
+This value can be used for driver matching.
+
+As SP805 WDT is a primecell IP, it follows the base bindings specified in
+'arm/primecell.txt'
+
 Required properties:
 - compatible: Should be "arm,sp805" & "arm,primecell"
 - reg: Should contain location and length for watchdog timer register.
-- interrupts: Should contain the list of watchdog timer interrupts.
 - clocks: clocks driving the watchdog timer hardware. This list should be 2
-	clocks. With 2 clocks, the order is wdogclk clock, apb_pclk.
+	clocks. With 2 clocks, the order is wdog_clk, apb_pclk.
+	wdog_clk can be equal to or be a sub-multiple of the apb_pclk frequency
+- clock-names : Shall be "wdog_clk" for first clock and "apb_pclk" for the
+                second one.
+
+Optional properties:
+- interrupts : Should specify WDT interrupt number.
 
 Example:
 	watchdog@66090000 {
 		compatible = "arm,sp805", "arm,primecell";
 		reg = <0x66090000 0x1000>;
 		interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&apb_pclk>,<&apb_pclk>;
-		clock-names = "wdogclk", "apb_pclk";
+		clocks = <&wdt_clk>, <&apb_pclk>;
+		clock-names = "wdog_clk", "apb_pclk";
 	};
diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
deleted file mode 100644
index edc4f0e..0000000
--- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* ARM SP805 Watchdog Timer (WDT) Controller
-
-SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
-can be used to identify the peripheral type, vendor, and revision.
-This value can be used for driver matching.
-
-As SP805 WDT is a primecell IP, it follows the base bindings specified in
-'arm/primecell.txt'
-
-Required properties:
-- compatible : Should be "arm,sp805-wdt", "arm,primecell"
-- reg : Base address and size of the watchdog timer registers.
-- clocks : From common clock binding.
-           First clock is PCLK and the second is WDOGCLK.
-           WDOGCLK can be equal to or be a sub-multiple of the PCLK frequency.
-- clock-names : From common clock binding.
-                Shall be "apb_pclk" for first clock and "wdog_clk" for the
-                second one.
-
-Optional properties:
-- interrupts : Should specify WDT interrupt number.
-
-Examples:
-
-		cluster1_core0_watchdog: wdt@c000000 {
-			compatible = "arm,sp805-wdt", "arm,primecell";
-			reg = <0x0 0xc000000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
-			clock-names = "apb_pclk", "wdog_clk";
-		};
-
-- 
2.1.4
