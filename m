Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A2CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2C820811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2C820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLKLMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:12:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37981 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeLKLMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:12:55 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gWfy4-0001p4-2V; Tue, 11 Dec 2018 12:12:48 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] srcu: Remove srcu_queue_delayed_work_on()
Date:   Tue, 11 Dec 2018 12:12:38 +0100
Message-Id: <20181211111238.13474-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

srcu_queue_delayed_work_on() disables preemption (and therefore CPU
hotplug in RCU's case) and then checks based on its own accounting if a
CPU is online. If the CPU is online it uses queue_delayed_work_on()
otherwise it fallbacks to queue_delayed_work().
The problem here is that queue_work() on -RT does not work with disabled
preemption.

queue_work_on() works also on an offlined CPU. queue_delayed_work_on()
has the problem that it is possible to program a timer on an offlined
CPU. This timer will fire once the CPU is online again. But until then,
the timer remains programmed and nothing will happen.

Add a local timer which will fire (as requested per delay) on the local
CPU and then enqueue the work on the specific CPU.

RCUtorture testing with SRCU-P for 24h showed no problems.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/srcutree.h |  3 ++-
 kernel/rcu/srcutree.c    | 57 ++++++++++++++++++----------------------
 kernel/rcu/tree.c        |  4 ---
 kernel/rcu/tree.h        |  8 ------
 4 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6f292bd3e7db7..0faa978c98807 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -45,7 +45,8 @@ struct srcu_data {
 	unsigned long srcu_gp_seq_needed;	/* Furthest future GP needed. */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	bool srcu_cblist_invoking;		/* Invoking these CBs? */
-	struct delayed_work work;		/* Context for CB invoking. */
+	struct timer_list delay_work;		/* Delay for CB invoking */
+	struct work_struct work;		/* Context for CB invoking. */
 	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
 	struct srcu_node *mynode;		/* Leaf srcu_node. */
 	unsigned long grpmask;			/* Mask for leaf srcu_node */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3600d88d8956b..7f041f2435df9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -58,6 +58,7 @@ static bool __read_mostly srcu_init_done;
 static void srcu_invoke_callbacks(struct work_struct *work);
 static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
 static void process_srcu(struct work_struct *work);
+static void srcu_delay_timer(struct timer_list *t);
 
 /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
 #define spin_lock_rcu_node(p)					\
@@ -156,7 +157,8 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 			snp->grphi = cpu;
 		}
 		sdp->cpu = cpu;
-		INIT_DELAYED_WORK(&sdp->work, srcu_invoke_callbacks);
+		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
+		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
 		if (is_static)
@@ -386,13 +388,19 @@ void _cleanup_srcu_struct(struct srcu_struct *ssp, bool quiesced)
 	} else {
 		flush_delayed_work(&ssp->work);
 	}
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
+
 		if (quiesced) {
-			if (WARN_ON(delayed_work_pending(&per_cpu_ptr(ssp->sda, cpu)->work)))
+			if (WARN_ON(timer_pending(&sdp->delay_work)))
+				return; /* Just leak it! */
+			if (WARN_ON(work_pending(&sdp->work)))
 				return; /* Just leak it! */
 		} else {
-			flush_delayed_work(&per_cpu_ptr(ssp->sda, cpu)->work);
+			del_timer_sync(&sdp->delay_work);
+			flush_work(&sdp->work);
 		}
+	}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
 		pr_info("%s: Active srcu_struct %p state: %d\n",
@@ -463,39 +471,23 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
 }
 
-/*
- * Track online CPUs to guide callback workqueue placement.
- */
-DEFINE_PER_CPU(bool, srcu_online);
 
-void srcu_online_cpu(unsigned int cpu)
+static void srcu_delay_timer(struct timer_list *t)
 {
-	WRITE_ONCE(per_cpu(srcu_online, cpu), true);
+	struct srcu_data *sdp = container_of(t, struct srcu_data, delay_work);
+
+	queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 }
 
-void srcu_offline_cpu(unsigned int cpu)
-{
-	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
-}
-
-/*
- * Place the workqueue handler on the specified CPU if online, otherwise
- * just run it whereever.  This is useful for placing workqueue handlers
- * that are to invoke the specified CPU's callbacks.
- */
-static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
-				       struct delayed_work *dwork,
+static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
 				       unsigned long delay)
 {
-	bool ret;
+	if (!delay) {
+		queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
+		return;
+	}
 
-	preempt_disable();
-	if (READ_ONCE(per_cpu(srcu_online, cpu)))
-		ret = queue_delayed_work_on(cpu, wq, dwork, delay);
-	else
-		ret = queue_delayed_work(wq, dwork, delay);
-	preempt_enable();
-	return ret;
+	timer_reduce(&sdp->delay_work, jiffies + delay);
 }
 
 /*
@@ -504,7 +496,7 @@ static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
  */
 static void srcu_schedule_cbs_sdp(struct srcu_data *sdp, unsigned long delay)
 {
-	srcu_queue_delayed_work_on(sdp->cpu, rcu_gp_wq, &sdp->work, delay);
+	srcu_queue_delayed_work_on(sdp, delay);
 }
 
 /*
@@ -1186,7 +1178,8 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	struct srcu_data *sdp;
 	struct srcu_struct *ssp;
 
-	sdp = container_of(work, struct srcu_data, work.work);
+	sdp = container_of(work, struct srcu_data, work);
+
 	ssp = sdp->ssp;
 	rcu_cblist_init(&ready_cbs);
 	spin_lock_irq_rcu_node(sdp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index be67a1bcba1da..86538c72cae90 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3361,8 +3361,6 @@ int rcutree_online_cpu(unsigned int cpu)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->ffmask |= rdp->grpmask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	if (IS_ENABLED(CONFIG_TREE_SRCU))
-		srcu_online_cpu(cpu);
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
@@ -3387,8 +3385,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
-	if (IS_ENABLED(CONFIG_TREE_SRCU))
-		srcu_offline_cpu(cpu);
 	return 0;
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 0ab060c8e9a71..e27fb27e087df 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -456,11 +456,3 @@ static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
-
-#ifdef CONFIG_SRCU
-void srcu_online_cpu(unsigned int cpu);
-void srcu_offline_cpu(unsigned int cpu);
-#else /* #ifdef CONFIG_SRCU */
-void srcu_online_cpu(unsigned int cpu) { }
-void srcu_offline_cpu(unsigned int cpu) { }
-#endif /* #else #ifdef CONFIG_SRCU */
-- 
2.20.0.rc2

