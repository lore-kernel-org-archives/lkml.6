Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeDXCzs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:55:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35192 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932722AbeDXCzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:55:47 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: rename dio_rwsem to i_gc_rwsem
Date: Tue, 24 Apr 2018 10:55:28 +0800
Message-ID: <20180424025528.79273-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW semphore dio_rwsem in struct f2fs_inode_info is introduced to avoid
race between dio and data gc, but now, it is more wildly used to avoid
foreground operation vs data gc. So rename it to i_gc_rwsem to improve
its readability.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c  |  6 +++---
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/file.c  | 28 ++++++++++++++--------------
 fs/f2fs/gc.c    | 14 +++++++-------
 fs/f2fs/super.c |  4 ++--
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5477fc09c3cd..f7365ce45450 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2395,17 +2395,17 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (rw == WRITE && whint_mode == WHINT_MODE_OFF)
 		iocb->ki_hint = WRITE_LIFE_NOT_SET;
 
-	if (!down_read_trylock(&F2FS_I(inode)->dio_rwsem[rw])) {
+	if (!down_read_trylock(&F2FS_I(inode)->i_gc_rwsem[rw])) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			iocb->ki_hint = hint;
 			err = -EAGAIN;
 			goto out;
 		}
-		down_read(&F2FS_I(inode)->dio_rwsem[rw]);
+		down_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
 	}
 
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
-	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
+	up_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
 
 	if (rw == WRITE) {
 		if (whint_mode == WHINT_MODE_OFF)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c2b92cb377c6..96556ce7f754 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -653,7 +653,7 @@ struct f2fs_inode_info {
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
-	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
+	struct rw_semaphore i_gc_rwsem[2];/* avoid racing between foreground op and gc */
 	struct rw_semaphore i_mmap_sem;
 	struct rw_semaphore i_xattr_sem; /* avoid racing between reading and changing EAs */
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0cfa65c21d3f..e88d94846d50 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1191,7 +1191,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	pg_end = (offset + len) >> PAGE_SHIFT;
 
 	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	/* write out all dirty pages from offset */
@@ -1217,7 +1217,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		f2fs_i_size_write(inode, new_size);
 out_unlock:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
 
@@ -1393,7 +1393,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_balance_fs(sbi, true);
 
 	/* avoid gc operation during block exchange */
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 	ret = truncate_blocks(inode, i_size_read(inode), true);
@@ -1434,7 +1434,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		f2fs_i_size_write(inode, new_size);
 out:
 	up_write(&F2FS_I(inode)->i_mmap_sem);
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
 
@@ -1681,7 +1681,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	if (f2fs_is_atomic_file(inode))
 		goto out;
@@ -1709,7 +1709,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	stat_inc_atomic_write(inode);
 	stat_update_max_atomic_write(inode);
 out:
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
@@ -1729,7 +1729,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
-	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	if (f2fs_is_volatile_file(inode)) {
 		ret = -EINVAL;
@@ -1755,7 +1755,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 		ret = -EINVAL;
 	}
-	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
@@ -2342,12 +2342,12 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	inode_lock(src);
-	down_write(&F2FS_I(src)->dio_rwsem[WRITE]);
+	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
 	if (src != dst) {
 		ret = -EBUSY;
 		if (!inode_trylock(dst))
 			goto out;
-		if (!down_write_trylock(&F2FS_I(dst)->dio_rwsem[WRITE])) {
+		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE])) {
 			inode_unlock(dst);
 			goto out;
 		}
@@ -2409,11 +2409,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	f2fs_unlock_op(sbi);
 out_unlock:
 	if (src != dst) {
-		up_write(&F2FS_I(dst)->dio_rwsem[WRITE]);
+		up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
 		inode_unlock(dst);
 	}
 out:
-	up_write(&F2FS_I(src)->dio_rwsem[WRITE]);
+	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
 	inode_unlock(src);
 	return ret;
 }
@@ -2823,9 +2823,9 @@ int f2fs_precache_extents(struct inode *inode)
 	while (map.m_lblk < end) {
 		map.m_len = end - map.m_lblk;
 
-		down_write(&fi->dio_rwsem[WRITE]);
+		down_write(&fi->i_gc_rwsem[WRITE]);
 		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
-		up_write(&fi->dio_rwsem[WRITE]);
+		up_write(&fi->i_gc_rwsem[WRITE]);
 		if (err)
 			return err;
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ec6cb7b417a1..a7bda034db06 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -890,7 +890,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			}
 
 			if (!down_write_trylock(
-				&F2FS_I(inode)->dio_rwsem[WRITE])) {
+				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
 				iput(inode);
 				continue;
 			}
@@ -899,7 +899,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			data_page = get_read_data_page(inode,
 					start_bidx + ofs_in_node, REQ_RAHEAD,
 					true);
-			up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			if (IS_ERR(data_page)) {
 				iput(inode);
 				continue;
@@ -917,11 +917,11 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			bool locked = false;
 
 			if (S_ISREG(inode->i_mode)) {
-				if (!down_write_trylock(&fi->dio_rwsem[READ]))
+				if (!down_write_trylock(&fi->i_gc_rwsem[READ]))
 					continue;
 				if (!down_write_trylock(
-						&fi->dio_rwsem[WRITE])) {
-					up_write(&fi->dio_rwsem[READ]);
+						&fi->i_gc_rwsem[WRITE])) {
+					up_write(&fi->i_gc_rwsem[READ]);
 					continue;
 				}
 				locked = true;
@@ -940,8 +940,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 								segno, off);
 
 			if (locked) {
-				up_write(&fi->dio_rwsem[WRITE]);
-				up_write(&fi->dio_rwsem[READ]);
+				up_write(&fi->i_gc_rwsem[WRITE]);
+				up_write(&fi->i_gc_rwsem[READ]);
 			}
 
 			stat_inc_data_blk_count(sbi, 1, gc_type);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 199f29dce86d..7e6fab673073 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -833,8 +833,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->inmem_ilist);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
-	init_rwsem(&fi->dio_rwsem[READ]);
-	init_rwsem(&fi->dio_rwsem[WRITE]);
+	init_rwsem(&fi->i_gc_rwsem[READ]);
+	init_rwsem(&fi->i_gc_rwsem[WRITE]);
 	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_xattr_sem);
 
-- 
2.15.0.55.gc2ece9dc4de6
