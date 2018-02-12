Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbeBLWsx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:53 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37575 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932957AbeBLWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:38 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 30/45] rtc: ds1553: make alarms useful
Date: Mon, 12 Feb 2018 23:47:44 +0100
Message-Id: <20180212224759.15999-31-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the IRQs are disabled when the rtc driver is removed (e.g. when
shutting down the platform).
This means that the RTC will be unable to wakeup the platform.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1553.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 6205c28e0cdc..7334c824371a 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -330,21 +330,11 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ds1553_rtc_remove(struct platform_device *pdev)
-{
-	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-
-	if (pdata->irq > 0)
-		writeb(0, pdata->ioaddr + RTC_INTERRUPTS);
-	return 0;
-}
-
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:rtc-ds1553");
 
 static struct platform_driver ds1553_rtc_driver = {
 	.probe		= ds1553_rtc_probe,
-	.remove		= ds1553_rtc_remove,
 	.driver		= {
 		.name	= "rtc-ds1553",
 	},
-- 
2.16.1
