Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEGM3k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:29:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbeEGM3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:29:15 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/3] f2fs: avoid stucking GC due to atomic write
Date: Mon, 7 May 2018 20:28:54 +0800
Message-ID: <20180507122854.91506-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
In-Reply-To: <20180507122854.91506-1-yuchao0@huawei.com>
References: <20180507122854.91506-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs doesn't allow abuse on atomic write class interface, so except
limiting in-mem pages' total memory usage capacity, we need to limit
atomic-write usage as well when filesystem is seriously fragmented,
otherwise we may run into infinite loop during foreground GC because
target blocks in victim segment are belong to atomic opened file for
long time.

Now, we will detect failure due to atomic write in foreground GC, if
the count exceeds threshold, we will drop all atomic written data in
cache, by this, I expect it can keep our system running safely to
prevent Dos attack.

In addition, his patch adds to show GC skip information in debugfs,
now it just shows count of skipped caused by atomic write.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase code.
 fs/f2fs/data.c    |  2 +-
 fs/f2fs/debug.c   |  6 ++++++
 fs/f2fs/f2fs.h    | 21 +++++++++++++++------
 fs/f2fs/file.c    | 20 ++++++++++++++------
 fs/f2fs/gc.c      | 27 +++++++++++++++++++++++----
 fs/f2fs/inode.c   |  6 ++++--
 fs/f2fs/segment.c | 11 ++++++++++-
 fs/f2fs/segment.h |  2 ++
 8 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f7365ce45450..e394b5486c91 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2320,7 +2320,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	f2fs_put_page(page, 1);
 	f2fs_write_failed(mapping, pos + len);
 	if (drop_atomic)
-		drop_inmem_pages_all(sbi);
+		drop_inmem_pages_all(sbi, false);
 	return err;
 }
 
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index d92a01cb420c..8febd9160635 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -104,6 +104,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->avail_nids = NM_I(sbi)->available_nids;
 	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
 	si->bg_gc = sbi->bg_gc;
+	si->skipped_atomic_files[BG_GC] = sbi->skipped_atomic_files[BG_GC];
+	si->skipped_atomic_files[FG_GC] = sbi->skipped_atomic_files[FG_GC];
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
 		/ 2;
@@ -342,6 +344,10 @@ static int stat_show(struct seq_file *s, void *v)
 				si->bg_data_blks);
 		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
 				si->bg_node_blks);
