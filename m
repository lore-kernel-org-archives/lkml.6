Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEFFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147B0206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfAIVpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:45:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfAIVpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:45:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Ld6tf062346
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:45:37 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn7ptpuk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:45:37 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:45:37 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:45:31 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LjUR125166010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:45:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DA88B2066;
        Wed,  9 Jan 2019 21:45:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0084DB2064;
        Wed,  9 Jan 2019 21:45:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:45:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C92B216C63E4; Wed,  9 Jan 2019 13:45:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/2] srcu: Remove srcu_queue_delayed_work_on()
Date:   Wed,  9 Jan 2019 13:45:28 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214506.GA4747@linux.ibm.com>
References: <20190109214506.GA4747@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0064-0000-0000-000003941227
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144151; UDB=6.00595712; IPR=6.00924413;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:45:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0065-0000-0000-00003BF96B65
Message-Id: <20190109214528.5264-2-paulmck@linux.ibm.com>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/srcutree.h |  3 ++-
 kernel/rcu/srcutree.c    | 55 ++++++++++++++++++----------------------
 kernel/rcu/tree.c        |  4 ---
 kernel/rcu/tree.h        |  8 ------
 4 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6f292bd3e7db..0faa978c9880 100644
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
index 3600d88d8956..7f041f2435df 100644
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
-}
+	struct srcu_data *sdp = container_of(t, struct srcu_data, delay_work);
 
-void srcu_offline_cpu(unsigned int cpu)
-{
-	WRITE_ONCE(per_cpu(srcu_online, cpu), false);
+	queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 }
 
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
index 9180158756d2..b8049bfd3e8a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3329,8 +3329,6 @@ int rcutree_online_cpu(unsigned int cpu)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->ffmask |= rdp->grpmask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	if (IS_ENABLED(CONFIG_TREE_SRCU))
-		srcu_online_cpu(cpu);
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
@@ -3355,8 +3353,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
-	if (IS_ENABLED(CONFIG_TREE_SRCU))
-		srcu_offline_cpu(cpu);
 	return 0;
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d90b02b53c0e..44c5657e46ac 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -462,11 +462,3 @@ static void rcu_bind_gp_kthread(void);
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
2.17.1

