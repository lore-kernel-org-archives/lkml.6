Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A4217AF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1A4217AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeGFLAU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:00:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeGFK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:59:06 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fbOS2-00066c-Ed; Fri, 06 Jul 2018 12:58:58 +0200
Date:   Fri, 6 Jul 2018 12:58:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT v2] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Message-ID: <20180706105857.5tgi5irdxdryet64@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
 <20180705161807.GA5800@zipoli.concurrent-rt.com>
 <20180705165937.5orx3md3krg4akaz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180705165937.5orx3md3krg4akaz@linutronix.de>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SMP + !RT migrate_disable() is still around. It is not part of spin_lock()
anymore so it has almost no users. However the futex code has a workaround for
the !in_atomic() part of migrate disable which fails because the matching
migrade_disable() is no longer part of spin_lock().

On !SMP + !RT migrate_disable() is reduced to barrier(). This is not optimal
because we few spots where a "preempt_disable()" statement was replaced with
"migrate_disable()".

We also used the migration_disable counter to figure out if a sleeping lock is
acquired so RCU does not complain about schedule() during rcu_read_lock() while
a sleeping lock is held. This changed, we no longer use it, we have now a
sleeping_lock counter for the RCU purpose.

This means we can now:
- for SMP + RT_BASE
  full migration program, nothing changes here

- for !SMP + RT_BASE
  the migration counting is no longer required. It used to ensure that the task
  is not migrated to another CPU and that this CPU remains online. !SMP ensures
  that already.
  Move it to CONFIG_SCHED_DEBUG so the counting is done for debugging purpose
  only.

- for all other cases including !RT
  fallback to preempt_disable(). The only remaining users of migrate_disable()
  are those which were converted from preempt_disable() and the futex
  workaround which is already in the preempt_disable() section due to the
  spin_lock that is held.

Cc: stable-rt@vger.kernel.org
Reported-by: joe.korty@concurrent-rt.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: limit migrate_disable to RT only. Use preempt_disable() for !RT
       if migrate_disable() is used.

 include/linux/preempt.h |    6 +++---
 include/linux/sched.h   |    4 ++--
 kernel/sched/core.c     |   23 +++++++++++------------
 kernel/sched/debug.c    |    2 +-
 4 files changed, 17 insertions(+), 18 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -204,7 +204,7 @@ do { \
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 extern void migrate_disable(void);
 extern void migrate_enable(void);
@@ -221,8 +221,8 @@ static inline int __migrate_disabled(str
 }
 
 #else
-#define migrate_disable()		barrier()
-#define migrate_enable()		barrier()
+#define migrate_disable()		preempt_disable()
+#define migrate_enable()		preempt_enable()
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -645,7 +645,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
 	int				migrate_disable_update;
 # ifdef CONFIG_SCHED_DEBUG
@@ -653,8 +653,8 @@ struct task_struct {
 # endif
 
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	int				migrate_disable;
 # ifdef CONFIG_SCHED_DEBUG
+	int				migrate_disable;
 	int				migrate_disable_atomic;
 # endif
 #endif
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1059,7 +1059,7 @@ void set_cpus_allowed_common(struct task
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
@@ -1098,7 +1098,7 @@ static void __do_set_cpus_allowed_tail(s
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		lockdep_assert_held(&p->pi_lock);
 
@@ -1171,7 +1171,7 @@ static int __set_cpus_allowed_ptr(struct
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		p->migrate_disable_update = 1;
 		goto out;
@@ -7134,7 +7134,7 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 static inline void
 update_nr_migratory(struct task_struct *p, long delta)
@@ -7282,45 +7282,44 @@ EXPORT_SYMBOL(migrate_enable);
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 void migrate_disable(void)
 {
+#ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
 	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
-#endif
 		return;
 	}
-#ifdef CONFIG_SCHED_DEBUG
+
 	if (unlikely(p->migrate_disable_atomic)) {
 		tracing_off();
 		WARN_ON_ONCE(1);
 	}
-#endif
 
 	p->migrate_disable++;
+#endif
+	barrier();
 }
 EXPORT_SYMBOL(migrate_disable);
 
 void migrate_enable(void)
 {
+#ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
 	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
-#endif
 		return;
 	}
 
-#ifdef CONFIG_SCHED_DEBUG
 	if (unlikely(p->migrate_disable_atomic)) {
 		tracing_off();
 		WARN_ON_ONCE(1);
 	}
-#endif
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
+#endif
+	barrier();
 }
 EXPORT_SYMBOL(migrate_enable);
 #endif
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1030,7 +1030,7 @@ void proc_sched_show_task(struct task_st
 		P(dl.runtime);
 		P(dl.deadline);
 	}
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	P(migrate_disable);
 #endif
 	P(nr_cpus_allowed);
