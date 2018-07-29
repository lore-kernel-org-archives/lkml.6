Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658FBC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D56C20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D56C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeG2Xhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:37:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51576 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeG2Xg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003VH-0K; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 02/16] new primitive: discard_new_inode()
Date:   Sun, 29 Jul 2018 23:04:39 +0100
Message-Id: <20180729220453.13431-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

	We don't want open-by-handle picking half-set-up in-core
struct inode from e.g. mkdir() having failed halfway through.
In other words, we don't want such inodes returned by iget_locked()
on their way to extinction.  However, we can't just have them
unhashed - otherwise open-by-handle immediately *after* that would've
ended up creating a new in-core inode over the on-disk one that
is in process of being freed right under us.

	Solution: new flag (I_CREATING) set by insert_inode_locked() and
removed by unlock_new_inode() and a new primitive (discard_new_inode())
to be used by such halfway-through-setup failure exits instead of
unlock_new_inode() / iput() combinations.  That primitive unlocks new
inode, but leaves I_CREATING in place.

	iget_locked() treats finding an I_CREATING inode as failure
(-ESTALE, once we sort out the error propagation).
	insert_inode_locked() treats the same as instant -EBUSY.
	ilookup() treats those as icache miss.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/inode.c         | 44 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  6 +++++-
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2c300e981796..04dd7e0d5142 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -804,6 +804,10 @@ static struct inode *find_inode(struct super_block *sb,
 			__wait_on_freeing_inode(inode);
 			goto repeat;
 		}
+		if (unlikely(inode->i_state & I_CREATING)) {
+			spin_unlock(&inode->i_lock);
+			return ERR_PTR(-ESTALE);
+		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		return inode;
@@ -831,6 +835,10 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			__wait_on_freeing_inode(inode);
 			goto repeat;
 		}
+		if (unlikely(inode->i_state & I_CREATING)) {
+			spin_unlock(&inode->i_lock);
+			return ERR_PTR(-ESTALE);
+		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		return inode;
@@ -961,13 +969,26 @@ void unlock_new_inode(struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	spin_lock(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW;
+	inode->i_state &= ~I_NEW & ~I_CREATING;
 	smp_mb();
 	wake_up_bit(&inode->i_state, __I_NEW);
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(unlock_new_inode);
 
+void discard_new_inode(struct inode *inode)
+{
+	lockdep_annotate_inode_mutex_key(inode);
+	spin_lock(&inode->i_lock);
+	WARN_ON(!(inode->i_state & I_NEW));
+	inode->i_state &= ~I_NEW;
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_NEW);
+	spin_unlock(&inode->i_lock);
+	iput(inode);
+}
+EXPORT_SYMBOL(discard_new_inode);
+
 /**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
@@ -1039,6 +1060,8 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 		 * Use the old inode instead of the preallocated one.
 		 */
 		spin_unlock(&inode_hash_lock);
+		if (IS_ERR(old))
+			return NULL;
 		wait_on_inode(old);
 		if (unlikely(inode_unhashed(old))) {
 			iput(old);
@@ -1128,6 +1151,8 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 	inode = find_inode_fast(sb, head, ino);
 	spin_unlock(&inode_hash_lock);
 	if (inode) {
+		if (IS_ERR(inode))
+			return NULL;
 		wait_on_inode(inode);
 		if (unlikely(inode_unhashed(inode))) {
 			iput(inode);
@@ -1165,6 +1190,8 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		 */
 		spin_unlock(&inode_hash_lock);
 		destroy_inode(inode);
+		if (IS_ERR(old))
+			return NULL;
 		inode = old;
 		wait_on_inode(inode);
 		if (unlikely(inode_unhashed(inode))) {
@@ -1282,7 +1309,7 @@ struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 	inode = find_inode(sb, head, test, data);
 	spin_unlock(&inode_hash_lock);
 
-	return inode;
+	return IS_ERR(inode) ? NULL : inode;
 }
 EXPORT_SYMBOL(ilookup5_nowait);
 
@@ -1338,6 +1365,8 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	spin_unlock(&inode_hash_lock);
 
 	if (inode) {
+		if (IS_ERR(inode))
+			return NULL;
 		wait_on_inode(inode);
 		if (unlikely(inode_unhashed(inode))) {
 			iput(inode);
@@ -1421,12 +1450,16 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
-			inode->i_state |= I_NEW;
+			inode->i_state |= I_NEW | I_CREATING;
 			hlist_add_head(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		if (unlikely(old->i_state & I_CREATING)) {
+			spin_unlock(&old->i_lock);
+			return -EBUSY;
+		}
 		__iget(old);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
@@ -1443,7 +1476,10 @@ EXPORT_SYMBOL(insert_inode_locked);
 int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct inode *old = inode_insert5(inode, hashval, test, NULL, data);
+	struct inode *old;
+
+	inode->i_state |= I_CREATING;
+	old = inode_insert5(inode, hashval, test, NULL, data);
 
 	if (old != inode) {
 		iput(old);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5c91108846db..a42600565925 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2016,6 +2016,8 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
  * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
  *			and work dirs among overlayfs mounts.
  *
+ * I_CREATING		New object's inode in the middle of setting up.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2036,7 +2038,8 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 #define __I_DIRTY_TIME_EXPIRED	12
 #define I_DIRTY_TIME_EXPIRED	(1 << __I_DIRTY_TIME_EXPIRED)
 #define I_WB_SWITCH		(1 << 13)
-#define I_OVL_INUSE			(1 << 14)
+#define I_OVL_INUSE		(1 << 14)
+#define I_CREATING		(1 << 15)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -2919,6 +2922,7 @@ extern void lockdep_annotate_inode_mutex_key(struct inode *inode);
 static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 #endif
 extern void unlock_new_inode(struct inode *);
+extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
 
-- 
2.11.0

