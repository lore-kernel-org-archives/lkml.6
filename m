Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeEORjt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:39:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752359AbeEORjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:39:06 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
Date: Tue, 15 May 2018 13:38:03 -0400
Message-Id: <1526405884-4860-2-git-send-email-longman@redhat.com>
In-Reply-To: <1526405884-4860-1-git-send-email-longman@redhat.com>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use cases where a rwsem can be acquired by one task, but
released by another task. In thess cases, optimistic spinning may need
to be disabled.  One example will be the filesystem freeze/thaw code
where the task that freezes the filesystem will acquire a rwsem and
then un-owns it before returning to userspace. Later on, another task
will come along, acquire the ownership, thaw the filesystem and release
the rwsem.

To handle such transfer of ownership, a new RWSEM_ANONYMOUSLY_OWNED
flag can now be set in the owner field of the rwsem when the ownership
is to be tranfered to indicate that the rwsem is owned an anonymous
writer. Since the actual owner is not known after the flag is set,
optimistic spinning on the rwsem will be disabled.

Once the higher level code figures who the new owner is, it can then
set the owner field accordingly.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 17 ++++++++---------
 kernel/locking/rwsem.c      |  5 ++---
 kernel/locking/rwsem.h      | 33 ++++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908..a27dbb4 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -357,11 +357,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
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
 
@@ -382,8 +379,10 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
 
-	if (!rwsem_owner_is_writer(owner))
-		goto out;
+	if (!owner)
+		return true;
+	else if (!is_rwsem_owner_spinnable(owner))
+		return false;
 
 	rcu_read_lock();
 	while (sem->owner == owner) {
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
index 30465a2..b7208e1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -130,7 +130,8 @@ void up_read(struct rw_semaphore *sem)
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
+	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
+			     !rwsem_has_anonymous_owner(sem->owner));
 
 	rwsem_clear_owner(sem);
 	__up_write(sem);
@@ -221,5 +222,3 @@ void up_read_non_owner(struct rw_semaphore *sem)
 EXPORT_SYMBOL(up_read_non_owner);
 
 #endif
-
-
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index a17cba8..d035e8c 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,20 +1,27 @@
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
+ *  3) RWSEM_ANONYMOUSLY_OWNED
+ *     - lock is owned by an anonymous writer, so spinning on the lock
+ *       owner should be disabled.
+ *  4) Other non-zero value
+ *     - a writer owns the lock and other writers can spin on the lock owner.
  */
-#define RWSEM_READER_OWNED	((struct task_struct *)1UL)
+#define __RWSEM_READER_OWNED		(1UL << 0)
+#define __RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
+#define RWSEM_NOSPIN_MASK	(__RWSEM_READER_OWNED|__RWSEM_ANONYMOUSLY_OWNED)
+#define RWSEM_READER_OWNED	((struct task_struct *)__RWSEM_READER_OWNED)
+#define WSEM_ANONYMOUSLY_OWNED	((struct task_struct *)__RWSEM_ANONYMOUSLY_OWNED)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
@@ -51,14 +58,22 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
-static inline bool rwsem_owner_is_writer(struct task_struct *owner)
+/*
+ * Return true if the lock is owned by an anonymous writer.
+ */
+static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 {
-	return owner && owner != RWSEM_READER_OWNED;
+	return (unsigned long)owner & __RWSEM_ANONYMOUSLY_OWNED;
 }
 
-static inline bool rwsem_owner_is_reader(struct task_struct *owner)
+/*
+ * Return true if the a rwsem waiter can spin on the rwsem's owner
+ * and steal the lock.
+ * N.B. !owner is considered spinnable.
+ */
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return owner == RWSEM_READER_OWNED;
+	return !((unsigned long)owner & RWSEM_NOSPIN_MASK);
 }
 #else
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
-- 
1.8.3.1
