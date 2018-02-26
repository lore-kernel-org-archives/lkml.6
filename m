Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBZVx7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:53:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751889AbeBZVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:54 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 20/20] rcu: Create RCU-specific workqueues with rescuers
Date: Mon, 26 Feb 2018 13:53:10 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5BDB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE65EB
Message-Id: <1519681990-31349-20-git-send-email-paulmck@linux.vnet.ibm.com>
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

RCU's expedited grace periods can participate in out-of-memory deadlocks
due to all available system_wq kthreads being blocked and there not being
memory available to create more.  This commit prevents such deadlocks
by allocating an RCU-specific workqueue_struct at early boot time, and
providing it with a rescuer to ensure forward progress.  This uses the
shiny new init_rescuer() function provided by Tejun (but indirectly).

This commit also causes SRCU to use this new RCU-specific
workqueue_struct.  Note that SRCU's use of workqueues never blocks them
waiting for readers, so this should be safe from a forward-progress
viewpoint.  Note that this moves SRCU from system_power_efficient_wq
to a normal workqueue.  In the unlikely event that this results in
measurable degradation, a separate power-efficient workqueue will be
creates for SRCU.

Reported-by: Prateek Sood <prsood@codeaurora.org>
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/rcu/rcu.h      | 1 +
 kernel/rcu/srcutree.c | 8 +++-----
 kernel/rcu/tree.c     | 6 ++++++
 kernel/rcu/tree_exp.h | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 1c868bcfd705..7a693e31184a 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -485,6 +485,7 @@ void show_rcu_gp_kthreads(void);
 void rcu_force_quiescent_state(void);
 void rcu_bh_force_quiescent_state(void);
 void rcu_sched_force_quiescent_state(void);
+extern struct workqueue_struct *rcu_gp_wq;
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 045b559b9f22..743d18379256 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -492,8 +492,7 @@ static bool srcu_queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
  */
 static void srcu_schedule_cbs_sdp(struct srcu_data *sdp, unsigned long delay)
 {
-	srcu_queue_delayed_work_on(sdp->cpu, system_power_efficient_wq,
-				   &sdp->work, delay);
+	srcu_queue_delayed_work_on(sdp->cpu, rcu_gp_wq, &sdp->work, delay);
 }
 
 /*
@@ -691,8 +690,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *sp, struct srcu_data *sdp,
 	    rcu_seq_state(sp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
 		srcu_gp_start(sp);
-		queue_delayed_work(system_power_efficient_wq, &sp->work,
-				   srcu_get_delay(sp));
+		queue_delayed_work(rcu_gp_wq, &sp->work, srcu_get_delay(sp));
 	}
 	spin_unlock_irqrestore_rcu_node(sp, flags);
 }
@@ -1225,7 +1223,7 @@ static void srcu_reschedule(struct srcu_struct *sp, unsigned long delay)
 	spin_unlock_irq_rcu_node(sp);
 
 	if (pushgp)
-		queue_delayed_work(system_power_efficient_wq, &sp->work, delay);
+		queue_delayed_work(rcu_gp_wq, &sp->work, delay);
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 99d404c6bbbb..2a734692a581 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4167,6 +4167,8 @@ static void __init rcu_dump_rcu_node_tree(struct rcu_state *rsp)
 	pr_cont("\n");
 }
 
+struct workqueue_struct *rcu_gp_wq;
+
 void __init rcu_init(void)
 {
 	int cpu;
@@ -4193,6 +4195,10 @@ void __init rcu_init(void)
 		rcu_cpu_starting(cpu);
 		rcutree_online_cpu(cpu);
 	}
+
+	/* Create workqueue for expedited GPs and for Tree SRCU. */
+	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_gp_wq);
 }
 
 #include "tree_exp.h"
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6ad87642f44a..f72eefab8543 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -626,7 +626,7 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 		rew.rew_rsp = rsp;
 		rew.rew_s = s;
 		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
-		schedule_work(&rew.rew_work);
+		queue_work(rcu_gp_wq, &rew.rew_work);
 	}
 
 	/* Wait for expedited grace period to complete. */
-- 
2.5.2
