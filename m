Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B08C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3420825561
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3420825561
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965209AbeGBJiA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:38:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeGBJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:37:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w629bTh94024376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 02:37:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w629bT4p4024373;
        Mon, 2 Jul 2018 02:37:29 -0700
Date:   Mon, 2 Jul 2018 02:37:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-78c9c4dfbf8c04883941445a195276bb4bb92c76@git.kernel.org>
Cc:     mtk.manpages@gmail.com, john.stultz@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, icytxw@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
Reply-To: john.stultz@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mtk.manpages@gmail.com,
          mingo@kernel.org, peterz@infradead.org, icytxw@gmail.com,
          tglx@linutronix.de
In-Reply-To: <20180626132705.018623573@linutronix.de>
References: <20180626132705.018623573@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Sanitize overrun handling
Git-Commit-ID: 78c9c4dfbf8c04883941445a195276bb4bb92c76
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

Commit-ID:  78c9c4dfbf8c04883941445a195276bb4bb92c76
Gitweb:     https://git.kernel.org/tip/78c9c4dfbf8c04883941445a195276bb4bb92c76
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 26 Jun 2018 15:21:32 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 2 Jul 2018 11:33:25 +0200

posix-timers: Sanitize overrun handling

The posix timer overrun handling is broken because the forwarding functions
can return a huge number of overruns which does not fit in an int. As a
consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
random number generators.

The k_clock::timer_forward() callbacks return a 64 bit value now. Make
k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
accounting is correct. 3Remove the temporary (int) casts.

Add a helper function which clamps the overrun value returned to user space
via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
between 0 and INT_MAX. INT_MAX is an indicator for user space that the
overrun value has been clamped.

Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de

---
 include/linux/posix-timers.h   |  4 ++--
 kernel/time/posix-cpu-timers.c |  2 +-
 kernel/time/posix-timers.c     | 31 ++++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index c85704fcdbd2..ee7e987ea1b4 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -95,8 +95,8 @@ struct k_itimer {
 	clockid_t		it_clock;
 	timer_t			it_id;
 	int			it_active;
-	int			it_overrun;
-	int			it_overrun_last;
+	s64			it_overrun;
+	s64			it_overrun_last;
 	int			it_requeue_pending;
 	int			it_sigev_notify;
 	ktime_t			it_interval;
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5a6251ac6f7a..562cc3891b57 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -85,7 +85,7 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
 			continue;
 
 		timer->it.cpu.expires += incr;
-		timer->it_overrun += 1 << i;
+		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index db1d65963a57..3ac7295306dc 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -283,6 +283,17 @@ static __init int init_posix_timers(void)
 }
 __initcall(init_posix_timers);
 
+/*
+ * The siginfo si_overrun field and the return value of timer_getoverrun(2)
+ * are of type int. Clamp the overrun value to INT_MAX
+ */
+static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+{
+	s64 sum = timr->it_overrun_last + (s64)baseval;
+
+	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+}
+
 static void common_hrtimer_rearm(struct k_itimer *timr)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
@@ -290,9 +301,8 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 	if (!timr->it_interval)
 		return;
 
-	timr->it_overrun += (unsigned int) hrtimer_forward(timer,
-						timer->base->get_time(),
-						timr->it_interval);
+	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
+					    timr->it_interval);
 	hrtimer_restart(timer);
 }
 
@@ -321,10 +331,10 @@ void posixtimer_rearm(struct siginfo *info)
 
 		timr->it_active = 1;
 		timr->it_overrun_last = timr->it_overrun;
-		timr->it_overrun = -1;
+		timr->it_overrun = -1LL;
 		++timr->it_requeue_pending;
 
-		info->si_overrun += timr->it_overrun_last;
+		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
 
 	unlock_timer(timr, flags);
@@ -418,9 +428,8 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 					now = ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun += (unsigned int)
-				hrtimer_forward(timer, now,
-						timr->it_interval);
+			timr->it_overrun += hrtimer_forward(timer, now,
+							    timr->it_interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 			timr->it_active = 1;
@@ -524,7 +533,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
 	new_timer->kclock = kc;
-	new_timer->it_overrun = -1;
+	new_timer->it_overrun = -1LL;
 
 	if (event) {
 		rcu_read_lock();
@@ -702,7 +711,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * expiry time forward by intervals, so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun += (int)kc->timer_forward(timr, now);
+		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -791,7 +800,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timr->it_overrun_last;
+	overrun = timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
 
 	return overrun;
