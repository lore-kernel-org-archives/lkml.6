Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeBVXvO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:51:14 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeBVXvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:51:11 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in shrink_dentry_list()
Date: Fri, 23 Feb 2018 00:50:25 +0100
Message-Id: <20180222235025.28662-7-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222235025.28662-1-john.ogness@linutronix.de>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shrink_dentry_list() holds dentry->d_lock and needs to acquire
dentry->d_inode->i_lock. This cannot be done with a spin_lock()
operation because it's the reverse of the regular lock order.
To avoid ABBA deadlocks it is done with a trylock loop.

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

Avoid the trylock loop by using dentry_kill(). When killing dentries
from the dispose list, it is very similar to killing a dentry in
dput(). The difference is that dput() expects to be the last user of
the dentry (refcount=1) and will deref whereas shrink_dentry_list()
expects there to be no user (refcount=0). In order to handle both
situations with the same code, move the deref code from dentry_kill()
into a new wrapper function dentry_put_kill(), which can be used
by previous dentry_kill() users. Then shrink_dentry_list() can use
the dentry_kill() to cleanup the dispose list.

This also has the benefit that the locking order is now the same.
First the inode is locked, then the parent.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 58 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e470d49daa54..23a90a64d74f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -690,11 +690,17 @@ static bool dentry_lock_inode(struct dentry *dentry)
 
 /*
  * Finish off a dentry we've decided to kill.
- * dentry->d_lock must be held, returns with it unlocked.
- * Returns dentry requiring refcount drop, or NULL if we're done.
+ * dentry->d_lock must be held and returns with it unlocked if the
+ * dentry was killed.
+ *
+ * Returns parent dentry requiring refcount drop or NULL if we're done
+ * or ERR_PTR(-EINTR) if the dentry was not killed because its refcount
+ * changed while preparing to kill.
+ *
+ * Note, if the dentry was not killed, i.e. ERR_PTR(-EINTR) returned,
+ * dentry->d_lock is left locked!
  */
 static struct dentry *dentry_kill(struct dentry *dentry)
-	__releases(dentry->d_lock)
 {
 	int saved_count = dentry->d_lockref.count;
 	struct dentry *parent;
@@ -741,6 +747,27 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	return parent;
 
 out_ref_changed:
+	/* dentry->d_lock still locked! */
+	return ERR_PTR(-EINTR);
+}
+
+/*
+ * Finish off a dentry where we are the last user (refcount=1) and
+ * we've decided to kill it.
+ * dentry->d_lock must be held, returns with it unlocked.
+ * Returns dentry requiring refcount drop, or NULL if we're done.
+ */
+static struct dentry *dentry_put_kill(struct dentry *dentry)
+	__releases(dentry->d_lock)
+{
+	struct dentry *parent;
+
+	parent = dentry_kill(dentry);
+	if (likely(!IS_ERR(parent)))
+		return parent;
+
+	/* dentry->d_lock still held */
+
 	/*
 	 * The refcount was incremented while dentry->d_lock was dropped.
 	 * Just decrement the refcount, unlock, and tell the caller to
@@ -927,7 +954,7 @@ void dput(struct dentry *dentry)
 	return;
 
 kill_it:
-	dentry = dentry_kill(dentry);
+	dentry = dentry_put_kill(dentry);
 	if (dentry)
 		goto repeat;
 }
@@ -1078,10 +1105,8 @@ static void shrink_dentry_list(struct list_head *list)
 	struct dentry *dentry, *parent;
 
 	while (!list_empty(list)) {
-		struct inode *inode;
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
-		parent = lock_parent(dentry);
 
 		/*
 		 * The dispose list is isolated and dentries are not accounted
@@ -1089,15 +1114,13 @@ static void shrink_dentry_list(struct list_head *list)
 		 * here regardless of whether it is referenced or not.
 		 */
 		d_shrink_del(dentry);
-
+again:
 		/*
 		 * We found an inuse dentry which was not removed from
 		 * the LRU because of laziness during lookup. Do not free it.
 		 */
 		if (dentry->d_lockref.count > 0) {
 			spin_unlock(&dentry->d_lock);
-			if (parent)
-				spin_unlock(&parent->d_lock);
 			continue;
 		}
 
@@ -1105,23 +1128,14 @@ static void shrink_dentry_list(struct list_head *list)
 		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
 			bool can_free = dentry->d_flags & DCACHE_MAY_FREE;
 			spin_unlock(&dentry->d_lock);
-			if (parent)
-				spin_unlock(&parent->d_lock);
 			if (can_free)
 				dentry_free(dentry);
 			continue;
 		}
 
-		inode = dentry->d_inode;
-		if (inode && unlikely(!spin_trylock(&inode->i_lock))) {
-			d_shrink_add(dentry, list);
-			spin_unlock(&dentry->d_lock);
-			if (parent)
-				spin_unlock(&parent->d_lock);
-			continue;
-		}
-
-		__dentry_kill(dentry);
+		parent = dentry_kill(dentry);
+		if (unlikely(IS_ERR(parent)))
+			goto again;
 
 		/*
 		 * We need to prune ancestors too. This is necessary to prevent
@@ -1131,7 +1145,7 @@ static void shrink_dentry_list(struct list_head *list)
 		 */
 		dentry = parent;
 		while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
-			dentry = dentry_kill(dentry);
+			dentry = dentry_put_kill(dentry);
 	}
 }
 
-- 
2.11.0
