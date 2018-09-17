Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A67B2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A67B2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeIREXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:23:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeIREXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:23:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6880ACA0;
        Mon, 17 Sep 2018 22:53:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>, john.stultz@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 26/70] timers: Clear timer_base::must_forward_clk with timer_base::lock held
Date:   Tue, 18 Sep 2018 00:41:59 +0200
Message-Id: <20180917211651.297987268@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Kohli <gkohli@codeaurora.org>

[ Upstream commit 363e934d8811d799c88faffc5bfca782fd728334 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timer.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1649,6 +1649,22 @@ static inline void __run_timers(struct t
 
 	spin_lock_irq(&base->lock);
 
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
@@ -1668,19 +1684,6 @@ static __latent_entropy void run_timer_s
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


