Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DCC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B5E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B5E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeJNXdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:33:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36125 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cm-21; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000eC-Ov; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mike Marshall" <hubcap@omnibond.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Andreas Dilger" <adilger@dilger.ca>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.828034507@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 293/366] do d_instantiate/unlock_new_inode
 combinations safely
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 1e2e547a93a00ebc21582c06ca3c6cfea2a309ee upstream.

For anything NFS-exported we do _not_ want to unlock new inode
before it has grown an alias; original set of fixes got the
ordering right, but missed the nasty complication in case of
lockdep being enabled - unlock_new_inode() does
	lockdep_annotate_inode_mutex_key(inode)
which can only be done before anyone gets a chance to touch
->i_mutex.  Unfortunately, flipping the order and doing
unlock_new_inode() before d_instantiate() opens a window when
mkdir can race with open-by-fhandle on a guessed fhandle, leading
to multiple aliases for a directory inode and all the breakage
that follows from that.

	Correct solution: a new primitive (d_instantiate_new())
combining these two in the right order - lockdep annotate, then
d_instantiate(), then the rest of unlock_new_inode().  All
combinations of d_instantiate() with unlock_new_inode() should
be converted to that.

Tested-by: Mike Marshall <hubcap@omnibond.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16:
 - Drop changes in orangefs
 - Apply similar change to ext3
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6019,8 +6019,7 @@ static int btrfs_mknod(struct inode *dir
 		goto out_unlock_inode;
 	} else {
 		btrfs_update_inode(trans, root, inode);
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 	}
 
 out_unlock:
