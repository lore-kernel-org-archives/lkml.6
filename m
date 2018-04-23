Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeDWCdO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753958AbeDWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:23 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 08/22] rcu: Move __rcu_read_lock() and __rcu_read_unlock() to tree_plugin.h
Date: Sun, 22 Apr 2018 19:32:13 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-2213-0000-0000-0000029781B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020718; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-2214-0000-0000-000059DC3349
Message-Id: <1524450747-22778-8-git-send-email-paulmck@linux.vnet.ibm.com>
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

The __rcu_read_lock() and __rcu_read_unlock() functions were moved
to kernel/rcu/update.c in order to implement tiny preemptible RCU.
However, tiny preemptible RCU was removed from the kernel a long time
ago, so this commit belatedly moves them back into the only remaining
preemptible-RCU code.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/update.c      | 48 ------------------------------------------------
 2 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfc42c3d52d4..ee24a5de0503 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -384,6 +384,50 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 }
 
 /*
+ * Preemptible RCU implementation for rcu_read_lock().
+ * Just increment ->rcu_read_lock_nesting, shared state will be updated
+ * if we block.
+ */
+void __rcu_read_lock(void)
+{
+	current->rcu_read_lock_nesting++;
+	barrier();  /* critical section after entry code. */
+}
+EXPORT_SYMBOL_GPL(__rcu_read_lock);
+
+/*
+ * Preemptible RCU implementation for rcu_read_unlock().
+ * Decrement ->rcu_read_lock_nesting.  If the result is zero (outermost
+ * rcu_read_unlock()) and ->rcu_read_unlock_special is non-zero, then
+ * invoke rcu_read_unlock_special() to clean up after a context switch
+ * in an RCU read-side critical section and other special cases.
+ */
+void __rcu_read_unlock(void)
+{
+	struct task_struct *t = current;
+
+	if (t->rcu_read_lock_nesting != 1) {
+		--t->rcu_read_lock_nesting;
+	} else {
+		barrier();  /* critical section before exit code. */
+		t->rcu_read_lock_nesting = INT_MIN;
+		barrier();  /* assign before ->rcu_read_unlock_special load */
+		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
+			rcu_read_unlock_special(t);
+		barrier();  /* ->rcu_read_unlock_special load before assign */
+		t->rcu_read_lock_nesting = 0;
+	}
+#ifdef CONFIG_PROVE_LOCKING
+	{
+		int rrln = READ_ONCE(t->rcu_read_lock_nesting);
+
+		WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
+	}
+#endif /* #ifdef CONFIG_PROVE_LOCKING */
+}
+EXPORT_SYMBOL_GPL(__rcu_read_unlock);
+
+/*
  * Advance a ->blkd_tasks-list pointer to the next entry, instead
  * returning NULL if at the end of the list.
  */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index e401960c7f51..4c230a60ece4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -226,54 +226,6 @@ core_initcall(rcu_set_runtime_mode);
 
 #endif /* #if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU) */
 
-#ifdef CONFIG_PREEMPT_RCU
-
-/*
- * Preemptible RCU implementation for rcu_read_lock().
- * Just increment ->rcu_read_lock_nesting, shared state will be updated
- * if we block.
- */
-void __rcu_read_lock(void)
-{
-	current->rcu_read_lock_nesting++;
-	barrier();  /* critical section after entry code. */
-}
-EXPORT_SYMBOL_GPL(__rcu_read_lock);
-
-/*
- * Preemptible RCU implementation for rcu_read_unlock().
- * Decrement ->rcu_read_lock_nesting.  If the result is zero (outermost
- * rcu_read_unlock()) and ->rcu_read_unlock_special is non-zero, then
- * invoke rcu_read_unlock_special() to clean up after a context switch
- * in an RCU read-side critical section and other special cases.
- */
-void __rcu_read_unlock(void)
-{
-	struct task_struct *t = current;
-
-	if (t->rcu_read_lock_nesting != 1) {
-		--t->rcu_read_lock_nesting;
-	} else {
-		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = INT_MIN;
-		barrier();  /* assign before ->rcu_read_unlock_special load */
-		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
-			rcu_read_unlock_special(t);
-		barrier();  /* ->rcu_read_unlock_special load before assign */
-		t->rcu_read_lock_nesting = 0;
-	}
-#ifdef CONFIG_PROVE_LOCKING
-	{
-		int rrln = READ_ONCE(t->rcu_read_lock_nesting);
-
-		WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
-	}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
-}
-EXPORT_SYMBOL_GPL(__rcu_read_unlock);
-
-#endif /* #ifdef CONFIG_PREEMPT_RCU */
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key rcu_lock_key;
 struct lockdep_map rcu_lock_map =
-- 
2.5.2
