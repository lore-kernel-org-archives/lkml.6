Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeDWDFb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:05:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753964AbeDWDCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:02:40 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/21] rcu: Make rcu_start_future_gp()'s grace-period check more precise
Date: Sun, 22 Apr 2018 20:03:25 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0024-0000-0000-0000034CD02E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0025-0000-0000-000047C2E846
Message-Id: <1524452624-27589-2-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcu_start_future_gp() function uses a sloppy check for a grace
period being in progress, which works today because there are a number
of code sequences that resolve the resulting races.  However, some of
these race-resolution code sequences must acquire the root rcu_node
structure's ->lock, and contention on that lock has started manifesting.
This commit therefore makes rcu_start_future_gp() check more precise,
eliminating the sloppy lockless check of the rcu_state structure's ->gpnum
and ->completed fields.  The effect is that rcu_start_future_gp() will
sometimes unnecessarily attempt to start a new grace period, but this
overhead will be reduced later using funnel locking.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f5ca72f2ed43..4bbba17422cd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1705,20 +1705,12 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	}
 
 	/*
-	 * If either this rcu_node structure or the root rcu_node structure
-	 * believe that a grace period is in progress, then we must wait
-	 * for the one following, which is in "c".  Because our request
-	 * will be noticed at the end of the current grace period, we don't
-	 * need to explicitly start one.  We only do the lockless check
-	 * of rnp_root's fields if the current rcu_node structure thinks
-	 * there is no grace period in flight, and because we hold rnp->lock,
-	 * the only possible change is when rnp_root's two fields are
-	 * equal, in which case rnp_root->gpnum might be concurrently
-	 * incremented.  But that is OK, as it will just result in our
-	 * doing some extra useless work.
+	 * If this rcu_node structure believes that a grace period is in
+	 * progress, then we must wait for the one following, which is in
+	 * "c".  Because our request will be noticed at the end of the
+	 * current grace period, we don't need to explicitly start one.
 	 */
-	if (rnp->gpnum != rnp->completed ||
-	    READ_ONCE(rnp_root->gpnum) != READ_ONCE(rnp_root->completed)) {
+	if (rnp->gpnum != rnp->completed) {
 		rnp->need_future_gp[c & 0x1]++;
 		trace_rcu_future_gp(rnp, rdp, c, TPS("Startedleaf"));
 		goto out;
-- 
2.5.2