+		seq_printf(s, "Skipped : atomic write %llu (%llu)\n",
+				si->skipped_atomic_files[BG_GC] +
+				si->skipped_atomic_files[FG_GC],
+				si->skipped_atomic_files[BG_GC]);
 		seq_puts(s, "\nExtent Cache:\n");
 		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
 				si->hit_largest, si->hit_cached,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 73a1a39889bc..3286127708f9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -617,15 +617,20 @@ enum {
 
 #define DEF_DIR_LEVEL		0
 
+enum {
+	GC_FAILURE_PIN,
+	GC_FAILURE_ATOMIC,
+	MAX_GC_FAILURE
+};
+
 struct f2fs_inode_info {
 	struct inode vfs_inode;		/* serve a vfs inode */
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
 	unsigned char i_advise;		/* use to give file attribute hints */
 	unsigned char i_dir_level;	/* use for dentry level for large dir */
-	union {
-		unsigned int i_current_depth;	/* only for directory depth */
-		unsigned short i_gc_failures;	/* only for regular file */
-	};
+	unsigned int i_current_depth;	/* only for directory depth */
+	/* for gc failure statistic */
+	unsigned int i_gc_failures[MAX_GC_FAILURE];
 	unsigned int i_pino;		/* parent inode number */
 	umode_t i_acl_mode;		/* keep file acl mode temporarily */
 
@@ -1194,6 +1199,8 @@ struct f2fs_sb_info {
 	struct rw_semaphore gc_rwsem;		/* rw semaphore for gc_thread */
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
+	/* for skip statistic */
+	unsigned long long skipped_atomic_files[2];
 
 	/* threshold for gc trials on pinned files */
 	u64 gc_pin_file_threshold;
@@ -2242,6 +2249,7 @@ enum {
 	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
 	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
 	FI_PIN_FILE,		/* indicate file should not be gced */
+	FI_ATOMIC_REVOKE_REQUEST,/* indicate atomic committed data has been dropped */
 };
 
 static inline void __mark_inode_dirty_flag(struct inode *inode,
@@ -2340,7 +2348,7 @@ static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 static inline void f2fs_i_gc_failures_write(struct inode *inode,
 					unsigned int count)
 {
-	F2FS_I(inode)->i_gc_failures = count;
+	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] = count;
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
@@ -2804,7 +2812,7 @@ void destroy_node_manager_caches(void);
  */
 bool need_SSR(struct f2fs_sb_info *sbi);
 void register_inmem_page(struct inode *inode, struct page *page);
-void drop_inmem_pages_all(struct f2fs_sb_info *sbi);
+void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure);
 void drop_inmem_pages(struct inode *inode);
 void drop_inmem_page(struct inode *inode, struct page *page);
 int commit_inmem_pages(struct inode *inode);
@@ -2997,6 +3005,7 @@ struct f2fs_stat_info {
 	int bg_node_segs, bg_data_segs;
 	int tot_blks, data_blks, node_blks;
 	int bg_data_blks, bg_node_blks;
+	unsigned long long skipped_atomic_files[2];
 	int curseg[NR_CURSEG_TYPE];
 	int cursec[NR_CURSEG_TYPE];
 	int curzone[NR_CURSEG_TYPE];
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2b06e250326e..169ea3910b48 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1701,6 +1701,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 skip_flush:
 	set_inode_flag(inode, FI_ATOMIC_FILE);
+	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	F2FS_I(inode)->inmem_task = current;
@@ -1742,12 +1743,17 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret) {
 			clear_inode_flag(inode, FI_ATOMIC_FILE);
+			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
 			stat_dec_atomic_write(inode);
 		}
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
 err_out:
+	if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST)) {
+		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
+		ret = -EINVAL;
+	}
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
@@ -2721,12 +2727,14 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
 
 	/* Use i_gc_failures for normal file as a risk signal. */
 	if (inc)
-		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
+		f2fs_i_gc_failures_write(inode,
+				fi->i_gc_failures[GC_FAILURE_PIN] + 1);
 
-	if (fi->i_gc_failures > sbi->gc_pin_file_threshold) {
+	if (fi->i_gc_failures[GC_FAILURE_PIN] > sbi->gc_pin_file_threshold) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"%s: Enable GC = ino %lx after %x GC trials\n",
-			__func__, inode->i_ino, fi->i_gc_failures);
+			__func__, inode->i_ino,
+			fi->i_gc_failures[GC_FAILURE_PIN]);
 		clear_inode_flag(inode, FI_PIN_FILE);
 		return -EAGAIN;
 	}
@@ -2764,7 +2772,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	if (!pin) {
 		clear_inode_flag(inode, FI_PIN_FILE);
-		F2FS_I(inode)->i_gc_failures = 1;
+		F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] = 1;
 		goto done;
 	}
 
@@ -2777,7 +2785,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto out;
 
 	set_inode_flag(inode, FI_PIN_FILE);
-	ret = F2FS_I(inode)->i_gc_failures;
+	ret = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
 done:
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 out:
@@ -2792,7 +2800,7 @@ static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin = 0;
 
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
-		pin = F2FS_I(inode)->i_gc_failures;
+		pin = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
 	return put_user(pin, (u32 __user *)arg);
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3c7914425b4e..33aa82f5b9bf 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -600,7 +600,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
  * This can be used to move blocks, aka LBAs, directly on disk.
  */
 static void move_data_block(struct inode *inode, block_t bidx,
-					unsigned int segno, int off)
+				int gc_type, unsigned int segno, int off)
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
@@ -627,8 +627,11 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode)) {
+		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
+		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
 		goto out;
+	}
 
 	if (f2fs_is_pinned_file(inode)) {
 		f2fs_pin_file_control(inode, true);
@@ -735,8 +738,11 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode)) {
+		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
+		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
 		goto out;
+	}
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
 			f2fs_pin_file_control(inode, true);
