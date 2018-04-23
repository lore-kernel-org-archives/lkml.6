Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeDWDGE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:06:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753953AbeDWDCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:39 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 08/21] rcu: Convert ->need_future_gp[] array to boolean
Date: Sun, 22 Apr 2018 20:03:31 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0052-0000-0000-000002E0B3AE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0053-0000-0000-00005C6D8F39
Message-Id: <1524452624-27589-8-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no longer any need for ->need_future_gp[] to count the number of
requests for future grace periods, so this commit converts the additions
to assignments to "true" and reduces the size of each element to one byte.
While we are in the area, fix an obsolete comment.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 6 +++---
 kernel/rcu/tree.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b05ab6379562..6ef1f2b4a6d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1709,7 +1709,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * current grace period, we don't need to explicitly start one.
 	 */
 	if (rnp->gpnum != rnp->completed) {
-		need_future_gp_element(rnp, c)++;
+		need_future_gp_element(rnp, c) = true;
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedleaf"));
 		goto out;
 	}
@@ -1741,7 +1741,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	}
 
 	/* Record the need for the future grace period. */
-	need_future_gp_element(rnp_root, c)++;
+	need_future_gp_element(rnp_root, c) = true;
 
 	/* If a grace period is not already in progress, start one. */
 	if (rnp_root->gpnum != rnp_root->completed) {
@@ -1769,7 +1769,7 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
-	need_future_gp_element(rnp, c) = 0;
+	need_future_gp_element(rnp, c) = false;
 	needmore = need_any_future_gp(rnp);
 	trace_rcu_future_gp(rnp, rdp, c,
 			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 123c30eac8b5..9f97fd7f648c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -150,7 +150,7 @@ struct rcu_node {
 	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
-	int need_future_gp[4];	/* Counts of upcoming no-CB GP requests. */
+	u8 need_future_gp[4];	/* Counts of upcoming GP requests. */
 	raw_spinlock_t fqslock ____cacheline_internodealigned_in_smp;
 
 	spinlock_t exp_lock ____cacheline_internodealigned_in_smp;
-- 
2.5.2
