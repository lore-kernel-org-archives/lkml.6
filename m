Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B25B208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B25B208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbeHAO4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:56:05 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:17418 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389266AbeHAO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:56:04 -0400
X-IronPort-AV: E=Sophos;i="5.51,432,1526322600"; 
   d="scan'208";a="119713"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 01 Aug 2018 18:40:20 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8971"; a="713655"
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg03-blr.qualcomm.com with ESMTP; 01 Aug 2018 18:40:19 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id 2F02B30CD; Wed,  1 Aug 2018 18:40:18 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH v1] timers: Clear must_forward_clk inside base lock
Date:   Wed,  1 Aug 2018 18:40:16 +0530
Message-Id: <1533129016-28050-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer wheel base->must_forward_clock is indicating that
the base clock might be stale due to a long idle sleep.
The forwarding of base clock takes place in softirq of timer
or when a timer is enqueued to base which is idle. While migrate
timer from remote CPU to the new base which is idle, then
following race can happen:

  CPU0                                  CPU1
  run_timer_softirq                     timers_dead_cpu

					base = lock_timer_base(timer);
  base->must_forward_clk = false
					if (base->must_forward_clk)
				         forward(base); >>skip

					migrate_timer_list
					enqueue_timer(base, timer, idx);
					>> idx is calculated high due to
					>> stale base
					unlock_timer_base(timer);
  base = lock_timer_base(timer);
  forward(base);

The root cause is that base->must_forward_clk is cleared outside the
base->lock held region, so the remote queuing CPU observes it as
cleared, but the base clock is still stale. This can cause large
granularity values for timers, i.e. the accuracy of the expiry time
suffers.

Prevent this by clearing the flag with base->lock held, so that the
forwarding takes place before the cleared flag is observable by a remote
CPU.
Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
---
Changes since v0:
 - Updated commit text and comment suggested by Thomas.
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cc2d23e..70aa1c6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1657,6 +1657,17 @@ static inline void __run_timers(struct timer_base *base)
 
 	raw_spin_lock_irq(&base->lock);
 
+	/*
+	 * The must_forward_clk flag is cleared unconditionally also for
+	 * the deferrable base. The deferrable base is not affected by idle
+	 * tracking and never forwarded, so clearing the flag is a NOOP.
+	 *
+	 * The fact that the deferrable base is never forwarded can cause
+	 * large variations in granularity for deferrable timers, but they
+	 * can be deferred for long periods due to idle anyway.
+	 */
+	base->must_forward_clk = false;
+
 	while (time_after_eq(jiffies, base->clk)) {
 
 		levels = collect_expired_timers(base, heads);
@@ -1676,19 +1687,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
-	/*
-	 * must_forward_clk must be cleared before running timers so that any
-	 * timer functions that call mod_timer will not try to forward the
-	 * base. idle trcking / clock forwarding logic is only used with
-	 * BASE_STD timers.
-	 *
-	 * The deferrable base does not do idle tracking at all, so we do
-	 * not forward it. This can result in very large variations in
-	 * granularity for deferrable timers, but they can be deferred for
-	 * long periods due to idle.
-	 */
-	base->must_forward_clk = false;
-
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
-- 
1.9.1

