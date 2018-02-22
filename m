Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeBVXvy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:51:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeBVXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:51:14 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] fs/dcache: Avoid the try_lock loop in d_delete()
Date: Fri, 23 Feb 2018 00:50:22 +0100
Message-Id: <20180222235025.28662-4-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222235025.28662-1-john.ogness@linutronix.de>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
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
   rcu_read_lock();        <-- Protects d_inode from being freed,
                               i.e. inode is a valid pointer even
                               after dentry->d_lock is dropped
   unlock(dentry->d_lock);
   lock(inode->i_lock);
   lock(&dentry->d_lock);
   if (error)
       unlock(inode->i_lock);
   rcu_read_unlock();

After the locks are acquired it's necessary to verify whether
dentry->d_inode is still pointing to inode as it might have been
changed after dropping dentry->d_lock. If it matches d_delete() can
proceed, if not the whole operation has to be repeated.

Implement this in a new function dentry_lock_inode() which will be
used in a subsequent patch as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9fed398687c9..bfdf1ff237f2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -623,6 +623,71 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	return parent;
 }
 
+/**
+ * dentry_lock_inode - Lock dentry->d_inode->i_lock
+ * @dentry: The dentry to operate on
+ *
+ * Tries to acquire @dentry->d_inode->i_lock with a trylock first. If
+ * that fails it retries in correct lock order, which requires dropping
+ * @dentry->d_lock under RCU protection and then reacquiring it after
+ * locking @dentry->d_inode->i_lock.
+ *
+ * If @dentry->d_lockref.count changes while trying to acquire
+ * @dentry->d_inode->i_lock, drop @dentry->d_inode->i_lock and return
+ * false. Otherwise return true.
+ *
+ * Note that all relevant struct members of @dentry must be reevaluated by
+ * the caller since @dentry->d_lock might have been temporarily dropped.
+ */
+static bool dentry_lock_inode(struct dentry *dentry)
+{
+	int saved_count = dentry->d_lockref.count;
+	struct inode *inode;
+
+	lockdep_assert_held(&dentry->d_lock);
+again:
+	inode = dentry->d_inode;
+	if (likely(spin_trylock(&inode->i_lock)))
+		return true;
+
+	/*
+	 * The inode struct pointed to by "inode" is protected by RCU,
+	 * i.e. destroy_inode() uses call_rcu() to reclaim the memory.
+	 * Using rcu_read_lock() ensures that the inode struct remains
+	 * valid after dropping @dentry->d_lock, independent of whether
+	 * or not @dentry->d_inode continues to point to that inode.
+	 */
+	rcu_read_lock();
+
+	spin_unlock(&dentry->d_lock);
+	spin_lock(&inode->i_lock);
+	spin_lock(&dentry->d_lock);
+
+	/*
+	 * @dentry->d_lockref.count might have changed after dropping
+	 * @dentry->d_lock. If so, release @inode->i_lock and tell caller.
+	 */
+	if (unlikely(dentry->d_lockref.count != saved_count)) {
+		spin_unlock(&inode->i_lock);
+		rcu_read_unlock();
+		return false;
+	}
+
+	/*
+	 * @dentry->d_inode might have changed after dropping @dentry->d_lock.
+	 * If so, release @inode->i_lock and restart.
+	 */
+	if (unlikely(inode != dentry->d_inode)) {
+		spin_unlock(&inode->i_lock);
+		rcu_read_unlock();
+		goto again;
+	}
+
+	rcu_read_unlock();
+
+	return true;
+}
+
 /*
  * Finish off a dentry we've decided to kill.
  * dentry->d_lock must be held, returns with it unlocked.
@@ -2373,32 +2438,27 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  
 void d_delete(struct dentry * dentry)
 {
-	struct inode *inode;
-	int isdir = 0;
+	int isdir;
 	/*
 	 * Are we the only user?
 	 */
-again:
+
 	spin_lock(&dentry->d_lock);
-	inode = dentry->d_inode;
-	isdir = S_ISDIR(inode->i_mode);
-	if (dentry->d_lockref.count == 1) {
-		if (!spin_trylock(&inode->i_lock)) {
-			spin_unlock(&dentry->d_lock);
-			cpu_relax();
-			goto again;
-		}
-		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
-		dentry_unlink_inode(dentry);
-		fsnotify_nameremove(dentry, isdir);
-		return;
-	}
 
+	if (dentry->d_lockref.count > 1 || !dentry_lock_inode(dentry))
+		goto drop;
+
+	dentry->d_flags &= ~DCACHE_CANT_MOUNT;
+	isdir = S_ISDIR(dentry->d_inode->i_mode);
+	dentry_unlink_inode(dentry);
+	fsnotify_nameremove(dentry, isdir);
+	return;
+drop:
 	if (!d_unhashed(dentry))
 		__d_drop(dentry);
 
+	isdir = S_ISDIR(dentry->d_inode->i_mode);
 	spin_unlock(&dentry->d_lock);
-
 	fsnotify_nameremove(dentry, isdir);
 }
 EXPORT_SYMBOL(d_delete);
-- 
2.11.0
