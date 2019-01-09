Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C14C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfAIVl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:41:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbfAIVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:41:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Ld5ii052307
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:41:51 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwnayj6yq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:41:51 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:41:50 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:41:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09Lfi1K21430312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:41:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 727AFB205F;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3760BB2066;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0E86D16C63E4; Wed,  9 Jan 2019 13:41:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/8] rcu: Rename rcu_check_callbacks() to rcu_sched_clock_irq()
Date:   Wed,  9 Jan 2019 13:41:36 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214115.GA2835@linux.ibm.com>
References: <20190109214115.GA2835@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0072-0000-0000-000003E73EA2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144149; UDB=6.00595711; IPR=6.00924412;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:41:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0073-0000-0000-00004ABF70CE
Message-Id: <20190109214142.4428-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name rcu_check_callbacks() arguably made sense back in the early
2000s when RCU was quite a bit simpler than it is today, but it has
become quite misleading, especially with the advent of dyntick-idle
and NO_HZ_FULL.  The rcu_check_callbacks() function is RCU's hook into
the scheduling-clock interrupt, and is now but one of many ways that
callbacks get promoted to invocable state.

This commit therefore changes the name to rcu_sched_clock_irq(),
which is the same number of characters and clearly indicates this
function's relation to the rest of the Linux kernel.  In addition, for
the sake of consistency, rcu_flavor_check_callbacks() is also renamed
to rcu_flavor_sched_clock_irq().

While in the area, the header comments for both functions are reworked.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../Tree-RCU-Memory-Ordering.html             |  4 ++--
 .../TreeRCU-callback-invocation.svg           |  2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg |  4 ++--
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg |  2 +-
 include/linux/rcupdate.h                      |  2 +-
 kernel/rcu/tiny.c                             |  2 +-
 kernel/rcu/tree.c                             | 18 +++++++-------
 kernel/rcu/tree.h                             |  2 +-
 kernel/rcu/tree_plugin.h                      | 24 ++++++++-----------
 kernel/time/timer.c                           |  2 +-
 10 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index e4d94fba6c89..a3acfd49255f 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -485,7 +485,7 @@ section that the grace period must wait on.
 noted by <tt>rcu_node_context_switch()</tt> on the left.
 On the other hand, if the CPU takes a scheduler-clock interrupt
 while executing in usermode, a quiescent state will be noted by
-<tt>rcu_check_callbacks()</tt> on the right.
+<tt>rcu_sched_clock_irq()</tt> on the right.
 Either way, the passage through a quiescent state will be noted
 in a per-CPU variable.
 
@@ -651,7 +651,7 @@ to end.
 These callbacks are identified by <tt>rcu_advance_cbs()</tt>,
 which is usually invoked by <tt>__note_gp_changes()</tt>.
 As shown in the diagram below, this invocation can be triggered by
