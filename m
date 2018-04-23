Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDWDCo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:02:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753911AbeDWDCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:38 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/21] rcu: Avoid __call_rcu_core() root rcu_node ->lock acquisition
Date: Sun, 22 Apr 2018 20:03:33 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-2213-0000-0000-0000029783A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-2214-0000-0000-000059DC406F
Message-Id: <1524452624-27589-10-git-send-email-paulmck@linux.vnet.ibm.com>
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

When __call_rcu_core() notices excessive numbers of callbacks pending
on the current CPU, we know that at least one of them is not yet
classified, namely the one that was just now queued.  Therefore, it
is not necessary to invoke rcu_start_gp() and thus not necessary to
acquire the root rcu_node structure's ->lock.  This commit therefore
replaces the rcu_start_gp() with rcu_accelerate_cbs(), thus replacing
an acquisition of the root rcu_node structure's ->lock with that of
this CPU's leaf rcu_node structure.

This decreases contention on the root rcu_node structure's ->lock.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f75eb5174021..6396a3d10be9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2988,11 +2988,11 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 
 		/* Start a new grace period if one not already started. */
 		if (!rcu_gp_in_progress(rsp)) {
-			struct rcu_node *rnp_root = rcu_get_root(rsp);
+			struct rcu_node *rnp = rdp->mynode;
 
-			raw_spin_lock_rcu_node(rnp_root);
-			needwake = rcu_start_gp(rsp);
-			raw_spin_unlock_rcu_node(rnp_root);
+			raw_spin_lock_rcu_node(rnp);
+			needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+			raw_spin_unlock_rcu_node(rnp);
 			if (needwake)
 				rcu_gp_kthread_wake(rsp);
 		} else {
-- 
2.5.2
