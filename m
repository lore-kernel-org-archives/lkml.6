Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AADC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1E220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfAOPkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:40:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfAOPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:40:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0FFds3A2577318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 07:39:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0FFdsTH2577315;
        Tue, 15 Jan 2019 07:39:54 -0800
Date:   Tue, 15 Jan 2019 07:39:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-16118794ede91aac1a73abe15de22d3de9d2b775@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, hjl.tools@gmail.com, hpa@zytor.com,
        peterz@infradead.org
Reply-To: john.stultz@linaro.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, hjl.tools@gmail.com,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190111133500.945255655@linutronix.de>
References: <20190111133500.945255655@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-cpu-timers: Remove private interval storage
Git-Commit-ID: 16118794ede91aac1a73abe15de22d3de9d2b775
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

Commit-ID:  16118794ede91aac1a73abe15de22d3de9d2b775
Gitweb:     https://git.kernel.org/tip/16118794ede91aac1a73abe15de22d3de9d2b775
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 11 Jan 2019 14:33:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 16:36:13 +0100

posix-cpu-timers: Remove private interval storage

Posix CPU timers store the interval in private storage for historical
reasons (it_interval used to be a non scalar representation on 32bit
systems). This is gone and there is no reason for duplicated storage
anymore.

Use it_interval everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>
Link: https://lkml.kernel.org/r/20190111133500.945255655@linutronix.de

---
 include/linux/posix-timers.h   |  2 +-
 kernel/time/posix-cpu-timers.c | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index e96581ca7c9d..b20798fc5191 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -12,7 +12,7 @@ struct siginfo;
 
 struct cpu_timer_list {
 	struct list_head entry;
-	u64 expires, incr;
+	u64 expires;
 	struct task_struct *task;
 	int firing;
 };
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 80f955210861..0a426f4e3125 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -67,13 +67,13 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
 	int i;
 	u64 delta, incr;
 
-	if (timer->it.cpu.incr == 0)
+	if (!timer->it_interval)
 		return;
 
 	if (now < timer->it.cpu.expires)
 		return;
 
-	incr = timer->it.cpu.incr;
+	incr = timer->it_interval;
 	delta = now + incr - timer->it.cpu.expires;
 
 	/* Don't use (incr*2 < delta), incr*2 might overflow. */
@@ -520,7 +520,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 		 */
 		wake_up_process(timer->it_process);
 		timer->it.cpu.expires = 0;
-	} else if (timer->it.cpu.incr == 0) {
+	} else if (!timer->it_interval) {
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
@@ -606,7 +606,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 
 	ret = 0;
-	old_incr = timer->it.cpu.incr;
+	old_incr = timer->it_interval;
 	old_expires = timer->it.cpu.expires;
 	if (unlikely(timer->it.cpu.firing)) {
 		timer->it.cpu.firing = -1;
@@ -684,8 +684,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * Install the new reload setting, and
 	 * set up the signal and overrun bookkeeping.
 	 */
-	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
-	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
+	timer->it_interval = timespec64_to_ktime(new->it_interval);
 
 	/*
 	 * This acts as a modification timestamp for the timer,
@@ -724,7 +723,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	/*
 	 * Easy part: convert the reload time.
 	 */
-	itp->it_interval = ns_to_timespec64(timer->it.cpu.incr);
+	itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
 	if (!timer->it.cpu.expires)
 		return;
