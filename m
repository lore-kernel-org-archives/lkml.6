Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E871C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E586C20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E586C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51564 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto6-0003VP-7Q; Sun, 29 Jul 2018 22:04:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 04/16] btrfs: switch to discard_new_inode()
Date:   Sun, 29 Jul 2018 23:04:41 +0100
Message-Id: <20180729220453.13431-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
 <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Make sure that no partially set up inodes can be returned by
open-by-handle.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/inode.c | 106 ++++++++++++++++++++-----------------------------------
 1 file changed, 39 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e9482f0db9d0..9382e0881900 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6335,8 +6335,10 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	location->type = BTRFS_INODE_ITEM_KEY;
 
 	ret = btrfs_insert_inode_locked(inode);
-	if (ret < 0)
+	if (ret < 0) {
+		iput(inode);
 		goto fail;
+	}
 
 	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_items(trans, root, path, key, sizes, nitems);
@@ -6395,12 +6397,11 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	return inode;
 
 fail_unlock:
-	unlock_new_inode(inode);
+	discard_new_inode(inode);
 fail:
 	if (dir && name)
 		BTRFS_I(dir)->index_cnt--;
 	btrfs_free_path(path);
-	iput(inode);
 	return ERR_PTR(ret);
 }
 
@@ -6505,7 +6506,6 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
 	int err;
-	int drop_inode = 0;
 	u64 objectid;
 	u64 index = 0;
 
@@ -6527,6 +6527,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 			mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
+		inode = NULL;
 		goto out_unlock;
 	}
 
@@ -6541,31 +6542,24 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		goto out_unlock_inode;
+		goto out_unlock;
 
 	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
 			0, index);
-	if (err) {
-		goto out_unlock_inode;
-	} else {
-		btrfs_update_inode(trans, root, inode);
-		d_instantiate_new(dentry, inode);
-	}
+	if (err)
+		goto out_unlock;
+
+	btrfs_update_inode(trans, root, inode);
+	d_instantiate_new(dentry, inode);
 
 out_unlock:
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
-	if (drop_inode) {
+	if (err && inode) {
 		inode_dec_link_count(inode);
-		iput(inode);
+		discard_new_inode(inode);
 	}
 	return err;
-
-out_unlock_inode:
-	drop_inode = 1;
-	unlock_new_inode(inode);
-	goto out_unlock;
-
 }
 
 static int btrfs_create(struct inode *dir, struct dentry *dentry,
@@ -6575,7 +6569,6 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
-	int drop_inode_on_err = 0;
 	int err;
 	u64 objectid;
 	u64 index = 0;
@@ -6598,9 +6591,9 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 			mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
+		inode = NULL;
 		goto out_unlock;
 	}
-	drop_inode_on_err = 1;
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
@@ -6613,33 +6606,28 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		goto out_unlock_inode;
+		goto out_unlock;
 
 	err = btrfs_update_inode(trans, root, inode);
 	if (err)
-		goto out_unlock_inode;
+		goto out_unlock;
 
 	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
 			0, index);
 	if (err)
-		goto out_unlock_inode;
+		goto out_unlock;
 
 	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
 	btrfs_end_transaction(trans);
-	if (err && drop_inode_on_err) {
+	if (err && inode) {
 		inode_dec_link_count(inode);
-		iput(inode);
+		discard_new_inode(inode);
 	}
 	btrfs_btree_balance_dirty(fs_info);
 	return err;
-
-out_unlock_inode:
-	unlock_new_inode(inode);
-	goto out_unlock;
-
 }
 
 static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
@@ -6748,6 +6736,7 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 			S_IFDIR | mode, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
+		inode = NULL;
 		goto out_fail;
 	}
 
@@ -6758,34 +6747,30 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		goto out_fail_inode;
+		goto out_fail;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 	err = btrfs_update_inode(trans, root, inode);
 	if (err)
-		goto out_fail_inode;
+		goto out_fail;
 
 	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			dentry->d_name.name,
 			dentry->d_name.len, 0, index);
 	if (err)
-		goto out_fail_inode;
+		goto out_fail;
 
 	d_instantiate_new(dentry, inode);
 	drop_on_err = 0;
 
 out_fail:
 	btrfs_end_transaction(trans);
-	if (drop_on_err) {
+	if (err && inode) {
 		inode_dec_link_count(inode);
-		iput(inode);
+		discard_new_inode(inode);
 	}
 	btrfs_btree_balance_dirty(fs_info);
 	return err;
-
-out_fail_inode:
-	unlock_new_inode(inode);
-	goto out_fail;
 }
 
 static noinline int uncompress_inline(struct btrfs_path *path,
@@ -10112,7 +10097,6 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	struct btrfs_key key;
 	struct inode *inode = NULL;
 	int err;
-	int drop_inode = 0;
 	u64 objectid;
 	u64 index = 0;
 	int name_len;
@@ -10145,6 +10129,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 				objectid, S_IFLNK|S_IRWXUGO, &index);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
+		inode = NULL;
 		goto out_unlock;
 	}
 
@@ -10161,12 +10146,12 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		goto out_unlock_inode;
+		goto out_unlock;
 
 	path = btrfs_alloc_path();
 	if (!path) {
 		err = -ENOMEM;
-		goto out_unlock_inode;
+		goto out_unlock;
 	}
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 	key.offset = 0;
@@ -10176,7 +10161,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 				      datasize);
 	if (err) {
 		btrfs_free_path(path);
-		goto out_unlock_inode;
+		goto out_unlock;
 	}
 	leaf = path->nodes[0];
 	ei = btrfs_item_ptr(leaf, path->slots[0],
@@ -10208,26 +10193,19 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	if (!err)
 		err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry,
 				BTRFS_I(inode), 0, index);
-	if (err) {
-		drop_inode = 1;
-		goto out_unlock_inode;
-	}
+	if (err)
+		goto out_unlock;
 
 	d_instantiate_new(dentry, inode);
 
 out_unlock:
 	btrfs_end_transaction(trans);
-	if (drop_inode) {
+	if (err && inode) {
 		inode_dec_link_count(inode);
-		iput(inode);
+		discard_new_inode(inode);
 	}
 	btrfs_btree_balance_dirty(fs_info);
 	return err;
-
-out_unlock_inode:
-	drop_inode = 1;
-	unlock_new_inode(inode);
-	goto out_unlock;
 }
 
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
@@ -10436,14 +10414,14 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
 	if (ret)
-		goto out_inode;
+		goto out;
 
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret)
-		goto out_inode;
+		goto out;
 	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 	if (ret)
-		goto out_inode;
+		goto out;
 
 	/*
 	 * We set number of links to 0 in btrfs_new_inode(), and here we set
@@ -10453,21 +10431,15 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	 *    d_tmpfile() -> inode_dec_link_count() -> drop_nlink()
 	 */
 	set_nlink(inode, 1);
-	unlock_new_inode(inode);
 	d_tmpfile(dentry, inode);
+	unlock_new_inode(inode);
 	mark_inode_dirty(inode);
-
 out:
 	btrfs_end_transaction(trans);
-	if (ret)
-		iput(inode);
+	if (ret && inode)
+		discard_new_inode(inode);
 	btrfs_btree_balance_dirty(fs_info);
 	return ret;
-
-out_inode:
-	unlock_new_inode(inode);
-	goto out;
-
 }
 
 __attribute__((const))
-- 
2.11.0

