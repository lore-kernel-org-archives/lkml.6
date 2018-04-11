Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDKSBS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:01:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbeDKSBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:01:08 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com
Subject: [PATCH v2 13/13] locking/qspinlock: Add stat tracking for pending vs slowpath
Date: Wed, 11 Apr 2018 19:01:20 +0100
Message-Id: <1523469680-17699-14-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Currently, the qspinlock_stat code tracks only statistical counts in the
PV qspinlock code. However, it may also be useful to track the number
of locking operations done via the pending code vs. the MCS lock queue
slowpath for the non-PV case.

The qspinlock stat code is modified to do that. The stat counter
pv_lock_slowpath is renamed to lock_slowpath so that it can be used by
both the PV and non-PV cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c          | 14 +++++++++++---
 kernel/locking/qspinlock_paravirt.h |  7 +------
 kernel/locking/qspinlock_stat.h     |  9 ++++++---
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 1e3ddc42135e..b39f341d831b 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -12,11 +12,11 @@
  * GNU General Public License for more details.
  *
  * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
- * (C) Copyright 2013-2014 Red Hat, Inc.
+ * (C) Copyright 2013-2014,2018 Red Hat, Inc.
  * (C) Copyright 2015 Intel Corp.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
  *
- * Authors: Waiman Long <waiman.long@hpe.com>
+ * Authors: Waiman Long <longman@redhat.com>
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
@@ -33,6 +33,11 @@
 #include <asm/qspinlock.h>
 
 /*
+ * Include queued spinlock statistics code
+ */
+#include "qspinlock_stat.h"
+
+/*
  * The basic principle of a queue-based spinlock can best be understood
  * by studying a classic queue-based spinlock implementation called the
  * MCS lock. The paper below provides a good description for this kind
@@ -295,7 +300,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
 	if (pv_enabled())
-		goto queue;
+		goto pv_queue;
 
 	if (virt_spin_lock(lock))
 		return;
@@ -348,6 +353,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		 * *,1,0 -> *,0,1
 		 */
 		clear_pending_set_locked(lock);
+		qstat_inc(qstat_lock_pending, true);
 		return;
 	}
 
@@ -363,6 +369,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * queuing.
 	 */
 queue:
+	qstat_inc(qstat_lock_slowpath, true);
+pv_queue:
 	node = this_cpu_ptr(&mcs_nodes[0]);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 2711940429f5..970f47632b6f 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -56,11 +56,6 @@ struct pv_node {
 };
 
 /*
- * Include queued spinlock statistics code
- */
-#include "qspinlock_stat.h"
-
-/*
  * Hybrid PV queued/unfair lock
  *
  * By replacing the regular queued_spin_trylock() with the function below,
@@ -433,7 +428,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	/*
 	 * Tracking # of slowpath locking operations
 	 */
-	qstat_inc(qstat_pv_lock_slowpath, true);
+	qstat_inc(qstat_lock_slowpath, true);
 
 	for (;; waitcnt++) {
 		/*
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 4a30ef63c607..6bd78c0740fc 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -22,13 +22,14 @@
  *   pv_kick_wake	- # of vCPU kicks used for computing pv_latency_wake
  *   pv_latency_kick	- average latency (ns) of vCPU kick operation
  *   pv_latency_wake	- average latency (ns) from vCPU kick to wakeup
- *   pv_lock_slowpath	- # of locking operations via the slowpath
  *   pv_lock_stealing	- # of lock stealing operations
  *   pv_spurious_wakeup	- # of spurious wakeups in non-head vCPUs
  *   pv_wait_again	- # of wait's after a queue head vCPU kick
  *   pv_wait_early	- # of early vCPU wait's
  *   pv_wait_head	- # of vCPU wait's at the queue head
  *   pv_wait_node	- # of vCPU wait's at a non-head queue node
+ *   lock_pending	- # of locking operations via pending code
+ *   lock_slowpath	- # of locking operations via MCS lock queue
  *
  * Writing to the "reset_counters" file will reset all the above counter
  * values.
@@ -46,13 +47,14 @@ enum qlock_stats {
 	qstat_pv_kick_wake,
 	qstat_pv_latency_kick,
 	qstat_pv_latency_wake,
-	qstat_pv_lock_slowpath,
 	qstat_pv_lock_stealing,
 	qstat_pv_spurious_wakeup,
 	qstat_pv_wait_again,
 	qstat_pv_wait_early,
 	qstat_pv_wait_head,
 	qstat_pv_wait_node,
+	qstat_lock_pending,
+	qstat_lock_slowpath,
 	qstat_num,	/* Total number of statistical counters */
 	qstat_reset_cnts = qstat_num,
 };
@@ -73,12 +75,13 @@ static const char * const qstat_names[qstat_num + 1] = {
 	[qstat_pv_spurious_wakeup] = "pv_spurious_wakeup",
 	[qstat_pv_latency_kick]	   = "pv_latency_kick",
 	[qstat_pv_latency_wake]    = "pv_latency_wake",
-	[qstat_pv_lock_slowpath]   = "pv_lock_slowpath",
 	[qstat_pv_lock_stealing]   = "pv_lock_stealing",
 	[qstat_pv_wait_again]      = "pv_wait_again",
 	[qstat_pv_wait_early]      = "pv_wait_early",
 	[qstat_pv_wait_head]       = "pv_wait_head",
 	[qstat_pv_wait_node]       = "pv_wait_node",
+	[qstat_lock_pending]       = "lock_pending",
+	[qstat_lock_slowpath]      = "lock_slowpath",
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
-- 
2.1.4
