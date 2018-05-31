Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeEaVLC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:11:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34466 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeEaVKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:10:03 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] rtc: test: remove irq sysfs file
Date: Thu, 31 May 2018 23:09:59 +0200
Message-Id: <20180531210959.2472-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
References: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that alarms are emulated, remove the irq sysfs file that could be used
to send alarms.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 975f6cdda73f..fbcec4a2e3c9 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -110,37 +110,6 @@ static void test_rtc_alarm_handler(struct timer_list *t)
 	rtc_update_irq(rtd->rtc, 1, RTC_AF | RTC_IRQF);
 }
 
-static ssize_t test_irq_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n", 42);
-}
-static ssize_t test_irq_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	int retval;
-	struct rtc_device *rtc = dev_get_drvdata(dev);
-
-	retval = count;
-	if (strncmp(buf, "tick", 4) == 0 && rtc->pie_enabled)
-		rtc_update_irq(rtc, 1, RTC_PF | RTC_IRQF);
-	else if (strncmp(buf, "alarm", 5) == 0) {
-		struct rtc_wkalrm alrm;
-		int err = rtc_read_alarm(rtc, &alrm);
-
-		if (!err && alrm.enabled)
-			rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
-
-	} else if (strncmp(buf, "update", 6) == 0 && rtc->uie_rtctimer.enabled)
-		rtc_update_irq(rtc, 1, RTC_UF | RTC_IRQF);
-	else
-		retval = -EINVAL;
-
-	return retval;
-}
-static DEVICE_ATTR(irq, S_IRUGO | S_IWUSR, test_irq_show, test_irq_store);
-
 static int test_probe(struct platform_device *plat_dev)
 {
 	struct rtc_test_data *rtd;
@@ -162,16 +131,8 @@ static int test_probe(struct platform_device *plat_dev)
 	return 0;
 }
 
-static int test_remove(struct platform_device *plat_dev)
-{
-	device_remove_file(&plat_dev->dev, &dev_attr_irq);
-
-	return 0;
-}
-
 static struct platform_driver test_driver = {
 	.probe	= test_probe,
-	.remove = test_remove,
 	.driver = {
 		.name = "rtc-test",
 	},
-- 
2.17.0
