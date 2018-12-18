Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1CCC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8700A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeLRVLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:11:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43264 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeLRVLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:11:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE46F20824; Tue, 18 Dec 2018 22:11:41 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8F605207BE;
        Tue, 18 Dec 2018 22:11:31 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] rtc: enforce rtc_timer_init private_data type
Date:   Tue, 18 Dec 2018 22:11:26 +0100
Message-Id: <20181218211126.12613-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the remaining users of rtc_timers are passing the rtc_device as private
data. Enforce that and rename private_data to rtc.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c     |  4 ++--
 drivers/rtc/interface.c | 19 +++++++++----------
 include/linux/rtc.h     | 14 ++++++++------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 6d364085bd86..8d9b65d54f4f 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -178,9 +178,9 @@ static struct rtc_device *rtc_allocate_device(void)
 	timerqueue_init_head(&rtc->timerqueue);
 	INIT_WORK(&rtc->irqwork, rtc_timer_do_work);
 	/* Init aie timer */
-	rtc_timer_init(&rtc->aie_timer, rtc_aie_update_irq, (void *)rtc);
+	rtc_timer_init(&rtc->aie_timer, rtc_aie_update_irq, rtc);
 	/* Init uie timer */
-	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, (void *)rtc);
+	rtc_timer_init(&rtc->uie_rtctimer, rtc_uie_update_irq, rtc);
 	/* Init pie timer */
 	hrtimer_init(&rtc->pie_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	rtc->pie_timer.function = rtc_pie_update_irq;
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index e8d77b1eaeb2..98d9c87b0d1b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -609,26 +609,24 @@ void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode)
 
 /**
  * rtc_aie_update_irq - AIE mode rtctimer hook
- * @private: pointer to the rtc_device
+ * @rtc: pointer to the rtc_device
  *
  * This functions is called when the aie_timer expires.
  */
-void rtc_aie_update_irq(void *private)
+void rtc_aie_update_irq(struct rtc_device *rtc)
 {
-	struct rtc_device *rtc = (struct rtc_device *)private;
 	rtc_handle_legacy_irq(rtc, 1, RTC_AF);
 }
 
 
 /**
  * rtc_uie_update_irq - UIE mode rtctimer hook
- * @private: pointer to the rtc_device
+ * @rtc: pointer to the rtc_device
  *
  * This functions is called when the uie_timer expires.
  */
-void rtc_uie_update_irq(void *private)
+void rtc_uie_update_irq(struct rtc_device *rtc)
 {
-	struct rtc_device *rtc = (struct rtc_device *)private;
 	rtc_handle_legacy_irq(rtc, 1,  RTC_UF);
 }
 
@@ -908,7 +906,7 @@ void rtc_timer_do_work(struct work_struct *work)
 		trace_rtc_timer_dequeue(timer);
 		timer->enabled = 0;
 		if (timer->func)
-			timer->func(timer->private_data);
+			timer->func(timer->rtc);
 
 		trace_rtc_timer_fired(timer);
 		/* Re-add/fwd periodic timers */
@@ -955,16 +953,17 @@ void rtc_timer_do_work(struct work_struct *work)
 /* rtc_timer_init - Initializes an rtc_timer
  * @timer: timer to be intiialized
  * @f: function pointer to be called when timer fires
- * @data: private data passed to function pointer
+ * @rtc: pointer to the rtc_device
  *
  * Kernel interface to initializing an rtc_timer.
  */
-void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data)
+void rtc_timer_init(struct rtc_timer *timer, void (*f)(struct rtc_device *r),
+		    struct rtc_device *rtc)
 {
 	timerqueue_init(&timer->node);
 	timer->enabled = 0;
 	timer->func = f;
-	timer->private_data = data;
+	timer->rtc = rtc;
 }
 
 /* rtc_timer_start - Sets an rtc_timer to fire in the future
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 58147b057acd..c1089fe5344a 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -87,15 +87,16 @@ struct rtc_class_ops {
 	int (*set_offset)(struct device *, long offset);
 };
 
+struct rtc_device;
+
 struct rtc_timer {
 	struct timerqueue_node node;
 	ktime_t period;
-	void (*func)(void *private_data);
-	void *private_data;
+	void (*func)(struct rtc_device *rtc);
+	struct rtc_device *rtc;
 	int enabled;
 };
 
-
 /* flags */
 #define RTC_DEV_BUSY 0
 
@@ -197,11 +198,12 @@ extern int rtc_dev_update_irq_enable_emul(struct rtc_device *rtc,
 						unsigned int enabled);
 
 void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode);
-void rtc_aie_update_irq(void *private);
-void rtc_uie_update_irq(void *private);
+void rtc_aie_update_irq(struct rtc_device *rtc);
+void rtc_uie_update_irq(struct rtc_device *rtc);
 enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer);
 
-void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data);
+void rtc_timer_init(struct rtc_timer *timer, void (*f)(struct rtc_device *r),
+		    struct rtc_device *rtc);
 int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
 		    ktime_t expires, ktime_t period);
 void rtc_timer_cancel(struct rtc_device *rtc, struct rtc_timer *timer);
-- 
2.20.0

