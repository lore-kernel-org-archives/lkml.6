Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBZVy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751857AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/20] rcu: Remove obsolete __rcu_pending() statistics for debugfs
Date: Mon, 26 Feb 2018 13:52:59 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0056-0000-0000-0000042458A5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0057-0000-0000-00000866621D
Message-Id: <1519681990-31349-9-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs interface displayed statistics on RCU-pending checks
but this interface has since been removed.  This commit therefore
removes the no-longer-used rcu_data structure's ->n_rcu_pending,
->n_rp_core_needs_qs, ->n_rp_report_qs, ->n_rp_cb_ready,
->n_rp_cpu_needs_gp, ->n_rp_gp_completed, ->n_rp_gp_started,
->n_rp_nocb_defer_wakeup, and ->n_rp_need_nothing fields along with
their updates.

If this information proves necessary in the future, the corresponding
event traces will be added.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 31 ++++++-------------------------
 kernel/rcu/tree.h | 17 +++--------------
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e0711954bbf..99d59be761d1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3354,8 +3354,6 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	rdp->n_rcu_pending++;
-
 	/* Check for CPU stalls, if enabled. */
 	check_cpu_stall(rsp, rdp);
 
@@ -3364,48 +3362,31 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
-	if (rcu_scheduler_fully_active &&
-	    rdp->core_needs_qs && rdp->cpu_no_qs.b.norm &&
-	    rdp->rcu_qs_ctr_snap == __this_cpu_read(rcu_dynticks.rcu_qs_ctr)) {
-		rdp->n_rp_core_needs_qs++;
-	} else if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm) {
-		rdp->n_rp_report_qs++;
+	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
 		return 1;
-	}
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
-		rdp->n_rp_cb_ready++;
+	if (rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
-	}
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-	if (cpu_needs_another_gp(rsp, rdp)) {
-		rdp->n_rp_cpu_needs_gp++;
+	if (cpu_needs_another_gp(rsp, rdp))
 		return 1;
-	}
 
 	/* Has another RCU grace period completed?  */
-	if (READ_ONCE(rnp->completed) != rdp->completed) { /* outside lock */
-		rdp->n_rp_gp_completed++;
+	if (READ_ONCE(rnp->completed) != rdp->completed) /* outside lock */
 		return 1;
-	}
 
 	/* Has a new RCU grace period started? */
 	if (READ_ONCE(rnp->gpnum) != rdp->gpnum ||
-	    unlikely(READ_ONCE(rdp->gpwrap))) { /* outside lock */
-		rdp->n_rp_gp_started++;
+	    unlikely(READ_ONCE(rdp->gpwrap))) /* outside lock */
 		return 1;
-	}
 
 	/* Does this CPU need a deferred NOCB wakeup? */
-	if (rcu_nocb_need_deferred_wakeup(rdp)) {
-		rdp->n_rp_nocb_defer_wakeup++;
+	if (rcu_nocb_need_deferred_wakeup(rdp))
 		return 1;
-	}
 
 	/* nothing to do */
-	rdp->n_rp_need_nothing++;
 	return 0;
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b258fac73524..d29bab8dea28 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -226,18 +226,7 @@ struct rcu_data {
 					/* Grace period that needs help */
 					/*  from cond_resched(). */
 
-	/* 5) __rcu_pending() statistics. */
-	unsigned long n_rcu_pending;	/* rcu_pending() calls since boot. */
-	unsigned long n_rp_core_needs_qs;
-	unsigned long n_rp_report_qs;
-	unsigned long n_rp_cb_ready;
-	unsigned long n_rp_cpu_needs_gp;
-	unsigned long n_rp_gp_completed;
-	unsigned long n_rp_gp_started;
-	unsigned long n_rp_nocb_defer_wakeup;
-	unsigned long n_rp_need_nothing;
-
-	/* 6) _rcu_barrier(), OOM callbacks, and expediting. */
+	/* 5) _rcu_barrier(), OOM callbacks, and expediting. */
 	struct rcu_head barrier_head;
 #ifdef CONFIG_RCU_FAST_NO_HZ
 	struct rcu_head oom_head;
@@ -248,7 +237,7 @@ struct rcu_data {
 	atomic_long_t exp_workdone3;	/* # done by others #3. */
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
-	/* 7) Callback offloading. */
+	/* 6) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct rcu_head *nocb_head;	/* CBs waiting for kthread. */
 	struct rcu_head **nocb_tail;
@@ -275,7 +264,7 @@ struct rcu_data {
 					/* Leader CPU takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-	/* 8) RCU CPU stall data. */
+	/* 7) RCU CPU stall data. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
-- 
2.5.2
