Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030984AbeEZCEb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 22:04:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33472 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030648AbeEZCEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 22:04:30 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: test: remove obsolete .set_mmss
Date: Sat, 26 May 2018 04:04:26 +0200
Message-Id: <20180526020426.2984-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in testing .set_mmss versus .set_mmss64 as there are both
taking the exact same argument (truncated for set_mmss though).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 390f928fd6fc..a0d1571c4af6 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -13,10 +13,6 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-static int test_mmss64;
-module_param(test_mmss64, int, 0644);
-MODULE_PARM_DESC(test_mmss64, "Test struct rtc_class_ops.set_mmss64().");
-
 static struct platform_device *test0 = NULL, *test1 = NULL;
 
 static int test_rtc_read_alarm(struct device *dev,
@@ -44,12 +40,6 @@ static int test_rtc_set_mmss64(struct device *dev, time64_t secs)
 	return 0;
 }
 
-static int test_rtc_set_mmss(struct device *dev, unsigned long secs)
-{
-	dev_info(dev, "%s, secs = %lu\n", __func__, secs);
-	return 0;
-}
-
 static int test_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	struct platform_device *plat_dev = to_platform_device(dev);
@@ -65,12 +55,12 @@ static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	return 0;
 }
 
-static struct rtc_class_ops test_rtc_ops = {
+static const struct rtc_class_ops test_rtc_ops = {
 	.proc = test_rtc_proc,
 	.read_time = test_rtc_read_time,
 	.read_alarm = test_rtc_read_alarm,
 	.set_alarm = test_rtc_set_alarm,
-	.set_mmss = test_rtc_set_mmss,
+	.set_mmss64 = test_rtc_set_mmss64,
 	.alarm_irq_enable = test_rtc_alarm_irq_enable,
 };
 
@@ -110,11 +100,6 @@ static int test_probe(struct platform_device *plat_dev)
 	int err;
 	struct rtc_device *rtc;
 
-	if (test_mmss64) {
-		test_rtc_ops.set_mmss64 = test_rtc_set_mmss64;
-		test_rtc_ops.set_mmss = NULL;
-	}
-
 	rtc = devm_rtc_device_register(&plat_dev->dev, "test",
 				&test_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
-- 
2.17.0
