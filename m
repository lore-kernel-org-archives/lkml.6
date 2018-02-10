Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeBJENM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 23:13:12 -0500
Received: from omr-m017e.mx.aol.com ([204.29.186.19]:43327 "EHLO
        omr-m017e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJENK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 23:13:10 -0500
From: Gao Xiang <hsiangkao@aol.com>
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        heyunlei@huawei.com, Gao Xiang <hsiangkao@aol.com>
Subject: [PATCH RFC v5] f2fs: flush cp pack except cp pack 2 page at first
Date: Sat, 10 Feb 2018 12:12:51 +0800
Message-Id: <20180210041251.1208-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.14.2.windows.2
x-aol-global-disposition: G
x-aol-sid: 3039ac1b150d5a7e714f7af3
X-AOL-IP: 112.64.61.200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we attempt to flush the whole cp pack in a single bio,
however, when suddenly powering off at this time, we could get into
an extreme scenario that cp pack 1 page and cp pack 2 page are updated
and latest, but payload or current summaries are still partially
outdated. (see reliable write in the UFS specification)

This patch submits the whole cp pack except cp pack 2 page at first,
and then writes the cp pack 2 page with an extra independent
bio with pre-io barrier.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
Change log from v4:
  - remove redundant "filemap_fdatawait_range"
      - filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
      - filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);
  - move f2fs_flush_device_cache to a more suitable position
  - wait_on_all_pages_writeback after commit_checkpoint
      - since we remove lots of redundant code, I think it's acceptable
      - and it will ensure one checkpoint safety.
Change log from v3:
  - further review comments are applied from Jaegeuk and Chao
  - Tested on this patch (without multiple-device): mount, boot Android with f2fs userdata and make fragment
  - If any problem with this patch or I miss something, please kindly share your comments, thanks :)
Change log from v2:
  - Apply the review comments from Chao
Change log from v1:
  - Apply the review comments from Chao
  - time data from "finish block_ops" to " finish checkpoint" (tested on ARM64 with TOSHIBA 128GB UFS):
     Before patch: 0.002273  0.001973  0.002789  0.005159  0.002050
     After patch: 0.002502  0.001624  0.002487  0.003049  0.002696

 fs/f2fs/checkpoint.c | 69 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 512dca8..4e352cf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1162,6 +1162,39 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	spin_unlock_irqrestore(&sbi->cp_lock, flags);
 }
 
+static void commit_checkpoint(struct f2fs_sb_info *sbi,
+	void *src, block_t blk_addr)
+{
+	struct writeback_control wbc = {
+		.for_reclaim = 0,
+	};
+
+	/*
+	 * pagevec_lookup_tag and lock_page again will take
+	 * some extra time. Therefore, update_meta_pages and
+	 * sync_meta_pages are combined in this function.
+	 */
+	struct page *page = grab_meta_page(sbi, blk_addr);
+	int err;
+
+	memcpy(page_address(page), src, PAGE_SIZE);
+	set_page_dirty(page);
+
+	f2fs_wait_on_page_writeback(page, META, true);
+	f2fs_bug_on(sbi, PageWriteback(page));
+	if (unlikely(!clear_page_dirty_for_io(page)))
+		f2fs_bug_on(sbi, 1);
+
+	/* writeout cp pack 2 page */
+	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
+	f2fs_bug_on(sbi, err);
+
+	f2fs_put_page(page, 0);
+
+	/* submit checkpoint (with barrier if NOBARRIER is not set) */
+	f2fs_submit_merged_write(sbi, META_FLUSH);
+}
+
 static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -1264,16 +1297,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		}
 	}
 
-	/* need to wait for end_io results */
-	wait_on_all_pages_writeback(sbi);
-	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
-
-	/* flush all device cache */
-	err = f2fs_flush_device_cache(sbi);
-	if (err)
-		return err;
-
 	/* write out checkpoint buffer at block 0 */
 	update_meta_page(sbi, ckpt, start_blk++);
 
@@ -1301,26 +1324,26 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
-	/* writeout checkpoint block */
-	update_meta_page(sbi, ckpt, start_blk);
+	/* update user_block_counts */
+	sbi->last_valid_block_count = sbi->total_valid_block_count;
+	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
-	/* wait for previous submitted node/meta pages writeback */
+	/* Here, we have one bio having CP pack except cp pack 2 page */
+	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+
+	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
-	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
-	filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);
-
-	/* update user_block_counts */
-	sbi->last_valid_block_count = sbi->total_valid_block_count;
-	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
-
-	/* Here, we only have one bio having CP pack */
-	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
+	/* flush all device cache */
+	err = f2fs_flush_device_cache(sbi);
+	if (err)
+		return err;
 
-	/* wait for previous submitted meta pages writeback */
+	/* barrier and flush checkpoint cp pack 2 page if it can */
+	commit_checkpoint(sbi, ckpt, start_blk);
 	wait_on_all_pages_writeback(sbi);
 
 	release_ino_entry(sbi, false);
-- 
2.7.4
