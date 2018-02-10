Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeBJUgn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:36:43 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39468 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeBJUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:36:40 -0500
X-Google-Smtp-Source: AH8x227MKNeVff1Ic+x92WLR1hISLbshZx05S6mEalP+1aowAyjjlQV5WA3nfMwOe/E8Rgu9GF87FQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] watchdog: omap_wdt: change order for setting default timeout
Date: Sat, 10 Feb 2018 21:36:21 +0100
Message-Id: <20180210203623.17832-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_init_timeout() will preserve wdd->timeout value if
no parameter nor timeout-secs dt property is set.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/omap_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1b02bfa81b29..ae77112ce97f 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -253,10 +253,10 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	wdev->wdog.ops = &omap_wdt_ops;
 	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
 	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
+	wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
 	wdev->wdog.parent = &pdev->dev;
 
-	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
-		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
+	watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev);
 
 	watchdog_set_nowayout(&wdev->wdog, nowayout);
 
-- 
2.15.1
