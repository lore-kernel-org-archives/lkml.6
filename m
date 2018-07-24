Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAFBC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640FE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="sz87vK05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640FE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbeGYA3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:29:12 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39322 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbeGYA3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:29:12 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 08/21] watchdog: jz4740: Use regmap and WDT clock provided by TCU driver
Date:   Wed, 25 Jul 2018 01:19:45 +0200
Message-Id: <20180724231958.20659-9-paul@crapouillou.net>
In-Reply-To: <20180724231958.20659-1-paul@crapouillou.net>
References: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474422; bh=bqiXYje5F0bUp2IwboPJ+pmzRXSTw8ARrIrzUUWP45A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sz87vK05YjrXgCokxbkeivVfhP690BC/woaEAYEbG5lQDHvs3hdM6FqwpmaCbtuOwUj4UZ1bwGDVm5SZ1qAm4rFaMZpUvmRkDLzlP0aUXX3XNeSLpxUhnpxnO6jDbLJw/8R7XclE2k098zZO5or4qr9eElMWt2oCgpIApillL6c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of requesting the "ext" clock and handling the watchdog clock
divider and gating in the watchdog driver, we now request and use the
"wdt" clock that is supplied by the ingenic-timer "TCU" driver.

The major benefit is that the watchdog's clock rate and parent can now
be specified from within devicetree, instead of hardcoded in the driver.

Also, this driver won't poke anymore into the TCU registers to
enable/disable the clock, as this is now handled by the TCU driver.

On the bad side, we break the ABI with devicetree - as we now request a
different clock. In this very specific case it is still okay, as every
Ingenic JZ47xx-based board out there compile the devicetree within the
kernel; so it's still time to push breaking changes, in order to get a
clean devicetree that won't break once it musn't.

Since we broke the ABI by changing the clock, the driver was also
updated to use the regmap provided by the TCU driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/Kconfig      |   2 +
 drivers/watchdog/jz4740_wdt.c | 128 +++++++++++++++++++++---------------------
 2 files changed, 66 insertions(+), 64 deletions(-)

 v5: New patch

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9af07fd92763..834222abbbdb 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1476,7 +1476,9 @@ config INDYDOG
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
 	depends on MACH_JZ4740 || MACH_JZ4780
+	depends on COMMON_CLK
 	select WATCHDOG_CORE
+	select INGENIC_TIMER
 	help
 	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
 
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index ec4d99a830ba..aaa6fc87136c 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/mfd/ingenic-tcu.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -25,26 +26,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-
-#include <asm/mach-jz4740/timer.h>
-
-#define JZ_REG_WDT_TIMER_DATA     0x0
-#define JZ_REG_WDT_COUNTER_ENABLE 0x4
-#define JZ_REG_WDT_TIMER_COUNTER  0x8
-#define JZ_REG_WDT_TIMER_CONTROL  0xC
-
-#define JZ_WDT_CLOCK_PCLK 0x1
-#define JZ_WDT_CLOCK_RTC  0x2
-#define JZ_WDT_CLOCK_EXT  0x4
-
-#define JZ_WDT_CLOCK_DIV_SHIFT   3
-
-#define JZ_WDT_CLOCK_DIV_1    (0 << JZ_WDT_CLOCK_DIV_SHIFT)
-#define JZ_WDT_CLOCK_DIV_4    (1 << JZ_WDT_CLOCK_DIV_SHIFT)
-#define JZ_WDT_CLOCK_DIV_16   (2 << JZ_WDT_CLOCK_DIV_SHIFT)
-#define JZ_WDT_CLOCK_DIV_64   (3 << JZ_WDT_CLOCK_DIV_SHIFT)
-#define JZ_WDT_CLOCK_DIV_256  (4 << JZ_WDT_CLOCK_DIV_SHIFT)
-#define JZ_WDT_CLOCK_DIV_1024 (5 << JZ_WDT_CLOCK_DIV_SHIFT)
+#include <linux/regmap.h>
 
 #define DEFAULT_HEARTBEAT 5
 #define MAX_HEARTBEAT     2048
