Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeDWDCq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:02:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753905AbeDWDCi (ORCPT
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
Subject: [PATCH tip/core/rcu 04/21] rcu: Make rcu_gp_kthread() check for early-boot activity
Date: Sun, 22 Apr 2018 20:03:27 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-2213-0000-0000-0000029783A1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:02:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-2214-0000-0000-000059DC4067
Message-Id: <1524452624-27589-4-git-send-email-paulmck@linux.vnet.ibm.com>
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

The rcu_gp_kthread() function immediately sleeps waiting to be notified
of the need for a new grace period, which currently works because there
are a number of code sequences that will provide the needed wakeup later.
However, some of these code sequences need to acquire the root rcu_node
structure's ->lock, and contention on that lock has started manifesting.
This commit therefore makes rcu_gp_kthread() check for early-boot activity
when it starts up, omitting the initial sleep in that case.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79fb99951a0c..497f139056c7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2192,6 +2192,12 @@ static int __noreturn rcu_gp_kthread(void *arg)
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
+	/* Check for early-boot work. */
+	raw_spin_lock_irq_rcu_node(rnp);
+	if (need_any_future_gp(rnp))
+		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
+	raw_spin_unlock_irq_rcu_node(rnp);
+
 	rcu_bind_gp_kthread();
 	for (;;) {
 
-- 
2.5.2
