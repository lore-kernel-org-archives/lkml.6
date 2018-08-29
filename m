Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCAFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCB420658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCB420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeH3BWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:22:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727581AbeH3BWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:22:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLNCYj058637
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:23:20 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7stfh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:23:20 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:23:19 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:23:15 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLNEVH2818414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:23:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BC51B206A;
        Wed, 29 Aug 2018 17:22:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F6FEB206B;
        Wed, 29 Aug 2018 17:22:10 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:22:10 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A451B16C3063; Wed, 29 Aug 2018 14:23:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 1/3] srcu: Make call_srcu() available during very early boot
Date:   Wed, 29 Aug 2018 14:23:11 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829212036.GA22033@linux.vnet.ibm.com>
References: <20180829212036.GA22033@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0040-0000-0000-0000046751FF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080719; UDB=6.00557482; IPR=6.00860704;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:23:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0041-0000-0000-0000086E6BCD
Message-Id: <20180829212313.22903-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event tracing is moving to SRCU in order to take advantage of the fact
that SRCU may be safely used from idle and even offline CPUs.  However,
event tracing can invoke call_srcu() very early in the boot process,
even before workqueue_init_early() is invoked (let alone rcu_init()).
Therefore, call_srcu()'s attempts to queue work fail miserably.

This commit therefore detects this situation, and refrains from attempting
to queue work before rcu_init() time, but does everything else that it
would have done, and in addition, adds the srcu_struct to a global list.
The rcu_init() function now invokes a new srcu_init() function, which
is empty if CONFIG_SRCU=n.  Otherwise, srcu_init() queues work for
each srcu_struct on the list.  This all happens early enough in boot
that there is but a single CPU with interrupts disabled, which allows
synchronization to be dispensed with.

Of course, the queued work won't actually be invoked until after
workqueue_init() is invoked, which happens shortly after the scheduler
is up and running.  This means that although call_srcu() may be invoked
any time after per-CPU variables have been set up, there is still a very
narrow window when synchronize_srcu() won't work, and this window
extends from the time that the scheduler starts until the time that
workqueue_init() returns.  This can be fixed in a manner similar to
the fix for synchronize_rcu_expedited() and friends, but until someone
actually needs to use synchronize_srcu() during this window, this fix
is added churn for no benefit.

Finally, note that Tree SRCU's new srcu_init() function invokes
queue_work() rather than the queue_delayed_work() function that is
invoked post-boot.  The reason is that queue_delayed_work() will (as you
would expect) post a timer, and timers have not yet been initialized.
So use of queue_work() avoids the complaints about use of uninitialized
spinlocks that would otherwise result.  Besides, some delay is already
provide by the aforementioned fact that the queued work won't actually
be invoked until after the scheduler is up and running.

Requested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/srcutiny.h |  2 ++
 include/linux/srcutree.h | 14 ++++++++------
 kernel/rcu/rcu.h         |  6 ++++++
 kernel/rcu/srcutiny.c    | 29 +++++++++++++++++++++++++++--
 kernel/rcu/srcutree.c    | 25 ++++++++++++++++++++++++-
 kernel/rcu/tiny.c        |  1 +
 kernel/rcu/tree.c        |  1 +
 kernel/rcu/update.c      |  9 +++++++++
 8 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index f41d2fb09f87..2b5c0822e683 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -36,6 +36,7 @@ struct srcu_struct {
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
+	struct list_head srcu_boot_entry; /* Early-boot callbacks. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
@@ -48,6 +49,7 @@ void srcu_drive_gp(struct work_struct *wp);
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
 	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
+	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 745d4ca4dd50..9cfa4610113a 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -94,6 +94,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
+	struct list_head srcu_boot_entry;	/* Early-boot callbacks. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
@@ -105,12 +106,13 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN2	2
 
 #define __SRCU_STRUCT_INIT(name, pcpu_name)				\
-	{								\
-		.sda = &pcpu_name,					\
-		.lock = __SPIN_LOCK_UNLOCKED(name.lock),		\
-		.srcu_gp_seq_needed = 0 - 1,				\
-		__SRCU_DEP_MAP_INIT(name)				\
-	}
+{									\
+	.sda = &pcpu_name,						\
+	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
+	.srcu_gp_seq_needed = -1UL,					\
+	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
+	__SRCU_DEP_MAP_INIT(name)					\
+}
 
 /*
  * Define and initialize a srcu struct at build time.
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4d04683c31b2..e1b5aec5ec1c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -435,6 +435,12 @@ do {									\
 
 #endif /* #if defined(SRCU) || !defined(TINY_RCU) */
 
+#ifdef CONFIG_SRCU
+void srcu_init(void);
+#else /* #ifdef CONFIG_SRCU */
+static inline void srcu_init(void) { }
+#endif /* #else #ifdef CONFIG_SRCU */
+
 #ifdef CONFIG_TINY_RCU
 /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
 static inline bool rcu_gp_is_normal(void) { return true; }
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 04fc2ed71af8..d233f0c63f6f 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -34,6 +34,8 @@
 #include "rcu.h"
 
 int rcu_scheduler_active __read_mostly;
+static LIST_HEAD(srcu_boot_list);
+static bool srcu_init_done;
 
 static int init_srcu_struct_fields(struct srcu_struct *sp)
 {
@@ -46,6 +48,7 @@ static int init_srcu_struct_fields(struct srcu_struct *sp)
 	sp->srcu_gp_waiting = false;
 	sp->srcu_idx = 0;
 	INIT_WORK(&sp->srcu_work, srcu_drive_gp);
+	INIT_LIST_HEAD(&sp->srcu_boot_entry);
 	return 0;
 }
 
@@ -179,8 +182,12 @@ void call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
 	*sp->srcu_cb_tail = rhp;
 	sp->srcu_cb_tail = &rhp->next;
 	local_irq_restore(flags);
-	if (!READ_ONCE(sp->srcu_gp_running))
-		schedule_work(&sp->srcu_work);
+	if (!READ_ONCE(sp->srcu_gp_running)) {
+		if (likely(srcu_init_done))
+			schedule_work(&sp->srcu_work);
+		else if (list_empty(&sp->srcu_boot_entry))
+			list_add(&sp->srcu_boot_entry, &srcu_boot_list);
+	}
 }
 EXPORT_SYMBOL_GPL(call_srcu);
 
