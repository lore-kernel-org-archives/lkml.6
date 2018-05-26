Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030973AbeEZBAu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 21:00:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030834AbeEZBAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 21:00:49 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: keep migration IO order in LFS mode
Date: Sat, 26 May 2018 09:00:13 +0800
Message-ID: <20180526010013.10143-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-migration IO, we will keep order of data/node blocks' submitting
as allocation sequence by sorting IOs in per log io_list list, but for
migration IO, it could be out-of-order.

In LFS mode, we should keep all IOs including migration IO be ordered,
so that this patch fixes to add an additional lock to keep submitting
order.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
v2:
- introduce variable lfs_mode to record historical option, it can avoid
option being changed.
 fs/f2fs/f2fs.h    | 2 ++
 fs/f2fs/gc.c      | 6 ++++++
 fs/f2fs/segment.c | 5 +++++
 fs/f2fs/super.c   | 1 +
 4 files changed, 14 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dc0a462461e8..3cc56b4df03f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1124,6 +1124,8 @@ struct f2fs_sb_info {
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
 	struct mutex wio_mutex[NR_PAGE_TYPE - 1][NR_TEMP_TYPE];
 						/* bio ordering for NODE/DATA */
+	/* keep migration IO order for LFS mode */
+	struct rw_semaphore io_order_lock;
 	mempool_t *write_io_dummy;		/* Dummy pages */
 
 	/* for checkpoint */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5ef3233c38d2..50bb8fc25275 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -610,6 +610,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	struct page *page;
 	block_t newaddr;
 	int err;
+	bool lfs_mode = test_opt(fio.sbi, LFS);
 
 	/* do not read out */
 	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
@@ -653,6 +654,9 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
+	if (lfs_mode)
+		down_write(&fio.sbi->io_order_lock);
+
 	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 					&sum, CURSEG_COLD_DATA, NULL, false);
 
@@ -709,6 +713,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
 put_page_out:
 	f2fs_put_page(fio.encrypted_page, 1);
 recover_block:
+	if (lfs_mode)
+		up_write(&fio.sbi->io_order_lock);
 	if (err)
 		__f2fs_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
 								true, true);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a05208954dd5..c67d92bf2968 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2735,7 +2735,10 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
 	int type = __get_segment_type(fio);
 	int err;
+	bool keep_order = (test_opt(fio->sbi, LFS) && type == CURSEG_COLD_DATA);
 
+	if (keep_order)
+		down_read(&fio->sbi->io_order_lock);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio, true);
@@ -2748,6 +2751,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	} else if (!err) {
 		update_device_state(fio);
 	}
+	if (keep_order)
+		up_read(&fio->sbi->io_order_lock);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8e5f0a178f5d..1b42fc7e4b29 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2365,6 +2365,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_PAGE_TYPE - 1; i++)
 		for (j = HOT; j < NR_TEMP_TYPE; j++)
 			mutex_init(&sbi->wio_mutex[i][j]);
+	init_rwsem(&sbi->io_order_lock);
 	spin_lock_init(&sbi->cp_lock);
 
 	sbi->dirty_device = 0;
-- 
2.17.0.391.g1f1cddd558b5
