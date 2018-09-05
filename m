Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C411C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5832088E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5832088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIEQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbeIEQ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 606F620879;
        Wed,  5 Sep 2018 12:28:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxWvE-0002Bs-Cf; Wed, 05 Sep 2018 08:28:36 -0400
Message-Id: <20180905122836.291129565@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Sep 2018 08:28:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        joe.korty@concurrent-rt.com
Subject: [PATCH RT 12/22] sched/migrate_disable: fallback to preempt_disable() instead
 barrier()
References: <20180905122754.443196118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 10e90c155bbc7cab420f47694404f8f9fe33c2b2 ]

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
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/preempt.h |  6 +++---
 include/linux/sched.h   |  4 ++--
 kernel/sched/core.c     | 23 +++++++++++------------
 kernel/sched/debug.c    |  2 +-
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 0591df500e9d..6728662a81e8 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -224,7 +224,7 @@ do { \
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 extern void migrate_disable(void);
 extern void migrate_enable(void);
@@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-#define migrate_disable()		barrier()
-#define migrate_enable()		barrier()
+#define migrate_disable()		preempt_disable()
+#define migrate_enable()		preempt_enable()
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c26b5ff005ab..a6ffb552be01 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -626,7 +626,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			cpus_mask;
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
 	int				migrate_disable_update;
 	int				pinned_on_cpu;
@@ -635,8 +635,8 @@ struct task_struct {
 # endif
 
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	int				migrate_disable;
 # ifdef CONFIG_SCHED_DEBUG
+	int				migrate_disable;
 	int				migrate_disable_atomic;
 # endif
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7817c6c44d2..fa5b76255f8c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1107,7 +1107,7 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
@@ -1146,7 +1146,7 @@ static void __do_set_cpus_allowed_tail(struct task_struct *p,
 
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		lockdep_assert_held(&p->pi_lock);
 
@@ -1219,7 +1219,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
 		goto out;
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	if (__migrate_disabled(p)) {
 		p->migrate_disable_update = 1;
 		goto out;
@@ -6897,7 +6897,7 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 
 static inline void
 update_nr_migratory(struct task_struct *p, long delta)
@@ -7048,45 +7048,44 @@ EXPORT_SYMBOL(migrate_enable);
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
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3108da1ee253..b5b43861c2b6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1017,7 +1017,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	P(migrate_disable);
 #endif
 	P(nr_cpus_allowed);
-- 
2.18.0


