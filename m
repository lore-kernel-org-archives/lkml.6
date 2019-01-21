Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3333C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8A52084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfAUNx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:53:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbfAUNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LDr8LQ2542966
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 05:53:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LDr88Y2542963;
        Mon, 21 Jan 2019 05:53:08 -0800
Date:   Mon, 21 Jan 2019 05:53:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-3cd126af79ed5a4d6b06eba63d3349e143a3bd3b@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tom.putzeys@be.atlascopco.com, linux-kernel@vger.kernel.org,
        efault@gmx.de, hpa@zytor.com, mingo@kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          tom.putzeys@be.atlascopco.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, efault@gmx.de,
          bigeasy@linutronix.de, tglx@linutronix.de
In-Reply-To: <20190107125231.GE14122@hirez.programming.kicks-ass.net>
References: <20190107125231.GE14122@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Robustify CFS-bandwidth timer locking
Git-Commit-ID: 3cd126af79ed5a4d6b06eba63d3349e143a3bd3b
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

Commit-ID:  3cd126af79ed5a4d6b06eba63d3349e143a3bd3b
Gitweb:     https://git.kernel.org/tip/3cd126af79ed5a4d6b06eba63d3349e143a3bd3b
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 7 Jan 2019 13:52:31 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 14:40:28 +0100

sched/fair: Robustify CFS-bandwidth timer locking

Traditionally hrtimer callbacks were run with IRQs disabled, but with
the introduction of HRTIMER_MODE_SOFT it is possible they run from
SoftIRQ context, which does _NOT_ have IRQs disabled.

Allow for the CFS bandwidth timers (period_timer and slack_timer) to
be ran from SoftIRQ context; this entails removing the assumption that
IRQs are already disabled from the locking.

While mainline doesn't strictly need this, -RT forces all timers not
explicitly marked with MODE_HARD into MODE_SOFT and trips over this.
And marking these timers as MODE_HARD doesn't make sense as they're
not required for RT operation and can potentially be quite expensive.

Reported-by: Tom Putzeys <tom.putzeys@be.atlascopco.com>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190107125231.GE14122@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b1374fbddd0d..3b61e19b504a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4565,7 +4565,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		struct rq *rq = rq_of(cfs_rq);
 		struct rq_flags rf;
 
-		rq_lock(rq, &rf);
+		rq_lock_irqsave(rq, &rf);
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
@@ -4582,7 +4582,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 			unthrottle_cfs_rq(cfs_rq);
 
 next:
-		rq_unlock(rq, &rf);
+		rq_unlock_irqrestore(rq, &rf);
 
 		if (!remaining)
 			break;
@@ -4598,7 +4598,7 @@ next:
  * period the timer is deactivated until scheduling resumes; cfs_b->idle is
  * used to track this state.
  */
-static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
+static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
 	u64 runtime, runtime_expires;
 	int throttled;
@@ -4640,11 +4640,11 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
 		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
 						 runtime_expires);
-		raw_spin_lock(&cfs_b->lock);
+		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -4753,17 +4753,18 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	unsigned long flags;
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (cfs_b->distribute_running) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
@@ -4774,18 +4775,18 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
 		return;
 
 	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (expires == cfs_b->runtime_expires)
 		lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -4863,20 +4864,21 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	unsigned long flags;
 	int overrun;
 	int idle = 0;
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
-		idle = do_sched_cfs_period_timer(cfs_b, overrun);
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
