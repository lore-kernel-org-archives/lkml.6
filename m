Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966809AbeBPPKV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:10:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeBPPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:10:12 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] fs/dcache: Avoid the try_lock loop in d_delete()
Date: Fri, 16 Feb 2018 16:09:32 +0100
Message-Id: <20180216150933.971-4-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180216150933.971-1-john.ogness@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d_delete() holds dentry->d_lock and needs to acquire
dentry->d_inode->i_lock. This cannot be done with a spin_lock()
operation because it's the reverse of the regular lock order. To avoid
the ABBA deadlock it is done with a trylock loop.

Trylock loops are problematic in two scenarios:

  1) PREEMPT_RT converts spinlocks to 'sleeping' spinlocks, which are
     preemptible. As a consequence the i_lock holder can be preempted
     by a higher priority task. If that task executes the trylock loop
     it will do so forever and live lock.

  2) In virtual machines trylock loops are problematic as well. The
     VCPU on which the i_lock holder runs can be scheduled out and a
     task on a different VCPU can loop for a whole time slice. In the
     worst case this can lead to starvation. Commits 47be61845c77
     ("fs/dcache.c: avoid soft-lockup in dput()") and 046b961b45f9
     ("shrink_dentry_list(): take parent's d_lock earlier") are
     addressing exactly those symptoms.

The trylock loop can be avoided with functionality similar to
lock_parent(). The fast path tries the trylock first, which is likely
to succeed. In the contended case it attempts locking in the correct
order. This requires to drop dentry->d_lock first, which allows
another task to free d_inode. This can be prevented by the following
mechanism:

   inode = dentry->d_inode;
   rcu_read_lock();         <- Protects d_inode from being freed,
                               i.e. dentry->d_inode is a valid pointer
                               even after dentry->d_lock is dropped
   unlock(dentry->d_lock);
   lock(inode->i_lock);
   lock(dentry->d_lock);
   rcu_read_unlock();

After the locks are acquired it's necessary to verify whether
dentry->d_inode is still pointing to inode as it might have been
changed after dropping dentry->d_lock. If it matches d_delete() can
proceed, if not the whole operation has to be repeated.

Implement this in a new function dentry_lock_inode() which will be
used in a subsequent patch as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9fed398687c9..2cd252f88c5d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -623,6 +623,48 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	return parent;
 }
 
+/**
+ * dentry_lock_inode - Lock dentry->d_inode->i_lock
+ * @dentry:	The dentry to operate on
+ *
+ * Tries to acquire @dentry->d_inode->i_lock with a trylock first. If that
+ * fails it retries in correct lock order, which requires dropping
+ * @dentry->d_lock under RCU protection and then reacquiring it after
+ * locking @dentry->d_inode->i_lock.
+ *
+ * After both locks are acquired it must be verified that @dentry->d_inode
+ * did not change while @dentry->d_lock was dropped. If it's unchanged
+ * return true, otherwise drop @dentry->d_inode->i_lock and return false.
+ *
+ * Note, that even if @dentry->d_inode is unchanged, all other relevant struct
+ * members of @dentry must be reevaluated by the caller.
+ */
+static bool dentry_lock_inode(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+
+	lockdep_assert_held(&dentry->d_lock);
+
+	if (unlikely(!spin_trylock(&inode->i_lock))) {
+		rcu_read_lock();
+		spin_unlock(&dentry->d_lock);
+		spin_lock(&inode->i_lock);
+		spin_lock(&dentry->d_lock);
+		rcu_read_unlock();
+
+		/*
+		 * @dentry->d_inode might have changed after dropping
+		 * @dentry->d_lock. If so, release @inode->i_lock and
+		 * signal the caller to restart the operation.
+		 */
+		if (unlikely(inode != dentry->d_inode)) {
+			spin_unlock(&inode->i_lock);
+			return false;
+		}
+	}
+	return true;
+}
+
 /*
  * Finish off a dentry we've decided to kill.
  * dentry->d_lock must be held, returns with it unlocked.
@@ -2378,22 +2420,36 @@ void d_delete(struct dentry * dentry)
 	/*
 	 * Are we the only user?
 	 */
-again:
 	spin_lock(&dentry->d_lock);
+again:
 	inode = dentry->d_inode;
 	isdir = S_ISDIR(inode->i_mode);
 	if (dentry->d_lockref.count == 1) {
-		if (!spin_trylock(&inode->i_lock)) {
-			spin_unlock(&dentry->d_lock);
-			cpu_relax();
+		/*
+		 * Lock the inode. Might drop dentry->d_lock temporarily
+		 * which allows inode to change. Start over if that happens.
+		 */
+		if (!dentry_lock_inode(dentry))
 			goto again;
+
+		/*
+		 * Recheck refcount as it might have been incremented while
+		 * d_lock was dropped.
+		 */
+		if (dentry->d_lockref.count != 1) {
+			spin_unlock(&inode->i_lock);
+			goto drop;
 		}
+		/*
+		 * isdir is not reloaded because it is not possible that it
+		 * changes on the same inode.
+		 */
 		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
 		dentry_unlink_inode(dentry);
 		fsnotify_nameremove(dentry, isdir);
 		return;
 	}
-
+drop:
 	if (!d_unhashed(dentry))
 		__d_drop(dentry);
 
-- 
2.11.0