@@ -6096,8 +6095,7 @@ static int btrfs_create(struct inode *di
 		goto out_unlock_inode;
 
 	BTRFS_I(inode)->io_tree.ops = &btrfs_extent_io_ops;
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 
 out_unlock:
 	btrfs_end_transaction(trans, root);
@@ -6238,12 +6236,7 @@ static int btrfs_mkdir(struct inode *dir
 	if (err)
 		goto out_fail_inode;
 
-	d_instantiate(dentry, inode);
-	/*
-	 * mkdir is special.  We're unlocking after we call d_instantiate
-	 * to avoid a race with nfsd calling d_instantiate.
-	 */
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	drop_on_err = 0;
 
 out_fail:
@@ -8926,8 +8919,7 @@ static int btrfs_symlink(struct inode *d
 		goto out_unlock_inode;
 	}
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 
 out_unlock:
 	btrfs_end_transaction(trans, root);
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1680,6 +1680,28 @@ void d_instantiate(struct dentry *entry,
 }
 EXPORT_SYMBOL(d_instantiate);
 
+/*
+ * This should be equivalent to d_instantiate() + unlock_new_inode(),
+ * with lockdep-related part of unlock_new_inode() done before
+ * anything else.  Use that instead of open-coding d_instantiate()/
+ * unlock_new_inode() combinations.
+ */
+void d_instantiate_new(struct dentry *entry, struct inode *inode)
+{
+	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
+	BUG_ON(!inode);
+	lockdep_annotate_inode_mutex_key(inode);
+	security_d_instantiate(entry, inode);
+	spin_lock(&inode->i_lock);
+	__d_instantiate(entry, inode);
+	WARN_ON(!(inode->i_state & I_NEW));
+	inode->i_state &= ~I_NEW;
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_NEW);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL(d_instantiate_new);
+
 /**
  * d_instantiate_unique - instantiate a non-aliased dentry
  * @entry: dentry to instantiate
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -298,8 +298,7 @@ ecryptfs_create(struct inode *directory_
 		iput(ecryptfs_inode);
 		goto out;
 	}
-	unlock_new_inode(ecryptfs_inode);
-	d_instantiate(ecryptfs_dentry, ecryptfs_inode);
+	d_instantiate_new(ecryptfs_dentry, ecryptfs_inode);
 out:
 	return rc;
 }
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -41,8 +41,7 @@ static inline int ext2_add_nondir(struct
 {
 	int err = ext2_add_link(dentry, inode);
 	if (!err) {
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
@@ -265,8 +264,7 @@ static int ext2_mkdir(struct inode * dir
 	if (err)
 		goto out_fail;
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 out:
 	return err;
 
--- a/fs/ext3/namei.c
+++ b/fs/ext3/namei.c
@@ -1671,8 +1671,7 @@ static int ext3_add_nondir(handle_t *han
 	int err = ext3_add_entry(handle, dentry, inode);
 	if (!err) {
 		ext3_mark_inode_dirty(handle, inode);
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	drop_nlink(inode);
@@ -1873,8 +1872,7 @@ out_clear_inode:
 	if (err)
 		goto out_clear_inode;
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 out_stop:
 	brelse(dir_block);
 	ext3_journal_stop(handle);
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2227,8 +2227,7 @@ static int ext4_add_nondir(handle_t *han
 	int err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
 		ext4_mark_inode_dirty(handle, inode);
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	drop_nlink(inode);
@@ -2466,8 +2465,7 @@ out_clear_inode:
 	err = ext4_mark_inode_dirty(handle, dir);
 	if (err)
 		goto out_clear_inode;
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -127,8 +127,7 @@ static int f2fs_create(struct inode *dir
 
 	alloc_nid_done(sbi, ino);
 
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 out:
 	handle_failed_inode(inode);
@@ -260,8 +259,7 @@ static int f2fs_symlink(struct inode *di
 	err = page_symlink(inode, symname, symlen);
 	alloc_nid_done(sbi, inode->i_ino);
 
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	return err;
 out:
 	handle_failed_inode(inode);
@@ -294,8 +292,7 @@ static int f2fs_mkdir(struct inode *dir,
 
 	alloc_nid_done(sbi, inode->i_ino);
 
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 
 	return 0;
 
@@ -340,8 +337,7 @@ static int f2fs_mknod(struct inode *dir,
 	f2fs_unlock_op(sbi);
 
 	alloc_nid_done(sbi, inode->i_ino);
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 out:
 	handle_failed_inode(inode);
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -207,8 +207,7 @@ static int jffs2_create(struct inode *di
 		  __func__, inode->i_ino, inode->i_mode, inode->i_nlink,
 		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 
  fail:
@@ -427,8 +426,7 @@ static int jffs2_symlink (struct inode *
 	mutex_unlock(&dir_f->sem);
 	jffs2_complete_reservation(c);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 
  fail:
@@ -572,8 +570,7 @@ static int jffs2_mkdir (struct inode *di
 	mutex_unlock(&dir_f->sem);
 	jffs2_complete_reservation(c);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 
  fail:
@@ -747,8 +744,7 @@ static int jffs2_mknod (struct inode *di
 	mutex_unlock(&dir_f->sem);
 	jffs2_complete_reservation(c);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 
  fail:
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -176,8 +176,7 @@ static int jfs_create(struct inode *dip,
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
 
       out2:
@@ -309,8 +308,7 @@ static int jfs_mkdir(struct inode *dip,
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
 
       out2:
@@ -1043,8 +1041,7 @@ static int jfs_symlink(struct inode *dip
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
 
       out2:
@@ -1424,8 +1421,7 @@ static int jfs_mknod(struct inode *dir,
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
 
       out1:
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -50,8 +50,7 @@ static inline int nilfs_add_nondir(struc
 {
 	int err = nilfs_add_link(dentry, inode);
 	if (!err) {
-		d_instantiate(dentry, inode);
-		unlock_new_inode(inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
@@ -249,8 +248,7 @@ static int nilfs_mkdir(struct inode *dir
 		goto out_fail;
 
 	nilfs_mark_inode_dirty(inode);
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 out:
 	if (!err)
 		err = nilfs_transaction_commit(dir->i_sb);
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -682,8 +682,7 @@ static int reiserfs_create(struct inode
 	reiserfs_update_inode_transaction(inode);
 	reiserfs_update_inode_transaction(dir);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval = journal_end(&th);
 
 out_failed:
@@ -763,8 +762,7 @@ static int reiserfs_mknod(struct inode *
 		goto out_failed;
 	}
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval = journal_end(&th);
 
 out_failed:
@@ -857,8 +855,7 @@ static int reiserfs_mkdir(struct inode *
 	/* the above add_entry did not update dir's stat data */
 	reiserfs_update_sd(&th, dir);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval = journal_end(&th);
 out_failed:
 	reiserfs_write_unlock(dir->i_sb);
@@ -1162,8 +1159,7 @@ static int reiserfs_symlink(struct inode
 		goto out_failed;
 	}
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval = journal_end(&th);
 out_failed:
 	reiserfs_write_unlock(parent_dir->i_sb);
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -576,8 +576,7 @@ static int udf_add_nondir(struct dentry
 	if (fibh.sbh != fibh.ebh)
 		brelse(fibh.ebh);
 	brelse(fibh.sbh);
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 
 	return 0;
 }
@@ -697,8 +696,7 @@ static int udf_mkdir(struct inode *dir,
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	inc_nlink(dir);
 	mark_inode_dirty(dir);
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	if (fibh.sbh != fibh.ebh)
 		brelse(fibh.ebh);
 	brelse(fibh.sbh);
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -38,8 +38,7 @@ static inline int ufs_add_nondir(struct
 {
 	int err = ufs_add_link(dentry, inode);
 	if (!err) {
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
@@ -212,8 +211,7 @@ static int ufs_mkdir(struct inode * dir,
 		goto out_fail;
 	unlock_ufs(dir->i_sb);
 
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 out:
 	return err;
 
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -234,6 +234,7 @@ static inline int dname_external(const s
  * These are the low-level FS interfaces to the dcache..
  */
 extern void d_instantiate(struct dentry *, struct inode *);
+extern void d_instantiate_new(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern struct dentry * d_materialise_unique(struct dentry *, struct inode *);
 extern int d_instantiate_no_diralias(struct dentry *, struct inode *);

