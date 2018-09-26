Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18B2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E18B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIZP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:59:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbeIZP7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:59:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90DA16EBBE2B7;
        Wed, 26 Sep 2018 17:47:39 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 26 Sep 2018 17:47:33 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] Revert: "f2fs: check last page index in cached bio to decide submission"
Date:   Wed, 26 Sep 2018 17:47:30 +0800
Message-ID: <20180926094730.100570-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
v2:
- rebase to dev-test.
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       | 38 +++++++++++++++++++-------------------
 fs/f2fs/f2fs.h       |  4 ++--
 fs/f2fs/node.c       | 12 ++++++------
 fs/f2fs/segment.c    | 11 +++++------
 5 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d624d7983197..b634e7f88d43 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -280,7 +280,7 @@ static int __f2fs_write_meta_page(struct page *page,
 
 	if (wbc->for_reclaim)
 		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
-						0, page->index, META);
+							page->index, 0, META);
 
 	unlock_page(page);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index be69b6ac6870..8bf08196e91c 100644
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
@@ -1962,7 +1962,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		ClearPageUptodate(page);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
+		f2fs_submit_merged_write_cond(sbi, inode, page->index, 0, DATA);
 		clear_inode_flag(inode, FI_HOT_DATA);
 		f2fs_remove_dirty_inode(inode);
 		submitted = NULL;
@@ -2020,10 +2020,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
-	pgoff_t last_idx = ULONG_MAX;
 	int cycled;
 	int range_whole = 0;
 	int tag;
+	int nwritten = 0;
 
 	pagevec_init(&pvec);
 
@@ -2126,7 +2126,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				done = 1;
 				break;
 			} else if (submitted) {
-				last_idx = page->index;
+				nwritten++;
 			}
 
 			if (--wbc->nr_to_write <= 0 &&
@@ -2148,9 +2148,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
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
index dc9306e87a51..464545e40729 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3049,8 +3049,8 @@ int f2fs_init_post_read_processing(void);
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
index ea151e07790f..38a1f0d395a2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1561,8 +1561,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	up_read(&sbi->node_write);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_write_cond(sbi, page->mapping->host, 0,
-						page->index, NODE);
+		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
+						page->index, 0, NODE);
 		submitted = NULL;
 	}
 
@@ -1634,13 +1634,13 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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
@@ -1718,7 +1718,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				f2fs_put_page(last_page, 0);
 				break;
 			} else if (submitted) {
-				last_idx = page->index;
+				nwritten++;
 			}
 
 			if (page == last_page) {
@@ -1744,8 +1744,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
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
2.18.0.rc1

