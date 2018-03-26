Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCZTRi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:17:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751157AbeCZTRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:17:37 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches
Date: Mon, 26 Mar 2018 15:17:28 -0400
Message-Id: <1522091848-18426-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a rwsem, locking can either be exclusive or shared. The corresponding
exclusive or shared unlock must be used. Otherwise, the protected data
structures may get corrupted or the lock may be in an inconsistent state.

In order to detect such anomaly, a new configuration option DEBUG_RWSEMS
is added which can be enabled to look for such mismatches and print
warnings that that happens.

Signed-off-by: Waiman Long <longman@redhat.com>

 v2: - Fix typo

---
 kernel/locking/rwsem.c | 4 ++++
 kernel/locking/rwsem.h | 8 +++++++-
 lib/Kconfig.debug      | 7 +++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f549c55..30465a2 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -117,6 +117,7 @@ int down_write_trylock(struct rw_semaphore *sem)
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_READER_OWNED);
 
 	__up_read(sem);
 }
@@ -129,6 +130,7 @@ void up_read(struct rw_semaphore *sem)
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	rwsem_clear_owner(sem);
 	__up_write(sem);
@@ -142,6 +144,7 @@ void up_write(struct rw_semaphore *sem)
 void downgrade_write(struct rw_semaphore *sem)
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	rwsem_set_reader_owned(sem);
 	__downgrade_write(sem);
@@ -211,6 +214,7 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
+	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_READER_OWNED);
 	__up_read(sem);
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a883b8f..563a7bc 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -16,6 +16,12 @@
  */
 #define RWSEM_READER_OWNED	((struct task_struct *)1UL)
 
+#ifdef CONFIG_DEBUG_RWSEMS
+#define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
+#else
+#define DEBUG_RWSEMS_WARN_ON(c)
+#endif
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -41,7 +47,7 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 	 * do a write to the rwsem cacheline when it is really necessary
 	 * to minimize cacheline contention.
 	 */
-	if (sem->owner != RWSEM_READER_OWNED)
+	if (READ_ONCE(sem->owner) != RWSEM_READER_OWNED)
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e3..0958192 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1075,6 +1075,13 @@ config DEBUG_WW_MUTEX_SLOWPATH
 	 even a debug kernel.  If you are a driver writer, enable it.  If
 	 you are a distro, do not.
 
+config DEBUG_RWSEMS
+	bool "RW Semaphore debugging: basic checks"
+	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
+	help
+	  This feature allows mismatched rw semaphore locks and unlocks
+	  to be detected and reported.
+
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
1.8.3.1
