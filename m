Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22C4C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763EF2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="L7Pu5ALR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeL0SNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:13:50 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53742 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeL0SNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545934417; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nvAnVxD+gNeDpJ9Q0/TfVq0ySzptpG05UDYop5pdf+E=;
        b=L7Pu5ALRdSGhOnWmIxAdmy2LN8pjKDUAIyFc4fD7ik98e21aLCj/MAxR4FOcXgNy2Czdu8
        roggBPN+MOi2jHLVX2FnVc+yI5ouT8v4vv4MiXMHi57NM3eH+mmq5BVa/b6DS8trgHVe5U
        SqMzGuD1IkoSz3ZmkzTnpAe40bIzJmc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 03/27] dt-bindings: Add doc for the Ingenic TCU drivers
Date:   Thu, 27 Dec 2018 19:12:55 +0100
Message-Id: <20181227181319.31095-4-paul@crapouillou.net>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about how to properly use the Ingenic TCU
(Timer/Counter Unit) drivers from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
         added content.
    
     v5: - Edited PWM/watchdog DT bindings documentation to point to the new
           document.
         - Moved main document to
           Documentation/devicetree/bindings/timer/ingenic,tcu.txt
         - Updated documentation to reflect the new devicetree bindings.
    
     v6: - Removed PWM/watchdog documentation files as asked by upstream
         - Removed doc about properties that should be implicit
         - Removed doc about ingenic,timer-channel /
           ingenic,clocksource-channel as they are gone
         - Fix WDT clock name in the binding doc
         - Fix lengths of register areas in watchdog/pwm nodes
    
     v7: No change

     v8: - Fix address of the PWM node
         - Added doc about system timer and clocksource children nodes

     v9: - Remove doc about system timer and clocksource children
           nodes...
	 - Add doc about ingenic,pwm-channels-mask property

 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
 .../devicetree/bindings/timer/ingenic,tcu.txt      | 139 +++++++++++++++++++++
 .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
 3 files changed, 139 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
deleted file mode 100644
index 7d9d3f90641b..000000000000
--- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Ingenic JZ47xx PWM Controller
-=============================
-
-Required properties:
-- compatible: One of:
-  * "ingenic,jz4740-pwm"
-  * "ingenic,jz4770-pwm"
-  * "ingenic,jz4780-pwm"
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description
-  of the cells format.
-- clocks : phandle to the external clock.
-- clock-names : Should be "ext".
-
-
-Example:
-
-	pwm: pwm@10002000 {
-		compatible = "ingenic,jz4740-pwm";
-		reg = <0x10002000 0x1000>;
-
-		#pwm-cells = <3>;
-
-		clocks = <&ext>;
-		clock-names = "ext";
-	};
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
new file mode 100644
index 000000000000..ec9639700115
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
@@ -0,0 +1,139 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
+==========================================================
+
+For a description of the TCU hardware and drivers, have a look at
+Documentation/mips/ingenic-tcu.txt.
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-tcu
+  * ingenic,jz4725b-tcu
+  * ingenic,jz4770-tcu
+- reg: Should be the offset/length value corresponding to the TCU registers
+- clocks: List of phandle & clock specifiers for clocks external to the TCU.
+  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
+- clock-names: List of name strings for the external clocks.
+- #clock-cells: Should be <1>;
+  Clock consumers specify this argument to identify a clock. The valid values
+  may be found in <dt-bindings/clock/ingenic,tcu.h>.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value should be 1.
+- interrupt-parent : phandle of the interrupt controller.
+- interrupts : Specifies the interrupt the controller is connected to.
+
+Optional properties:
+
+- ingenic,pwm-channels-mask: Bitmask of TCU channels reserved for PWM use.
+  Default value is 0xfe or 0xfc if the SoC does not have the OS Timer.
+
+
+Children nodes
+==========================================================
+
+
+PWM node:
+---------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-pwm
+  * ingenic,jz4725b-pwm
+- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of the cell
+  format.
+- clocks: List of phandle & clock specifiers for the TCU clocks.
+- clock-names: List of name strings for the TCU clocks.
+
+
+Watchdog node:
+--------------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-watchdog
+  * ingenic,jz4780-watchdog
+- clocks: phandle to the WDT clock
+- clock-names: should be "wdt"
+
+
+OS Timer node:
+---------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4725b-ost
+  * ingenic,jz4770-ost
+- clocks: phandle to the OST clock
+- clock-names: should be "ost"
+- interrupts : Specifies the interrupt the OST is connected to.
+
+
+Example
+==========================================================
+
+#include <dt-bindings/clock/jz4770-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
+
+/ {
+	tcu: timer@10002000 {
+		compatible = "ingenic,jz4770-tcu";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		#clock-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_RTC
+			  &cgu JZ4770_CLK_EXT
+			  &cgu JZ4770_CLK_PCLK
+			  &cgu JZ4770_CLK_EXT>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27 26 25>;
+
+		watchdog: watchdog@0 {
+			compatible = "ingenic,jz4740-watchdog";
+			reg = <0x0 0xc>;
+
+			clocks = <&tcu TCU_CLK_WDT>;
+			clock-names = "wdt";
+		};
+
+		pwm: pwm@40 {
+			compatible = "ingenic,jz4740-pwm";
+			reg = <0x40 0x80>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0
+				  &tcu TCU_CLK_TIMER1
+				  &tcu TCU_CLK_TIMER2
+				  &tcu TCU_CLK_TIMER3
+				  &tcu TCU_CLK_TIMER4
+				  &tcu TCU_CLK_TIMER5
+				  &tcu TCU_CLK_TIMER6
+				  &tcu TCU_CLK_TIMER7>;
+			clock-names = "timer0", "timer1", "timer2", "timer3",
+				      "timer4", "timer5", "timer6", "timer7";
+		};
+
+		ost: timer@e0 {
+			compatible = "ingenic,jz4770-ost";
+			reg = <0xe0 0x20>;
+
+			clocks = <&tcu TCU_CLK_OST>;
+			clock-names = "ost";
+
+			interrupts = <15>;
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
deleted file mode 100644
index ce1cb72d5345..000000000000
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Ingenic Watchdog Timer (WDT) Controller for JZ4740 & JZ4780
-
-Required properties:
-compatible: "ingenic,jz4740-watchdog" or "ingenic,jz4780-watchdog"
-reg: Register address and length for watchdog registers
-clocks: phandle to the RTC clock
-clock-names: should be "rtc"
-
-Example:
-
-watchdog: jz4740-watchdog@10002000 {
-	compatible = "ingenic,jz4740-watchdog";
-	reg = <0x10002000 0x10>;
-
-	clocks = <&cgu JZ4740_CLK_RTC>;
-	clock-names = "rtc";
-};
-- 
2.11.0

