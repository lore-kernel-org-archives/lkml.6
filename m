Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeEJSsk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:48:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56608 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEJSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:48:37 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 6/8] MIPS: jz4780: dts: Fix watchdog node
Date: Thu, 10 May 2018 20:47:49 +0200
Message-Id: <20180510184751.13416-6-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- The previous node requested a memory area of 0x100 bytes, while the
  driver only manipulates four registers present in the first 0x10 bytes.

- The driver requests for the "rtc" clock, but the previous node did not
  provide any.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Mathieu Malaterre <malat@debian.org>
Acked-by: James Hogan <jhogan@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt | 7 ++++++-
 arch/mips/boot/dts/ingenic/jz4780.dtsi                            | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

 v2: No change
 v3: Also fix documentation

diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
index cb44918f01a8..ce1cb72d5345 100644
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
@@ -3,10 +3,15 @@ Ingenic Watchdog Timer (WDT) Controller for JZ4740 & JZ4780
 Required properties:
 compatible: "ingenic,jz4740-watchdog" or "ingenic,jz4780-watchdog"
 reg: Register address and length for watchdog registers
+clocks: phandle to the RTC clock
+clock-names: should be "rtc"
 
 Example:
 
 watchdog: jz4740-watchdog@10002000 {
 	compatible = "ingenic,jz4740-watchdog";
-	reg = <0x10002000 0x100>;
+	reg = <0x10002000 0x10>;
+
+	clocks = <&cgu JZ4740_CLK_RTC>;
+	clock-names = "rtc";
 };
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9b5794667aee..a52f59bf58c7 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -221,7 +221,10 @@
 
 	watchdog: watchdog@10002000 {
 		compatible = "ingenic,jz4780-watchdog";
-		reg = <0x10002000 0x100>;
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4780_CLK_RTCLK>;
+		clock-names = "rtc";
 	};
 
 	nemc: nemc@13410000 {
-- 
2.11.0
