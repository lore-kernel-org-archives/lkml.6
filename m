Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B352183B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="YyiCkrXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B352183B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeHUUiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57628 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeHUUiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:07 -0400
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
Subject: [PATCH v7 09/24] watchdog: jz4740: Use regmap provided by TCU driver
Date:   Tue, 21 Aug 2018 19:16:20 +0200
Message-Id: <20180821171635.22740-10-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871824; bh=fM3Kfrs201BnoBmqhC8GaYnqHG2NjHRAaBZsVsmcIMg=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YyiCkrXYD4izhOEM90Fe3Pkdk74ZMWvwwI9qz1vfUVUroAHblbYatgELySBPe3dTThcLBaBws1v/akD69NUN8uR3SHQKoHNdxAgjCn7zb7kUR1KuSF7x2QqTOmH268SMXl3raCZHNSQKq0rBw2tGezWG9F94WhWmw+J4RuLdk/8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we broke the ABI by changing the clock, the driver was also
updated to use the regmap provided by the TCU driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
     v6: New patch
    
     v7: No change

 drivers/watchdog/jz4740_wdt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 1d504ecf45e1..0f54306aee25 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/mfd/ingenic-tcu.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -25,10 +26,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-
-#define JZ_REG_WDT_TIMER_DATA     0x0
-#define JZ_REG_WDT_COUNTER_ENABLE 0x4
-#define JZ_REG_WDT_TIMER_COUNTER  0x8
+#include <linux/regmap.h>
 
 #define DEFAULT_HEARTBEAT 5
 #define MAX_HEARTBEAT     2048
@@ -48,7 +46,7 @@ MODULE_PARM_DESC(heartbeat,
 
 struct jz4740_wdt_drvdata {
 	struct watchdog_device wdt;
-	void __iomem *base;
+	struct regmap *map;
 	struct clk *clk;
 	unsigned long clk_rate;
 };
@@ -57,7 +55,7 @@ static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 	return 0;
 }
 
@@ -67,12 +65,12 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
 
-	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
-	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
-	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
+	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
-	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	wdt_dev->timeout = new_timeout;
 	return 0;
@@ -96,7 +94,7 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 	clk_disable_unprepare(drvdata->clk);
 
 	return 0;
@@ -138,7 +136,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct jz4740_wdt_drvdata *drvdata;
 	struct watchdog_device *jz4740_wdt;
-	struct resource	*res;
 	long rate;
 	int ret;
 
@@ -174,10 +171,11 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->base))
-		return PTR_ERR(drvdata->base);
+	drvdata->map = dev_get_regmap(dev->parent, NULL);
+	if (!drvdata->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
 
 	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (ret < 0)
-- 
2.11.0

