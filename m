Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938304AbeE1LaA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424174AbeE1LOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:14:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 214/272] watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()
Date: Mon, 28 May 2018 12:04:07 +0200
Message-Id: <20180528100258.475516734@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 3c829f47e33eb0398a9a14e357a05199a7be0277 ]

If devm_reset_control_get_exclusive() fails, asm9260_wdt_probe()
returns immediately. But clks has been already enabled at that point,
so it is required to disable them or to move the code around.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/asm9260_wdt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -292,14 +292,14 @@ static int asm9260_wdt_probe(struct plat
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
