Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeEQUTT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:19:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38534 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeEQUTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:16 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/5] rtc: 88pm80x: fix possible race condition
Date: Thu, 17 May 2018 22:18:58 +0200
Message-Id: <20180517201900.22055-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
References: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm80x.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f60c0d73c2f3..dae527f8c58e 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -290,6 +290,10 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 	info->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, info);
 
+	info->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(info->rtc_dev))
+		return PTR_ERR(info->rtc_dev);
+
 	ret = pm80x_request_irq(chip, info->irq, rtc_update_handler,
 				IRQF_ONESHOT, "rtc", info);
 	if (ret < 0) {
@@ -298,10 +302,10 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "88pm80x-rtc",
-					    &pm80x_rtc_ops, THIS_MODULE);
-	if (IS_ERR(info->rtc_dev)) {
-		ret = PTR_ERR(info->rtc_dev);
+	info->rtc_dev->ops = &pm80x_rtc_ops;
+
+	ret = rtc_register_device(info->rtc_dev);
+	if (ret) {
 		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
 		goto out_rtc;
 	}
-- 
2.17.0
