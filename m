Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeDWCdQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753962AbeDWCbX (ORCPT
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
Subject: [PATCH tip/core/rcu 11/22] srcu: Add cleanup_srcu_struct_quiesced()
Date: Sun, 22 Apr 2018 19:32:16 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0040-0000-0000-00000420725F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0041-0000-0000-000008267BD5
Message-Id: <1524450747-22778-11-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current cleanup_srcu_struct() flushes work, which prevents it
from being invoked from some workqueue contexts, as well as from
atomic (non-blocking) contexts.  This patch therefore introduced a
cleanup_srcu_struct_quiesced(), which can be invoked only after all
activity on the specified srcu_struct has completed.  This restriction
allows cleanup_srcu_struct_quiesced() to be invoked from workqueue
contexts as well as from atomic contexts.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Nitzan Carmi <nitzanc@mellanox.com>
---
 include/linux/srcu.h    | 36 +++++++++++++++++++++++++++++++++++-
 kernel/rcu/rcutorture.c |  7 ++++++-
 kernel/rcu/srcutiny.c   |  9 ++++++---
 kernel/rcu/srcutree.c   | 30 +++++++++++++++++-------------
 4 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 33c1c698df09..91494d7e8e41 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -69,11 +69,45 @@ struct srcu_struct { };
 
 void call_srcu(struct srcu_struct *sp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
-void cleanup_srcu_struct(struct srcu_struct *sp);
+void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced);
 int __srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
 void __srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);
 void synchronize_srcu(struct srcu_struct *sp);
 
+/**
+ * cleanup_srcu_struct - deconstruct a sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct that
+ * was initialized via init_srcu_struct(), else you leak memory.
+ */
+static inline void cleanup_srcu_struct(struct srcu_struct *sp)
+{
+	_cleanup_srcu_struct(sp, false);
+}
+
+/**
+ * cleanup_srcu_struct_quiesced - deconstruct a quiesced sleep-RCU structure
+ * @sp: structure to clean up.
+ *
+ * Must invoke this after you are finished using a given srcu_struct that
+ * was initialized via init_srcu_struct(), else you leak memory.  Also,
+ * all grace-period processing must have completed.
+ *
+ * "Completed" means that the last synchronize_srcu() and
+ * synchronize_srcu_expedited() calls must have returned before the call
+ * to cleanup_srcu_struct_quiesced().  It also means that the callback
+ * from the last call_srcu() must have been invoked before the call to
+ * cleanup_srcu_struct_quiesced(), but you can use srcu_barrier() to help
+ * with this last.  Violating these rules will get you a WARN_ON() splat
+ * (with high probability, anyway), and will also cause the srcu_struct
+ * to be leaked.
+ */
+static inline void cleanup_srcu_struct_quiesced(struct srcu_struct *sp)
+{
+	_cleanup_srcu_struct(sp, true);
+}
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 680c96d8c00f..f0e1d44459f8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -593,7 +593,12 @@ static void srcu_torture_init(void)
 
 static void srcu_torture_cleanup(void)
 {
-	cleanup_srcu_struct(&srcu_ctld);
+	static DEFINE_TORTURE_RANDOM(rand);
+
+	if (torture_random(&rand) & 0x800)
+		cleanup_srcu_struct(&srcu_ctld);
+	else
+		cleanup_srcu_struct_quiesced(&srcu_ctld);
 	srcu_ctlp = &srcu_ctl; /* In case of a later rcutorture run. */
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 76ac5f50b2c7..622792abe41a 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -86,16 +86,19 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
  * Must invoke this after you are finished using a given srcu_struct that
  * was initialized via init_srcu_struct(), else you leak memory.
  */
-void cleanup_srcu_struct(struct srcu_struct *sp)
+void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced)
 {
 	WARN_ON(sp->srcu_lock_nesting[0] || sp->srcu_lock_nesting[1]);
-	flush_work(&sp->srcu_work);
+	if (quiesced)
+		WARN_ON(work_pending(&sp->srcu_work));
+	else
+		flush_work(&sp->srcu_work);
 	WARN_ON(sp->srcu_gp_running);
 	WARN_ON(sp->srcu_gp_waiting);
 	WARN_ON(sp->srcu_cb_head);
 	WARN_ON(&sp->srcu_cb_head != sp->srcu_cb_tail);
 }
-EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
 
 /*
  * Removes the count for the old reader from the appropriate element of
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fb560fca9ef4..b4123d7a2cec 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -366,24 +366,28 @@ static unsigned long srcu_get_delay(struct srcu_struct *sp)
 	return SRCU_INTERVAL;
 }
 
-/**
- * cleanup_srcu_struct - deconstruct a sleep-RCU structure
- * @sp: structure to clean up.
- *
- * Must invoke this after you are finished using a given srcu_struct that
- * was initialized via init_srcu_struct(), else you leak memory.
- */
-void cleanup_srcu_struct(struct srcu_struct *sp)
+/* Helper for cleanup_srcu_struct() and cleanup_srcu_struct_quiesced(). */
+void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced)
 {
 	int cpu;
 
 	if (WARN_ON(!srcu_get_delay(sp)))
-		return; /* Leakage unless caller handles error. */
+		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(sp)))
-		return; /* Leakage unless caller handles error. */
-	flush_delayed_work(&sp->work);
+		return; /* Just leak it! */
+	if (quiesced) {
+		if (WARN_ON(delayed_work_pending(&sp->work)))
+			return; /* Just leak it! */
+	} else {
+		flush_delayed_work(&sp->work);
+	}
 	for_each_possible_cpu(cpu)
-		flush_delayed_work(&per_cpu_ptr(sp->sda, cpu)->work);
+		if (quiesced) {
+			if (WARN_ON(delayed_work_pending(&per_cpu_ptr(sp->sda, cpu)->work)))
+				return; /* Just leak it! */
+		} else {
+			flush_delayed_work(&per_cpu_ptr(sp->sda, cpu)->work);
+		}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
 	    WARN_ON(srcu_readers_active(sp))) {
 		pr_info("%s: Active srcu_struct %p state: %d\n", __func__, sp, rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)));
@@ -392,7 +396,7 @@ void cleanup_srcu_struct(struct srcu_struct *sp)
 	free_percpu(sp->sda);
 	sp->sda = NULL;
 }
-EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
+EXPORT_SYMBOL_GPL(_cleanup_srcu_struct);
 
 /*
  * Counts the new reader in the appropriate per-CPU element of the
-- 
2.5.2
