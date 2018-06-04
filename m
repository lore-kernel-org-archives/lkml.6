Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeFDPWs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbeFDPWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:22:45 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: let sync node IO interrupt async one
Date: Mon,  4 Jun 2018 23:20:36 +0800
Message-Id: <20180604152036.23764-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180604152036.23764-1-chao@kernel.org>
References: <20180604152036.23764-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Although mixed sync/async IOs can have continuous LBA, as they have
different IO priority, block IO scheduler will add them into different
queues and commit them separately, result in splited IOs which causes
wrose performance.

This patch gives high priority to synchronous IO of nodes, means that
once synchronous flow starts, it can interrupt asynchronous writeback
flow of system flusher, so more big IOs can be expected.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 ++
 fs/f2fs/data.c       |  9 +++++----
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       |  2 ++
 fs/f2fs/gc.c         |  7 +++++++
 fs/f2fs/node.c       | 21 ++++++++++++++++++---
 fs/f2fs/super.c      |  3 ++-
 7 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c7ffa1e0e021..07e2f1514a21 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1079,7 +1079,9 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
+		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
+		atomic_dec(&sbi->wb_sync_req[NODE]);
 		if (err) {
 			up_write(&sbi->node_change);
 			f2fs_unlock_all(sbi);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a2e30c403ef2..8f931d699287 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1933,6 +1933,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	struct pagevec pvec;
+	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	int nr_pages;
 	pgoff_t uninitialized_var(writeback_index);
 	pgoff_t index;
@@ -1987,7 +1988,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			bool submitted = false;
 
 			/* give a priority to WB_SYNC threads */
-			if (atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) &&
+			if (atomic_read(&sbi->wb_sync_req[DATA]) &&
 					wbc->sync_mode == WB_SYNC_NONE) {
 				done = 1;
 				break;
@@ -2107,8 +2108,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 
 	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		atomic_inc(&sbi->wb_sync_req);
-	else if (atomic_read(&sbi->wb_sync_req))
+		atomic_inc(&sbi->wb_sync_req[DATA]);
+	else if (atomic_read(&sbi->wb_sync_req[DATA]))
 		goto skip_write;
 
 	blk_start_plug(&plug);
@@ -2116,7 +2117,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	blk_finish_plug(&plug);
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		atomic_dec(&sbi->wb_sync_req);
+		atomic_dec(&sbi->wb_sync_req[DATA]);
 	/*
 	 * if some pages were truncated, we cannot guarantee its mapping->host
 	 * to detect pending bios.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f167d01443fe..4c09e770a0a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1201,7 +1201,7 @@ struct f2fs_sb_info {
 	struct percpu_counter alloc_valid_block_count;
 
 	/* writeback control */
-	atomic_t wb_sync_req;			/* count # of WB_SYNC threads */
+	atomic_t wb_sync_req[META];	/* count # of WB_SYNC threads */
 
 	/* valid inode count */
 	struct percpu_counter total_valid_inode_count;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 74c326442565..16fd50abbf40 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -274,7 +274,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto out;
 	}
 sync_nodes:
+	atomic_inc(&sbi->wb_sync_req[NODE]);
 	ret = f2fs_fsync_node_pages(sbi, inode, &wbc, atomic);
+	atomic_dec(&sbi->wb_sync_req[NODE]);
 	if (ret)
 		goto out;
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2a97ce7bc91d..9093be6e7a7d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -473,12 +473,16 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 	block_t start_addr;
 	int off;
 	int phase = 0;
+	bool fggc = (gc_type == FG_GC);
 
 	start_addr = START_BLOCK(sbi, segno);
 
 next_step:
 	entry = sum;
 
+	if (fggc && phase == 2)
+		atomic_inc(&sbi->wb_sync_req[NODE]);
+
 	for (off = 0; off < sbi->blocks_per_seg; off++, entry++) {
 		nid_t nid = le32_to_cpu(entry->nid);
 		struct page *node_page;
@@ -525,6 +529,9 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 
 	if (++phase < 3)
 		goto next_step;
+
+	if (fggc)
+		atomic_dec(&sbi->wb_sync_req[NODE]);
 }
 
 /*
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 64ad5466887f..47d0e64a95a8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1596,21 +1596,28 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
-	int nr_pages;
+	int nr_pages, done = 0;
 
 	pagevec_init(&pvec);
 
 next_step:
 	index = 0;
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
+			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
 		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
 
+			/* give a priority to WB_SYNC threads */
+			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
+					wbc->sync_mode == WB_SYNC_NONE) {
+				done = 1;
+				break;
+			}
+
 			/*
 			 * flushing sequence with step:
 			 * 0. indirect nodes
@@ -1738,6 +1745,11 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
 		goto skip_write;
 
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		atomic_inc(&sbi->wb_sync_req[NODE]);
+	else if (atomic_read(&sbi->wb_sync_req[NODE]))
+		goto skip_write;
+
 	trace_f2fs_writepages(mapping->host, wbc, NODE);
 
 	diff = nr_pages_to_write(sbi, NODE, wbc);
@@ -1745,6 +1757,9 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	f2fs_sync_node_pages(sbi, wbc, true, FS_NODE_IO);
 	blk_finish_plug(&plug);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
+
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		atomic_dec(&sbi->wb_sync_req[NODE]);
 	return 0;
 
 skip_write:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 25863cec143a..73d7d7e51a61 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2362,7 +2362,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_COUNT_TYPE; i++)
 		atomic_set(&sbi->nr_pages[i], 0);
 
-	atomic_set(&sbi->wb_sync_req, 0);
+	for (i = 0; i < META; i++)
+		atomic_set(&sbi->wb_sync_req[i], 0);
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
-- 
2.16.2.17.g38e79b1fd
