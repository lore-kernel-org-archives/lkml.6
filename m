Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB183C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76570214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeloVXpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76570214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeJICHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeJICHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:07:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D80D204FD;
        Mon,  8 Oct 2018 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024832;
        bh=rnf8K0v6DcAeofiHKVlwpgH0GMtISKd3mR42TYFkMgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeloVXpyLX5S/VtkcM2AGqLAjA8Y1x2+9ZJbMTyNd0P+mHBdiMxFFJbQMhpqo4EsH
         mGyl6Mw/eWXk5GmminURlFwArMhhCluWYMC2U93lHyasype+VLXyODo62M6Vn10MVM
         7nXR9aKolark0VJrvN2xh6PnlcdcAamwJCujVtBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 4.18 144/168] new primitive: discard_new_inode()
Date:   Mon,  8 Oct 2018 20:32:04 +0200
Message-Id: <20181008175625.505155604@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit c2b6d621c4ffe9936adf7a55c8b1c769672c306f upstream.

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

[Fix by Dan Carpenter <dan.carpenter@oracle.com> folded in]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c        |    2 +-
 fs/inode.c         |   45 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |    6 +++++-
 3 files changed, 47 insertions(+), 6 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1890,7 +1890,7 @@ void d_instantiate_new(struct dentry *en
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode->i_state & I_NEW));
-	inode->i_state &= ~I_NEW;
+	inode->i_state &= ~I_NEW & ~I_CREATING;
 	smp_mb();
 	wake_up_bit(&inode->i_state, __I_NEW);
 	spin_unlock(&inode->i_lock);
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -804,6 +804,10 @@ repeat:
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
@@ -831,6 +835,10 @@ repeat:
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
@@ -961,13 +969,26 @@ void unlock_new_inode(struct inode *inod
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
@@ -1039,6 +1060,8 @@ again:
 		 * Use the old inode instead of the preallocated one.
 		 */
 		spin_unlock(&inode_hash_lock);
+		if (IS_ERR(old))
+			return NULL;
 		wait_on_inode(old);
 		if (unlikely(inode_unhashed(old))) {
 			iput(old);
@@ -1128,6 +1151,8 @@ again:
 	inode = find_inode_fast(sb, head, ino);
 	spin_unlock(&inode_hash_lock);
 	if (inode) {
+		if (IS_ERR(inode))
+			return NULL;
 		wait_on_inode(inode);
 		if (unlikely(inode_unhashed(inode))) {
 			iput(inode);
@@ -1165,6 +1190,8 @@ again:
 		 */
 		spin_unlock(&inode_hash_lock);
 		destroy_inode(inode);
+		if (IS_ERR(old))
+			return NULL;
 		inode = old;
 		wait_on_inode(inode);
 		if (unlikely(inode_unhashed(inode))) {
@@ -1282,7 +1309,7 @@ struct inode *ilookup5_nowait(struct sup
 	inode = find_inode(sb, head, test, data);
 	spin_unlock(&inode_hash_lock);
 
-	return inode;
+	return IS_ERR(inode) ? NULL : inode;
 }
 EXPORT_SYMBOL(ilookup5_nowait);
 
@@ -1338,6 +1365,8 @@ again:
 	spin_unlock(&inode_hash_lock);
 
 	if (inode) {
+		if (IS_ERR(inode))
+			return NULL;
 		wait_on_inode(inode);
 		if (unlikely(inode_unhashed(inode))) {
 			iput(inode);
@@ -1421,12 +1450,17 @@ int insert_inode_locked(struct inode *in
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
+			spin_unlock(&inode_hash_lock);
+			return -EBUSY;
+		}
 		__iget(old);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
@@ -1443,7 +1477,10 @@ EXPORT_SYMBOL(insert_inode_locked);
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
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2014,6 +2014,8 @@ static inline void init_sync_kiocb(struc
  * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
  *			and work dirs among overlayfs mounts.
  *
+ * I_CREATING		New object's inode in the middle of setting up.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2034,7 +2036,8 @@ static inline void init_sync_kiocb(struc
 #define __I_DIRTY_TIME_EXPIRED	12
 #define I_DIRTY_TIME_EXPIRED	(1 << __I_DIRTY_TIME_EXPIRED)
 #define I_WB_SWITCH		(1 << 13)
-#define I_OVL_INUSE			(1 << 14)
+#define I_OVL_INUSE		(1 << 14)
+#define I_CREATING		(1 << 15)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -2918,6 +2921,7 @@ extern void lockdep_annotate_inode_mutex
 static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 #endif
 extern void unlock_new_inode(struct inode *);
+extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
 


