Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F2DC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4EA20818
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyveRkff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4EA20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbeKNMsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732805AbeKNMsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:23 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE1922507;
        Wed, 14 Nov 2018 02:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163633;
        bh=flwIkirhf8N2whRn/kM+LCuIa6KaRike4W/zGGw3xto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyveRkffV3O2rj0b2bfy7I1gFc3YJGf+h4gtF217+cPn/tEFqtqz61WDwalkIPk2q
         X8rf/PMdi2tQmScHcW9PatqyBa07wS1ZmSPaSvSoGUo0PzTvahFwlh4RlY6AmHyHZu
         sdMTAyRHkcIKnguSeCRRRDUvSOZwtV8SZh8QNqbE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 25/25] sched/vtime: Clarify vtime_task_switch() argument layout
Date:   Wed, 14 Nov 2018 03:46:09 +0100
Message-Id: <1542163569-20047-26-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function deals with the previous and next tasks during a context
switch. But only the previous is passed as an argument, the next task
being deduced from current. Make the code clearer by passing both
previous and next as arguments.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/cputime.h    |  3 ++-
 arch/ia64/kernel/time.c            |  5 +++--
 arch/powerpc/include/asm/cputime.h |  8 +++++---
 arch/s390/kernel/vtime.c           | 13 +++++++------
 include/linux/vtime.h              | 17 +++++++++++------
 kernel/sched/core.c                |  2 +-
 kernel/sched/cputime.c             | 18 ++++++++++--------
 7 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/arch/ia64/include/asm/cputime.h b/arch/ia64/include/asm/cputime.h
index 3d665c0..0bc90a1 100644
--- a/arch/ia64/include/asm/cputime.h
+++ b/arch/ia64/include/asm/cputime.h
@@ -19,7 +19,8 @@
 #define __IA64_CPUTIME_H
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void arch_vtime_task_switch(struct task_struct *tsk);
+extern void arch_vtime_task_switch(struct task_struct *prev,
+				   struct task_struct *next);
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 #endif /* __IA64_CPUTIME_H */
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 46a9798..908bd4f 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -105,10 +105,11 @@ void vtime_flush(struct task_struct *tsk)
  * accumulated times to the current process, and to prepare accounting on
  * the next process.
  */
