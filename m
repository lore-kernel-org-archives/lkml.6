Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBHNLj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:11:39 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35266 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:11:37 -0500
X-Google-Smtp-Source: AH8x225SsRRPuAz+Ouqgn9aMg6tnXryqCC1RvymkbdotRdG377B3GpXsUOWMSsL38NVwuCWrkCGx0g==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: imx2_wdt: allow setting timeout in devicetree
Date: Thu,  8 Feb 2018 14:11:08 +0100
Message-Id: <20180208131108.3048-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt, it also let us to set
timout-sec property in devicetree.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 2 ++
 drivers/watchdog/imx2_wdt.c                                | 8 ++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 107280ef0025..adc6b76fcb3a 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -11,6 +11,7 @@ Optional properties:
   detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
 - fsl,ext-reset-output: If present the watchdog device is configured to
   assert its external reset (WDOG_B) instead of issuing a software reset.
+- timeout-sec : Contains the watchdog timeout in seconds
 
 Examples:
 
@@ -19,4 +20,5 @@ wdt@73f98000 {
 	reg = <0x73f98000 0x4000>;
 	interrupts = <58>;
 	big-endian;
+	timeout-sec = <20>;
 };
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 4874b0f18650..b8674c5c2d9f 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -76,7 +76,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 
-static unsigned timeout = IMX2_WDT_DEFAULT_TIME;
+static unsigned timeout;
 module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
 				__MODULE_STRING(IMX2_WDT_DEFAULT_TIME) ")");
@@ -275,6 +275,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->info		= &imx2_wdt_info;
 	wdog->ops		= &imx2_wdt_ops;
 	wdog->min_timeout	= 1;
+	wdog->timeout		= IMX2_WDT_DEFAULT_TIME;
 	wdog->max_hw_heartbeat_ms = IMX2_WDT_MAX_TIME * 1000;
 	wdog->parent		= &pdev->dev;
 
@@ -293,11 +294,6 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 	wdev->ext_reset = of_property_read_bool(pdev->dev.of_node,
 						"fsl,ext-reset-output");
-	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
-	if (wdog->timeout != timeout)
-		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
-			 timeout, wdog->timeout);
-
 	platform_set_drvdata(pdev, wdog);
 	watchdog_set_drvdata(wdog, wdev);
 	watchdog_set_nowayout(wdog, nowayout);
-- 
2.15.1
