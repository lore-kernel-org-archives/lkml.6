Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5EDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E8216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IljIQQAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8E8216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeI0WBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbeI0WBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:01:23 -0400
Received: from localhost.localdomain (unknown [49.77.227.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A20216C4;
        Thu, 27 Sep 2018 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538062951;
        bh=h3pRTZkNDPDv9a9en+kR/W+YdXMohtUL1X4CS9CllNU=;
        h=From:To:Cc:Subject:Date:From;
        b=IljIQQAmI2ynS08Q8bFfmr6DOpFFSDkQaO2ckK7UfkIHgibuiBAJ9NQP5KfwFc9E+
         1BlLNZTCoOhzhava8IyJQEo47y8QFzyrDT0QlkCLYIbJ7AeWl/HNCqsP0wSm3F/Szo
         Lyt6q9vlgL4uFl0zdZ+sXN+Ji8c71mNjyRx+1pm0=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] Revert: "f2fs: check last page index in cached bio to decide submission"
Date:   Thu, 27 Sep 2018 23:41:16 +0800
Message-Id: <20180927154116.10912-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

There is one case that we can leave bio in f2fs, result in hanging
page writeback waiter.

Thread A				Thread B
- f2fs_write_cache_pages
 - f2fs_submit_page_write
 page #0 cached in bio #0 of cold log
 - f2fs_submit_page_write
 page #1 cached in bio #1 of warm log
					- f2fs_write_cache_pages
					 - f2fs_submit_page_write
					 bio is full, submit bio #1 contain page #1
 - f2fs_submit_merged_write_cond(, page #1)
 fail to submit bio #0 due to page #1 is not in any cached bios.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- only pass page parameter for f2fs_submit_merged_write_cond in relaimer path
 fs/f2fs/checkpoint.c |  3 +--
 fs/f2fs/data.c       | 38 +++++++++++++++++++-------------------
 fs/f2fs/f2fs.h       |  4 ++--
 fs/f2fs/node.c       | 11 +++++------
 fs/f2fs/segment.c    | 11 +++++------
 5 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d312d2829d5a..dbffb3f6c5c7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -279,8 +279,7 @@ static int __f2fs_write_meta_page(struct page *page,
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
-		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
-						0, page->index, META);
+		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, META);
 
 	unlock_page(page);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 36998b078b1b..02d5ce888a4a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -322,8 +322,8 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
-static bool __has_merged_page(struct f2fs_bio_info *io,
-				struct inode *inode, nid_t ino, pgoff_t idx)
+static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
+						struct page *page, nid_t ino)
 {
 	struct bio_vec *bvec;
 	struct page *target;
@@ -332,7 +332,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	if (!io->bio)
 		return false;
 
-	if (!inode && !ino)
+	if (!inode && !page && !ino)
 		return true;
 
 	bio_for_each_segment_all(bvec, io->bio, i) {
@@ -342,11 +342,10 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 		else
 			target = fscrypt_control_page(bvec->bv_page);
 
-		if (idx != target->index)
-			continue;
-
 		if (inode && inode == target->mapping->host)
 			return true;
+		if (page && page == target)
+			return true;
 		if (ino && ino == ino_of_node(target))
 			return true;
 	}
@@ -355,7 +354,8 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 }
 
 static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
-				nid_t ino, pgoff_t idx, enum page_type type)
+						struct page *page, nid_t ino,
+						enum page_type type)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	enum temp_type temp;
@@ -366,7 +366,7 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
 		io = sbi->write_io[btype] + temp;
 
 		down_read(&io->io_rwsem);
-		ret = __has_merged_page(io, inode, ino, idx);
+		ret = __has_merged_page(io, inode, page, ino);
 		up_read(&io->io_rwsem);
 
 		/* TODO: use HOT temp only for meta pages now. */
@@ -397,12 +397,12 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 }
 
 static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type, bool force)
