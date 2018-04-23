Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeDWCbw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:31:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753983AbeDWCbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:24 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 16/22] EXP: rcu: Add debugging info to assertion
Date: Sun, 22 Apr 2018 19:32:21 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-2213-0000-0000-0000029781B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-2214-0000-0000-000059DC334B
Message-Id: <1524450747-22778-16-git-send-email-paulmck@linux.vnet.ibm.com>
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

The WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp()) in
rcu_gp_cleanup() triggers (inexplicably, of course) every so often.
This commit therefore extracts more information.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 08b72dd02d88..6ad2ac34558f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2147,7 +2147,22 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	 */
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
-		WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp));
+#ifdef CONFIG_PREEMPT_RCU
+		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp))) {
+			int i;
+			struct task_struct *t;
+
+			pr_info("%s: grp: %d-%d level: %d ->gp_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->gp_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
+			pr_cont("\t->blkd_tasks");
+			i = 0;
+			list_for_each_entry(t, &rnp->blkd_tasks, rcu_node_entry) {
+				pr_cont(" %p", t);
+				if (++i >= 10)
+					break;
+			}
+			pr_cont("\n");
+		}
+#endif /* #ifdef CONFIG_PREEMPT_RCU */
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->completed, rsp->gpnum);
 		rdp = this_cpu_ptr(rsp->rda);
-- 
2.5.2
