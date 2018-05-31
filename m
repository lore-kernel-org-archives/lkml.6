Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeEaVKK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:10:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34464 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeEaVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:10:02 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/5] rtc: test: emulate alarms using timers
Date: Thu, 31 May 2018 23:09:58 +0200
Message-Id: <20180531210959.2472-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
References: <20180531210959.2472-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use timers to emulate alarms. Note that multiple alarms may happen if they
are set more than 15 days after the current RTC time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 56 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 041150e53fd7..975f6cdda73f 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -18,19 +18,49 @@
 struct rtc_test_data {
 	struct rtc_device *rtc;
 	time64_t offset;
+	struct timer_list alarm;
+	bool alarm_en;
 };
 
 struct platform_device *pdev[MAX_RTC_TEST];
 
-static int test_rtc_read_alarm(struct device *dev,
-	struct rtc_wkalrm *alrm)
+static int test_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct rtc_test_data *rtd = dev_get_drvdata(dev);
+	time64_t alarm;
+
+	alarm = (rtd->alarm.expires - jiffies) / HZ;
+	alarm += ktime_get_real_seconds() + rtd->offset;
+
+	rtc_time64_to_tm(alarm, &alrm->time);
+	alrm->enabled = rtd->alarm_en;
+
 	return 0;
 }
 
-static int test_rtc_set_alarm(struct device *dev,
-	struct rtc_wkalrm *alrm)
+static int test_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	struct rtc_test_data *rtd = dev_get_drvdata(dev);
+	ktime_t timeout;
+	u64 expires;
+
+	timeout = rtc_tm_to_time64(&alrm->time) - ktime_get_real_seconds();
+	timeout -= rtd->offset;
+
+	del_timer(&rtd->alarm);
+
+	expires = jiffies + timeout * HZ;
+	if (expires > U32_MAX)
+		expires = U32_MAX;
+
+	pr_err("ABE: %s +%d %s\n", __FILE__, __LINE__, __func__);
+	rtd->alarm.expires = expires;
+
+	if (alrm->enabled)
+		add_timer(&rtd->alarm);
+
+	rtd->alarm_en = alrm->enabled;
+
 	return 0;
 }
 
@@ -54,6 +84,14 @@ static int test_rtc_set_mmss64(struct device *dev, time64_t secs)
 
 static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
+	struct rtc_test_data *rtd = dev_get_drvdata(dev);
+
+	rtd->alarm_en = enable;
+	if (enable)
+		add_timer(&rtd->alarm);
+	else
+		del_timer(&rtd->alarm);
+
 	return 0;
 }
 
@@ -65,6 +103,13 @@ static const struct rtc_class_ops test_rtc_ops = {
 	.alarm_irq_enable = test_rtc_alarm_irq_enable,
 };
 
+static void test_rtc_alarm_handler(struct timer_list *t)
+{
+	struct rtc_test_data *rtd = from_timer(rtd, t, alarm);
+
+	rtc_update_irq(rtd->rtc, 1, RTC_AF | RTC_IRQF);
+}
+
 static ssize_t test_irq_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -111,6 +156,9 @@ static int test_probe(struct platform_device *plat_dev)
 	if (IS_ERR(rtd->rtc))
 		return PTR_ERR(rtd->rtc);
 
+	timer_setup(&rtd->alarm, test_rtc_alarm_handler, 0);
+	rtd->alarm.expires = 0;
+
 	return 0;
 }
 
-- 
2.17.0
