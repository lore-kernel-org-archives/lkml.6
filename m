Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966651AbeBPPKL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:10:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56540 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966462AbeBPPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:10:08 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] fs/dcache: Avoid the try_lock loops in dentry_kill()
Date: Fri, 16 Feb 2018 16:09:33 +0100
Message-Id: <20180216150933.971-5-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180216150933.971-1-john.ogness@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dentry_kill() holds dentry->d_lock and needs to acquire both
dentry->d_inode->i_lock and dentry->d_parent->d_lock. This cannot be
done with spin_lock() operations because it's the reverse of the
regular lock order. To avoid ABBA deadlocks it is done with two
trylock loops.

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

Avoid the trylock loops by using dentry_lock_inode() and lock_parent()
which take the locks in the appropriate order. As both functions drop
dentry->lock briefly, this requires rechecking of the dentry content
as it might have changed after dropping the lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2cd252f88c5d..b557679c14c9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -673,27 +673,73 @@ static bool dentry_lock_inode(struct dentry *dentry)
 static struct dentry *dentry_kill(struct dentry *dentry)
 	__releases(dentry->d_lock)
 {
-	struct inode *inode = dentry->d_inode;
-	struct dentry *parent = NULL;
+	struct dentry *parent;
+	struct inode *inode;
+
+again:
+	parent = NULL;
+	inode = dentry->d_inode;
+	if (inode) {
+		/*
+		 * Lock the inode. Might drop dentry->d_lock temporarily
+		 * which allows inode to change. Start over if that happens.
+		 */
+		if (!dentry_lock_inode(dentry))
+			goto again;
 
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
-		goto failed;
+		/*
+		 * Recheck refcount as it might have been incremented while
+		 * d_lock was dropped.
+		 */
+		if (unlikely(dentry->d_lockref.count != 1))
+			goto drop_ref;
+	}
 
-	if (!IS_ROOT(dentry)) {
-		parent = dentry->d_parent;
-		if (unlikely(!spin_trylock(&parent->d_lock))) {
-			if (inode)
-				spin_unlock(&inode->i_lock);
-			goto failed;
-		}
+	parent = lock_parent(dentry);
+
+	/*
+	 * Check refcount because it might have changed
+	 * while d_lock was dropped.
+	 */
+	if (unlikely(dentry->d_lockref.count != 1))
+		goto drop_ref;
+
+	/*
+	 * The inode may have changed in the window where the
+	 * dentry was unlocked. If that happens it is necessary
+	 * to start over because the wrong inode lock is held.
+	 */
+	if (unlikely(inode != dentry->d_inode)) {
+		if (parent)
+			spin_unlock(&parent->d_lock);
+		if (inode)
+			spin_unlock(&inode->i_lock);
+		goto again;
 	}
 
 	__dentry_kill(dentry);
 	return parent;
 
-failed:
+drop_ref:
+	/*
+	 * If refcount is > 1 it was incremented while dentry->d_lock was
+	 * dropped. Just decrement the refcount, unlock and tell the caller
+	 * to stop the directory walk.
+	 *
+	 * For paranoia reasons check whether the refcount is < 1. If so,
+	 * report the detection and avoid the decrement which would just
+	 * cause a problem in some other place. The warning might be
+	 * helpful to decode the root cause of the refcounting bug.
+	 */
+	if (!WARN_ON(dentry->d_lockref.count < 1))
+		dentry->d_lockref.count--;
+
 	spin_unlock(&dentry->d_lock);
-	return dentry; /* try again with same dentry */
+	if (parent)
+		spin_unlock(&parent->d_lock);
+	if (inode)
+		spin_unlock(&inode->i_lock);
+	return NULL;
 }
 
 /*
@@ -865,10 +911,8 @@ void dput(struct dentry *dentry)
 
 kill_it:
 	dentry = dentry_kill(dentry);
-	if (dentry) {
-		cond_resched();
+	if (dentry)
 		goto repeat;
-	}
 }
 EXPORT_SYMBOL(dput);
 
-- 
2.11.0
