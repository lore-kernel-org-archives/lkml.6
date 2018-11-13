Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BDAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4A52243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4A52243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbeKMQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:30:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730901AbeKMQak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:30:40 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B44C08FCBBBE4;
        Tue, 13 Nov 2018 14:33:58 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Nov 2018 14:33:52 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix out-place-update DIO write
Date:   Tue, 13 Nov 2018 14:33:45 +0800
Message-ID: <20181113063345.22410-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In get_more_blocks(), we may override @create as below code:

	create = dio->op == REQ_OP_WRITE;
	if (dio->flags & DIO_SKIP_HOLES) {
		if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
						i_blkbits))
			create = 0;
	}

But in f2fs_map_blocks(), we only trigger f2fs_balance_fs() if @create
is 1, so in LFS mode, dio overwrite under LFS mode can easily run out
of free segments, result in below panic.

 Call Trace:
  allocate_segment_by_default+0xa8/0x270 [f2fs]
  f2fs_allocate_data_block+0x1ea/0x5c0 [f2fs]
  __allocate_data_block+0x306/0x480 [f2fs]
  f2fs_map_blocks+0x6f6/0x920 [f2fs]
  __get_data_block+0x4f/0xb0 [f2fs]
  get_data_block_dio_write+0x50/0x60 [f2fs]
  do_blockdev_direct_IO+0xcd5/0x21e0
  __blockdev_direct_IO+0x3a/0x3c
  f2fs_direct_IO+0x1ff/0x4a0 [f2fs]
  generic_file_direct_write+0xd9/0x160
  __generic_file_write_iter+0xbb/0x1e0
  f2fs_file_write_iter+0xaf/0x220 [f2fs]
  __vfs_write+0xd0/0x130
  vfs_write+0xb2/0x1b0
  SyS_pwrite64+0x69/0xa0
  ? vtime_user_exit+0x29/0x70
  do_syscall_64+0x6e/0x160
  entry_SYSCALL64_slow_path+0x25/0x25
 RIP: new_curseg+0x36f/0x380 [f2fs] RSP: ffffac570393f7a8

So this patch introduces a parameter map.m_may_create to indicate that
f2fs_map_blocks() is called from write or read path, which can give the
right hint to let f2fs_map_blocks() trigger OPU allocation and call
f2fs_balanc_fs() correctly.

BTW, it disables physical address preallocation for direct IO in
f2fs_preallocate_blocks, which is redundant to OPU allocation of
f2fs_map_blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 42 +++++++++++++++++++++++++++++-------------
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c |  3 ++-
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6a78d3f71318..3700e09a748a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1000,6 +1000,9 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 	}
 
+	if (direct_io && allow_outplace_dio(inode, iocb, from))
+		return 0;
+
 	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
 		return 0;
 
@@ -1013,6 +1016,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = NULL;
 	map.m_seg_type = NO_CHECK_TYPE;
+	map.m_may_create = true;
 
 	if (direct_io) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
@@ -1071,7 +1075,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int mode = create ? ALLOC_NODE : LOOKUP_NODE;
+	int mode = map->m_may_create ? ALLOC_NODE : LOOKUP_NODE;
 	pgoff_t pgofs, end_offset, end;
 	int err = 0, ofs = 1;
 	unsigned int ofs_in_node, last_ofs_in_node;
@@ -1105,7 +1109,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	}
 
 next_dnode:
-	if (create)
+	if (map->m_may_create)
 		__do_map_lock(sbi, flag, true);
 
 	/* When reading holes, we need its node page */
@@ -1142,8 +1146,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 	if (is_valid_data_blkaddr(sbi, blkaddr)) {
 		/* use out-place-update for driect IO under LFS mode */
-		if (test_opt(sbi, LFS) && create &&
-				flag == F2FS_GET_BLOCK_DIO) {
+		if (test_opt(sbi, LFS) && flag == F2FS_GET_BLOCK_DIO &&
+							map->m_may_create) {
 			err = __allocate_data_block(&dn, map->m_seg_type);
 			if (!err)
 				set_inode_flag(inode, FI_APPEND_WRITE);
@@ -1252,7 +1256,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 	f2fs_put_dnode(&dn);
 
-	if (create) {
+	if (map->m_may_create) {
 		__do_map_lock(sbi, flag, false);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
@@ -1278,7 +1282,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	}
 	f2fs_put_dnode(&dn);
 unlock_out:
-	if (create) {
+	if (map->m_may_create) {
 		__do_map_lock(sbi, flag, false);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
@@ -1314,7 +1318,7 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 
 static int __get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh, int create, int flag,
-			pgoff_t *next_pgofs, int seg_type)
+			pgoff_t *next_pgofs, int seg_type, bool may_write)
 {
 	struct f2fs_map_blocks map;
 	int err;
@@ -1324,6 +1328,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	map.m_next_pgofs = next_pgofs;
 	map.m_next_extent = NULL;
 	map.m_seg_type = seg_type;
+	map.m_may_create = may_write;
 
 	err = f2fs_map_blocks(inode, &map, create, flag);
 	if (!err) {
@@ -1340,16 +1345,25 @@ static int get_data_block(struct inode *inode, sector_t iblock,
 {
 	return __get_data_block(inode, iblock, bh_result, create,
 							flag, next_pgofs,
-							NO_CHECK_TYPE);
+							NO_CHECK_TYPE, create);
+}
+
+static int get_data_block_dio_write(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
+{
+	return __get_data_block(inode, iblock, bh_result, create,
+				F2FS_GET_BLOCK_DIO, NULL,
+				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
+				true);
 }
 
 static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_DIO, NULL,
-						f2fs_rw_hint_to_seg_type(
-							inode->i_write_hint));
+				F2FS_GET_BLOCK_DIO, NULL,
+				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
+				false);
 }
 
 static int get_data_block_bmap(struct inode *inode, sector_t iblock,
@@ -1361,7 +1375,7 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 
 	return __get_data_block(inode, iblock, bh_result, create,
 						F2FS_GET_BLOCK_BMAP, NULL,
-						NO_CHECK_TYPE);
+						NO_CHECK_TYPE, create);
 }
 
 static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
@@ -1568,6 +1582,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = NULL;
 	map.m_seg_type = NO_CHECK_TYPE;
+	map.m_may_create = false;
 
 	for (; nr_pages; nr_pages--) {
 		if (pages) {
@@ -2696,7 +2711,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	err = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
-			iter, get_data_block_dio, NULL, f2fs_dio_submit_bio,
+			iter, rw == WRITE ? get_data_block_dio_write :
+			get_data_block_dio, NULL, f2fs_dio_submit_bio,
 			DIO_LOCKING | DIO_SKIP_HOLES);
 
 	if (do_opu)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 413e9be4e607..13cf9c62a126 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -596,6 +596,7 @@ struct f2fs_map_blocks {
 	pgoff_t *m_next_pgofs;		/* point next possible non-hole pgofs */
 	pgoff_t *m_next_extent;		/* point to next possible extent */
 	int m_seg_type;
+	bool m_may_create;		/* indicate it is from write path */
 };
 
 /* for flag in get_data_block */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1e168f70d774..5d369b4f5dab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1499,7 +1499,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
-			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE };
+			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE,
+			.m_may_create = true };
 	pgoff_t pg_end;
 	loff_t new_size = i_size_read(inode);
 	loff_t off_end;
-- 
2.18.0.rc1

