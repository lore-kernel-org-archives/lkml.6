Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424996AbeE1Lwf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423373AbeE1LJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 121/272] watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()
Date: Mon, 28 May 2018 12:02:34 +0200
Message-Id: <20180528100251.295713678@linuxfoundation.org>
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

[ Upstream commit d66e53649c18377edc08d48901e658e4fd491d46 ]

clk_disable_unprepare() was added to one error path,
but there is another one. The patch makes sure clk is
disabled at the both of them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/davinci_wdt.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -236,15 +236,22 @@ static int davinci_wdt_probe(struct plat
 
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
 
