Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EF0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1EB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1EB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbeIXUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42301 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733127AbeIXUvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7112E20731; Mon, 24 Sep 2018 16:49:08 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0C8D9204AE;
        Mon, 24 Sep 2018 16:49:08 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: ab8500: use rtc_add_group
Date:   Mon, 24 Sep 2018 16:49:00 +0200
Message-Id: <20180924144902.607-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rtc_add_group to add the sysfs group in a race free manner.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab8500.c | 41 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index e28f4401fd35..e97015e5c63e 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -360,15 +360,14 @@ static DEVICE_ATTR(rtc_calibration, S_IRUGO | S_IWUSR,
 		   ab8500_sysfs_show_rtc_calibration,
 		   ab8500_sysfs_store_rtc_calibration);
 
-static int ab8500_sysfs_rtc_register(struct device *dev)
-{
-	return device_create_file(dev, &dev_attr_rtc_calibration);
-}
+static struct attribute *ab8500_rtc_attrs[] = {
+	&dev_attr_rtc_calibration.attr,
+	NULL
+};
 
-static void ab8500_sysfs_rtc_unregister(struct device *dev)
-{
-	device_remove_file(dev, &dev_attr_rtc_calibration);
-}
+static const struct attribute_group ab8500_rtc_sysfs_files = {
+	.attrs	= ab8500_rtc_attrs,
+};
 
 static irqreturn_t rtc_alarm_handler(int irq, void *data)
 {
@@ -429,14 +428,11 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, true);
 
-	rtc = devm_rtc_device_register(&pdev->dev, "ab8500-rtc",
-				(struct rtc_class_ops *)platid->driver_data,
-				THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		dev_err(&pdev->dev, "Registration failed\n");
-		err = PTR_ERR(rtc);
-		return err;
-	}
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	rtc->ops = (struct rtc_class_ops *)platid->driver_data;
 
 	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 			rtc_alarm_handler, IRQF_ONESHOT,
@@ -447,22 +443,19 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	dev_pm_set_wake_irq(&pdev->dev, irq);
 	platform_set_drvdata(pdev, rtc);
 
-	err = ab8500_sysfs_rtc_register(&pdev->dev);
-	if (err) {
-		dev_err(&pdev->dev, "sysfs RTC failed to register\n");
-		return err;
-	}
-
 	rtc->uie_unsupported = 1;
 
-	return 0;
+	err = rtc_add_group(rtc, &ab8500_rtc_sysfs_files);
+	if (err)
+		return err;
+
+	return rtc_register_device(rtc);
 }
 
 static int ab8500_rtc_remove(struct platform_device *pdev)
 {
 	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
-	ab8500_sysfs_rtc_unregister(&pdev->dev);
 
 	return 0;
 }
-- 
2.19.0

