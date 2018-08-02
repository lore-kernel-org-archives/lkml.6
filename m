Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1779DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C86214DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C86214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeHBMsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:48:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbeHBMsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:48:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72AvqSQ3474198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 03:57:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72Avqhb3474195;
        Thu, 2 Aug 2018 03:57:52 -0700
Date:   Thu, 2 Aug 2018 03:57:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gaurav Kohli <tipbot@zytor.com>
Message-ID: <tip-363e934d8811d799c88faffc5bfca782fd728334@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        gkohli@codeaurora.org, hpa@zytor.com
Reply-To: gkohli@codeaurora.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1533199863-22748-1-git-send-email-gkohli@codeaurora.org>
References: <1533199863-22748-1-git-send-email-gkohli@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timers: Clear timer_base::must_forward_clk with
 timer_base::lock held
Git-Commit-ID: 363e934d8811d799c88faffc5bfca782fd728334
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  363e934d8811d799c88faffc5bfca782fd728334
Gitweb:     https://git.kernel.org/tip/363e934d8811d799c88faffc5bfca782fd728334
Author:     Gaurav Kohli <gkohli@codeaurora.org>
AuthorDate: Thu, 2 Aug 2018 14:21:03 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 12:52:38 +0200

timers: Clear timer_base::must_forward_clk with timer_base::lock held

timer_base::must_forward_clock is indicating that the base clock might be
stale due to a long idle sleep.

The forwarding of the base clock takes place in the timer softirq or when a
timer is enqueued to a base which is idle. If the enqueue of timer to an
idle base happens from a remote CPU, then the following race can happen:

  CPU0					CPU1
  run_timer_softirq			mod_timer

					base = lock_timer_base(timer);
  base->must_forward_clk = false
					if (base->must_forward_clk)
				       	    forward(base); -> skipped

					enqueue_timer(base, timer, idx);
					-> idx is calculated high due to
					   stale base
					unlock_timer_base(timer);
  base = lock_timer_base(timer);
  forward(base);

The root cause is that timer_base::must_forward_clk is cleared outside the
timer_base::lock held region, so the remote queuing CPU observes it as
cleared, but the base clock is still stale. This can cause large
granularity values for timers, i.e. the accuracy of the expiry time
suffers.

Prevent this by clearing the flag with timer_base::lock held, so that the
forwarding takes place before the cleared flag is observable by a remote
CPU.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: john.stultz@linaro.org
Cc: sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org
Link: https://lkml.kernel.org/r/1533199863-22748-1-git-send-email-gkohli@codeaurora.org
---
 kernel/time/timer.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index baa528a24a73..fa49cd753dea 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1657,6 +1657,22 @@ static inline void __run_timers(struct timer_base *base)
 
 	raw_spin_lock_irq(&base->lock);
 
+	/*
+	 * timer_base::must_forward_clk must be cleared before running
+	 * timers so that any timer functions that call mod_timer() will
+	 * not try to forward the base. Idle tracking / clock forwarding
+	 * logic is only used with BASE_STD timers.
+	 *
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
@@ -1676,19 +1692,6 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
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
