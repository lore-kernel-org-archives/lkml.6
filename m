Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933037AbeBLWsp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:45 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37583 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932954AbeBLWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:38 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 28/45] rtc: ds1553: switch to rtc_register_device
Date: Mon, 12 Feb 2018 23:47:42 +0100
Message-Id: <20180212224759.15999-29-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1553.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 9961ec646fd2..59eab5eceafa 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -308,11 +308,16 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 	pdata->last_jiffies = jiffies;
 	platform_set_drvdata(pdev, pdata);
 
-	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-				  &ds1553_rtc_ops, THIS_MODULE);
+	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(pdata->rtc))
 		return PTR_ERR(pdata->rtc);
 
+	pdata->rtc->ops = &ds1553_rtc_ops;
+
+	ret = rtc_register_device(pdata->rtc);
+	if (ret)
+		return ret;
+
 	if (pdata->irq > 0) {
 		writeb(0, ioaddr + RTC_INTERRUPTS);
 		if (devm_request_irq(&pdev->dev, pdata->irq,
-- 
2.16.1
