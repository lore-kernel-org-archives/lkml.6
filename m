Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDWCdB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753960AbeDWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:23 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/22] rcu: Remove deprecated RCU debugfs tracing code
Date: Sun, 22 Apr 2018 19:32:10 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0056-0000-0000-0000044375FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0057-0000-0000-000008877F31
Message-Id: <1524450747-22778-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Byungchul Park <byungchul.park@lge.com>

Commit ae91aa0adb14 ("rcu: Remove debugfs tracing") removed the
RCU debugfs tracing code, but did not remove the no-longer used
->exp_workdone{0,1,2,3} fields in the srcu_data structure.  This commit
therefore removes these fields along with the code that uselessly
updates them.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h     |  4 ----
 kernel/rcu/tree_exp.h | 13 +++++--------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3a0dc30100e8..5fd374c71404 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -224,10 +224,6 @@ struct rcu_data {
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
index f72eefab8543..f512dd4e57a8 100644
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
@@ -633,7 +630,7 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	rdp = per_cpu_ptr(rsp->rda, raw_smp_processor_id());
 	rnp = rcu_get_root(rsp);
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-		   sync_exp_work_done(rsp, &rdp->exp_workdone0, s));
+		   sync_exp_work_done(rsp, s));
 	smp_mb(); /* Workqueue actions happen before return. */
 
 	/* Let the next expedited grace period start. */
-- 
2.5.2