-the scheduling-clock interrupt (<tt>rcu_check_callbacks()</tt> on
+the scheduling-clock interrupt (<tt>rcu_sched_clock_irq()</tt> on
 the left) or by idle entry (<tt>rcu_cleanup_after_idle()</tt> on
 the right, but only for kernels build with
 <tt>CONFIG_RCU_FAST_NO_HZ=y</tt>).
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg
index 832408313d93..3fcf0c17cef2 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg
@@ -349,7 +349,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_check_callbacks()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_sched_clock_irq()</text>
     <rect
        x="7069.6187"
        y="5087.4678"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index acd73c7ad0f4..f0bbe6f8d729 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3902,7 +3902,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_check_callbacks()</text>
+         xml:space="preserve">rcu_sched_clock_irq()</text>
     </g>
     <g
        transform="translate(-850.30204,55463.106)"
@@ -4968,7 +4968,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-19"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_check_callbacks()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_sched_clock_irq()</text>
     <rect
        x="5314.2671"
        y="82817.688"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
index 149bec2a4493..3596ffdd4685 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
@@ -775,7 +775,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_check_callbacks()</text>
+         xml:space="preserve">rcu_sched_clock_irq()</text>
     </g>
     <g
        transform="translate(399.7744,828.86448)"
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d8a8302e21f0..b4e99639d6d4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -89,7 +89,7 @@ static inline int rcu_preempt_depth(void)
 /* Internal to kernel */
 void rcu_init(void);
 extern int rcu_scheduler_active __read_mostly;
-void rcu_check_callbacks(int user);
+void rcu_sched_clock_irq(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 5f5963ba313e..d7a9135b9471 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -76,7 +76,7 @@ void rcu_qs(void)
  * be called from hardirq context.  It is normally called from the
  * scheduling-clock interrupt.
  */
-void rcu_check_callbacks(int user)
+void rcu_sched_clock_irq(int user)
 {
 	if (user) {
 		rcu_qs();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9180158756d2..a79dd51c9cce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1115,7 +1115,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	}
 
 	/*
-	 * NO_HZ_FULL CPUs can run in-kernel without rcu_check_callbacks!
+	 * NO_HZ_FULL CPUs can run in-kernel without rcu_sched_clock_irq!
 	 * The above code handles this, but only for straight cond_resched().
 	 * And some in-kernel loops check need_resched() before calling
 	 * cond_resched(), which defeats the above code for CPUs that are
@@ -2497,14 +2497,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 }
 
 /*
- * Check to see if this CPU is in a non-context-switch quiescent state
- * (user mode or idle loop for rcu, non-softirq execution for rcu_bh).
- * Also schedule RCU core processing.
- *
- * This function must be called from hardirq context.  It is normally
- * invoked from the scheduling-clock interrupt.
+ * This function is invoked from each scheduling-clock interrupt,
+ * and checks to see if this CPU is in a non-context-switch quiescent
+ * state, for example, user mode or idle loop.  It also schedules RCU
+ * core processing.  If the current grace period has gone on too long,
+ * it will ask the scheduler to manufacture a context switch for the sole
+ * purpose of providing a providing the needed quiescent state.
  */
-void rcu_check_callbacks(int user)
+void rcu_sched_clock_irq(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	raw_cpu_inc(rcu_data.ticks_this_gp);
@@ -2517,7 +2517,7 @@ void rcu_check_callbacks(int user)
 		}
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
-	rcu_flavor_check_callbacks(user);
+	rcu_flavor_sched_clock_irq(user);
 	if (rcu_pending())
 		invoke_rcu_core();
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d90b02b53c0e..6562411de80d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -420,7 +420,7 @@ static void rcu_print_detail_task_stall(void);
 static int rcu_print_task_stall(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
-static void rcu_flavor_check_callbacks(int user);
+static void rcu_flavor_sched_clock_irq(int user);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1b3dd2fc0cd6..575671646c60 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -307,7 +307,7 @@ static void rcu_qs(void)
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-		barrier(); /* Coordinate with rcu_flavor_check_callbacks(). */
+		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
 		current->rcu_read_unlock_special.b.need_qs = false;
 	}
 }
@@ -788,13 +788,13 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 }
 
 /*
- * Check for a quiescent state from the current CPU.  When a task blocks,
- * the task is recorded in the corresponding CPU's rcu_node structure,
- * which is checked elsewhere.
- *
- * Caller must disable hard irqs.
+ * Check for a quiescent state from the current CPU, including voluntary
+ * context switches for Tasks RCU.  When a task blocks, the task is
+ * recorded in the corresponding CPU's rcu_node structure, which is checked
+ * elsewhere, hence this function need only check for quiescent states
+ * related to the current CPU, not to those related to tasks.
  */
-static void rcu_flavor_check_callbacks(int user)
+static void rcu_flavor_sched_clock_irq(int user)
 {
 	struct task_struct *t = current;
 
@@ -1088,14 +1088,10 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 }
 
 /*
- * Check to see if this CPU is in a non-context-switch quiescent state
- * (user mode or idle loop for rcu, non-softirq execution for rcu_bh).
- * Also schedule RCU core processing.
- *
- * This function must be called from hardirq context.  It is normally
- * invoked from the scheduling-clock interrupt.
+ * Check to see if this CPU is in a non-context-switch quiescent state,
+ * namely user mode and idle loop.
  */
-static void rcu_flavor_check_callbacks(int user)
+static void rcu_flavor_sched_clock_irq(int user)
 {
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 444156debfa0..6eb7cc4b6d52 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1632,7 +1632,7 @@ void update_process_times(int user_tick)
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
 	run_local_timers();
-	rcu_check_callbacks(user_tick);
+	rcu_sched_clock_irq(user_tick);
 #ifdef CONFIG_IRQ_WORK
 	if (in_irq())
 		irq_work_tick();
-- 
2.17.1

