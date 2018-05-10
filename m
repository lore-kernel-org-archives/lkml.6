Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEJSte (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:49:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55952 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEJSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:48:27 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 4/8] watchdog: JZ4740: Drop module remove function
Date: Thu, 10 May 2018 20:47:47 +0200
Message-Id: <20180510184751.13416-4-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the watchdog was configured for nowayout, and after the
userspace watchdog daemon closed the dev node without sending the
magic character, unloading this module stopped the watchdog
hardware, which was clearly a problem.

Besides, unloading the module is not possible when the userspace
watchdog daemon is running, so it's safe to assume that we don't
need to stop the watchdog hardware in the jz4740_wdt_remove()
function.

For this reason, the jz4740_wdt_remove() function can then be
dropped alltogether.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

 v2: New patch in this series
 v3: No change

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index b8b015a7d045..ec4d99a830ba 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -206,16 +206,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int jz4740_wdt_remove(struct platform_device *pdev)
-{
-	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
-
-	return jz4740_wdt_stop(&drvdata->wdt);
-}
-
 static struct platform_driver jz4740_wdt_driver = {
 	.probe = jz4740_wdt_probe,
-	.remove = jz4740_wdt_remove,
 	.driver = {
 		.name = "jz4740-wdt",
 		.of_match_table = of_match_ptr(jz4740_wdt_of_matches),
-- 
2.11.0