@@ -64,15 +46,15 @@ MODULE_PARM_DESC(heartbeat,
 
 struct jz4740_wdt_drvdata {
 	struct watchdog_device wdt;
-	void __iomem *base;
-	struct clk *rtc_clk;
+	struct regmap *map;
+	struct clk *clk;
 };
 
 static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 	return 0;
 }
 
@@ -80,52 +62,65 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 				    unsigned int new_timeout)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
-	unsigned int rtc_clk_rate;
-	unsigned int timeout_value;
-	unsigned short clock_div = JZ_WDT_CLOCK_DIV_1;
-
-	rtc_clk_rate = clk_get_rate(drvdata->rtc_clk);
-
-	timeout_value = rtc_clk_rate * new_timeout;
-	while (timeout_value > 0xffff) {
-		if (clock_div == JZ_WDT_CLOCK_DIV_1024) {
-			/* Requested timeout too high;
-			* use highest possible value. */
-			timeout_value = 0xffff;
-			break;
-		}
-		timeout_value >>= 2;
-		clock_div += (1 << JZ_WDT_CLOCK_DIV_SHIFT);
+	struct clk *clk = drvdata->clk;
+	unsigned long clk_rate, timeout_value;
+	bool change_rate = false;
+	u32 tcer;
+	int ret = 0;
+
+	clk_rate = clk_get_rate(clk);
+	timeout_value = clk_rate * new_timeout;
+
+	if (timeout_value > 0xffff) {
+		clk_rate = clk_round_rate(clk, 0xffff / new_timeout);
+		timeout_value = clk_rate * new_timeout;
+		if (timeout_value > 0xffff)
+			return -EINVAL;
+		change_rate = true;
 	}
 
-	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
-	writew(clock_div, drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
+	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
-	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
-	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
-	writew(clock_div | JZ_WDT_CLOCK_RTC,
-		drvdata->base + JZ_REG_WDT_TIMER_CONTROL);
+	if (change_rate) {
+		clk_disable_unprepare(clk);
+		ret = clk_set_rate(clk, clk_rate);
+		clk_prepare_enable(clk);
+		if (ret)
+			goto done;
+	}
 
-	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TDR, (u16)timeout_value);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
 	wdt_dev->timeout = new_timeout;
-	return 0;
+
+done:
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
+	return ret;
 }
 
 static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
 {
-	jz4740_timer_enable_watchdog();
-	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+	int ret;
 
-	return 0;
+	clk_prepare_enable(drvdata->clk);
+	ret = jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	if (ret)
+		clk_disable_unprepare(drvdata->clk);
+	else
+		regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
+
+	return ret;
 }
 
 static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
-	jz4740_timer_disable_watchdog();
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
+	clk_disable_unprepare(drvdata->clk);
 
 	return 0;
 }
@@ -163,13 +158,17 @@ MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
 
 static int jz4740_wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct jz4740_wdt_drvdata *drvdata;
 	struct watchdog_device *jz4740_wdt;
-	struct resource	*res;
 	int ret;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
-			       GFP_KERNEL);
+	if (!dev->of_node) {
+		dev_err(dev, "jz4740-wdt must be probed via devicetree\n");
+		return -ENODEV;
+	}
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
@@ -182,19 +181,20 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	jz4740_wdt->timeout = heartbeat;
 	jz4740_wdt->min_timeout = 1;
 	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
-	jz4740_wdt->parent = &pdev->dev;
+	jz4740_wdt->parent = dev;
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->base))
-		return PTR_ERR(drvdata->base);
+	drvdata->map = dev_get_regmap(dev->parent, NULL);
+	if (IS_ERR(drvdata->map)) {
+		dev_warn(dev, "regmap not found\n");
+		return PTR_ERR(drvdata->map);
+	}
 
-	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
-	if (IS_ERR(drvdata->rtc_clk)) {
-		dev_err(&pdev->dev, "cannot find RTC clock\n");
-		return PTR_ERR(drvdata->rtc_clk);
+	drvdata->clk = devm_clk_get(&pdev->dev, "wdt");
+	if (IS_ERR(drvdata->clk)) {
+		dev_err(&pdev->dev, "cannot find WDT clock\n");
+		return PTR_ERR(drvdata->clk);
 	}
 
 	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
-- 
2.11.0

