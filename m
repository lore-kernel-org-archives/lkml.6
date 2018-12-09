Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C3FC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090D220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090D220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeLIWTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35594 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbeLIVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002ii-G8; Sun, 09 Dec 2018 21:55:24 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hc-Ru; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Team OWL337" <icytxw@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "John Stultz" <john.stultz@linaro.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.635009654@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 324/328] posix-timers: Sanitize overrun handling
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 upstream.

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
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/posix-timers.h |  4 ++--
 kernel/posix-cpu-timers.c    |  2 +-
 kernel/posix-timers.c        | 31 ++++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 14 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,8 +65,8 @@ struct k_itimer {
 	spinlock_t it_lock;
 	clockid_t it_clock;		/* which timer type */
 	timer_t it_id;			/* timer id */
-	int it_overrun;			/* overrun on pending signal  */
-	int it_overrun_last;		/* overrun on last delivered signal */
+	s64 it_overrun;			/* overrun on pending signal  */
+	s64 it_overrun_last;		/* overrun on last delivered signal */
 	int it_requeue_pending;		/* waiting to requeue this timer */
 #define REQUEUE_PENDING 1
 	int it_sigev_notify;		/* notify word of sigevent struct */
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -103,7 +103,7 @@ static void bump_cpu_timer(struct k_itim
 			continue;
 
 		timer->it.cpu.expires += incr;
-		timer->it_overrun += 1 << i;
+		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
 }
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -347,6 +347,17 @@ static __init int init_posix_timers(void
 
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
 static void schedule_next_timer(struct k_itimer *timr)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
@@ -354,12 +365,11 @@ static void schedule_next_timer(struct k
 	if (timr->it.real.interval.tv64 == 0)
 		return;
 
-	timr->it_overrun += (unsigned int) hrtimer_forward(timer,
-						timer->base->get_time(),
-						timr->it.real.interval);
+	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
+					    timr->it.real.interval);
 
 	timr->it_overrun_last = timr->it_overrun;
-	timr->it_overrun = -1;
+	timr->it_overrun = -1LL;
 	++timr->it_requeue_pending;
 	hrtimer_restart(timer);
 }
@@ -388,7 +398,7 @@ void do_schedule_next_timer(struct sigin
 		else
 			schedule_next_timer(timr);
 
-		info->si_overrun += timr->it_overrun_last;
+		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
 
 	if (timr)
@@ -483,9 +493,8 @@ static enum hrtimer_restart posix_timer_
 					now = ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun += (unsigned int)
-				hrtimer_forward(timer, now,
-						timr->it.real.interval);
+			timr->it_overrun += hrtimer_forward(timer, now,
+							    timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 		}
@@ -633,7 +642,7 @@ SYSCALL_DEFINE3(timer_create, const cloc
 	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
-	new_timer->it_overrun = -1;
+	new_timer->it_overrun = -1LL;
 
 	if (timer_event_spec) {
 		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
@@ -763,7 +772,7 @@ common_timer_get(struct k_itimer *timr,
 	 * expiry is > now.
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
+		timr->it_overrun += hrtimer_forward(timer, now, iv);
 
 	remaining = ktime_sub(hrtimer_get_expires(timer), now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -825,7 +834,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timr->it_overrun_last;
+	overrun = timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
 
 	return overrun;

