Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72997C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E492150B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E492150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI0Qwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:52:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49395 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbeI0Qwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:52:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B25323579A38;
        Thu, 27 Sep 2018 18:35:04 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 18:34:56 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v5] f2fs: allow out-place-update for direct IO in LFS mode
Date:   Thu, 27 Sep 2018 18:34:52 +0800
Message-ID: <20180927103452.40623-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, DIO uses in-pllace-update, but in LFS mode, f2fs doesn't
allow triggering any in-place-update writes, so we fallback direct
write to buffered write, result in bad performance of large size
write.

This patch adds to support triggering out-place-update for direct IO
to enhance its performance.

Note that it needs to exclude direct read IO during direct write,
since new data writing to new block address will no be valid until
write finished.

storage: zram

time xfs_io -f -d /mnt/f2fs/file -c "pwrite 0 1073741824" -c "fsync"

Before:
real	0m13.061s
user	0m0.327s
sys	0m12.486s

After:
real	0m6.448s
user	0m0.228s
sys	0m6.212s

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v5:
- use F2FS_GET_BLOCK_DIO instead of F2FS_GET_BLOCK_DEFAULT.
 fs/f2fs/data.c | 44 +++++++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h | 45 +++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/file.c |  3 ++-
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e98ea9a84782..652919552758 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -893,7 +893,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 	dn->data_blkaddr = datablock_addr(dn->inode,
 				dn->node_page, dn->ofs_in_node);
-	if (dn->data_blkaddr == NEW_ADDR)
+	if (dn->data_blkaddr != NULL_ADDR)
 		goto alloc;
 
 	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
@@ -947,7 +947,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 
 	if (direct_io) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
-		flag = f2fs_force_buffered_io(inode, WRITE) ?
+		flag = f2fs_force_buffered_io(inode, iocb, from) ?
 					F2FS_GET_BLOCK_PRE_AIO :
 					F2FS_GET_BLOCK_PRE_DIO;
 		goto map_blocks;
@@ -1066,7 +1066,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto sync_out;
 	}
 
-	if (!is_valid_data_blkaddr(sbi, blkaddr)) {
+	if (is_valid_data_blkaddr(sbi, blkaddr)) {
+		/* use out-place-update for driect IO under LFS mode */
+		if (test_opt(sbi, LFS) && create &&
+				flag == F2FS_GET_BLOCK_DIO) {
+			err = __allocate_data_block(&dn, map->m_seg_type);
+			if (!err)
+				set_inode_flag(inode, FI_APPEND_WRITE);
+		}
+	} else {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -2492,36 +2500,53 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t offset = iocb->ki_pos;
 	int rw = iov_iter_rw(iter);
 	int err;
 	enum rw_hint hint = iocb->ki_hint;
 	int whint_mode = F2FS_OPTION(sbi).whint_mode;
+	bool do_opu;
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
 		return err < 0 ? err : 0;
 
-	if (f2fs_force_buffered_io(inode, rw))
+	if (f2fs_force_buffered_io(inode, iocb, iter))
 		return 0;
 
+	do_opu = allow_outplace_dio(inode, iocb, iter);
+
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
 	if (rw == WRITE && whint_mode == WHINT_MODE_OFF)
 		iocb->ki_hint = WRITE_LIFE_NOT_SET;
 
-	if (!down_read_trylock(&F2FS_I(inode)->i_gc_rwsem[rw])) {
-		if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!down_read_trylock(&fi->i_gc_rwsem[rw])) {
+			iocb->ki_hint = hint;
+			err = -EAGAIN;
+			goto out;
+		}
+		if (do_opu && !down_read_trylock(&fi->i_gc_rwsem[READ])) {
+			up_read(&fi->i_gc_rwsem[rw]);
 			iocb->ki_hint = hint;
 			err = -EAGAIN;
 			goto out;
 		}
-		down_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
+	} else {
+		down_read(&fi->i_gc_rwsem[rw]);
+		if (do_opu)
+			down_read(&fi->i_gc_rwsem[READ]);
 	}
 
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
-	up_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
+
+	if (do_opu)
+		up_read(&fi->i_gc_rwsem[READ]);
+
+	up_read(&fi->i_gc_rwsem[rw]);
 
 	if (rw == WRITE) {
 		if (whint_mode == WHINT_MODE_OFF)
@@ -2529,7 +2554,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		if (err > 0) {
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_IO,
 									err);
-			set_inode_flag(inode, FI_UPDATE_WRITE);
+			if (!do_opu)
+				set_inode_flag(inode, FI_UPDATE_WRITE);
 		} else if (err < 0) {
 			f2fs_write_failed(mapping, offset + count);
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6b6871093406..675ff5df13bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_F2FS_H
 #define _LINUX_F2FS_H
 
+#include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/page-flags.h>
 #include <linux/buffer_head.h>
@@ -3488,11 +3489,47 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
 #endif
 }
 
-static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
+static inline int block_unaligned_IO(struct inode *inode,
+				struct kiocb *iocb, struct iov_iter *iter)
 {
-	return (f2fs_post_read_required(inode) ||
-			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
-			F2FS_I_SB(inode)->s_ndevs);
+	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
+	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
+	loff_t offset = iocb->ki_pos;
+	unsigned long align = offset | iov_iter_alignment(iter);
+
+	return align & blocksize_mask;
+}
+
+static inline int allow_outplace_dio(struct inode *inode,
+				struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int rw = iov_iter_rw(iter);
+
+	return (test_opt(sbi, LFS) && (rw == WRITE) &&
+				!block_unaligned_IO(inode, iocb, iter));
+}
+
+static inline bool f2fs_force_buffered_io(struct inode *inode,
+				struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int rw = iov_iter_rw(iter);
+
+	if (f2fs_post_read_required(inode))
+		return true;
+	if (sbi->s_ndevs)
+		return true;
+	/*
+	 * for blkzoned device, fallback direct IO to buffered IO, so
+	 * all IOs can be serialized by log-structured write.
+	 */
+	if (f2fs_sb_has_blkzoned(sbi->sb))
+		return true;
+	if (test_opt(sbi, LFS) && (rw == WRITE) &&
+				block_unaligned_IO(inode, iocb, iter))
+		return true;
+	return false;
 }
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 378684bf1ee6..2a4cad36141c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3037,7 +3037,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 				if (!f2fs_overwrite_io(inode, iocb->ki_pos,
 						iov_iter_count(from)) ||
 					f2fs_has_inline_data(inode) ||
-					f2fs_force_buffered_io(inode, WRITE)) {
+					f2fs_force_buffered_io(inode,
+							iocb, from)) {
 						clear_inode_flag(inode,
 								FI_NO_PREALLOC);
 						inode_unlock(inode);
-- 
2.18.0.rc1