@@ -898,7 +904,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_post_read_required(inode))
-				move_data_block(inode, start_bidx, segno, off);
+				move_data_block(inode, start_bidx, gc_type,
+								segno, off);
 			else
 				move_data_page(inode, start_bidx, gc_type,
 								segno, off);
@@ -1015,6 +1022,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		.ilist = LIST_HEAD_INIT(gc_list.ilist),
 		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 	};
+	unsigned long long last_skipped = sbi->skipped_atomic_files[FG_GC];
+	unsigned int skipped_round = 0, round = 0;
 
 	trace_f2fs_gc_begin(sbi->sb, sync, background,
 				get_pages(sbi, F2FS_DIRTY_NODES),
@@ -1066,11 +1075,21 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		sec_freed++;
 	total_freed += seg_freed;
 
+	if (gc_type == FG_GC) {
+		if (sbi->skipped_atomic_files[FG_GC] > last_skipped)
+			skipped_round++;
+		last_skipped = sbi->skipped_atomic_files[FG_GC];
+		round++;
+	}
+
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (!sync) {
 		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
+			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
+				skipped_round * 2 >= round)
+				drop_inmem_pages_all(sbi, true);
 			segno = NULL_SEGNO;
 			goto gc_more;
 		}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3a74a1cf3264..4b9dce9029ac 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -235,7 +235,8 @@ static int do_read_inode(struct inode *inode)
 	if (S_ISDIR(inode->i_mode))
 		fi->i_current_depth = le32_to_cpu(ri->i_current_depth);
 	else if (S_ISREG(inode->i_mode))
-		fi->i_gc_failures = le16_to_cpu(ri->i_gc_failures);
+		fi->i_gc_failures[GC_FAILURE_PIN] =
+					le16_to_cpu(ri->i_gc_failures);
 	fi->i_xattr_nid = le32_to_cpu(ri->i_xattr_nid);
 	fi->i_flags = le32_to_cpu(ri->i_flags);
 	fi->flags = 0;
@@ -428,7 +429,8 @@ void update_inode(struct inode *inode, struct page *node_page)
 		ri->i_current_depth =
 			cpu_to_le32(F2FS_I(inode)->i_current_depth);
 	else if (S_ISREG(inode->i_mode))
-		ri->i_gc_failures = cpu_to_le16(F2FS_I(inode)->i_gc_failures);
+		ri->i_gc_failures =
+			cpu_to_le16(F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN]);
 	ri->i_xattr_nid = cpu_to_le32(F2FS_I(inode)->i_xattr_nid);
 	ri->i_flags = cpu_to_le32(F2FS_I(inode)->i_flags);
 	ri->i_pino = cpu_to_le32(F2FS_I(inode)->i_pino);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c660efad7590..cfa173942056 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -280,7 +280,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 	return err;
 }
 
-void drop_inmem_pages_all(struct f2fs_sb_info *sbi)
+void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 {
 	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
 	struct inode *inode;
@@ -296,9 +296,17 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi)
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 
 	if (inode) {
+		if (gc_failure) {
+			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
+				goto drop;
+			goto skip;
+		}
+drop:
+		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 		drop_inmem_pages(inode);
 		iput(inode);
 	}
+skip:
 	congestion_wait(BLK_RW_ASYNC, HZ/50);
 	cond_resched();
 	goto next;
@@ -318,6 +326,7 @@ void drop_inmem_pages(struct inode *inode)
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
+	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
 	stat_dec_atomic_write(inode);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5b7c35fa4bd2..c385daabcb67 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -215,6 +215,8 @@ struct segment_allocation {
 #define IS_DUMMY_WRITTEN_PAGE(page)			\
 		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
 
+#define MAX_SKIP_ATOMIC_COUNT			16
+
 struct inmem_pages {
 	struct list_head list;
 	struct page *page;
-- 
2.17.0.391.g1f1cddd558b5
