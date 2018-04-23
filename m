Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeDWCbm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:31:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753987AbeDWCbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:25 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 22/22] rcu: Use the proper lockdep annotation in dump_blkd_tasks()
Date: Sun, 22 Apr 2018 19:32:27 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-2213-0000-0000-0000029781B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-2214-0000-0000-000059DC334D
Message-Id: <1524450747-22778-22-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Boqun Feng <boqun.feng@gmail.com>

Sparse reported this:

| kernel/rcu/tree_plugin.h:814:9: warning: incorrect type in argument 1 (different modifiers)
| kernel/rcu/tree_plugin.h:814:9:    expected struct lockdep_map const *lock
| kernel/rcu/tree_plugin.h:814:9:    got struct lockdep_map [noderef] *<noident>

This is caused by using vanilla lockdep annotations on rcu_node::lock,
and that requires accessing ->lock of rcu_node directly. However we need
to keep rcu_node::lock __private to avoid breaking its extra ordering
guarantee. And we have a dedicated lockdep annotation for
rcu_node::lock, so use it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8014a09a5c9b..52bd92acbe6b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -855,7 +855,7 @@ static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	int i;
 	struct list_head *lhp;
 
-	lockdep_assert_held(&rnp->lock);
+	raw_lockdep_assert_held_rcu_node(rnp);
 	pr_info("%s: grp: %d-%d level: %d ->qamask %#lx ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->qsmask, rnp->gp_tasks, rnp->boost_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
 	pr_cont("\t->blkd_tasks");
 	i = 0;
-- 
2.5.2
