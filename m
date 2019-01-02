Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7497421871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfABJIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:08:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbfABJIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:08:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C99C51D4812F;
        Wed,  2 Jan 2019 17:08:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 2 Jan 2019
 17:08:29 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH 1/2] f2fs-dev: support multi-device direct IO
Date:   Wed, 2 Jan 2019 17:06:59 +0800
Message-ID: <20190102090659.7974-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

The physical blocks in struct f2fs_map_blocks must be in the same device.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/data.c | 20 +++++++++++++++++++-
 fs/f2fs/f2fs.h |  2 --
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5cd3fd..7a6369e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1076,6 +1076,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct extent_info ei = {0,0,0};
 	block_t blkaddr;
 	unsigned int start_pgofs;
+	int devi;
+	block_t end_blk;
 
 	if (!maxblocks)
 		return 0;
@@ -1207,8 +1209,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
+
+		if (sbi->s_ndevs && blkaddr != NEW_ADDR &&
+							blkaddr != NULL_ADDR) {
+			devi = f2fs_target_device_index(sbi, blkaddr);
+			end_blk = FDEV(devi).end_blk;
+		}
 	} else if ((map->m_pblk != NEW_ADDR &&
-			blkaddr == (map->m_pblk + ofs)) ||
+			blkaddr == (map->m_pblk + ofs) &&
+			(!sbi->s_ndevs || blkaddr <= end_blk)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
 			flag == F2FS_GET_BLOCK_PRE_DIO) {
 		ofs++;
@@ -1322,6 +1331,8 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 {
 	struct f2fs_map_blocks map;
 	int err;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int devi;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -1333,6 +1344,13 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	err = f2fs_map_blocks(inode, &map, create, flag);
 	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
+		if (sbi->s_ndevs) {
+			devi = f2fs_target_device_index(sbi, map.m_pblk);
+			if (devi) {
+				bh->b_bdev = FDEV(devi).bdev;
+				bh->b_blocknr -= FDEV(devi).start_blk;
+			}
+		}
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eeede26..b311471 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3595,8 +3595,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 
 	if (f2fs_post_read_required(inode))
 		return true;
-	if (sbi->s_ndevs)
-		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
-- 
1.8.3.1