-void arch_vtime_task_switch(struct task_struct *prev)
+void arch_vtime_task_switch(struct task_struct *prev,
+			    struct task_struct *next)
 {
 	struct thread_info *pi = task_thread_info(prev);
-	struct thread_info *ni = task_thread_info(current);
+	struct thread_info *ni = task_thread_info(next);
 
 	ni->ac_stamp = pi->ac_stamp;
 	ni->ac_stime = ni->ac_utime = 0;
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index ae73dc8..9d68040 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -47,7 +47,8 @@ static inline unsigned long cputime_to_usecs(const cputime_t ct)
  */
 #ifdef CONFIG_PPC64
 #define get_accounting(tsk)	(&get_paca()->accounting)
-static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
+static inline void arch_vtime_task_switch(struct task_struct *prev,
+					  struct task_struct *next) { }
 #else
 #define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
 /*
@@ -55,9 +56,10 @@ static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
  * accumulated times to the current process, and to prepare accounting on
  * the next process.
  */
-static inline void arch_vtime_task_switch(struct task_struct *prev)
+static inline void arch_vtime_task_switch(struct task_struct *prev,
+					  struct task_struct *next)
 {
-	struct cpu_accounting_data *acct = get_accounting(current);
+	struct cpu_accounting_data *acct = get_accounting(next);
 	struct cpu_accounting_data *acct0 = get_accounting(prev);
 
 	acct->starttime = acct0->starttime;
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index b6b888d..fcfeb63 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -191,7 +191,8 @@ static int do_account_vtime(struct task_struct *tsk)
 	return virt_timer_forward(user + guest + system + hardirq + softirq);
 }
 
-void vtime_task_switch(struct task_struct *prev)
+void vtime_task_switch(struct task_struct *prev,
+		       struct task_struct *next)
 {
 	do_account_vtime(prev);
 	prev->thread.user_timer = S390_lowcore.user_timer;
@@ -199,11 +200,11 @@ void vtime_task_switch(struct task_struct *prev)
 	prev->thread.system_timer = S390_lowcore.system_timer;
 	prev->thread.hardirq_timer = S390_lowcore.hardirq_timer;
 	prev->thread.softirq_timer = S390_lowcore.softirq_timer;
-	S390_lowcore.user_timer = current->thread.user_timer;
-	S390_lowcore.guest_timer = current->thread.guest_timer;
-	S390_lowcore.system_timer = current->thread.system_timer;
-	S390_lowcore.hardirq_timer = current->thread.hardirq_timer;
-	S390_lowcore.softirq_timer = current->thread.softirq_timer;
+	S390_lowcore.user_timer = next->thread.user_timer;
+	S390_lowcore.guest_timer = next->thread.guest_timer;
+	S390_lowcore.system_timer = next->thread.system_timer;
+	S390_lowcore.hardirq_timer = next->thread.hardirq_timer;
+	S390_lowcore.softirq_timer = next->thread.softirq_timer;
 }
 
 /*
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index b4566d5..188eace 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -16,7 +16,8 @@ struct task_struct;
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
 
 static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
-extern void vtime_task_switch(struct task_struct *prev);
+extern void vtime_task_switch(struct task_struct *prev,
+			      struct task_struct *next);
 
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
 
@@ -51,19 +52,22 @@ static inline bool vtime_accounting_enabled_this_cpu(void)
 	return false;
 }
 
-extern void vtime_task_switch_generic(struct task_struct *prev);
+extern void vtime_task_switch_generic(struct task_struct *prev,
+				      struct task_struct *next);
 
-static inline void vtime_task_switch(struct task_struct *prev)
+static inline void vtime_task_switch(struct task_struct *prev,
+				     struct task_struct *next)
 {
 	if (vtime_accounting_enabled_this_cpu())
-		vtime_task_switch_generic(prev);
+		vtime_task_switch_generic(prev, next);
 }
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 static inline bool vtime_accounting_enabled_cpu(int cpu) {return false; }
 static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
-static inline void vtime_task_switch(struct task_struct *prev) { }
+static inline void vtime_task_switch(struct task_struct *prev,
+				     struct task_struct *next) { }
 
 #endif
 
@@ -78,7 +82,8 @@ static inline void vtime_account_kernel(struct task_struct *tsk) { }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void arch_vtime_task_switch(struct task_struct *tsk);
+extern void arch_vtime_task_switch(struct task_struct *prev,
+				   struct task_struct *next);
 extern void vtime_user_enter(struct task_struct *tsk);
 extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8f0437..6e315b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2675,7 +2675,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * transition, resulting in a double drop.
 	 */
 	prev_state = prev->state;
-	vtime_task_switch(prev);
+	vtime_task_switch(prev, current);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	finish_lock_switch(rq);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 3afde9f..c6a953d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -421,7 +421,8 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 
 # ifndef __ARCH_HAS_VTIME_TASK_SWITCH
-void vtime_task_switch(struct task_struct *prev)
+void vtime_task_switch(struct task_struct *prev,
+		       struct task_struct *next)
 {
 	if (is_idle_task(prev))
 		vtime_account_idle(prev);
@@ -429,7 +430,7 @@ void vtime_task_switch(struct task_struct *prev)
 		vtime_account_kernel(prev);
 
 	vtime_flush(prev);
-	arch_vtime_task_switch(prev);
+	arch_vtime_task_switch(prev, next);
 }
 # endif
 
@@ -848,7 +849,8 @@ void vtime_account_idle(struct task_struct *tsk)
 	account_idle_time(get_vtime_delta(&tsk->vtime));
 }
 
-void vtime_task_switch_generic(struct task_struct *prev)
+void vtime_task_switch_generic(struct task_struct *prev,
+			       struct task_struct *next)
 {
 	struct vtime *vtime = &prev->vtime;
 	struct kernel_cpustat *kcpustat = kcpustat_this_cpu;
@@ -869,7 +871,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 		write_seqcount_end(&vtime->seqcount);
 	}
 
-	vtime = &current->vtime;
+	vtime = &next->vtime;
 
 	/*
 	 * Ignore the next task if it has been preempted after
@@ -881,18 +883,18 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	}
 
 	write_seqcount_begin(&vtime->seqcount);
-	if (is_idle_task(current))
+	if (is_idle_task(next))
 		vtime->state = VTIME_IDLE;
-	else if (current->flags & PF_VCPU)
+	else if (next->flags & PF_VCPU)
 		vtime->state = VTIME_GUEST;
 	else
 		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
-	vtime->nice = (task_nice(current) > 0) ? 1 : 0;
+	vtime->nice = (task_nice(next) > 0) ? 1 : 0;
 	write_seqcount_end(&vtime->seqcount);
 
-	rcu_assign_pointer(kcpustat->curr, current);
+	rcu_assign_pointer(kcpustat->curr, next);
 }
 
 void vtime_init_idle(struct task_struct *t, int cpu)
-- 
2.7.4

