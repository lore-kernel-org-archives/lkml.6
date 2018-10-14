Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886EC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637CA20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637CA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbeJNXlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35877 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbeJNXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLd-0004io-Ex; Sun, 14 Oct 2018 16:30:29 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000Zz-7Z; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chris Mason" <clm@fb.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.393527941@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 282/366] Btrfs: use insert_inode_locked4 for inode
 creation
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Mason <clm@fb.com>

commit b0d5d10f41a0f1cd839408dd94427f2db3553bca upstream.

Btrfs was inserting inodes into the hash table before we had fully
set the inode up on disk.  This leaves us open to rare races that allow
two different inodes in memory for the same [root, inode] pair.

This patch fixes things by using insert_inode_locked4 to insert an I_NEW
inode and unlock_new_inode when we're ready for the rest of the kernel
to use the inode.

It also makes sure to init the operations pointers on the inode before
going into the error handling paths.

Signed-off-by: Chris Mason <clm@fb.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 176 +++++++++++++++++++++++++++++------------------
 1 file changed, 109 insertions(+), 67 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5702,6 +5702,17 @@ int btrfs_set_inode_index(struct inode *
 	return ret;
 }
 
+static int btrfs_insert_inode_locked(struct inode *inode)
+{
+	struct btrfs_iget_args args;
+	args.location = &BTRFS_I(inode)->location;
+	args.root = BTRFS_I(inode)->root;
+
+	return insert_inode_locked4(inode,
+		   btrfs_inode_hash(inode->i_ino, BTRFS_I(inode)->root),
+		   btrfs_find_actor, &args);
+}
+
 static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
 				     struct inode *dir,
@@ -5794,10 +5805,19 @@ static struct inode *btrfs_new_inode(str
 		sizes[1] = name_len + sizeof(*ref);
 	}
 
+	location = &BTRFS_I(inode)->location;
+	location->objectid = objectid;
+	location->offset = 0;
+	btrfs_set_key_type(location, BTRFS_INODE_ITEM_KEY);
+
+	ret = btrfs_insert_inode_locked(inode);
+	if (ret < 0)
+		goto fail;
+
 	path->leave_spinning = 1;
 	ret = btrfs_insert_empty_items(trans, root, path, key, sizes, nitems);
 	if (ret != 0)
-		goto fail;
+		goto fail_unlock;
 
 	inode_init_owner(inode, dir, mode);
 	inode_set_bytes(inode, 0);
