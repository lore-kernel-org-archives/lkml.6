Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeDWCUW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:20:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753926AbeDWCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:20:14 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/3] rcu: exp: Fix "must hold exp_mutex" comments for QS reporting functions
Date: Sun, 22 Apr 2018 19:21:18 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423022047.GA20189@linux.vnet.ibm.com>
References: <20180423022047.GA20189@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0052-0000-0000-000002E0B05D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021884; UDB=6.00521534; IPR=6.00801119;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:20:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0053-0000-0000-00005C6D7CCB
Message-Id: <1524450079-20938-2-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

Since commit d9a3da0699b2 ("rcu: Add expedited grace-period support
for preemptible RCU"), there are comments for some funtions in
rcu_report_exp_rnp()'s call-chain saying that exp_mutex or its
predecessors needs to be held.

However, exp_mutex and its predecessors were used only to synchronize
between GPs, and it is clear that all variables visited by those functions
are under the protection of rcu_node's ->lock. Moreover, those functions
are currently called without held exp_mutex, and seems that doesn't
introduce any trouble.

So this patch fixes this problem by updating the comments to match the
current code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Fixes: d9a3da0699b2 ("rcu: Add expedited grace-period support for preemptible RCU")
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_exp.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 73e1d3dca5b1..d7622cb85aa7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -154,7 +154,7 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
  * for the current expedited grace period.  Works only for preemptible
  * RCU -- other RCU implementation use other means.
  *
- * Caller must hold the rcu_state's exp_mutex.
+ * Caller must hold the specificed rcu_node structure's ->lock
  */
 static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
 {
@@ -170,8 +170,7 @@ static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
  * recursively up the tree.  (Calm down, calm down, we do the recursion
  * iteratively!)
  *
- * Caller must hold the rcu_state's exp_mutex and the specified rcu_node
- * structure's ->lock.
+ * Caller must hold the specified rcu_node structure's ->lock.
  */
 static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 				 bool wake, unsigned long flags)
@@ -207,8 +206,6 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 /*
  * Report expedited quiescent state for specified node.  This is a
  * lock-acquisition wrapper function for __rcu_report_exp_rnp().
- *
- * Caller must hold the rcu_state's exp_mutex.
  */
 static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
 					      struct rcu_node *rnp, bool wake)
@@ -221,8 +218,7 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
 
 /*
  * Report expedited quiescent state for multiple CPUs, all covered by the
- * specified leaf rcu_node structure.  Caller must hold the rcu_state's
- * exp_mutex.
+ * specified leaf rcu_node structure.
  */
 static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 				    unsigned long mask, bool wake)
-- 
2.5.2
