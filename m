Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEJSsU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:48:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55294 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEJSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:48:17 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/8] watchdog: jz4740: Use devm_* functions
Date: Thu, 10 May 2018 20:47:45 +0200
Message-Id: <20180510184751.13416-2-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use devm_clk_get instead of clk_get
- Use devm_watchdog_register_device instead of watchdog_register_device

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

 v2: No change
 v3: No change

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 55c9a1f26498..22136e3522b9 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -179,40 +179,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->base)) {
-		ret = PTR_ERR(drvdata->base);
-		goto err_out;
-	}
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
-	drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
+	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
 	if (IS_ERR(drvdata->rtc_clk)) {
 		dev_err(&pdev->dev, "cannot find RTC clock\n");
-		ret = PTR_ERR(drvdata->rtc_clk);
-		goto err_out;
+		return PTR_ERR(drvdata->rtc_clk);
 	}
 
-	ret = watchdog_register_device(&drvdata->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, drvdata);
-	return 0;
 
-err_disable_clk:
-	clk_put(drvdata->rtc_clk);
-err_out:
-	return ret;
+	return 0;
 }
 
 static int jz4740_wdt_remove(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
 
-	jz4740_wdt_stop(&drvdata->wdt);
-	watchdog_unregister_device(&drvdata->wdt);
-	clk_put(drvdata->rtc_clk);
-
-	return 0;
+	return jz4740_wdt_stop(&drvdata->wdt);
 }
 
 static struct platform_driver jz4740_wdt_driver = {
-- 
2.11.0
