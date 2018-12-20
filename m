Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F19BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E73121773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297629;
	bh=dal54FcIx1YbvSTX5W6X19DXRtqZE6MhbSaSnY+4TTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3q46ei2FO/BsWI5DqXNvjM9Z8IlWw0T3BgSpjTdL2ty8YifdM/oTbtz8ooyNSvvb
	 kpjyxXGKu73jAw1wh8GfoJGo3vOHGNIhwy+94xuC6xym0npJkkj7oMBhfSFn/zF8Io
	 PQyOxTKQ76hzJ/LKCorj8J8NhOyLNYZiUGcrOxvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeLTJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbeLTJUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCC72177B;
        Thu, 20 Dec 2018 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297622;
        bh=dal54FcIx1YbvSTX5W6X19DXRtqZE6MhbSaSnY+4TTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDtKtU1Eo/4p1he61zeM+pVOcf/nLTWbSB2fkAgo/K5J0bvksToBxix/vs9mgsXVv
         3e3oqoawVA/M5uQ3SoPG//gYvjksGsurRQom+fKPEhDAX4XZ0cgUaVQb3iihD8gHoF
         6tLjf4HSKuVbCRXm5zOIhCuHZNT8jMWD195K9NI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Team OWL337 <icytxw@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 28/31] posix-timers: Sanitize overrun handling
Date:   Thu, 20 Dec 2018 10:18:40 +0100
Message-Id: <20181220085743.708124630@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
[florian: Make patch apply to v4.9.135]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/posix-timers.h   |    4 ++--
 kernel/time/posix-cpu-timers.c |    2 +-
 kernel/time/posix-timers.c     |   29 +++++++++++++++++++----------
 3 files changed, 22 insertions(+), 13 deletions(-)

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
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -103,7 +103,7 @@ static void bump_cpu_timer(struct k_itim
 			continue;
 
 		timer->it.cpu.expires += incr;
-		timer->it_overrun += 1 << i;
+		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
 }
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -348,6 +348,17 @@ static __init int init_posix_timers(void
 
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
@@ -355,12 +366,11 @@ static void schedule_next_timer(struct k
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
@@ -389,7 +399,7 @@ void do_schedule_next_timer(struct sigin
 		else
 			schedule_next_timer(timr);
 
-		info->si_overrun += timr->it_overrun_last;
+		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
 
 	if (timr)
@@ -484,8 +494,7 @@ static enum hrtimer_restart posix_timer_
 					now = ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun += (unsigned int)
-				hrtimer_forward(timer, now,
+			timr->it_overrun += hrtimer_forward(timer, now,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
@@ -626,7 +635,7 @@ SYSCALL_DEFINE3(timer_create, const cloc
 	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
-	new_timer->it_overrun = -1;
+	new_timer->it_overrun = -1LL;
 
 	if (timer_event_spec) {
 		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
@@ -755,7 +764,7 @@ common_timer_get(struct k_itimer *timr,
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
 			timr->it_sigev_notify == SIGEV_NONE))
-		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
+		timr->it_overrun += hrtimer_forward(timer, now, iv);
 
 	remaining = ktime_sub(hrtimer_get_expires(timer), now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -817,7 +826,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timr->it_overrun_last;
+	overrun = timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
 
 	return overrun;


