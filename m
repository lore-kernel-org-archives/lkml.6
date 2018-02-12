Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932989AbeBLW5N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:57:13 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37552 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932701AbeBLWs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:28 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 14/45] rtc: omap: call rtc_nvmem_register()
Date: Mon, 12 Feb 2018 23:47:28 +0100
Message-Id: <20180212224759.15999-15-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call rtc_nvmem_register instead of letting the core do it and stop using
the nvmem_config member of struct rtc_device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 09ef802d6e54..e53cb27f4118 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -850,7 +850,6 @@ static int omap_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc->ops = &omap_rtc_ops;
 	omap_rtc_nvmem_config.priv = rtc;
-	rtc->rtc->nvmem_config = &omap_rtc_nvmem_config;
 
 	/* handle periodic and alarm irqs */
 	ret = devm_request_irq(&pdev->dev, rtc->irq_timer, rtc_irq, 0,
@@ -886,6 +885,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	rtc_nvmem_register(rtc->rtc, &omap_rtc_nvmem_config);
+
 	return 0;
 
 err:
-- 
2.16.1
