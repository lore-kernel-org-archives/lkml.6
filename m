Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeCWVg7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:36:59 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44700 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeCWVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:36:58 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()
Date: Sat, 24 Mar 2018 00:36:46 +0300
Message-Id: <1521841006-12153-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() was added to one error path,
but there is another one. The patch makes sure clk is
disabled at the both of them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/watchdog/davinci_wdt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 3e4c592c239f..6c6594261cb7 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -236,15 +236,22 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 
 	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	davinci_wdt->base = devm_ioremap_resource(dev, wdt_mem);
-	if (IS_ERR(davinci_wdt->base))
-		return PTR_ERR(davinci_wdt->base);
+	if (IS_ERR(davinci_wdt->base)) {
+		ret = PTR_ERR(davinci_wdt->base);
+		goto err_clk_disable;
+	}
 
 	ret = watchdog_register_device(wdd);
-	if (ret < 0) {
-		clk_disable_unprepare(davinci_wdt->clk);
+	if (ret) {
 		dev_err(dev, "cannot register watchdog device\n");
+		goto err_clk_disable;
 	}
 
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(davinci_wdt->clk);
+
 	return ret;
 }
 
-- 
2.7.4
