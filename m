Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeDWCfj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:35:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753935AbeDWCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:21 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH tip/core/rcu 07/22] softirq: Eliminate unused cond_resched_softirq() macro
Date: Sun, 22 Apr 2018 19:32:12 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0056-0000-0000-0000044375FB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0057-0000-0000-000008877F32
Message-Id: <1524450747-22778-7-git-send-email-paulmck@linux.vnet.ibm.com>
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

The cond_resched_softirq() macro is not used anywhere in mainline, so
this commit simplifies the kernel by eliminating it.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched.h |  8 --------
 kernel/sched/core.c   | 14 --------------
 kernel/softirq.c      |  3 +--
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fe8f7178a22d..9ae6943b7310 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1613,7 +1613,6 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * explicit rescheduling in places that are safe. The return
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
- * cond_resched_softirq() will enable bhs before scheduling.
  */
 #ifndef CONFIG_PREEMPT
 extern int _cond_resched(void);
@@ -1639,13 +1638,6 @@ extern int __cond_resched_lock(spinlock_t *lock);
 	__cond_resched_lock(lock);				\
 })
 
-extern int __cond_resched_softirq(void);
-
-#define cond_resched_softirq() ({					\
-	___might_sleep(__FILE__, __LINE__, SOFTIRQ_DISABLE_OFFSET);	\
-	__cond_resched_softirq();					\
-})
-
 static inline void cond_resched_rcu(void)
 {
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..6a09e6af64b9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5012,20 +5012,6 @@ int __cond_resched_lock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_lock);
 
-int __sched __cond_resched_softirq(void)
-{
-	BUG_ON(!in_softirq());
-
-	if (should_resched(SOFTIRQ_DISABLE_OFFSET)) {
-		local_bh_enable();
-		preempt_schedule_common();
-		local_bh_disable();
-		return 1;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(__cond_resched_softirq);
-
 /**
  * yield - yield the current processor to other threads.
  *
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de3640c78..03981f1c39ea 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -145,8 +145,7 @@ static void __local_bh_enable(unsigned int cnt)
 }
 
 /*
- * Special-case - softirqs can safely be enabled in
- * cond_resched_softirq(), or by __do_softirq(),
+ * Special-case - softirqs can safely be enabled by __do_softirq(),
  * without processing still-pending softirqs:
  */
 void _local_bh_enable(void)
-- 
2.5.2
