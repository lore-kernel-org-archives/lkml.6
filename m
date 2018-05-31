Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeEaVKI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:10:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34462 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeEaVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:10:02 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/5] rtc: test: store time as an offset to system time
Date: Thu, 31 May 2018 23:09:57 +0200
Message-Id: <20180531210959.2472-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
References: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the time as an offset to system time. As the offset is in second, it
is currently always synced with system time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 796c45dee661..041150e53fd7 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -15,6 +15,11 @@
 
 #define MAX_RTC_TEST 3
 
+struct rtc_test_data {
+	struct rtc_device *rtc;
+	time64_t offset;
+};
+
 struct platform_device *pdev[MAX_RTC_TEST];
 
 static int test_rtc_read_alarm(struct device *dev,
@@ -29,16 +34,21 @@ static int test_rtc_set_alarm(struct device *dev,
 	return 0;
 }
 
-static int test_rtc_read_time(struct device *dev,
-	struct rtc_time *tm)
+static int test_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time64_to_tm(ktime_get_real_seconds(), tm);
+	struct rtc_test_data *rtd = dev_get_drvdata(dev);
+
+	rtc_time64_to_tm(ktime_get_real_seconds() + rtd->offset, tm);
+
 	return 0;
 }
 
 static int test_rtc_set_mmss64(struct device *dev, time64_t secs)
 {
-	dev_info(dev, "%s, secs = %lld\n", __func__, (long long)secs);
+	struct rtc_test_data *rtd = dev_get_drvdata(dev);
+
+	rtd->offset = secs - ktime_get_real_seconds();
+
 	return 0;
 }
 
@@ -88,21 +98,18 @@ static DEVICE_ATTR(irq, S_IRUGO | S_IWUSR, test_irq_show, test_irq_store);
 
 static int test_probe(struct platform_device *plat_dev)
 {
-	int err;
-	struct rtc_device *rtc;
+	struct rtc_test_data *rtd;
 
-	rtc = devm_rtc_device_register(&plat_dev->dev, "test",
-				&test_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
-		return PTR_ERR(rtc);
-	}
+	rtd = devm_kzalloc(&plat_dev->dev, sizeof(*rtd), GFP_KERNEL);
+	if (!rtd)
+		return -ENOMEM;
 
-	err = device_create_file(&plat_dev->dev, &dev_attr_irq);
-	if (err)
-		dev_err(&plat_dev->dev, "Unable to create sysfs entry: %s\n",
-			dev_attr_irq.attr.name);
+	platform_set_drvdata(plat_dev, rtd);
 
-	platform_set_drvdata(plat_dev, rtc);
+	rtd->rtc = devm_rtc_device_register(&plat_dev->dev, "test",
+					    &test_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtd->rtc))
+		return PTR_ERR(rtd->rtc);
 
 	return 0;
 }
-- 
2.17.0
