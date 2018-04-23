Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754242AbeDWCfg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:35:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753929AbeDWCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:21 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/22] rcu: Don't allocate rcu_nocb_mask if no one needs it
Date: Sun, 22 Apr 2018 19:32:08 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0052-0000-0000-000002E0B1C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0053-0000-0000-00005C6D822B
Message-Id: <1524450747-22778-3-git-send-email-paulmck@linux.vnet.ibm.com>
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

Commit 44c65ff2e3b0 ("rcu: Eliminate NOCBs CPU-state Kconfig options")
made allocation of rcu_nocb_mask depend only on the rcu_nocbs=,
nohz_full=, or isolcpus= kernel boot parameters.  However, it failed
to change the initial value of rcu_init_nohz()'s local variable
need_rcu_nocb_mask to false, which can result in useless allocation
of an all-zero rcu_nocb_mask.  This commit therefore fixes this bug by
changing the initial value of need_rcu_nocb_mask to false.

While we are in the area, also correct the error message that is printed
when someone specifies that can-never-exist CPUs should be NOCBs CPUs.

Reported-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6c5df18bbf2f..3566e4f6dfcc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2283,7 +2283,7 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = true;
+	bool need_rcu_nocb_mask = false;
 	struct rcu_state *rsp;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -2306,7 +2306,7 @@ void __init rcu_init_nohz(void)
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-		pr_info("\tNote: kernel parameter 'rcu_nocbs=' contains nonexistent CPUs.\n");
+		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
 			    rcu_nocb_mask);
 	}
-- 
2.5.2