@@ -204,3 +211,21 @@ void __init rcu_scheduler_starting(void)
 {
 	rcu_scheduler_active = RCU_SCHEDULER_RUNNING;
 }
+
+/*
+ * Queue work for srcu_struct structures with early boot callbacks.
+ * The work won't actually execute until the workqueue initialization
+ * phase that takes place after the scheduler starts.
+ */
+void __init srcu_init(void)
+{
+	struct srcu_struct *sp;
+
+	srcu_init_done = true;
+	while (!list_empty(&srcu_boot_list)) {
+		sp = list_first_entry(&srcu_boot_list,
+				      struct srcu_struct, srcu_boot_entry);
+		list_del_init(&sp->srcu_boot_entry);
+		schedule_work(&sp->srcu_work);
+	}
+}
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6c9866a854b1..e79c1929328f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -51,6 +51,10 @@ module_param(exp_holdoff, ulong, 0444);
 static ulong counter_wrap_check = (ULONG_MAX >> 2);
 module_param(counter_wrap_check, ulong, 0444);
 
+/* Early-boot callback-management, so early that no lock is required! */
+static LIST_HEAD(srcu_boot_list);
+static bool __read_mostly srcu_init_done;
+
 static void srcu_invoke_callbacks(struct work_struct *work);
 static void srcu_reschedule(struct srcu_struct *sp, unsigned long delay);
 static void process_srcu(struct work_struct *work);
@@ -182,6 +186,7 @@ static int init_srcu_struct_fields(struct srcu_struct *sp, bool is_static)
 	mutex_init(&sp->srcu_barrier_mutex);
 	atomic_set(&sp->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&sp->work, process_srcu);
+	INIT_LIST_HEAD(&sp->srcu_boot_entry);
 	if (!is_static)
 		sp->sda = alloc_percpu(struct srcu_data);
 	init_srcu_struct_nodes(sp, is_static);
@@ -701,7 +706,11 @@ static void srcu_funnel_gp_start(struct srcu_struct *sp, struct srcu_data *sdp,
 	    rcu_seq_state(sp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
 		srcu_gp_start(sp);
-		queue_delayed_work(rcu_gp_wq, &sp->work, srcu_get_delay(sp));
+		if (likely(srcu_init_done))
+			queue_delayed_work(rcu_gp_wq, &sp->work,
+					   srcu_get_delay(sp));
+		else if (list_empty(&sp->srcu_boot_entry))
+			list_add(&sp->srcu_boot_entry, &srcu_boot_list);
 	}
 	spin_unlock_irqrestore_rcu_node(sp, flags);
 }
@@ -1308,3 +1317,17 @@ static int __init srcu_bootup_announce(void)
 	return 0;
 }
 early_initcall(srcu_bootup_announce);
+
+void __init srcu_init(void)
+{
+	struct srcu_struct *sp;
+
+	srcu_init_done = true;
+	while (!list_empty(&srcu_boot_list)) {
+		sp = list_first_entry(&srcu_boot_list,
+				      struct srcu_struct, srcu_boot_entry);
+		check_init_srcu_struct(sp);
+		list_del_init(&sp->srcu_boot_entry);
+		queue_work(rcu_gp_wq, &sp->work.work);
+	}
+}
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index befc9321a89c..101ed5bb836c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -236,4 +236,5 @@ void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 	rcu_early_boot_tests();
+	srcu_init();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1369f7..43c806291208 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4164,6 +4164,7 @@ void __init rcu_init(void)
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
+	srcu_init();
 }
 
 #include "tree_exp.h"
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39cb23d22109..7d057d0aaec4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -888,11 +888,16 @@ static void test_callback(struct rcu_head *r)
 	pr_info("RCU test callback executed %d\n", rcu_self_test_counter);
 }
 
+DEFINE_STATIC_SRCU(early_srcu);
+
 static void early_boot_test_call_rcu(void)
 {
 	static struct rcu_head head;
+	static struct rcu_head shead;
 
 	call_rcu(&head, test_callback);
+	if (IS_ENABLED(CONFIG_SRCU))
+		call_srcu(&early_srcu, &shead, test_callback);
 }
 
 static void early_boot_test_call_rcu_bh(void)
@@ -930,6 +935,10 @@ static int rcu_verify_early_boot_tests(void)
 	if (rcu_self_test) {
 		early_boot_test_counter++;
 		rcu_barrier();
+		if (IS_ENABLED(CONFIG_SRCU)) {
+			early_boot_test_counter++;
+			srcu_barrier(&early_srcu);
+		}
 	}
 	if (rcu_self_test_bh) {
 		early_boot_test_counter++;
-- 
2.17.1

