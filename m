Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB80C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF8920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF8920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeJNXWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:22:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36194 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbeJNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cZ-8f; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000bA-Cx; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jaegeuk Kim" <jaegeuk@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.796499847@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 285/366] f2fs: call f2fs_unlock_op after error was
 handled
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 44c16156512f33c81e382a1e1df9524e26a7026a upstream.

This patch relocates f2fs_unlock_op in every directory operations to be called
after any error was processed.
Otherwise, the checkpoint can be entered with valid node ids without its
dentry when -ENOSPC is occurred.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 3.16:
 - Drop changes in f2fs_tmpfile()
 - Use F2FS_SB() instead of F2FS_I_SB()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/inode.c | 23 +++++++++++++++++++++++
 fs/f2fs/namei.c | 32 +++++++++++---------------------
 3 files changed, 35 insertions(+), 21 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1121,6 +1121,7 @@ void update_inode(struct inode *, struct
 void update_inode_page(struct inode *);
 int f2fs_write_inode(struct inode *, struct writeback_control *);
 void f2fs_evict_inode(struct inode *);
+void handle_failed_inode(struct inode *);
 
 /*
  * namei.c
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -299,3 +299,26 @@ no_delete:
 	clear_inode(inode);
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 }
+
+/* caller should call f2fs_lock_op() */
+void handle_failed_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+
+	clear_nlink(inode);
+	make_bad_inode(inode);
+	unlock_new_inode(inode);
+
+	i_size_write(inode, 0);
+	if (F2FS_HAS_BLOCKS(inode))
+		f2fs_truncate(inode);
+
+	remove_inode_page(inode);
+	stat_dec_inline_inode(inode);
+
+	alloc_nid_failed(sbi, inode->i_ino);
+	f2fs_unlock_op(sbi);
+
+	/* iput will drop the inode object */
+	iput(inode);
+}
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -124,9 +124,9 @@ static int f2fs_create(struct inode *dir
 
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
 
 	alloc_nid_done(sbi, ino);
 
@@ -134,9 +134,7 @@ static int f2fs_create(struct inode *dir
 	unlock_new_inode(inode);
 	return 0;
 out:
-	clear_nlink(inode);
-	iget_failed(inode);
-	alloc_nid_failed(sbi, ino);
+	handle_failed_inode(inode);
 	return err;
 }
 
@@ -156,15 +154,16 @@ static int f2fs_link(struct dentry *old_
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
 
 	d_instantiate(dentry, inode);
 	return 0;
 out:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	iput(inode);
+	f2fs_unlock_op(sbi);
 	return err;
 }
 
@@ -257,9 +256,9 @@ static int f2fs_symlink(struct inode *di
 
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
 
 	err = page_symlink(inode, symname, symlen);
 	alloc_nid_done(sbi, inode->i_ino);
@@ -268,9 +267,7 @@ static int f2fs_symlink(struct inode *di
 	unlock_new_inode(inode);
 	return err;
 out:
-	clear_nlink(inode);
-	iget_failed(inode);
-	alloc_nid_failed(sbi, inode->i_ino);
+	handle_failed_inode(inode);
 	return err;
 }
 
@@ -294,9 +291,9 @@ static int f2fs_mkdir(struct inode *dir,
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out_fail;
+	f2fs_unlock_op(sbi);
 
 	alloc_nid_done(sbi, inode->i_ino);
 
@@ -307,9 +304,7 @@ static int f2fs_mkdir(struct inode *dir,
 
 out_fail:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
-	clear_nlink(inode);
-	iget_failed(inode);
-	alloc_nid_failed(sbi, inode->i_ino);
+	handle_failed_inode(inode);
 	return err;
 }
 
@@ -343,18 +338,16 @@ static int f2fs_mknod(struct inode *dir,
 
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
 
 	alloc_nid_done(sbi, inode->i_ino);
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
 	return 0;
 out:
-	clear_nlink(inode);
-	iget_failed(inode);
-	alloc_nid_failed(sbi, inode->i_ino);
+	handle_failed_inode(inode);
 	return err;
 }
 

