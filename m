Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbeDWDFy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:05:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753957AbeDWDCj (ORCPT
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
Subject: [PATCH tip/core/rcu 09/21] rcu: Make rcu_migrate_callbacks wake GP kthread when needed
Date: Sun, 22 Apr 2018 20:03:32 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0024-0000-0000-0000034CD02F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0025-0000-0000-000047C2E849
Message-Id: <1524452624-27589-9-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcu_migrate_callbacks() function invokes rcu_advance_cbs()
twice, ignoring the return value.  This is OK at pressent because of
failsafe code that does the wakeup when needed.  However, this failsafe
code acquires the root rcu_node structure's lock frequently, while
rcu_migrate_callbacks() does so only once per CPU-offline operation.

This commit therefore makes rcu_migrate_callbacks()
wake up the RCU GP kthread when either call to rcu_advance_cbs()
returns true, thus removing need for the failsafe code.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6ef1f2b4a6d3..f75eb5174021 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3876,6 +3876,7 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 	struct rcu_data *my_rdp;
 	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
 	struct rcu_node *rnp_root = rcu_get_root(rdp->rsp);
+	bool needwake;
 
 	if (rcu_is_nocb_cpu(cpu) || rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
@@ -3887,12 +3888,15 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
-	rcu_advance_cbs(rsp, rnp_root, rdp); /* Leverage recent GPs. */
-	rcu_advance_cbs(rsp, rnp_root, my_rdp); /* Assign GP to pending CBs. */
+	/* Leverage recent GPs and set GP for new callbacks. */
+	needwake = rcu_advance_cbs(rsp, rnp_root, rdp) ||
+		   rcu_advance_cbs(rsp, rnp_root, my_rdp);
 	rcu_segcblist_merge(&my_rdp->cblist, &rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
 	raw_spin_unlock_irqrestore_rcu_node(rnp_root, flags);
+	if (needwake)
+		rcu_gp_kthread_wake(rsp);
 	WARN_ONCE(rcu_segcblist_n_cbs(&rdp->cblist) != 0 ||
 		  !rcu_segcblist_empty(&rdp->cblist),
 		  "rcu_cleanup_dead_cpu: Callbacks on offline CPU %d: qlen=%lu, 1stCB=%p\n",
-- 
2.5.2
