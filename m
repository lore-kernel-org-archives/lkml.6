Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754250AbeDWCfd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:35:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753938AbeDWCbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:22 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Yury Norov <ynorov@caviumnetworks.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/22] rcu: Declare rcu_eqs_special_set() in public header
Date: Sun, 22 Apr 2018 19:32:15 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0036-0000-0000-000002E8AF7C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0037-0000-0000-00004414FD95
Message-Id: <1524450747-22778-10-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Yury Norov <ynorov@caviumnetworks.com>

Because rcu_eqs_special_set() is declared only in internal header
kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h, it is
inaccessible outside of the RCU implementation.  This patch therefore
moves the  rcu_eqs_special_set() declaration to include/linux/rcutree.h,
which allows it to be used in non-rcu kernel code.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcutree.h | 1 +
 kernel/rcu/tree.h       | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..448f20f27396 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
 void rcu_barrier(void);
 void rcu_barrier_bh(void);
 void rcu_barrier_sched(void);
+bool rcu_eqs_special_set(int cpu);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 unsigned long get_state_synchronize_sched(void);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 5fd374c71404..0b3a90ebe225 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -404,7 +404,6 @@ extern struct rcu_state rcu_preempt_state;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
 int rcu_dynticks_snap(struct rcu_dynticks *rdtp);
-bool rcu_eqs_special_set(int cpu);
 
 #ifdef CONFIG_RCU_BOOST
 DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
-- 
2.5.2
