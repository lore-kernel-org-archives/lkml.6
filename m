Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeDWDEo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:04:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753969AbeDWDCk (ORCPT
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
Subject: [PATCH tip/core/rcu 01/21] rcu: Improve non-root rcu_cbs_completed() accuracy
Date: Sun, 22 Apr 2018 20:03:24 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0040-0000-0000-000004207439
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801134;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0041-0000-0000-000008267DAC
Message-Id: <1524452624-27589-1-git-send-email-paulmck@linux.vnet.ibm.com>
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

When rcu_cbs_completed() is invoked on a non-root rcu_node structure,
it unconditionally assumes that two grace periods must complete before
the callbacks at hand can be invoked.  This is overly conservative because
if that non-root rcu_node structure believes that no grace period is in
progress, and if the corresponding rcu_state structure's ->gpnum field
has not yet been incremented, then these callbacks may safely be invoked
after only one grace period has completed.

This change is required to permit grace-period start requests to use
funnel locking, which is in turn permitted to reduce root rcu_node ->lock
contention, which has been observed by Nick Piggin.  Furthermore, such
contention will likely be increased by the merging of RCU-bh, RCU-preempt,
and RCU-sched, so it makes sense to take steps to decrease it.

This commit therefore improves the accuracy of rcu_cbs_completed() when
invoked on a non-root rcu_node structure as described above.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a734692a581..f5ca72f2ed43 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1642,6 +1642,21 @@ static unsigned long rcu_cbs_completed(struct rcu_state *rsp,
 		return rnp->completed + 1;
 
 	/*
+	 * If the current rcu_node structure believes that RCU is
+	 * idle, and if the rcu_state structure does not yet reflect
+	 * the start of a new grace period, then the next grace period
+	 * will suffice.  The memory barrier is needed to accurately
+	 * sample the rsp->gpnum, and pairs with the second lock
+	 * acquisition in rcu_gp_init(), which is augmented with
+	 * smp_mb__after_unlock_lock() for this purpose.
+	 */
+	if (rnp->gpnum == rnp->completed) {
+		smp_mb(); /* See above block comment. */
+		if (READ_ONCE(rsp->gpnum) == rnp->completed)
+			return rnp->completed + 1;
+	}
+
+	/*
 	 * Otherwise, wait for a possible partial grace period and
 	 * then the subsequent full grace period.
 	 */
-- 
2.5.2
