Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C317C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504AE204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504AE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJIQlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39772 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeJIQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so1136779wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3R0mCTxrcaG6E+zMbdvov6kOed5ywjre5WnkUzlKbVU=;
        b=V4yaAB6xGKpJBVIau+iafhAvuMEnh8yfMNe+ikMmI2aWlCIQW4kN75T9islC48wGPZ
         7AHpLC/Z6v+0UVn1SAHrHOrWhHv0044GelHUJrI3z9QobaOxe9uZmdJkq6xsGEbzclJG
         rUdx7LLEqUCI2vzC1qz/dqn7jxYY9ILAfznFXH9iNFShlVHI9m5sN1YYJHQUbbc59vO2
         V391kij4dC6DlYrr5vyNpLI+BkdarXDnR13QgLKjBGqKs8Mkb5IfrqzJWYWTMqAqG7f/
         +8EHExm6rn2y8cvkDzR/TLuuDFOwKMLuxMnU7hUYmkBH8p7PRsgAci2/t2AxAPcWchn9
         aLbw==
X-Gm-Message-State: ABuFfoifH554ciF054LLHO5iU5ZOqAH9PxPhaZKHp4/YxduSpSF5AT4n
        n7tcSCyLYIN8p2W1jmWGlwEChA==
X-Google-Smtp-Source: ACcGV623vd4PrZwRTH3ffChMdGU9Q67WSOwPEtslECBTiUyst0FkTHOIMJoJ2P74tTwzA3lNsXER9g==
X-Received: by 2002:a1c:8bcc:: with SMTP id n195-v6mr1332074wmd.118.1539077111048;
        Tue, 09 Oct 2018 02:25:11 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:10 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 4/8] sched: Split scheduler execution context
Date:   Tue,  9 Oct 2018 11:24:30 +0200
Message-Id: <20181009092434.26221-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Lets define the scheduling context as all the scheduler state in
task_struct and the execution context as all state required to run the
task.

Currently both are intertwined in task_struct. We want to logically
split these such that we can run the execution context of one task
with the scheduling context of another.

To this purpose introduce rq::proxy to point to the task_struct used
for scheduler state and preserve rq::curr to denote the execution
context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[added lot of comments/questions - identifiable by XXX]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c  | 62 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/fair.c  |  4 +++
 kernel/sched/sched.h | 30 ++++++++++++++++++++-
 3 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe0223121883..d3c481b734dd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -224,12 +224,13 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 {
 	struct rq *rq = container_of(timer, struct rq, hrtick_timer);
 	struct rq_flags rf;
+	struct task_struct *curr = rq->proxy;
 
 	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	curr->sched_class->task_tick(rq, curr, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -836,13 +837,18 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
+	struct task_struct *curr = rq->proxy;
 	const struct sched_class *class;
 
-	if (p->sched_class == rq->curr->sched_class) {
-		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
+	if (p->sched_class == curr->sched_class) {
+		/*
+		 * XXX check_preempt_curr will check rq->curr against p, looks
+		 * like we want to check rq->proxy against p though?
+		 */
+		curr->sched_class->check_preempt_curr(rq, p, flags);
 	} else {
 		for_each_class(class) {
-			if (class == rq->curr->sched_class)
+			if (class == curr->sched_class)
 				break;
 			if (class == p->sched_class) {
 				resched_curr(rq);
@@ -855,7 +861,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(curr) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -1016,7 +1022,11 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX is changing affinity of a proxy a problem?
+	 * Consider for example put_prev_ set_curr_ below...
+	 */
+	running = task_current_proxy(rq, p);
 
 	if (queued) {
 		/*
@@ -3021,7 +3031,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_proxy(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -3040,8 +3050,9 @@ void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
+	/* accounting goes to the proxy task */
+	struct task_struct *curr = rq->proxy;
 
 	sched_clock_tick();
 
@@ -3096,6 +3107,13 @@ static void sched_tick_remote(struct work_struct *work)
 	if (is_idle_task(curr))
 		goto out_unlock;
 
+	/*
+	 * XXX don't we need to account to rq->proxy?
+	 * Maybe, since this is a remote tick for full dynticks mode, we are
+	 * always sure that there is no proxy (only a single task is running.
+	 */
+	SCHED_WARN_ON(rq->curr != rq->proxy);
+
 	update_rq_clock(rq);
 	delta = rq_clock_task(rq) - curr->se.exec_start;
 
@@ -3804,7 +3822,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX how does (proxy exec) mutexes and RT_mutexes work together?!
+	 */
+	running = task_current_proxy(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -3891,7 +3912,10 @@ void set_user_nice(struct task_struct *p, long nice)
 		goto out_unlock;
 	}
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX see concerns about do_set_cpus_allowed, rt_mutex_prio & Co.
+	 */
+	running = task_current_proxy(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -4318,7 +4342,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	/*
+	 * XXX and again, how is this safe w.r.t. proxy exec?
+	 */
+	running = task_current_proxy(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -4938,6 +4965,11 @@ static void do_sched_yield(void)
 	rq_lock(rq, &rf);
 
 	schedstat_inc(rq->yld_count);
+	/*
+	 * XXX how about proxy exec?
+	 * If a task currently proxied by some other task yields, should we
+	 * apply the proxy or the current yield "behaviour" ?
+	 */
 	current->sched_class->yield_task(rq);
 
 	/*
@@ -5044,6 +5076,10 @@ EXPORT_SYMBOL(yield);
  */
 int __sched yield_to(struct task_struct *p, bool preempt)
 {
+	/*
+	 * XXX what about current being proxied?
+	 * Should we use proxy->sched_class methods in this case?
+	 */
 	struct task_struct *curr = current;
 	struct rq *rq, *p_rq;
 	unsigned long flags;
@@ -5502,7 +5538,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_proxy(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -6351,7 +6387,7 @@ void sched_move_task(struct task_struct *tsk)
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_proxy(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d59307ecd67d..7f8a5dcda923 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9721,6 +9721,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	/*
+	 * XXX need to use execution context (rq->curr) for task_tick_numa and
+	 * update_misfit_status?
+	 */
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 798b1afd5092..287ff248836f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -824,7 +824,8 @@ struct rq {
 	 */
 	unsigned long		nr_uninterruptible;
 
-	struct task_struct	*curr;
+	struct task_struct	*curr;  /* Execution context */
+	struct task_struct	*proxy; /* Scheduling context (policy) */
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1421,11 +1422,38 @@ static inline u64 global_rt_runtime(void)
 	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
 }
 
+/*
+ * Is p the current execution context?
+ */
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
 	return rq->curr == p;
 }
 
+/*
+ * Is p the current scheduling context?
+ *
+ * Note that it might be the current execution context at the same time if
+ * rq->curr == rq->proxy == p.
+ */
+static inline int task_current_proxy(struct rq *rq, struct task_struct *p)
+{
+	return rq->proxy == p;
+}
+
+#ifdef CONFIG_PROXY_EXEC
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return !!p->blocked_on;
+}
+#else /* !PROXY_EXEC */
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	return false;
+}
+
+#endif /* PROXY_EXEC */
+
 static inline int task_running(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
-- 
2.17.1

