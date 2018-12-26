Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9294721741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nhL0qpsn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F5ZVsXFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeLZFut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:50:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeLZFut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:50:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5685460364; Wed, 26 Dec 2018 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545803448;
        bh=JUsQ9IVn1Fp9glEOcDKM+8t31FMwMuwYLb+dmVcL5f8=;
        h=From:To:Cc:Subject:Date:From;
        b=nhL0qpsnPbKkfHzSvGeL4J3rfkMtXtJit9CX71kCO7wxwx+El850n0SSIc/GL+bC6
         wqF4w7vNy6PGHixO1FFPirISeWsYjFR5cL0MOEz9LK65gFlkn3ycolaaYIEl4hkvaC
         fDh7WDCbNSLQJ/Nr8qGD1giDVEyiQ1YTVuVWprgg=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3591E6022B;
        Wed, 26 Dec 2018 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545803438;
        bh=JUsQ9IVn1Fp9glEOcDKM+8t31FMwMuwYLb+dmVcL5f8=;
        h=From:To:Cc:Subject:Date:From;
        b=F5ZVsXFMyufm5ZK9YfEmNa1XsmWZFl/pRU58VQVTXBFmUyzR2GObFpUwHNe6mUfXh
         uhc4KUy76+78IKHmiGCBxs0oCvgllqYmzxz+cDFIbgDx6UL7ahaWQGNCADRlqSNoQx
         moSYLn3tah4J9ACnRXiqXDrYiLFF7JIfr4dcnaV4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3591E6022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v2] f2fs: fix use-after-free issue when accessing sbi->stat_info
Date:   Wed, 26 Dec 2018 11:20:29 +0530
Message-Id: <1545803429-14340-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput() on sbi->node_inode can update sbi->stat_info
in the below context, if the f2fs_write_checkpoint()
has failed with error.

f2fs_balance_fs_bg+0x1ac/0x1ec
f2fs_write_node_pages+0x4c/0x260
do_writepages+0x80/0xbc
__writeback_single_inode+0xdc/0x4ac
writeback_single_inode+0x9c/0x144
write_inode_now+0xc4/0xec
iput+0x194/0x22c
f2fs_put_super+0x11c/0x1e8
generic_shutdown_super+0x70/0xf4
kill_block_super+0x2c/0x5c
kill_f2fs_super+0x44/0x50
deactivate_locked_super+0x60/0x8c
deactivate_super+0x68/0x74
cleanup_mnt+0x40/0x78

Fix this by moving f2fs_destroy_stats() further below iput() in
both f2fs_put_super() and f2fs_fill_super() paths.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- cover f2fs_fill_super() also, as pointed out by Chao.

 fs/f2fs/super.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e184ad4e..01d9548 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1058,9 +1058,6 @@ static void f2fs_put_super(struct super_block *sb)
 		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
-	/* f2fs_write_checkpoint can update stat informaion */
-	f2fs_destroy_stats(sbi);
-
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
@@ -1080,6 +1077,12 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
 
+	/*
+	 * iput() can update stat information, if f2fs_write_checkpoint()
+	 * above failed with error.
+	 */
+	f2fs_destroy_stats(sbi);
+
 	/* destroy f2fs internal modules */
 	f2fs_destroy_node_manager(sbi);
 	f2fs_destroy_segment_manager(sbi);
@@ -3259,30 +3262,30 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	f2fs_build_gc_manager(sbi);
 
+	err = f2fs_build_stats(sbi);
+	if (err)
+		goto free_nm;
+
 	/* get an inode for node space */
 	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
 	if (IS_ERR(sbi->node_inode)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read node inode");
 		err = PTR_ERR(sbi->node_inode);
-		goto free_nm;
+		goto free_stats;
 	}
 
-	err = f2fs_build_stats(sbi);
-	if (err)
-		goto free_node_inode;
-
 	/* read root inode and dentry */
 	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
 	if (IS_ERR(root)) {
 		f2fs_msg(sb, KERN_ERR, "Failed to read root inode");
 		err = PTR_ERR(root);
-		goto free_stats;
+		goto free_node_inode;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks ||
 			!root->i_size || !root->i_nlink) {
 		iput(root);
 		err = -EINVAL;
-		goto free_stats;
+		goto free_node_inode;
 	}
 
 	sb->s_root = d_make_root(root); /* allocate root dentry */
@@ -3406,12 +3409,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
-free_stats:
-	f2fs_destroy_stats(sbi);
 free_node_inode:
 	f2fs_release_ino_entry(sbi, true);
 	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	iput(sbi->node_inode);
+free_stats:
+	f2fs_destroy_stats(sbi);
 free_nm:
 	f2fs_destroy_node_manager(sbi);
 free_sm:
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

