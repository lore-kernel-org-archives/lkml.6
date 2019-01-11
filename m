Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C47C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4390020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfAKNg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:36:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbfAKNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:36:25 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ghwz1-0000nS-6v; Fri, 11 Jan 2019 14:36:23 +0100
Message-Id: <20190111133500.945255655@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 11 Jan 2019 14:33:17 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H.J. Lu" <hjl.tools@gmail.com>
Subject: [patch 2/2] posix-cpu-timers: Remove private interval storage
References: <20190111133315.657348322@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posix CPU timers store the interval in private storage for historical
reasons (it_interval used to be a non scalar representation on 32bit
systems). This is gone and there is no reason for duplicated storage
anymore.

Use it_interval everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    2 +-
 kernel/time/posix-cpu-timers.c |   13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

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
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -67,13 +67,13 @@ static void bump_cpu_timer(struct k_itim
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
@@ -520,7 +520,7 @@ static void cpu_timer_fire(struct k_itim
 		 */
 		wake_up_process(timer->it_process);
 		timer->it.cpu.expires = 0;
-	} else if (timer->it.cpu.incr == 0) {
+	} else if (!timer->it_interval) {
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
@@ -606,7 +606,7 @@ static int posix_cpu_timer_set(struct k_
 	 */
 
 	ret = 0;
-	old_incr = timer->it.cpu.incr;
+	old_incr = timer->it_interval;
 	old_expires = timer->it.cpu.expires;
 	if (unlikely(timer->it.cpu.firing)) {
 		timer->it.cpu.firing = -1;
@@ -684,8 +684,7 @@ static int posix_cpu_timer_set(struct k_
 	 * Install the new reload setting, and
 	 * set up the signal and overrun bookkeeping.
 	 */
-	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
-	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
+	timer->it_interval = timespec64_to_ktime(new->it_interval);
 
 	/*
 	 * This acts as a modification timestamp for the timer,
@@ -724,7 +723,7 @@ static void posix_cpu_timer_get(struct k
 	/*
 	 * Easy part: convert the reload time.
 	 */
-	itp->it_interval = ns_to_timespec64(timer->it.cpu.incr);
+	itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
 	if (!timer->it.cpu.expires)
 		return;