@@ -5820,11 +5840,6 @@ static struct inode *btrfs_new_inode(str
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_free_path(path);
 
-	location = &BTRFS_I(inode)->location;
-	location->objectid = objectid;
-	location->offset = 0;
-	btrfs_set_key_type(location, BTRFS_INODE_ITEM_KEY);
-
 	btrfs_inherit_iflags(inode, dir);
 
 	if (S_ISREG(mode)) {
@@ -5835,7 +5850,6 @@ static struct inode *btrfs_new_inode(str
 				BTRFS_INODE_NODATASUM;
 	}
 
-	btrfs_insert_inode_hash(inode);
 	inode_tree_add(inode);
 
 	trace_btrfs_inode_new(inode);
@@ -5850,6 +5864,9 @@ static struct inode *btrfs_new_inode(str
 			  btrfs_ino(inode), root->root_key.objectid, ret);
 
 	return inode;
+
+fail_unlock:
+	unlock_new_inode(inode);
 fail:
 	if (dir && name)
 		BTRFS_I(dir)->index_cnt--;
@@ -5984,28 +6001,28 @@ static int btrfs_mknod(struct inode *dir
 		goto out_unlock;
 	}
 
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err) {
-		drop_inode = 1;
-		goto out_unlock;
-	}
-
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
 	* if the filesystem supports xattrs by looking at the
 	* ops vector.
 	*/
-
 	inode->i_op = &btrfs_special_inode_operations;
-	err = btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
+	init_special_inode(inode, inode->i_mode, rdev);
+
+	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		drop_inode = 1;
-	else {
-		init_special_inode(inode, inode->i_mode, rdev);
+		goto out_unlock_inode;
+
+	err = btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
+	if (err) {
+		goto out_unlock_inode;
+	} else {
 		btrfs_update_inode(trans, root, inode);
+		unlock_new_inode(inode);
 		d_instantiate(dentry, inode);
 	}
+
 out_unlock:
 	btrfs_end_transaction(trans, root);
 	btrfs_balance_delayed_items(root);
@@ -6015,6 +6032,12 @@ out_unlock:
 		iput(inode);
 	}
 	return err;
+
+out_unlock_inode:
+	drop_inode = 1;
+	unlock_new_inode(inode);
+	goto out_unlock;
+
 }
 
 static int btrfs_create(struct inode *dir, struct dentry *dentry,
@@ -6049,15 +6072,6 @@ static int btrfs_create(struct inode *di
 		goto out_unlock;
 	}
 	drop_inode_on_err = 1;
-
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err)
-		goto out_unlock;
-
-	err = btrfs_update_inode(trans, root, inode);
-	if (err)
-		goto out_unlock;
-
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
@@ -6066,14 +6080,23 @@ static int btrfs_create(struct inode *di
 	*/
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops = &btrfs_aops;
+	inode->i_mapping->backing_dev_info = &root->fs_info->bdi;
+
+	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
+	if (err)
+		goto out_unlock_inode;
+
+	err = btrfs_update_inode(trans, root, inode);
+	if (err)
+		goto out_unlock_inode;
 
 	err = btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
 	if (err)
-		goto out_unlock;
+		goto out_unlock_inode;
 
-	inode->i_mapping->a_ops = &btrfs_aops;
-	inode->i_mapping->backing_dev_info = &root->fs_info->bdi;
 	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
+	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
 
 out_unlock:
@@ -6085,6 +6108,11 @@ out_unlock:
 	btrfs_balance_delayed_items(root);
 	btrfs_btree_balance_dirty(root);
 	return err;
+
+out_unlock_inode:
+	unlock_new_inode(inode);
+	goto out_unlock;
+
 }
 
 static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
@@ -6192,25 +6220,30 @@ static int btrfs_mkdir(struct inode *dir
 	}
 
 	drop_on_err = 1;
+	/* these must be set before we unlock the inode */
+	inode->i_op = &btrfs_dir_inode_operations;
+	inode->i_fop = &btrfs_dir_file_operations;
 
 	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		goto out_fail;
-
-	inode->i_op = &btrfs_dir_inode_operations;
-	inode->i_fop = &btrfs_dir_file_operations;
+		goto out_fail_inode;
 
 	btrfs_i_size_write(inode, 0);
 	err = btrfs_update_inode(trans, root, inode);
 	if (err)
-		goto out_fail;
+		goto out_fail_inode;
 
 	err = btrfs_add_link(trans, dir, inode, dentry->d_name.name,
 			     dentry->d_name.len, 0, index);
 	if (err)
-		goto out_fail;
+		goto out_fail_inode;
 
 	d_instantiate(dentry, inode);
+	/*
+	 * mkdir is special.  We're unlocking after we call d_instantiate
+	 * to avoid a race with nfsd calling d_instantiate.
+	 */
+	unlock_new_inode(inode);
 	drop_on_err = 0;
 
 out_fail:
@@ -6220,6 +6253,10 @@ out_fail:
 	btrfs_balance_delayed_items(root);
 	btrfs_btree_balance_dirty(root);
 	return err;
+
+out_fail_inode:
+	unlock_new_inode(inode);
+	goto out_fail;
 }
 
 /* helper for btfs_get_extent.  Given an existing extent in the tree,
@@ -8173,6 +8210,7 @@ int btrfs_create_subvol_root(struct btrf
 
 	set_nlink(inode, 1);
 	btrfs_i_size_write(inode, 0);
+	unlock_new_inode(inode);
 
 	err = btrfs_subvol_inherit_props(trans, new_root, parent_root);
 	if (err)
@@ -8823,12 +8861,6 @@ static int btrfs_symlink(struct inode *d
 		goto out_unlock;
 	}
 
-	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err) {
-		drop_inode = 1;
-		goto out_unlock;
-	}
-
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
@@ -8837,23 +8869,22 @@ static int btrfs_symlink(struct inode *d
 	*/
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops = &btrfs_aops;
+	inode->i_mapping->backing_dev_info = &root->fs_info->bdi;
+	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
+
+	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
+	if (err)
+		goto out_unlock_inode;
 
 	err = btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
 	if (err)
