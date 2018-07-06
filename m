Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFCEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A220837
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeGFOLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:11:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeGFOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:11:21 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fbRSB-0004L1-E1; Fri, 06 Jul 2018 16:11:19 +0200
Date:   Fri, 6 Jul 2018 16:11:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.18-rt9
Message-ID: <20180706141119.2x6zg4klzsa42val@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.18-rt9 patch set. 

Changes since v4.16.18-rt8:

  - A patch from upstream to avoid a warning in the kthread code. The
    warning was part of the stable update.

  - Revert of a timer patch which is no longer since the initial problem
    was addressed upstream. Patch by Anna-Maria Gleixner.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.18-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.18-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.18-rt9

The RT patch against v4.16.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.18-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.18-rt9.tar.xz

Sebastian

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 2017a39ab490..481951bf091d 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 
 void kthread_park_complete(struct task_struct *k)
 {
-	complete(&to_kthread(k)->parked);
+	complete_all(&to_kthread(k)->parked);
 }
 
 static int kthread(void *_create)
@@ -459,6 +459,7 @@ void kthread_unpark(struct task_struct *k)
 	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
 		__kthread_bind(k, kthread->cpu, TASK_PARKED);
 
+	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	wake_up_state(k, TASK_PARKED);
 }
@@ -483,9 +484,6 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
-	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
-		return -EBUSY;
-
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 26f23481030b..20ae4c544cda 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1673,13 +1673,13 @@ void update_process_times(int user_tick)
 
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
-	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #if defined(CONFIG_IRQ_WORK)
 	if (in_irq())
 		irq_work_tick();
 #endif
+	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers(p);
 }
diff --git a/localversion-rt b/localversion-rt
index 700c857efd9b..22746d6390a4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
