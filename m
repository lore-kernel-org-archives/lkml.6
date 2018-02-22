Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeBVXxD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:53:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeBVXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:51:13 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] fs/dcache: Avoid a try_lock loop in shrink_dentry_list()
Date: Fri, 23 Feb 2018 00:50:24 +0100
Message-Id: <20180222235025.28662-6-john.ogness@linutronix.de>
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

Avoid the trylock loop by using dentry_kill(). When pruning ancestors,
the same code applies that is used to kill a dentry in dput(). This
also has the benefit that the locking order is now the same. First
the inode is locked, then the parent.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 082361939b84..e470d49daa54 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1130,26 +1130,8 @@ static void shrink_dentry_list(struct list_head *list)
 		 * fragmentation.
 		 */
 		dentry = parent;
-		while (dentry && !lockref_put_or_lock(&dentry->d_lockref)) {
-			parent = lock_parent(dentry);
-			if (dentry->d_lockref.count != 1) {
-				dentry->d_lockref.count--;
-				spin_unlock(&dentry->d_lock);
-				if (parent)
-					spin_unlock(&parent->d_lock);
-				break;
-			}
-			inode = dentry->d_inode;	/* can't be NULL */
-			if (unlikely(!spin_trylock(&inode->i_lock))) {
-				spin_unlock(&dentry->d_lock);
-				if (parent)
-					spin_unlock(&parent->d_lock);
-				cpu_relax();
-				continue;
-			}
-			__dentry_kill(dentry);
-			dentry = parent;
-		}
+		while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
+			dentry = dentry_kill(dentry);
 	}
 }
 
-- 
2.11.0
