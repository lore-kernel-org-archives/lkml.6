Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5725C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4520883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOYYXWmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A4520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeKIHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732451AbeKIHpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C0B2147D;
        Thu,  8 Nov 2018 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714884;
        bh=WGubkUxUQiNQ8uTLD3gU7ElS7npVglnzDkRy8tqwes0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOYYXWmK45EohWfa9VjKALSpfzF5HBh7y8W8sj0S9i0DooxAn0yjqbNvDc1OCVWH7
         g6L58hNhGebdO6a5nmlOL7eunSI0v4N8G+Qhd+PDtAMUTOtYnp3XuT61FvBqArylla
         ZiKXDi7qDZ+/4oykqNppFgstDrWGvB7r+5BomvTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Team OWL337 <icytxw@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 171/171] posix-timers: Sanitize overrun handling
Date:   Thu,  8 Nov 2018 13:52:21 -0800
Message-Id: <20181108215139.300639655@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]

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
---
 include/linux/posix-timers.h   |  4 ++--
 kernel/time/posix-cpu-timers.c |  2 +-
 kernel/time/posix-timers.c     | 29 +++++++++++++++++++----------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 62d44c176071..e4b8678183f5 100644
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
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 39008d78927a..21a27bb73587 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -103,7 +103,7 @@ static void bump_cpu_timer(struct k_itimer *timer,
 			continue;
 
 		timer->it.cpu.expires += incr;
-		timer->it_overrun += 1 << i;
+		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fc7c37ad90a0..0e6ed2e7d066 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -355,6 +355,17 @@ static __init int init_posix_timers(void)
 
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
@@ -362,12 +373,11 @@ static void schedule_next_timer(struct k_itimer *timr)
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
@@ -396,7 +406,7 @@ void do_schedule_next_timer(struct siginfo *info)
 		else
 			schedule_next_timer(timr);
 
-		info->si_overrun += timr->it_overrun_last;
+		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
 
 	if (timr)
@@ -491,8 +501,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 					now = ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun += (unsigned int)
-				hrtimer_forward(timer, now,
+			timr->it_overrun += hrtimer_forward(timer, now,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
@@ -633,7 +642,7 @@ SYSCALL_DEFINE3(timer_create, const clockid_t, which_clock,
 	it_id_set = IT_ID_SET;
 	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
-	new_timer->it_overrun = -1;
+	new_timer->it_overrun = -1LL;
 
 	if (timer_event_spec) {
 		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
@@ -762,7 +771,7 @@ common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
 			timr->it_sigev_notify == SIGEV_NONE))
-		timr->it_overrun += (unsigned int) hrtimer_forward(timer, now, iv);
+		timr->it_overrun += hrtimer_forward(timer, now, iv);
 
 	remaining = __hrtimer_expires_remaining_adjusted(timer, now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -824,7 +833,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
 
-	overrun = timr->it_overrun_last;
+	overrun = timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
 
 	return overrun;
-- 
2.17.1



