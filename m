Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeBFDua (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 22:50:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751998AbeBFDuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 22:50:22 -0500
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: add fi->commit_lock to protect commit GCed pages
Date: Tue, 6 Feb 2018 11:49:49 +0800
Message-ID: <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.107.193.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds fi->commit_lock to avoid the case that GCed node pages
are committed but GCed data pages are not committed. This can avoid the
db file run into inconsistent state when sudden-power-off happens if
data pages of atomic file is allowed to be GCed before.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 15 ++++++++++++--
 fs/f2fs/gc.c    | 61 +++++++++++++++++++++++++++++++++++++--------------------
 fs/f2fs/super.c |  1 +
 4 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dbe87c7..b58a8f2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -628,6 +628,7 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
+	struct mutex commit_lock;	/* lock for commit GCed pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
 	struct rw_semaphore i_mmap_sem;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542..7e14724 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -202,6 +202,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 	nid_t ino = inode->i_ino;
 	int ret = 0;
 	enum cp_reason_type cp_reason = 0;
@@ -219,11 +220,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);
+	mutex_lock(&fi->commit_lock);
 	ret = file_write_and_wait_range(file, start, end);
 	clear_inode_flag(inode, FI_NEED_IPU);
 
 	if (ret) {
 		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
+		mutex_unlock(&fi->commit_lock);
 		return ret;
 	}
 
@@ -244,8 +247,11 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 			goto go_write;
 
 		if (is_inode_flag_set(inode, FI_UPDATE_WRITE) ||
-				exist_written_data(sbi, ino, UPDATE_INO))
+				exist_written_data(sbi, ino, UPDATE_INO)) {
+			mutex_unlock(&fi->commit_lock);
 			goto flush_out;
+		}
+		mutex_unlock(&fi->commit_lock);
 		goto out;
 	}
 go_write:
@@ -268,16 +274,20 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		try_to_fix_pino(inode);
 		clear_inode_flag(inode, FI_APPEND_WRITE);
 		clear_inode_flag(inode, FI_UPDATE_WRITE);
+		mutex_unlock(&fi->commit_lock);
 		goto out;
 	}
 sync_nodes:
 	ret = fsync_node_pages(sbi, inode, &wbc, atomic);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&fi->commit_lock);
 		goto out;
+	}
 
 	/* if cp_error was enabled, we should avoid infinite loop */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		ret = -EIO;
+		mutex_unlock(&fi->commit_lock);
 		goto out;
 	}
 
@@ -286,6 +296,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		f2fs_write_inode(inode, NULL);
 		goto sync_nodes;
 	}
+	mutex_unlock(&fi->commit_lock);
 
 	/*
 	 * If it's atomic_write, it's just fine to keep write ordering. So
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9d54ddb..b98aff5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -676,13 +676,20 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		goto put_page_out;
 	}
 
-	if (f2fs_is_atomic_file(inode) &&
-		!f2fs_is_commit_atomic_write(inode) &&
-		!IS_GC_WRITTEN_PAGE(fio.encrypted_page)) {
-		set_page_private(fio.encrypted_page, (unsigned long)GC_WRITTEN_PAGE);
-		SetPagePrivate(fio.encrypted_page);
-	}
-	set_page_dirty(fio.encrypted_page);
+	if (f2fs_is_atomic_file(inode)) {
+		struct f2fs_inode_info *fi = F2FS_I(inode);
+
+		mutex_lock(&fi->commit_lock);
+		if (!f2fs_is_commit_atomic_write(inode) &&
+			!IS_GC_WRITTEN_PAGE(fio.encrypted_page)) {
+			set_page_private(fio.encrypted_page,
+				(unsigned long)GC_WRITTEN_PAGE);
+			SetPagePrivate(fio.encrypted_page);
+		}
+		set_page_dirty(fio.encrypted_page);
+		mutex_unlock(&fi->commit_lock);
+	} else
+		set_page_dirty(fio.encrypted_page);
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
@@ -741,13 +748,19 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
 			goto out;
-		if (f2fs_is_atomic_file(inode) &&
-			!f2fs_is_commit_atomic_write(inode) &&
-			!IS_GC_WRITTEN_PAGE(page)) {
-			set_page_private(page, (unsigned long)GC_WRITTEN_PAGE);
-			SetPagePrivate(page);
-		}
-		set_page_dirty(page);
+		if (f2fs_is_atomic_file(inode)) {
+			struct f2fs_inode_info *fi = F2FS_I(inode);
+
+			mutex_lock(&fi->commit_lock);
+			if (!f2fs_is_commit_atomic_write(inode) &&
+				!IS_GC_WRITTEN_PAGE(page)) {
+				set_page_private(page, (unsigned long)GC_WRITTEN_PAGE);
+				SetPagePrivate(page);
+			}
+			set_page_dirty(page);
+			mutex_unlock(&fi->commit_lock);
+		} else
+			set_page_dirty(page);
 		set_cold_data(page);
 	} else {
 		struct f2fs_io_info fio = {
@@ -767,13 +780,19 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		int err;
 
 retry:
-		if (f2fs_is_atomic_file(inode) &&
-			!f2fs_is_commit_atomic_write(inode) &&
-			!IS_GC_WRITTEN_PAGE(page)) {
-			set_page_private(page, (unsigned long)GC_WRITTEN_PAGE);
-			SetPagePrivate(page);
-		}
-		set_page_dirty(page);
+		if (f2fs_is_atomic_file(inode)) {
+			struct f2fs_inode_info *fi = F2FS_I(inode);
+
+			mutex_lock(&fi->commit_lock);
+			if (!f2fs_is_commit_atomic_write(inode) &&
+				!IS_GC_WRITTEN_PAGE(page)) {
+				set_page_private(page, (unsigned long)GC_WRITTEN_PAGE);
+				SetPagePrivate(page);
+			}
+			set_page_dirty(page);
+			mutex_unlock(&fi->commit_lock);
+		} else
+			set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
 		if (clear_page_dirty_for_io(page)) {
 			inode_dec_dirty_pages(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7966cf7..ed6afd1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -772,6 +772,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->inmem_ilist);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
+	mutex_init(&fi->commit_lock);
 	init_rwsem(&fi->dio_rwsem[READ]);
 	init_rwsem(&fi->dio_rwsem[WRITE]);
 	init_rwsem(&fi->i_mmap_sem);
-- 
1.8.5.2
