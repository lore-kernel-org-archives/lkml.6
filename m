Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938356AbeE1Lk7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938092AbeE1LMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 178/272] f2fs: flush cp pack except cp pack 2 page at first
Date: Mon, 28 May 2018 12:03:31 +0200
Message-Id: <20180528100255.684743517@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@aol.com>

[ Upstream commit 46706d5917f4457a6befe7a39a15c89dbb1ce9ca ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |   69 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 23 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1162,6 +1162,39 @@ static void update_ckpt_flags(struct f2f
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
@@ -1264,16 +1297,6 @@ static int do_checkpoint(struct f2fs_sb_
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
 
@@ -1301,26 +1324,26 @@ static int do_checkpoint(struct f2fs_sb_
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
