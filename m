Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E1C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8B6218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfADL0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:26:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfADL0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:26:19 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3F385278E553;
        Fri,  4 Jan 2019 19:26:16 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 19:26:09 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH v2 1/2] f2fs-dev: support multi-device direct IO
Date:   Fri, 4 Jan 2019 19:24:39 +0800
Message-ID: <20190104112439.48918-1-sunqiuyang@huawei.com>
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

Changelog v1 ==> v2:
1. Modify the definition of update_device_state(),
   and call it in direct write;
2. Move some local variables into branches where they are used.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/data.c    | 25 ++++++++++++++++++++++++-
 fs/f2fs/f2fs.h    |  3 +--
 fs/f2fs/segment.c | 11 +++++------
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5cd3fd..010300c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1076,6 +1076,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct extent_info ei = {0,0,0};
 	block_t blkaddr;
 	unsigned int start_pgofs;
+	block_t end_blk;
 
 	if (!maxblocks)
 		return 0;
@@ -1207,8 +1208,17 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
+
+		if (sbi->s_ndevs && blkaddr != NEW_ADDR &&
+							blkaddr != NULL_ADDR) {
+			int devi;
+
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
@@ -1322,6 +1332,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 {
 	struct f2fs_map_blocks map;
 	int err;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -1333,6 +1344,18 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	err = f2fs_map_blocks(inode, &map, create, flag);
 	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
+		if (sbi->s_ndevs) {
+			int devi;
+
+			devi = f2fs_target_device_index(sbi, map.m_pblk);
+			if (devi) {
+				bh->b_bdev = FDEV(devi).bdev;
+				bh->b_blocknr -= FDEV(devi).start_blk;
+			}
+			if (may_write)
+				update_device_state(sbi, inode->i_ino,
+								map.m_pblk);
+		}
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eeede26..659e1e0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3056,6 +3056,7 @@ int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
 enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 			enum page_type type, enum temp_type temp);
+void update_device_state(struct f2fs_sb_info *sbi, nid_t ino, block_t blkaddr);
 
 /*
  * checkpoint.c
@@ -3595,8 +3596,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 
 	if (f2fs_post_read_required(inode))
 		return true;
-	if (sbi->s_ndevs)
-		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a361d61..eec5db1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3050,18 +3050,17 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	up_read(&SM_I(sbi)->curseg_lock);
 }
 
-static void update_device_state(struct f2fs_io_info *fio)
+void update_device_state(struct f2fs_sb_info *sbi, nid_t ino, block_t blkaddr)
 {
-	struct f2fs_sb_info *sbi = fio->sbi;
 	unsigned int devidx;
 
 	if (!sbi->s_ndevs)
 		return;
 
-	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
+	devidx = f2fs_target_device_index(sbi, blkaddr);
 
 	/* update device state for fsync */
-	f2fs_set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
+	f2fs_set_dirty_device(sbi, ino, devidx, FLUSH_INO);
 
 	/* update device state for checkpoint */
 	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
@@ -3092,7 +3091,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto reallocate;
 	}
 
-	update_device_state(fio);
+	update_device_state(fio->sbi, fio->ino, fio->new_blkaddr);
 
 	if (keep_order)
 		up_read(&fio->sbi->io_order_lock);
@@ -3168,7 +3167,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	else
 		err = f2fs_submit_page_bio(fio);
 	if (!err)
-		update_device_state(fio);
+		update_device_state(fio->sbi, fio->ino, fio->new_blkaddr);
 
 	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 
-- 
1.8.3.1

