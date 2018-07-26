Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD36EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BB820685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BB820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbeGZO61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59315 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZO61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3752B20943; Thu, 26 Jul 2018 15:41:29 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D2A4209C2;
        Thu, 26 Jul 2018 15:41:03 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 8/8] rtc: remove struct rtc_task
Date:   Thu, 26 Jul 2018 15:40:56 +0200
Message-Id: <20180726134056.18273-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include rtc_task members directly in rtc_timer member.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 8 ++++----
 include/linux/rtc.h     | 9 ++-------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index d0983ed6c842..a962540faf2e 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -912,8 +912,8 @@ void rtc_timer_do_work(struct work_struct *work)
 		timerqueue_del(&rtc->timerqueue, &timer->node);
 		trace_rtc_timer_dequeue(timer);
 		timer->enabled = 0;
-		if (timer->task.func)
-			timer->task.func(timer->task.private_data);
+		if (timer->func)
+			timer->func(timer->private_data);
 
 		trace_rtc_timer_fired(timer);
 		/* Re-add/fwd periodic timers */
@@ -968,8 +968,8 @@ void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data)
 {
 	timerqueue_init(&timer->node);
 	timer->enabled = 0;
-	timer->task.func = f;
-	timer->task.private_data = data;
+	timer->func = f;
+	timer->private_data = data;
 }
 
 /* rtc_timer_start - Sets an rtc_timer to fire in the future
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index bf4d375025d1..6aedc30003e7 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -87,16 +87,11 @@ struct rtc_class_ops {
 	int (*set_offset)(struct device *, long offset);
 };
 
-typedef struct rtc_task {
-	void (*func)(void *private_data);
-	void *private_data;
-} rtc_task_t;
-
-
 struct rtc_timer {
-	struct rtc_task	task;
 	struct timerqueue_node node;
 	ktime_t period;
+	void (*func)(void *private_data);
+	void *private_data;
 	int enabled;
 };
 
-- 
2.18.0

