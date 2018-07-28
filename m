Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0AC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351BB20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351BB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeG1MHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 08:07:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbeG1MHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 08:07:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9F9AD9E47A913;
        Sat, 28 Jul 2018 18:41:42 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Sat, 28 Jul 2018 18:41:37 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: fix to reset i_gc_failures offline
Date:   Sat, 28 Jul 2018 18:41:35 +0800
Message-ID: <20180728104135.13055-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch synchronize f2fs_inode structure from kernel side, in
addition, it adds to check .i_gc_failures and do resetting in fsck.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dir.c         |  5 ++++-
 fsck/fsck.c        | 16 ++++++++++++++++
 include/f2fs_fs.h  |  8 +++++++-
 mkfs/f2fs_format.c |  2 +-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 567a4e9c9b83..98a0b7a89601 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -445,7 +445,10 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
 	node_blk->i.i_ctime_nsec = 0;
 	node_blk->i.i_mtime_nsec = 0;
 	node_blk->i.i_generation = 0;
-	node_blk->i.i_current_depth = cpu_to_le32(1);
+	if (de->file_type == F2FS_FT_DIR)
+		node_blk->i.i_current_depth = cpu_to_le32(1);
+	else
+		node_blk->i.i_current_depth = cpu_to_le32(0);
 	node_blk->i.i_xattr_nid = 0;
 	node_blk->i.i_flags = 0;
 	node_blk->i.i_inline = F2FS_INLINE_XATTR;
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 20a569228516..d550403e3e10 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -662,6 +662,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	unsigned char *en;
 	u32 namelen;
 	unsigned int idx = 0;
+	unsigned short i_gc_failures;
 	int need_fix = 0;
 	int ret;
 
@@ -939,6 +940,21 @@ skip_blkcnt_fix:
 		}
 	}
 
+	i_gc_failures = le16_to_cpu(node_blk->i.i_gc_failures);
+	if (ftype == F2FS_FT_REG_FILE && i_gc_failures) {
+
+		DBG(1, "Regular Inode: 0x%x [%s] depth: %d\n\n",
+				le32_to_cpu(node_blk->footer.ino), en,
+				i_gc_failures);
+
+		if (c.fix_on) {
+			node_blk->i.i_gc_failures = cpu_to_le16(0);
+			need_fix = 1;
+			FIX_MSG("Regular: 0x%x reset i_gc_failures from 0x%x to 0x00",
+					nid, i_gc_failures);
+		}
+	}
+
 	free(en);
 
 	if (ftype == F2FS_FT_SYMLINK && i_blocks && i_size == 0) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index fe1e31ba1a46..53fa002c5520 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -788,7 +788,13 @@ struct f2fs_inode {
 	__le32 i_ctime_nsec;		/* change time in nano scale */
 	__le32 i_mtime_nsec;		/* modification time in nano scale */
 	__le32 i_generation;		/* file version (for NFS) */
-	__le32 i_current_depth;		/* only for directory depth */
+	union {
+		__le32 i_current_depth;	/* only for directory depth */
+		__le16 i_gc_failures;	/*
+					 * # of gc failures on pinned file.
+					 * only for regular files.
+					 */
+	};
 	__le32 i_xattr_nid;		/* nid to save xattr */
 	__le32 i_flags;			/* file attributes */
 	__le32 i_pino;			/* parent inode number */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f2880eb06460..01a73e858d73 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1251,7 +1251,7 @@ static int f2fs_write_qf_inode(int qtype)
 	raw_node->i.i_generation = 0;
 	raw_node->i.i_xattr_nid = 0;
 	raw_node->i.i_flags = FS_IMMUTABLE_FL;
-	raw_node->i.i_current_depth = cpu_to_le32(1);
+	raw_node->i.i_current_depth = cpu_to_le32(0);
 	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
-- 
2.18.0.rc1

