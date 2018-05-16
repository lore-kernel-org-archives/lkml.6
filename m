Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeEPKfd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:35:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeEPKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:35:29 -0400
Date: Wed, 16 May 2018 03:34:54 -0700
From: tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-d7d760efad70c7a030725499bf9f342f04af24dd@git.kernel.org>
Cc: dave@stgolabs.net, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, willy@infradead.org, tytso@mit.edu,
        jack@suse.cz, longman@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, oleg@redhat.com, amir73il@gmail.com,
        paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
        will.deacon@arm.com
Reply-To: akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        will.deacon@arm.com, tglx@linutronix.de, longman@redhat.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, amir73il@gmail.com,
        oleg@redhat.com, tytso@mit.edu, willy@infradead.org, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, dave@stgolabs.net,
        torvalds@linux-foundation.org
In-Reply-To: <1526420991-21213-2-git-send-email-longman@redhat.com>
References: <1526420991-21213-2-git-send-email-longman@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/rwsem: Add a new
 RWSEM_ANONYMOUSLY_OWNED flag
Git-Commit-ID: d7d760efad70c7a030725499bf9f342f04af24dd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d7d760efad70c7a030725499bf9f342f04af24dd
Gitweb:     https://git.kernel.org/tip/d7d760efad70c7a030725499bf9f342f04af24dd
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 15 May 2018 17:49:50 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 16 May 2018 11:45:15 +0200

locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag

There are use cases where a rwsem can be acquired by one task, but
released by another task. In thess cases, optimistic spinning may need
to be disabled.  One example will be the filesystem freeze/thaw code
where the task that freezes the filesystem will acquire a write lock
on a rwsem and then un-owns it before returning to userspace. Later on,
another task will come along, acquire the ownership, thaw the filesystem
and release the rwsem.

Bit 0 of the owner field was used to designate that it is a reader
owned rwsem. It is now repurposed to mean that the owner of the rwsem
is not known. If only bit 0 is set, the rwsem is reader owned. If bit
0 and other bits are set, it is writer owned with an unknown owner.
One such value for the latter case is (-1L). So we can set owner to 1 for
reader-owned, -1 for writer-owned. The owner is unknown in both cases.

To handle transfer of rwsem ownership, the higher level code should
set the owner field to -1 to indicate a write-locked rwsem with unknown
owner.  Optimistic spinning will be disabled in this case.

Once the higher level code figures who the new owner is, it can then
set the owner field accordingly.

Tested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Link: http://lkml.kernel.org/r/1526420991-21213-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c | 17 +++++++----------
 kernel/locking/rwsem.c      |  2 --
 kernel/locking/rwsem.h      | 30 +++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908f3607..604d247ea8c3 100644
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
 
@@ -382,11 +379,11 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
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
@@ -408,12 +405,12 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
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
