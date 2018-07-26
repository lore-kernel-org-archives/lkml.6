Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B392820685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B392820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeGZO6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59285 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730441AbeGZO6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5007420908; Thu, 26 Jul 2018 15:41:21 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id BE50A209B7;
        Thu, 26 Jul 2018 15:41:00 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/8] rtc: remove rtc_irq_register/rtc_irq_unregister
Date:   Thu, 26 Jul 2018 15:40:51 +0200
Message-Id: <20180726134056.18273-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc_irq_* interface is not used from outside the RTC subsytem since
2016.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 33 ---------------------------------
 include/linux/rtc.h     |  4 ----
 2 files changed, 37 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6d4012dd6922..2b1b9a0b9f8a 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -719,39 +719,6 @@ void rtc_class_close(struct rtc_device *rtc)
 }
 EXPORT_SYMBOL_GPL(rtc_class_close);
 
-int rtc_irq_register(struct rtc_device *rtc, struct rtc_task *task)
-{
-	int retval = -EBUSY;
-
-	if (task == NULL || task->func == NULL)
-		return -EINVAL;
-
-	/* Cannot register while the char dev is in use */
-	if (test_and_set_bit_lock(RTC_DEV_BUSY, &rtc->flags))
-		return -EBUSY;
-
-	spin_lock_irq(&rtc->irq_task_lock);
-	if (rtc->irq_task == NULL) {
-		rtc->irq_task = task;
-		retval = 0;
-	}
-	spin_unlock_irq(&rtc->irq_task_lock);
-
-	clear_bit_unlock(RTC_DEV_BUSY, &rtc->flags);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(rtc_irq_register);
-
-void rtc_irq_unregister(struct rtc_device *rtc, struct rtc_task *task)
-{
-	spin_lock_irq(&rtc->irq_task_lock);
-	if (rtc->irq_task == task)
-		rtc->irq_task = NULL;
-	spin_unlock_irq(&rtc->irq_task_lock);
-}
-EXPORT_SYMBOL_GPL(rtc_irq_unregister);
-
 static int rtc_update_hrtimer(struct rtc_device *rtc, int enabled)
 {
 	/*
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 6268208760e9..f868d6b619ab 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -204,10 +204,6 @@ extern void rtc_update_irq(struct rtc_device *rtc,
 extern struct rtc_device *rtc_class_open(const char *name);
 extern void rtc_class_close(struct rtc_device *rtc);
 
-extern int rtc_irq_register(struct rtc_device *rtc,
-				struct rtc_task *task);
-extern void rtc_irq_unregister(struct rtc_device *rtc,
-				struct rtc_task *task);
 extern int rtc_irq_set_state(struct rtc_device *rtc,
 				struct rtc_task *task, int enabled);
 extern int rtc_irq_set_freq(struct rtc_device *rtc,
-- 
2.18.0

