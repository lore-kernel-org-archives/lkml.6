Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F83C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEC820890
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC820890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeJNXc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:32:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36157 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbeJNXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:59 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLm-0004io-5j; Sun, 14 Oct 2018 16:30:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000d4-Fm; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jan Kara" <jack@suse.cz>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.53179729@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 288/366] udf: merge the pieces inserting a new
 non-directory object into directory
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

commit d2be51cb34dc501791f3b8c01a99a3f2064bd8d1 upstream.

boilerplate code in udf_{create,mknod,symlink} taken to new helper

symlink case converted to unique id calculated by udf_new_inode() - no
point finding a new one.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/udf/namei.c | 98 +++++++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 69 deletions(-)

--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -551,31 +551,16 @@ static int udf_delete_entry(struct inode
 	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
 }
 
-static int udf_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl)
+static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 {
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct inode *dir = dentry->d_parent->d_inode;
 	struct udf_fileident_bh fibh;
-	struct inode *inode;
 	struct fileIdentDesc cfi, *fi;
 	int err;
-	struct udf_inode_info *iinfo;
-
-	inode = udf_new_inode(dir, mode, &err);
-	if (!inode) {
-		return err;
-	}
-
-	iinfo = UDF_I(inode);
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		inode->i_data.a_ops = &udf_adinicb_aops;
-	else
-		inode->i_data.a_ops = &udf_aops;
-	inode->i_op = &udf_file_inode_operations;
-	inode->i_fop = &udf_file_operations;
-	mark_inode_dirty(inode);
 
 	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	if (unlikely(!fi)) {
 		inode_dec_link_count(inode);
 		iput(inode);
 		return err;
@@ -595,6 +580,28 @@ static int udf_create(struct inode *dir,
 	return 0;
 }
 
+static int udf_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+		      bool excl)
+{
+	struct inode *inode;
+	int err;
+
+	inode = udf_new_inode(dir, mode, &err);
+	if (!inode) {
+		return err;
+	}
+
+	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		inode->i_data.a_ops = &udf_adinicb_aops;
+	else
+		inode->i_data.a_ops = &udf_aops;
+	inode->i_op = &udf_file_inode_operations;
+	inode->i_fop = &udf_file_operations;
+	mark_inode_dirty(inode);
+
+	return udf_add_nondir(dentry, inode);
+}
+
 static int udf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
@@ -622,10 +629,7 @@ static int udf_mknod(struct inode *dir,
 		     dev_t rdev)
 {
 	struct inode *inode;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
 	int err;
-	struct udf_inode_info *iinfo;
 
 	if (!old_valid_dev(rdev))
 		return -EINVAL;
@@ -633,33 +637,10 @@ static int udf_mknod(struct inode *dir,
 	err = -EIO;
 	inode = udf_new_inode(dir, mode, &err);
 	if (!inode)
-		goto out;
-
-	iinfo = UDF_I(inode);
-	init_special_inode(inode, mode, rdev);
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
-		inode_dec_link_count(inode);
-		iput(inode);
 		return err;
-	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
-	mark_inode_dirty(inode);
-
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	d_instantiate(dentry, inode);
-	err = 0;
 
-out:
-	return err;
+	init_special_inode(inode, mode, rdev);
+	return udf_add_nondir(dentry, inode);
 }
 
 static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
@@ -880,11 +861,8 @@ static int udf_symlink(struct inode *dir
 	struct inode *inode;
 	struct pathComponent *pc;
 	const char *compstart;
-	struct udf_fileident_bh fibh;
 	struct extent_position epos = {};
 	int eoffset, elen = 0;
-	struct fileIdentDesc *fi;
-	struct fileIdentDesc cfi;
 	uint8_t *ea;
 	int err;
 	int block;
@@ -1013,31 +991,13 @@ static int udf_symlink(struct inode *dir
 	mark_inode_dirty(inode);
 	up_write(&iinfo->i_data_sem);
 
-	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi)
-		goto out_fail;
-	cfi.icb.extLength = cpu_to_le32(sb->s_blocksize);
-	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
-	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-			cpu_to_le32(lvid_get_unique_id(sb));
-	}
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	d_instantiate(dentry, inode);
-	err = 0;
-
+	err = udf_add_nondir(dentry, inode);
 out:
 	kfree(name);
 	return err;
 
 out_no_entry:
 	up_write(&iinfo->i_data_sem);
-out_fail:
 	inode_dec_link_count(inode);
 	iput(inode);
 	goto out;

