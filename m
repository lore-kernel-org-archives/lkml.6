Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF98C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A2821904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfBSIPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:15:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfBSIPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:15:43 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 508B951D1409C7E68666;
        Tue, 19 Feb 2019 16:15:41 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 16:15:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4] f2fs: add bio cache for IPU
Date:   Tue, 19 Feb 2019 16:15:29 +0800
Message-ID: <20190219081529.5106-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SQLite in Wal mode may trigger sequential IPU write in db-wal file, after
commit d1b3e72d5490 ("f2fs: submit bio of in-place-update pages"), we
lost the chance of merging page in inner managed bio cache, result in
submitting more small-sized IO.

So let's add temporary bio in writepages() to cache mergeable write IO as
much as possible.

Test case:
1. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"
2. xfs_io -f /mnt/f2fs/file -c "pwrite 0 65536" -c "fsync"

Before:
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65552, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65560, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65568, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65576, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65584, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65592, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65600, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65608, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65616, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65624, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65632, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65640, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65648, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65656, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65664, size = 4096
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57352, size = 4096

After:
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), DATA, sector = 65544, size = 65536
f2fs_submit_write_bio: dev = (251,0)/(251,0), rw = WRITE(S), NODE, sector = 57368, size = 4096

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v4:
- fix to set *bio to NULL in f2fs_submit_ipu_bio()
- spread f2fs_submit_ipu_bio()
- fix to count dirty encrypted page correctly in f2fs_merge_page_bio()
- remove redundant assignment of fio->last_block
 fs/f2fs/data.c    | 88 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/f2fs.h    |  3 ++
 fs/f2fs/segment.c |  5 ++-
 3 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 35910ff23582..e4c183e85de8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -296,20 +296,20 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
-static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
+static bool __has_merged_page(struct bio *bio, struct inode *inode,
 						struct page *page, nid_t ino)
 {
 	struct bio_vec *bvec;
 	struct page *target;
 	int i;
 
-	if (!io->bio)
+	if (!bio)
 		return false;
 
 	if (!inode && !page && !ino)
 		return true;
 
-	bio_for_each_segment_all(bvec, io->bio, i) {
+	bio_for_each_segment_all(bvec, bio, i) {
 
 		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
@@ -360,7 +360,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 			struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
 
 			down_read(&io->io_rwsem);
-			ret = __has_merged_page(io, inode, page, ino);
+			ret = __has_merged_page(io->bio, inode, page, ino);
 			up_read(&io->io_rwsem);
 		}
 		if (ret)
@@ -429,6 +429,61 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
+int f2fs_merge_page_bio(struct f2fs_io_info *fio)
+{
+	struct bio *bio = *fio->bio;
+	struct page *page = fio->encrypted_page ?
+			fio->encrypted_page : fio->page;
+
+	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
+			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
+		return -EFAULT;
+
+	trace_f2fs_submit_page_bio(page, fio);
+	f2fs_trace_ios(fio, 0);
+
+	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
+			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
+		__submit_bio(fio->sbi, bio, fio->type);
+		bio = NULL;
+	}
+alloc_new:
+	if (!bio) {
+		bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
+				BIO_MAX_PAGES, false, fio->type, fio->temp);
+		bio_set_op_attrs(bio, fio->op, fio->op_flags);
+	}
+
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		__submit_bio(fio->sbi, bio, fio->type);
+		bio = NULL;
+		goto alloc_new;
+	}
+
+	if (fio->io_wbc)
+		wbc_account_io(fio->io_wbc, page, PAGE_SIZE);
+
+	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
+
+	*fio->last_block = fio->new_blkaddr;
+	*fio->bio = bio;
+
+	return 0;
+}
+
+void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
+							struct page *page)
+{
+	if (!bio)
+		return;
+
+	if (!__has_merged_page(*bio, NULL, page, 0))
+		return;
+
+	__submit_bio(sbi, *bio, DATA);
+	*bio = NULL;
+}
+
 void f2fs_submit_page_write(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
@@ -1854,6 +1909,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 }
 
 static int __write_data_page(struct page *page, bool *submitted,
+				struct bio **bio,
+				sector_t *last_block,
 				struct writeback_control *wbc,
 				enum iostat_type io_type)
 {
@@ -1879,6 +1936,8 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.need_lock = LOCK_RETRY,
 		.io_type = io_type,
 		.io_wbc = wbc,
+		.bio = bio,
+		.last_block = last_block,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
 	}
 
 	unlock_page(page);
-	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
+	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
+		f2fs_submit_ipu_bio(sbi, bio, page);
 		f2fs_balance_fs(sbi, need_balance_fs);
+	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
+		f2fs_submit_ipu_bio(sbi, bio, page);
 		f2fs_submit_merged_write(sbi, DATA);
 		submitted = NULL;
 	}
@@ -2006,7 +2068,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 static int f2fs_write_data_page(struct page *page,
 					struct writeback_control *wbc)
 {
-	return __write_data_page(page, NULL, wbc, FS_DATA_IO);
+	return __write_data_page(page, NULL, NULL, NULL, wbc, FS_DATA_IO);
 }
 
 /*
@@ -2022,6 +2084,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int done = 0;
 	struct pagevec pvec;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	struct bio *bio = NULL;
+	sector_t last_block;
 	int nr_pages;
 	pgoff_t uninitialized_var(writeback_index);
 	pgoff_t index;
@@ -2098,17 +2162,20 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			}
 
 			if (PageWriteback(page)) {
-				if (wbc->sync_mode != WB_SYNC_NONE)
+				if (wbc->sync_mode != WB_SYNC_NONE) {
 					f2fs_wait_on_page_writeback(page,
 							DATA, true, true);
-				else
+					f2fs_submit_ipu_bio(sbi, &bio, page);
+				} else {
 					goto continue_unlock;
+				}
 			}
 
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			ret = __write_data_page(page, &submitted, wbc, io_type);
+			ret = __write_data_page(page, &submitted, &bio,
+					&last_block, wbc, io_type);
 			if (unlikely(ret)) {
 				/*
 				 * keep nr_to_write, since vfs uses this to
@@ -2157,6 +2224,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if (nwritten)
 		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
 								NULL, 0, DATA);
+	/* submit cached bio of IPU write */
+	if (bio)
+		__submit_bio(sbi, bio, DATA);
 
 	return ret;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46db3ed87c84..7c4355927d28 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1048,6 +1048,8 @@ struct f2fs_io_info {
 	bool retry;		/* need to reallocate block address */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
+	struct bio **bio;		/* bio for ipu */
+	sector_t *last_block;		/* last block number in bio */
 	unsigned char version;		/* version of the node */
 };
 
@@ -3105,6 +3107,7 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				nid_t ino, enum page_type type);
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
+int f2fs_merge_page_bio(struct f2fs_io_info *fio);
 void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 			block_t blk_addr, struct bio *bio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b2167d53fb9d..66838ab2f21e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3196,7 +3196,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 
 	stat_inc_inplace_blocks(fio->sbi);
 
-	err = f2fs_submit_page_bio(fio);
+	if (fio->bio)
+		err = f2fs_merge_page_bio(fio);
+	else
+		err = f2fs_submit_page_bio(fio);
 	if (!err)
 		update_device_state(fio);
 
-- 
2.18.0.rc1