-		drop_inode = 1;
-	else {
-		inode->i_mapping->a_ops = &btrfs_aops;
-		inode->i_mapping->backing_dev_info = &root->fs_info->bdi;
-		BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
-	}
-	if (drop_inode)
-		goto out_unlock;
+		goto out_unlock_inode;
 
 	path = btrfs_alloc_path();
 	if (!path) {
 		err = -ENOMEM;
-		drop_inode = 1;
-		goto out_unlock;
+		goto out_unlock_inode;
 	}
 	key.objectid = btrfs_ino(inode);
 	key.offset = 0;
@@ -8862,9 +8893,8 @@ static int btrfs_symlink(struct inode *d
 	err = btrfs_insert_empty_item(trans, root, path, &key,
 				      datasize);
 	if (err) {
-		drop_inode = 1;
 		btrfs_free_path(path);
-		goto out_unlock;
+		goto out_unlock_inode;
 	}
 	leaf = path->nodes[0];
 	ei = btrfs_item_ptr(leaf, path->slots[0],
@@ -8888,12 +8918,15 @@ static int btrfs_symlink(struct inode *d
 	inode_set_bytes(inode, name_len);
 	btrfs_i_size_write(inode, name_len);
 	err = btrfs_update_inode(trans, root, inode);
-	if (err)
+	if (err) {
 		drop_inode = 1;
+		goto out_unlock_inode;
+	}
+
+	unlock_new_inode(inode);
+	d_instantiate(dentry, inode);
 
 out_unlock:
-	if (!err)
-		d_instantiate(dentry, inode);
 	btrfs_end_transaction(trans, root);
 	if (drop_inode) {
 		inode_dec_link_count(inode);
@@ -8901,6 +8934,11 @@ out_unlock:
 	}
 	btrfs_btree_balance_dirty(root);
 	return err;
+
+out_unlock_inode:
+	drop_inode = 1;
+	unlock_new_inode(inode);
+	goto out_unlock;
 }
 
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
@@ -9084,14 +9122,6 @@ static int btrfs_tmpfile(struct inode *d
 		goto out;
 	}
 
-	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
-	if (ret)
-		goto out;
-
-	ret = btrfs_update_inode(trans, root, inode);
-	if (ret)
-		goto out;
-
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 
@@ -9099,9 +9129,16 @@ static int btrfs_tmpfile(struct inode *d
 	inode->i_mapping->backing_dev_info = &root->fs_info->bdi;
 	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
 
+	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
+	if (ret)
+		goto out_inode;
+
+	ret = btrfs_update_inode(trans, root, inode);
+	if (ret)
+		goto out_inode;
 	ret = btrfs_orphan_add(trans, inode);
 	if (ret)
-		goto out;
+		goto out_inode;
 
 	/*
 	 * We set number of links to 0 in btrfs_new_inode(), and here we set
@@ -9111,6 +9148,7 @@ static int btrfs_tmpfile(struct inode *d
 	 *    d_tmpfile() -> inode_dec_link_count() -> drop_nlink()
 	 */
 	set_nlink(inode, 1);
+	unlock_new_inode(inode);
 	d_tmpfile(dentry, inode);
 	mark_inode_dirty(inode);
 
@@ -9120,8 +9158,12 @@ out:
 		iput(inode);
 	btrfs_balance_delayed_items(root);
 	btrfs_btree_balance_dirty(root);
-
 	return ret;
+
+out_inode:
+	unlock_new_inode(inode);
+	goto out;
+
 }
 
 static const struct inode_operations btrfs_dir_inode_operations = {

