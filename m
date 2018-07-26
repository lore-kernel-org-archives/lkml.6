Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2BB20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2BB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbeGZO6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:58:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59309 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:58:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6D7E720935; Thu, 26 Jul 2018 15:41:26 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E5EA209C1;
        Thu, 26 Jul 2018 15:41:02 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/8] char: rtc: remove task handling
Date:   Thu, 26 Jul 2018 15:40:55 +0200
Message-Id: <20180726134056.18273-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9e7002a70e42 ("char: rtc: remove unused rtc_control() API"),
it is not possible to set a callback anymore, remove its handling from the
interrupt handler.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Hi,

My plan is to take that patch through the RTC tree because the next patch relies
on the rtc_task_t *rtc_callback removal.

 drivers/char/rtc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 94fedeeec035..4948c8bda6b1 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -193,14 +193,6 @@ static unsigned long rtc_freq;		/* Current periodic IRQ rate	*/
 static unsigned long rtc_irq_data;	/* our output to the world	*/
 static unsigned long rtc_max_user_freq = 64; /* > this, need CAP_SYS_RESOURCE */
 
-#ifdef RTC_IRQ
-/*
- * rtc_task_lock nests inside rtc_lock.
- */
-static DEFINE_SPINLOCK(rtc_task_lock);
-static rtc_task_t *rtc_callback;
-#endif
-
 /*
  *	If this driver ever becomes modularised, it will be really nice
  *	to make the epoch retain its value across module reload...
@@ -264,11 +256,6 @@ static irqreturn_t rtc_interrupt(int irq, void *dev_id)
 
 	spin_unlock(&rtc_lock);
 
-	/* Now do the rest of the actions */
-	spin_lock(&rtc_task_lock);
-	if (rtc_callback)
-		rtc_callback->func(rtc_callback->private_data);
-	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);
 
 	kill_fasync(&rtc_async_queue, SIGIO, POLL_IN);
-- 
2.18.0

