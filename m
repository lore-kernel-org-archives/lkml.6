Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326B421709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326B421709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeHCJ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:59:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39112 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeHCJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:59:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1flV4n-0003jc-R9; Fri, 03 Aug 2018 10:04:45 +0200
Date:   Fri, 3 Aug 2018 10:04:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.18-rt12
Message-ID: <20180803080445.7572rc6nkxx7h3va@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.18-rt12 patch set. 

Changes since v4.16.18-rt11:

  - Mark RCU's "rcu_iw" irqwork to be invoked in hardirq context as
    expected by RCU. Reported by John Ogness.

  - Drop the "is_special_task_state()" check from rtmutex's custom
    set_state function. This avoids a warning if the sleeping-lock code
    is restoring back to this "special" state.

  - If a kworker invokes schedule() it is possible that it wakes another
    kworker and invokes schedule() again. Try to avoid the second
    schedule(). Reported and patched by Daniel Bristot de Oliveira.

  - Enable XEN on ARM64. Iain Hunter reported that there are no problems
    with it so there is no reason to keep disabled.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.18-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.18-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.18-rt12

The RT patch against v4.16.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.18-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.18-rt12.tar.xz

Sebastian
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d2370c7829451..3a6f0ae739d39 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -861,7 +861,7 @@ config XEN_DOM0
 
 config XEN
 	bool "Xen guest support on ARM64"
-	depends on ARM64 && OF && !PREEMPT_RT_FULL
+	depends on ARM64 && OF
 	select SWIOTLB_XEN
 	select PARAVIRT
 	help
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a0c1c0cae992d..5d5adba0c8ef7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -131,16 +131,7 @@ struct task_group;
 	} while (0)
 
 #define __set_current_state_no_track(state_value)		\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->state = (state_value);			\
-	} while (0)
-
-#define set_current_state_no_track(state_value)			\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		smp_store_mb(current->state, (state_value));	\
-	} while (0)
+		current->state = (state_value);
 
 #define set_special_state(state_value)					\
 	do {								\
@@ -196,7 +187,6 @@ struct task_group;
 	smp_store_mb(current->state, (state_value))
 
 #define __set_current_state_no_track(state_value)	__set_current_state(state_value)
-#define set_current_state_no_track(state_value)		set_current_state(state_value)
 
 /*
  * set_special_state() should be used for those states when the blocking task
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bf969de8e2a03..604c1db913661 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1334,6 +1334,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gpnum != rnp->gpnum &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
+			rdp->rcu_iw.flags = IRQ_WORK_HARD_IRQ;
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gpnum = rnp->gpnum;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 70641e8f3c898..6907657dd4b1d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3545,10 +3545,15 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
+	 * As this function is called inside the schedule() context,
+	 * we disable preemption to avoid it calling schedule() again
+	 * in the possible wakeup of a kworker.
 	 */
-	if (tsk->flags & PF_WQ_WORKER)
+	if (tsk->flags & PF_WQ_WORKER) {
+		preempt_disable();
 		wq_worker_sleeping(tsk);
-
+		preempt_enable_no_resched();
+	}
 
 	if (tsk_is_pi_blocked(tsk))
 		return;
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
