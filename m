Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936197AbeCBHkD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:40:03 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:57456 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935717AbeCBHkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:40:02 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH] rcu: Remove deprecated RCU debugfs tracing code
Date: Fri,  2 Mar 2018 16:39:12 +0900
Message-Id: <1519976352-25400-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ae91aa0adb14(rcu: Remove debugfs tracing) removed the RCU debugfs
tracing code, and left deprecated code.

Because exp_workdone{0,1,2,3} won't be used anymore since the commit,
it's better to remove code to do with those variables. Remove it.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.h     |  4 ----
 kernel/rcu/tree_exp.h | 13 +++++--------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9dd0ea7..cfeb351 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -234,10 +234,6 @@ struct rcu_data {
 #ifdef CONFIG_RCU_FAST_NO_HZ
 	struct rcu_head oom_head;
 #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-	atomic_long_t exp_workdone0;	/* # done by workqueue. */
-	atomic_long_t exp_workdone1;	/* # done by others #1. */
-	atomic_long_t exp_workdone2;	/* # done by others #2. */
-	atomic_long_t exp_workdone3;	/* # done by others #3. */
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
 	/* 6) Callback offloading. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 73e1d3d..f8e4571 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -248,14 +248,12 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp,
 }
 
 /* Common code for synchronize_{rcu,sched}_expedited() work-done checking. */
-static bool sync_exp_work_done(struct rcu_state *rsp, atomic_long_t *stat,
-			       unsigned long s)
+static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
 {
 	if (rcu_exp_gp_seq_done(rsp, s)) {
 		trace_rcu_exp_grace_period(rsp->name, s, TPS("done"));
 		/* Ensure test happens before caller kfree(). */
 		smp_mb__before_atomic(); /* ^^^ */
-		atomic_long_inc(stat);
 		return true;
 	}
 	return false;
@@ -289,7 +287,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 	 * promoting locality and is not strictly needed for correctness.
 	 */
 	for (; rnp != NULL; rnp = rnp->parent) {
-		if (sync_exp_work_done(rsp, &rdp->exp_workdone1, s))
+		if (sync_exp_work_done(rsp, s))
 			return true;
 
 		/* Work not done, either wait here or go up. */
@@ -302,8 +300,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 						  rnp->grplo, rnp->grphi,
 						  TPS("wait"));
 			wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-				   sync_exp_work_done(rsp,
-						      &rdp->exp_workdone2, s));
+				   sync_exp_work_done(rsp, s));
 			return true;
 		}
 		rnp->exp_seq_rq = s; /* Followers can wait on us. */
@@ -313,7 +310,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 	}
 	mutex_lock(&rsp->exp_mutex);
 fastpath:
-	if (sync_exp_work_done(rsp, &rdp->exp_workdone3, s)) {
+	if (sync_exp_work_done(rsp, s)) {
 		mutex_unlock(&rsp->exp_mutex);
 		return true;
 	}
@@ -661,7 +658,7 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	rdp = per_cpu_ptr(rsp->rda, raw_smp_processor_id());
 	rnp = rcu_get_root(rsp);
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-		   sync_exp_work_done(rsp, &rdp->exp_workdone0, s));
+		   sync_exp_work_done(rsp, s));
 	smp_mb(); /* Workqueue actions happen before return. */
 
 	/* Let the next expedited grace period start. */
-- 
1.9.1
