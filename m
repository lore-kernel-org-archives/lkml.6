Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBJUgk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:36:40 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38801 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeBJUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:36:38 -0500
X-Google-Smtp-Source: AH8x224JcstiVuWuXMmbjkotJn60MZ11ZJMiL5R/b2CXMlkZtl5Q5t1i5OxQnZQEgd/YfZaKVXxBmQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] watchdog: uniphier: change order for setting default timeout
Date: Sat, 10 Feb 2018 21:36:20 +0100
Message-Id: <20180210203623.17832-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_init_timeout() will preserve wdd->timeout value if no parameter
nor timeout-secs dt property is set.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/uniphier_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index 0ea2339d9702..0e4f8d53ce3c 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -212,11 +212,10 @@ static int uniphier_wdt_probe(struct platform_device *pdev)
 	wdev->wdt_dev.ops = &uniphier_wdt_ops;
 	wdev->wdt_dev.max_timeout = WDT_PERIOD_MAX;
 	wdev->wdt_dev.min_timeout = WDT_PERIOD_MIN;
+	wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
 	wdev->wdt_dev.parent = dev;
 
-	if (watchdog_init_timeout(&wdev->wdt_dev, timeout, dev) < 0) {
-		wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
-	}
+	watchdog_init_timeout(&wdev->wdt_dev, timeout, dev);
 	watchdog_set_nowayout(&wdev->wdt_dev, nowayout);
 	watchdog_stop_on_reboot(&wdev->wdt_dev);
 
-- 
2.15.1
