Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23658C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DD7208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DD7208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967863AbeFRIzF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:55:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967715AbeFRIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:34:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B848C49;
        Mon, 18 Jun 2018 08:34:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 117/189] sched/core: Introduce set_special_state()
Date:   Mon, 18 Jun 2018 10:13:33 +0200
Message-Id: <20180618081213.958461287@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit b5bf9a90bbebffba888c9144c5a8a10317b04064 ]

Gaurav reported a perceived problem with TASK_PARKED, which turned out
to be a broken wait-loop pattern in __kthread_parkme(), but the
reported issue can (and does) in fact happen for states that do not do
condition based sleeps.

When the 'current->state = TASK_RUNNING' store of a previous
(concurrent) try_to_wake_up() collides with the setting of a 'special'
sleep state, we can loose the sleep state.

Normal condition based wait-loops are immune to this problem, but for
sleep states that are not condition based are subject to this problem.

There already is a fix for TASK_DEAD. Abstract that and also apply it
to TASK_STOPPED and TASK_TRACED, both of which are also without
condition based wait-loop.

Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sched.h        |   50 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/sched/signal.h |    2 -
 kernel/sched/core.c          |   17 --------------
 kernel/signal.c              |   17 ++++++++++++--
 4 files changed, 62 insertions(+), 24 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -113,17 +113,36 @@ struct task_group;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
+/*
+ * Special states are those that do not use the normal wait-loop pattern. See
+ * the comment with set_special_state().
+ */
+#define is_special_task_state(state)				\
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_DEAD))
+
 #define __set_current_state(state_value)			\
 	do {							\
+		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
 		current->state = (state_value);			\
 	} while (0)
+
 #define set_current_state(state_value)				\
 	do {							\
+		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
 		smp_store_mb(current->state, (state_value));	\
 	} while (0)
 
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		WARN_ON_ONCE(!is_special_task_state(state_value));	\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->task_state_change = _THIS_IP_;			\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
 #else
 /*
  * set_current_state() includes a barrier so that the write of current->state
@@ -145,8 +164,8 @@ struct task_group;
  *
  * The above is typically ordered against the wakeup, which does:
  *
- *	need_sleep = false;
- *	wake_up_state(p, TASK_UNINTERRUPTIBLE);
+ *   need_sleep = false;
+ *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
  * Where wake_up_state() (and all other wakeup primitives) imply enough
  * barriers to order the store of the variable against wakeup.
@@ -155,12 +174,33 @@ struct task_group;
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
  * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
  *
- * This is obviously fine, since they both store the exact same value.
+ * However, with slightly different timing the wakeup TASK_RUNNING store can
+ * also collide with the TASK_UNINTERRUPTIBLE store. Loosing that store is not
+ * a problem either because that will result in one extra go around the loop
+ * and our @cond test will save the day.
  *
  * Also see the comments of try_to_wake_up().
  */
-#define __set_current_state(state_value) do { current->state = (state_value); } while (0)
-#define set_current_state(state_value)	 smp_store_mb(current->state, (state_value))
+#define __set_current_state(state_value)				\
+	current->state = (state_value)
+
+#define set_current_state(state_value)					\
+	smp_store_mb(current->state, (state_value))
+
+/*
+ * set_special_state() should be used for those states when the blocking task
+ * can not use the regular condition based wait-loop. In that case we must
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
+ * will not collide with our state change.
+ */
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
+
 #endif
 
 /* Task command name length: */
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -280,7 +280,7 @@ static inline void kernel_signal_stop(vo
 {
 	spin_lock_irq(&current->sighand->siglock);
 	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 	spin_unlock_irq(&current->sighand->siglock);
 
 	schedule();
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3374,23 +3374,8 @@ static void __sched notrace __schedule(b
 
 void __noreturn do_task_dead(void)
 {
-	/*
-	 * The setting of TASK_RUNNING by try_to_wake_up() may be delayed
-	 * when the following two conditions become true.
-	 *   - There is race condition of mmap_sem (It is acquired by
-	 *     exit_mm()), and
-	 *   - SMI occurs before setting TASK_RUNINNG.
-	 *     (or hypervisor of virtual machine switches to other guest)
-	 *  As a result, we may become TASK_RUNNING after becoming TASK_DEAD
-	 *
-	 * To avoid it, we have to wait for releasing tsk->pi_lock which
-	 * is held by try_to_wake_up()
-	 */
-	raw_spin_lock_irq(&current->pi_lock);
-	raw_spin_unlock_irq(&current->pi_lock);
-
 	/* Causes final put_task_struct in finish_task_switch(): */
-	__set_current_state(TASK_DEAD);
+	set_special_state(TASK_DEAD);
 
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1828,14 +1828,27 @@ static void ptrace_stop(int exit_code, i
 			return;
 	}
 
+	set_special_state(TASK_TRACED);
+
 	/*
 	 * We're committing to trapping.  TRACED should be visible before
 	 * TRAPPING is cleared; otherwise, the tracer might fail do_wait().
 	 * Also, transition to TRACED and updates to ->jobctl should be
 	 * atomic with respect to siglock and should be done after the arch
 	 * hook as siglock is released and regrabbed across it.
+	 *
+	 *     TRACER				    TRACEE
+	 *
+	 *     ptrace_attach()
+	 * [L]   wait_on_bit(JOBCTL_TRAPPING)	[S] set_special_state(TRACED)
+	 *     do_wait()
+	 *       set_current_state()                smp_wmb();
+	 *       ptrace_do_wait()
+	 *         wait_task_stopped()
+	 *           task_stopped_code()
+	 * [L]         task_is_traced()		[S] task_clear_jobctl_trapping();
 	 */
-	set_current_state(TASK_TRACED);
+	smp_wmb();
 
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
@@ -2043,7 +2056,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
 		/*