+				struct inode *inode, struct page *page,
+				nid_t ino, enum page_type type, bool force)
 {
 	enum temp_type temp;
 
-	if (!force && !has_merged_page(sbi, inode, ino, idx, type))
+	if (!force && !has_merged_page(sbi, inode, page, ino, type))
 		return;
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
@@ -421,10 +421,10 @@ void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
 }
 
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type)
+				struct inode *inode, struct page *page,
+				nid_t ino, enum page_type type)
 {
-	__submit_merged_write_cond(sbi, inode, ino, idx, type, false);
+	__submit_merged_write_cond(sbi, inode, page, ino, type, false);
 }
 
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
@@ -1960,7 +1960,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		ClearPageUptodate(page);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
+		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, DATA);
 		clear_inode_flag(inode, FI_HOT_DATA);
 		f2fs_remove_dirty_inode(inode);
 		submitted = NULL;
@@ -2018,10 +2018,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
-	pgoff_t last_idx = ULONG_MAX;
 	int cycled;
 	int range_whole = 0;
 	int tag;
+	int nwritten = 0;
 
 	pagevec_init(&pvec);
 
@@ -2124,7 +2124,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				done = 1;
 				break;
 			} else if (submitted) {
-				last_idx = page->index;
+				nwritten++;
 			}
 
 			if (--wbc->nr_to_write <= 0 &&
@@ -2146,9 +2146,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = done_index;
 
-	if (last_idx != ULONG_MAX)
+	if (nwritten)
 		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
-						0, last_idx, DATA);
+								NULL, 0, DATA);
 
 	return ret;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dfd2de0414e0..9d85961cc498 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3028,8 +3028,8 @@ int f2fs_init_post_read_processing(void);
 void f2fs_destroy_post_read_processing(void);
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type);
+				struct inode *inode, struct page *page,
+				nid_t ino, enum page_type type);
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 void f2fs_submit_page_write(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8f4e12819c94..a4a6ec2b593f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1561,8 +1561,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	up_read(&sbi->node_write);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_write_cond(sbi, page->mapping->host, 0,
-						page->index, NODE);
+		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, NODE);
 		submitted = NULL;
 	}
 
@@ -1627,13 +1626,13 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			unsigned int *seq_id)
 {
 	pgoff_t index;
-	pgoff_t last_idx = ULONG_MAX;
 	struct pagevec pvec;
 	int ret = 0;
 	struct page *last_page = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
 	int nr_pages;
+	int nwritten = 0;
 
 	if (atomic) {
 		last_page = last_fsync_dnode(sbi, ino);
@@ -1711,7 +1710,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				f2fs_put_page(last_page, 0);
 				break;
 			} else if (submitted) {
-				last_idx = page->index;
+				nwritten++;
 			}
 
 			if (page == last_page) {
@@ -1737,8 +1736,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto retry;
 	}
 out:
-	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_write_cond(sbi, NULL, ino, last_idx, NODE);
+	if (nwritten)
+		f2fs_submit_merged_write_cond(sbi, NULL, NULL, ino, NODE);
 	return ret ? -EIO: 0;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 97a4fae75651..965ef524e2a2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -371,7 +371,7 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
 		.io_type = FS_DATA_IO,
 	};
 	struct list_head revoke_list;
-	pgoff_t last_idx = ULONG_MAX;
+	bool submit_bio = false;
 	int err = 0;
 
 	INIT_LIST_HEAD(&revoke_list);
@@ -406,14 +406,14 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
 			}
 			/* record old blkaddr for revoking */
 			cur->old_addr = fio.old_blkaddr;
-			last_idx = page->index;
+			submit_bio = true;
 		}
 		unlock_page(page);
 		list_move_tail(&cur->list, &revoke_list);
 	}
 
-	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_write_cond(sbi, inode, 0, last_idx, DATA);
+	if (submit_bio)
+		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
 
 	if (err) {
 		/*
@@ -3179,8 +3179,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
-		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
-						0, page->index, type);
+		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
 		if (ordered)
 			wait_on_page_writeback(page);
 		else
-- 
2.18.0

