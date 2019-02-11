Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6F421B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895601;
	bh=0Hbv8y3jXssBHkC2LFIKj7kdQF8Ty88VXIN7SUvIA0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WK9bHzIqaZnBHQS3p/ROhCF8bdjL0gJNgD/gKLcqMPh9ThsWee8AOFHzJIUpHnWEG
	 5rOq6MtM1cKRfbvRif5GR0v95sODFmrB8jolomiaNm2I4PSRvnibEgSyBSBTkT9Ct4
	 Y10/AmCp0eGiGQi+WOmcDFO/ZzFhwyV59excxpKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfBKOdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730611AbfBKOdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:33:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543EC218A3;
        Mon, 11 Feb 2019 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895594;
        bh=0Hbv8y3jXssBHkC2LFIKj7kdQF8Ty88VXIN7SUvIA0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNrhCUQxO9tZEEhvxpLclmA+jAyoLcQa6sInTxR1Hm2c+WIC+gA3sdCckkbRCby+R
         M+t6y84Ld3Vfd+Eb5r93yKHtcNNTp35Drzrl0Zv6M8sqjI9xyh6rrFuHFQPNwj7W82
         781dR1qbl+qLtuW9hqRRngGlIvgJp2yRYhd/C4Rg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 258/352] f2fs: fix use-after-free issue when accessing sbi->stat_info
Date:   Mon, 11 Feb 2019 15:18:05 +0100
Message-Id: <20190211141903.494985465@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 855a622fb052..a239472f405a 100644
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
@@ -3256,30 +3259,30 @@ try_onemore:
 
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
@@ -3403,12 +3406,12 @@ free_meta:
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



