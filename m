Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D559C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C7321840
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qfrzSHfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C7321840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeHUUiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeHUUiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:23 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 19/24] MIPS: jz4740: Add DTS nodes for the TCU drivers
Date:   Tue, 21 Aug 2018 19:16:30 +0200
Message-Id: <20180821171635.22740-20-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871840; bh=LMLhVsPF/PF+Wg53B9J+/KKd0SxHP0oDneJuBJRsXMM=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qfrzSHfFUXj6ylLIS7JlCDUxqOKTVRoZve0ZJWvspiLgJBsSdTKk1O/b6SaAt6qsV/41xCNGTpIVtCnP/OIOnGbvHVJRMAaCqFnhgAB1nMn6fbwB24ux6pLiGjKkr4okP9gVHb0YCE2bfplZjqVeimChdd/JH66PyQMxcoLsw6U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTS nodes for the JZ4780, JZ4770 and JZ4740 devicetree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: Fix register lengths in watchdog/pwm nodes
    
     v7: No change

 arch/mips/boot/dts/ingenic/jz4740.dtsi | 51 +++++++++++++++++++++++---
 arch/mips/boot/dts/ingenic/jz4770.dtsi | 59 ++++++++++++++++++++++++++++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 67 ++++++++++++++++++++++++++++++----
 3 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 26c6b561d6f7..bd4090b27dbb 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/jz4740-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
 
 / {
 	#address-cells = <1>;
@@ -45,12 +46,52 @@
 		#clock-cells = <1>;
 	};
 
-	watchdog: watchdog@10002000 {
-		compatible = "ingenic,jz4740-watchdog";
-		reg = <0x10002000 0x10>;
+	tcu: timer@10002000 {
+		compatible = "ingenic,jz4740-tcu";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
 
-		clocks = <&cgu JZ4740_CLK_RTC>;
-		clock-names = "rtc";
+		#clock-cells = <1>;
+
+		clocks = <&cgu JZ4740_CLK_RTC
+			  &cgu JZ4740_CLK_EXT
+			  &cgu JZ4740_CLK_PCLK
+			  &cgu JZ4740_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <23 22 21>;
+
+		watchdog: watchdog@0 {
+			compatible = "ingenic,jz4740-watchdog";
+			reg = <0x0 0xc>;
+
+			clocks = <&tcu TCU_CLK_WDT>;
+			clock-names = "wdt";
+		};
+
+		pwm: pwm@10 {
+			compatible = "ingenic,jz4740-pwm";
+			reg = <0x10 0x40>;
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
 	};
 
 	rtc_dev: rtc@10003000 {
diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index 7c2804f3f5f1..1097b97fd7a9 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <dt-bindings/clock/jz4770-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
 
 / {
 	#address-cells = <1>;
@@ -46,6 +47,64 @@
 		#clock-cells = <1>;
 	};
 
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
+		pwm: pwm@10 {
+			compatible = "ingenic,jz4740-pwm";
+			reg = <0x10 0x40>;
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
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,jz4770-pinctrl";
 		reg = <0x10010000 0x600>;
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index aa4e8f75ff5d..93da52eea1d2 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/jz4780-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
 #include <dt-bindings/dma/jz4780-dma.h>
 
 / {
@@ -46,6 +47,64 @@
 		#clock-cells = <1>;
 	};
 
+	tcu: timer@10002000 {
+		compatible = "ingenic,jz4770-tcu";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		#clock-cells = <1>;
+
+		clocks = <&cgu JZ4780_CLK_RTCLK
+			  &cgu JZ4780_CLK_EXCLK
+			  &cgu JZ4780_CLK_PCLK
+			  &cgu JZ4780_CLK_EXCLK>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27 26 25>;
+
+		watchdog: watchdog@0 {
+			compatible = "ingenic,jz4780-watchdog";
+			reg = <0x0 0xc>;
+
+			clocks = <&tcu TCU_CLK_WDT>;
+			clock-names = "wdt";
+		};
+
+		pwm: pwm@10 {
+			compatible = "ingenic,jz4740-pwm";
+			reg = <0x10 0x40>;
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
+
 	rtc_dev: rtc@10003000 {
 		compatible = "ingenic,jz4780-rtc";
 		reg = <0x10003000 0x4c>;
@@ -220,14 +279,6 @@
 		status = "disabled";
 	};
 
-	watchdog: watchdog@10002000 {
-		compatible = "ingenic,jz4780-watchdog";
-		reg = <0x10002000 0x10>;
-
-		clocks = <&cgu JZ4780_CLK_RTCLK>;
-		clock-names = "rtc";
-	};
-
 	nemc: nemc@13410000 {
 		compatible = "ingenic,jz4780-nemc";
 		reg = <0x13410000 0x10000>;
-- 
2.11.0

