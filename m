Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC601ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD192154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w2UmLkDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD192154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbeIUTBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeIUTBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:01:23 -0400
Received: from localhost.localdomain (unknown [222.95.226.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145CE21523;
        Fri, 21 Sep 2018 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537535553;
        bh=tZCEg+uyoCFNwQHYxLzDnFQUG2u3tfWxdJ00fyyJhGA=;
        h=From:To:Cc:Subject:Date:From;
        b=w2UmLkDLCeJPSHxRZTixB5U8d5RU5tRclt6XB6Snz5gggt0899bCcAVL3uMvbfQdt
         cxM8bnD3QGZ7N0qMhiL1RY6uKOUtQ2yVPSia04naLsxHbfnoJGIm4/mx1qVM4x1Pa8
         jct6jOeVZHQh6JQUM6KpjVuNLuYKXP3UIxJBOZsg=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4] f2fs: allow out-place-update for direct IO in LFS mode
Date:   Fri, 21 Sep 2018 21:12:22 +0800
Message-Id: <20180921131222.32057-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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
v4:
- correct parameter in f2fs_sb_has_blkzoned()
 fs/f2fs/data.c | 44 +++++++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h | 45 +++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/file.c |  3 ++-
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b96f8588d565..38d5baa1c35d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -894,7 +894,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 	dn->data_blkaddr = datablock_addr(dn->inode,
 				dn->node_page, dn->ofs_in_node);
-	if (dn->data_blkaddr == NEW_ADDR)
+	if (dn->data_blkaddr != NULL_ADDR)
 		goto alloc;
 
 	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
@@ -950,7 +950,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 
 	if (direct_io) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
-		flag = f2fs_force_buffered_io(inode, WRITE) ?
+		flag = f2fs_force_buffered_io(inode, iocb, from) ?
 					F2FS_GET_BLOCK_PRE_AIO :
 					F2FS_GET_BLOCK_PRE_DIO;
 		goto map_blocks;
@@ -1069,7 +1069,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto sync_out;
 	}
 
-	if (!is_valid_data_blkaddr(sbi, blkaddr)) {
+	if (is_valid_data_blkaddr(sbi, blkaddr)) {
+		/* use out-place-update for driect IO under LFS mode */
+		if (test_opt(sbi, LFS) && create &&
+				flag == F2FS_GET_BLOCK_DEFAULT) {
+			err = __allocate_data_block(&dn, map->m_seg_type);
+			if (!err)
+				set_inode_flag(inode, FI_APPEND_WRITE);
+		}
+	} else {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -2493,36 +2501,53 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -2530,7 +2555,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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
index 894a2503e722..72d46860cee3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_F2FS_H
 #define _LINUX_F2FS_H
 
+#include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/page-flags.h>
 #include <linux/buffer_head.h>
@@ -3486,11 +3487,47 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
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
index a75f3e145bf1..a388866e71ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3019,7 +3019,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
2.18.0

