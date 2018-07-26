Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6996BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C2B20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C2B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeGZO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59288 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbeGZO6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C201720893; Thu, 26 Jul 2018 15:41:22 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3B776209BC;
        Thu, 26 Jul 2018 15:41:01 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/8] rtc: remove irq_task and irq_task_lock
Date:   Thu, 26 Jul 2018 15:40:52 +0200
Message-Id: <20180726134056.18273-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to set a periodic task anymore, remove task pointer and
lock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c     |  1 -
 drivers/rtc/interface.c | 50 +++++++++--------------------------------
 include/linux/rtc.h     |  2 --
 3 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 7fa32c922617..0fca4d74c76b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -172,7 +172,6 @@ static struct rtc_device *rtc_allocate_device(void)
 
 	mutex_init(&rtc->ops_lock);
 	spin_lock_init(&rtc->irq_lock);
-	spin_lock_init(&rtc->irq_task_lock);
 	init_waitqueue_head(&rtc->irq_queue);
 
 	/* Init timerqueue */
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 2b1b9a0b9f8a..ae0d67610c7b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -605,12 +605,6 @@ void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode)
 	rtc->irq_data = (rtc->irq_data + (num << 8)) | (RTC_IRQF|mode);
 	spin_unlock_irqrestore(&rtc->irq_lock, flags);
 
-	/* call the task func */
-	spin_lock_irqsave(&rtc->irq_task_lock, flags);
-	if (rtc->irq_task)
-		rtc->irq_task->func(rtc->irq_task->private_data);
-	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
-
 	wake_up_interruptible(&rtc->irq_queue);
 	kill_fasync(&rtc->async_queue, SIGIO, POLL_IN);
 }
@@ -750,28 +744,16 @@ static int rtc_update_hrtimer(struct rtc_device *rtc, int enabled)
  * Context: any
  *
  * Note that rtc_irq_set_freq() should previously have been used to
- * specify the desired frequency of periodic IRQ task->func() callbacks.
+ * specify the desired frequency of periodic IRQ.
  */
 int rtc_irq_set_state(struct rtc_device *rtc, struct rtc_task *task, int enabled)
 {
 	int err = 0;
-	unsigned long flags;
 
-retry:
-	spin_lock_irqsave(&rtc->irq_task_lock, flags);
-	if (rtc->irq_task != NULL && task == NULL)
-		err = -EBUSY;
-	else if (rtc->irq_task != task)
-		err = -EACCES;
-	else {
-		if (rtc_update_hrtimer(rtc, enabled) < 0) {
-			spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
-			cpu_relax();
-			goto retry;
-		}
-		rtc->pie_enabled = enabled;
-	}
-	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+	while (rtc_update_hrtimer(rtc, enabled) < 0)
+		cpu_relax();
+
+	rtc->pie_enabled = enabled;
 
 	trace_rtc_irq_set_state(enabled, err);
 	return err;
@@ -782,7 +764,7 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_state);
  * rtc_irq_set_freq - set 2^N Hz periodic IRQ frequency for IRQ
  * @rtc: the rtc device
  * @task: currently registered with rtc_irq_register()
- * @freq: positive frequency with which task->func() will be called
+ * @freq: positive frequency
  * Context: any
  *
  * Note that rtc_irq_set_state() is used to enable or disable the
@@ -791,25 +773,13 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_state);
 int rtc_irq_set_freq(struct rtc_device *rtc, struct rtc_task *task, int freq)
 {
 	int err = 0;
-	unsigned long flags;
 
 	if (freq <= 0 || freq > RTC_MAX_FREQ)
 		return -EINVAL;
-retry:
-	spin_lock_irqsave(&rtc->irq_task_lock, flags);
-	if (rtc->irq_task != NULL && task == NULL)
-		err = -EBUSY;
-	else if (rtc->irq_task != task)
-		err = -EACCES;
-	else {
-		rtc->irq_freq = freq;
-		if (rtc->pie_enabled && rtc_update_hrtimer(rtc, 1) < 0) {
-			spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
-			cpu_relax();
-			goto retry;
-		}
-	}
-	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	rtc->irq_freq = freq;
+	while (rtc->pie_enabled && rtc_update_hrtimer(rtc, 1) < 0)
+		cpu_relax();
 
 	trace_rtc_irq_set_freq(freq, err);
 	return err;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index f868d6b619ab..8cc23fdfd4ee 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -121,8 +121,6 @@ struct rtc_device {
 	wait_queue_head_t irq_queue;
 	struct fasync_struct *async_queue;
 
-	struct rtc_task *irq_task;
-	spinlock_t irq_task_lock;
 	int irq_freq;
 	int max_user_freq;
 
-- 
2.18.0

