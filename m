Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeFEVR4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:17:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752034AbeFEVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:17:54 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: test: remove alarm support from the first device
Date: Tue,  5 Jun 2018 23:09:13 +0200
Message-Id: <20180605210914.8054-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605210914.8054-1-alexandre.belloni@bootlin.com>
References: <20180605210914.8054-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To test for issues with RTCs that don't provide an alarm, remove alarm
support from the first test RTC device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 6a6bc1f2a14d..9b7ef6f63251 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -95,6 +95,12 @@ static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	return 0;
 }
 
+static const struct rtc_class_ops test_rtc_ops_noalm = {
+	.read_time = test_rtc_read_time,
+	.set_mmss64 = test_rtc_set_mmss64,
+	.alarm_irq_enable = test_rtc_alarm_irq_enable,
+};
+
 static const struct rtc_class_ops test_rtc_ops = {
 	.read_time = test_rtc_read_time,
 	.read_alarm = test_rtc_read_alarm,
@@ -124,7 +130,13 @@ static int test_probe(struct platform_device *plat_dev)
 	if (IS_ERR(rtd->rtc))
 		return PTR_ERR(rtd->rtc);
 
-	rtd->rtc->ops = &test_rtc_ops;
+	switch (plat_dev->id) {
+	case 0:
+		rtd->rtc->ops = &test_rtc_ops_noalm;
+		break;
+	default:
+		rtd->rtc->ops = &test_rtc_ops;
+	}
 
 	timer_setup(&rtd->alarm, test_rtc_alarm_handler, 0);
 	rtd->alarm.expires = 0;
-- 
2.17.1
