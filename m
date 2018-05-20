Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeETIbd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:31:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58329 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeETIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:31:30 -0400
Date: Sun, 20 May 2018 10:31:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] locking fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805201028330.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

Two fixes to address shortcomings of the rwsem/percpu-rwsem lock debugging
code which emits false positive warnings when the rwsem is anonymously
locked and unlocked.

Thanks,

	tglx

------------------>
Waiman Long (2):
      locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
      locking/percpu-rwsem: Annotate rwsem ownership transfer by setting RWSEM_OWNER_UNKNOWN


 include/linux/percpu-rwsem.h |  6 +++++-
 include/linux/rwsem.h        |  6 ++++++
 kernel/locking/rwsem-xadd.c  | 19 +++++++++----------
 kernel/locking/rwsem.c       |  2 --
 kernel/locking/rwsem.h       | 30 +++++++++++++++++++++---------
 5 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index b1f37a89e368..79b99d653e03 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -133,7 +133,7 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
-		sem->rw_sem.owner = NULL;
+		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
 #endif
 }
 
@@ -141,6 +141,10 @@ static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
 	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+	if (!read)
+		sem->rw_sem.owner = current;
+#endif
 }
 
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 56707d5ff6ad..ab93b6eae696 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -44,6 +44,12 @@ struct rw_semaphore {
 #endif
 };
 
+/*
+ * Setting bit 0 of the owner field with other non-zero bits will indicate
+ * that the rwsem is writer-owned with an unknown owner.
+ */
+#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1L)
+
 extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908f3607..a90336779375 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -352,16 +352,15 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	struct task_struct *owner;
 	bool ret = true;
 
+	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+
 	if (need_resched())
 		return false;
 
 	rcu_read_lock();
 	owner = READ_ONCE(sem->owner);
-	if (!rwsem_owner_is_writer(owner)) {
-		/*
-		 * Don't spin if the rwsem is readers owned.
-		 */
-		ret = !rwsem_owner_is_reader(owner);
+	if (!owner || !is_rwsem_owner_spinnable(owner)) {
+		ret = !owner;	/* !owner is spinnable */
 		goto done;
 	}
 
@@ -382,11 +381,11 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
 
-	if (!rwsem_owner_is_writer(owner))
-		goto out;
+	if (!is_rwsem_owner_spinnable(owner))
+		return false;
 
 	rcu_read_lock();
-	while (sem->owner == owner) {
+	while (owner && (READ_ONCE(sem->owner) == owner)) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -408,12 +407,12 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		cpu_relax();
 	}
 	rcu_read_unlock();
-out:
+
 	/*
 	 * If there is a new owner or the owner is not set, we continue
 	 * spinning.
 	 */
-	return !rwsem_owner_is_reader(READ_ONCE(sem->owner));
+	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 30465a2f2b6c..bc1e507be9ff 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -221,5 +221,3 @@ void up_read_non_owner(struct rw_semaphore *sem)
 EXPORT_SYMBOL(up_read_non_owner);
 
 #endif
-
-
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a17cba8d94bb..b9d0e72aa80f 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,20 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * The owner field of the rw_semaphore structure will be set to
- * RWSEM_READ_OWNED when a reader grabs the lock. A writer will clear
+ * RWSEM_READER_OWNED when a reader grabs the lock. A writer will clear
  * the owner field when it unlocks. A reader, on the other hand, will
  * not touch the owner field when it unlocks.
  *
- * In essence, the owner field now has the following 3 states:
+ * In essence, the owner field now has the following 4 states:
  *  1) 0
  *     - lock is free or the owner hasn't set the field yet
  *  2) RWSEM_READER_OWNED
  *     - lock is currently or previously owned by readers (lock is free
  *       or not set by owner yet)
- *  3) Other non-zero value
- *     - a writer owns the lock
+ *  3) RWSEM_ANONYMOUSLY_OWNED bit set with some other bits set as well
+ *     - lock is owned by an anonymous writer, so spinning on the lock
+ *       owner should be disabled.
+ *  4) Other non-zero value
+ *     - a writer owns the lock and other writers can spin on the lock owner.
  */
-#define RWSEM_READER_OWNED	((struct task_struct *)1UL)
+#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 0)
+#define RWSEM_READER_OWNED	((struct task_struct *)RWSEM_ANONYMOUSLY_OWNED)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
@@ -51,14 +55,22 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
-static inline bool rwsem_owner_is_writer(struct task_struct *owner)
+/*
+ * Return true if the a rwsem waiter can spin on the rwsem's owner
+ * and steal the lock, i.e. the lock is not anonymously owned.
+ * N.B. !owner is considered spinnable.
+ */
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return owner && owner != RWSEM_READER_OWNED;
+	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
 }
 
-static inline bool rwsem_owner_is_reader(struct task_struct *owner)
+/*
+ * Return true if rwsem is owned by an anonymous writer or readers.
+ */
+static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 {
-	return owner == RWSEM_READER_OWNED;
+	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
 }
 #else
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
