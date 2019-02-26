Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F05C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2E12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfBZQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:19:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45401 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfBZQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:19:31 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gyfS4-0004PJ-D4; Tue, 26 Feb 2019 17:19:28 +0100
Date:   Tue, 26 Feb 2019 17:19:28 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.19.25-rt16
Message-ID: <20190226161928.fktqci3obi56h2ea@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.19.25-rt16 patch set. 

Changes since v4.19.25-rt15:

  - The "preserve task state" change in cpu_chill() in the previous
    release is responsible for missing a wake up. Reported by Mike
    Galbraith.

  - The x86-32 lazy preempt code was broken. Reported by Andri Yngvason.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.19.25-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.25-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.19.25-rt16

The RT patch against v4.19.25 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.25-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patches-4.19.25-rt16.tar.xz

Sebastian

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 0169c257cfffe..e6f61c813baf6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -773,15 +773,15 @@ ENTRY(resume_kernel)
 
 	# atleast preempt count == 0 ?
 	cmpl $_PREEMPT_ENABLED,PER_CPU_VAR(__preempt_count)
-	jne restore_all
+	jne	restore_all_kernel
 
 	movl	PER_CPU_VAR(current_task), %ebp
 	cmpl	$0,TASK_TI_preempt_lazy_count(%ebp)	# non-zero preempt_lazy_count ?
-	jnz	restore_all
+	jnz	restore_all_kernel
 
 	testl	$_TIF_NEED_RESCHED_LAZY, TASK_TI_flags(%ebp)
-	jz	restore_all
-	test_int_off:
+	jz	restore_all_kernel
+test_int_off:
 #endif
 	testl	$X86_EFLAGS_IF, PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz	restore_all_kernel
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6f2736ec4b8ef..e1040b80362c9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1900,20 +1900,28 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
  */
 void cpu_chill(void)
 {
-	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
-	long saved_state;
+	struct task_struct *self = current;
+	ktime_t chill_time;
 
-	saved_state = current->state;
-	chill_time = ktime_set(0, NSEC_PER_MSEC);
+	raw_spin_lock_irq(&self->pi_lock);
+	self->saved_state = self->state;
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+	raw_spin_unlock_irq(&self->pi_lock);
+
+	chill_time = ktime_set(0, NSEC_PER_MSEC);
+
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
-	__set_current_state_no_track(saved_state);
+
+	raw_spin_lock_irq(&self->pi_lock);
+	__set_current_state_no_track(self->saved_state);
+	self->saved_state = TASK_RUNNING;
+	raw_spin_unlock_irq(&self->pi_lock);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d4..1199ebade17b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
