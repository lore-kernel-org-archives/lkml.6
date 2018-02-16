Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966879AbeBPPKx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:10:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966522AbeBPPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:10:10 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fs/dcache: Move dentry_kill() below lock_parent()
Date: Fri, 16 Feb 2018 16:09:31 +0100
Message-Id: <20180216150933.971-3-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180216150933.971-1-john.ogness@linutronix.de>
References: <20180216150933.971-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will modify dentry_kill() to call lock_parent().
Move the dentry_kill() implementation "as is" below lock_parent()
first. This will help simplify the review of the subsequent patch
with dentry_kill() changes.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/dcache.c | 62 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3c7e0148b453..9fed398687c9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -589,37 +589,6 @@ static void __dentry_kill(struct dentry *dentry)
 		dentry_free(dentry);
 }
 
-/*
- * Finish off a dentry we've decided to kill.
- * dentry->d_lock must be held, returns with it unlocked.
- * Returns dentry requiring refcount drop, or NULL if we're done.
- */
-static struct dentry *dentry_kill(struct dentry *dentry)
-	__releases(dentry->d_lock)
-{
-	struct inode *inode = dentry->d_inode;
-	struct dentry *parent = NULL;
-
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
-		goto failed;
-
-	if (!IS_ROOT(dentry)) {
-		parent = dentry->d_parent;
-		if (unlikely(!spin_trylock(&parent->d_lock))) {
-			if (inode)
-				spin_unlock(&inode->i_lock);
-			goto failed;
-		}
-	}
-
-	__dentry_kill(dentry);
-	return parent;
-
-failed:
-	spin_unlock(&dentry->d_lock);
-	return dentry; /* try again with same dentry */
-}
-
 static inline struct dentry *lock_parent(struct dentry *dentry)
 {
 	struct dentry *parent = dentry->d_parent;
@@ -655,6 +624,37 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 }
 
 /*
+ * Finish off a dentry we've decided to kill.
+ * dentry->d_lock must be held, returns with it unlocked.
+ * Returns dentry requiring refcount drop, or NULL if we're done.
+ */
+static struct dentry *dentry_kill(struct dentry *dentry)
+	__releases(dentry->d_lock)
+{
+	struct inode *inode = dentry->d_inode;
+	struct dentry *parent = NULL;
+
+	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
+		goto failed;
+
+	if (!IS_ROOT(dentry)) {
+		parent = dentry->d_parent;
+		if (unlikely(!spin_trylock(&parent->d_lock))) {
+			if (inode)
+				spin_unlock(&inode->i_lock);
+			goto failed;
+		}
+	}
+
+	__dentry_kill(dentry);
+	return parent;
+
+failed:
+	spin_unlock(&dentry->d_lock);
+	return dentry; /* try again with same dentry */
+}
+
+/*
  * Try to do a lockless dput(), and return whether that was successful.
  *
  * If unsuccessful, we return false, having already taken the dentry lock.
-- 
2.11.0
