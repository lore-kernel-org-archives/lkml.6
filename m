Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034290AbeCBHsr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:48:47 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:42835 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163985AbeCBHsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:48:45 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: hyc.lee@gmail.com
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>, Christoph Hellwig <hch@lst.de>,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
Subject: [PATCH] f2fs: add nowait aio support
Date: Fri,  2 Mar 2018 16:48:34 +0900
Message-Id: <1519976914-32491-1-git-send-email-hyc.lee@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <cheol.lee@lge.com>

This patch adds nowait aio support[1].

Return EAGAIN if any of the following checks fail for direct I/O:
  - i_rwsem is not lockable
  - Blocks are not allocated at the write location

And xfstests generic/471 is passed.

 [1]: 6be96d "Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT"

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 fs/f2fs/data.c | 36 +++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h |  8 ++++++++
 fs/f2fs/file.c | 35 +++++++++++++++++++++++++++++------
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6c3c978..9a550c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -839,13 +839,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	return 0;
 }
 
-static inline bool __force_buffered_io(struct inode *inode, int rw)
-{
-	return (f2fs_encrypted_file(inode) ||
-			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
-			F2FS_I_SB(inode)->s_ndevs);
-}
-
 int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -877,7 +870,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 
 	if (direct_io) {
 		map.m_seg_type = rw_hint_to_seg_type(iocb->ki_hint);
-		flag = __force_buffered_io(inode, WRITE) ?
+		flag = f2fs_force_buffered_io(inode, WRITE) ?
 					F2FS_GET_BLOCK_PRE_AIO :
 					F2FS_GET_BLOCK_PRE_DIO;
 		goto map_blocks;
@@ -1121,6 +1114,31 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	return err;
 }
 
+bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+{
+	struct f2fs_map_blocks map;
+	block_t last_lblk;
+	int err;
+
+	if (pos + len > i_size_read(inode))
+		return false;
+
+	map.m_lblk = F2FS_BYTES_TO_BLK(pos);
+	map.m_next_pgofs = 0;
+	map.m_next_extent = NULL;
+	map.m_seg_type = NO_CHECK_TYPE;
+	last_lblk = F2FS_BYTES_TO_BLK(pos + len) + 1;
+
+	while (map.m_lblk < last_lblk) {
+		map.m_len = last_lblk - map.m_lblk;
+		err = f2fs_map_blocks(inode, &map, 0, 0);
+		if (err || map.m_len == 0)
+			return false;
+		map.m_lblk += map.m_len;
+	}
+	return true;
+}
+
 static int __get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh, int create, int flag,
 			pgoff_t *next_pgofs, int seg_type)
@@ -2306,7 +2324,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (err)
 		return err;
 
-	if (__force_buffered_io(inode, rw))
+	if (f2fs_force_buffered_io(inode, rw))
 		return 0;
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6dc706..351226e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2875,6 +2875,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
+bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
 
 /*
  * gc.c
@@ -3259,4 +3260,11 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
 #endif
 }
 
+static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
+{
+	return (f2fs_encrypted_file(inode) ||
+			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
+			F2FS_I_SB(inode)->s_ndevs);
+}
+
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6a202e5..1051edd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -479,6 +479,9 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 
 	if (err)
 		return err;
+
+	filp->f_mode |= FMODE_NOWAIT;
+
 	return dquot_file_open(inode, filp);
 }
 
@@ -2895,7 +2898,15 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
-	inode_lock(inode);
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
+
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
 		int err;
@@ -2903,11 +2914,23 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
 			set_inode_flag(inode, FI_NO_PREALLOC);
 
-		err = f2fs_preallocate_blocks(iocb, from);
-		if (err) {
-			clear_inode_flag(inode, FI_NO_PREALLOC);
-			inode_unlock(inode);
-			return err;
+		if ((iocb->ki_flags & IOCB_NOWAIT) &&
+			(iocb->ki_flags & IOCB_DIRECT)) {
+				if (!f2fs_overwrite_io(inode, iocb->ki_pos,
+						iov_iter_count(from)) ||
+					f2fs_has_inline_data(inode) ||
+					f2fs_force_buffered_io(inode, WRITE)) {
+						inode_unlock(inode);
+						return -EAGAIN;
+				}
+
+		} else {
+			err = f2fs_preallocate_blocks(iocb, from);
+			if (err) {
+				clear_inode_flag(inode, FI_NO_PREALLOC);
+				inode_unlock(inode);
+				return err;
+			}
 		}
 		blk_start_plug(&plug);
 		ret = __generic_file_write_iter(iocb, from);
-- 
1.9.1
