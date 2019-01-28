Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C0AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250DD2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695437;
	bh=3Iubp7GXKRgKQsPBPU3sK0hPRU7tYTDT7ou4wQD1BsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpX4q5z/WiftpfyBV+z73O3+PGyQQft4WCENQD6x2/kJdAwvn7e5J2bSxqFf0vnIy
	 vSAXAogZ8lFsMOPLiT+nV6+j8Kkwb4LEahIVr/puA02KKOE0QlOlJ69e2BvZ5iHyXv
	 hqealEFvtaQBR2LaGiSa7hs3sIfDi0/2odBuRPZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfA1RKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732757AbfA1QKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D850421852;
        Mon, 28 Jan 2019 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691817;
        bh=3Iubp7GXKRgKQsPBPU3sK0hPRU7tYTDT7ou4wQD1BsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0ETusAHCsnnRgfrjBYjr1dBmRepZYZ4B+UpgT2GaEfNKSbpznSdbu4qdXg6rT/m8
         rcOFZVssQ0okLIAXhkYyzzbmXeQHWfRn+fvC1pBlBMaxAgCPtOM68BjmfOrSgk+VWB
         RdwgmouKfnJu0qVdFIyYLitPBzxLfWqFBY0ZbE6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 227/258] f2fs: fix use-after-free issue when accessing sbi->stat_info
Date:   Mon, 28 Jan 2019 10:58:53 -0500
Message-Id: <20190128155924.51521-227-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit 60aa4d5536ab7fe32433ca1173bd9d6633851f27 ]

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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 338138b34993..c9639ef0e8d5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1039,9 +1039,6 @@ static void f2fs_put_super(struct super_block *sb)
 		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
-	/* f2fs_write_checkpoint can update stat informaion */
-	f2fs_destroy_stats(sbi);
-
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
@@ -1061,6 +1058,12 @@ static void f2fs_put_super(struct super_block *sb)
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
@@ -2980,30 +2983,30 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
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
@@ -3121,12 +3124,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
2.19.1

