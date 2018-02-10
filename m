Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeBJKRv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 05:17:51 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44232 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeBJKRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 05:17:49 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()
Date: Sat, 10 Feb 2018 13:17:27 +0300
Message-Id: <1518257847-28796-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180209223209.GA19627@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_reset_control_get_exclusive() fails, asm9260_wdt_probe()
returns immediately. But clks has been already enabled at that point,
so it is required to disable them or to move the code around.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v2: Move the code around instead of disabling clks as Guenter Roeck suggested.

 drivers/watchdog/asm9260_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 7dd0da644a7f..2cf56b459d84 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -292,14 +292,14 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
-	ret = asm9260_wdt_get_dt_clks(priv);
-	if (ret)
-		return ret;
-
 	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
 	if (IS_ERR(priv->rst))
 		return PTR_ERR(priv->rst);
 
+	ret = asm9260_wdt_get_dt_clks(priv);
+	if (ret)
+		return ret;
+
 	wdd = &priv->wdd;
 	wdd->info = &asm9260_wdt_ident;
 	wdd->ops = &asm9260_wdt_ops;
-- 
2.7.4
