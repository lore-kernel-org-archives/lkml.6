Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33CC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384B321738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dry/AzJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384B321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbeHNRZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732188AbeHNRZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:25:21 -0400
Received: from localhost.localdomain (unknown [49.77.216.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C921D21736;
        Tue, 14 Aug 2018 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534257473;
        bh=hRX/C6KdIctiRA8huIa3jiUop1o1bJxAHpdSAubM3IM=;
        h=From:To:Cc:Subject:Date:From;
        b=dry/AzJNHN2GP0EWgZAse/KyqtLFD+WTSL8uNbVHYVG8ap1vxRflIyF7juDIYLuhQ
         j6cLgt0d/wPbhhbCUL9ChkfHbxJg2MzmBTrEWuBbi5mTrRj3VwGnAJ5aJxgCDpgPng
         KKYedeww0D6ejZgbWyRFNwqtPgwGvlLk7fEfCFAg=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: readahead encrypted block during GC
Date:   Tue, 14 Aug 2018 22:37:25 +0800
Message-Id: <20180814143725.7599-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

During GC, for each encrypted block, we will read block synchronously
into meta page, and then submit it into current cold data log area.

So this block read model with 4k granularity can make poor performance,
like migrating non-encrypted block, let's readahead encrypted block
as well to improve migration performance.

To implement this, we choose meta page that its index is old block
address of the encrypted block, and readahead ciphertext into this
page, later, if readaheaded page is still updated, we will load its
data into target meta page, and submit the write IO.

Note that for OPU, truncation, deletion, we need to invalid meta
page after we invalid old block address, to make sure we won't load
invalid data from target meta page during encrypted block migration.

for ((i = 0; i < 1000; i++))
do {
        xfs_io -f /mnt/f2fs/dir/$i -c "pwrite 0 128k" -c "fsync";
} done

for ((i = 0; i < 1000; i+=2))
do {
        rm /mnt/f2fs/dir/$i;
} done

ret = ioctl(fd, F2FS_IOC_GARBAGE_COLLECT, 0);

Before:
              gc-6549  [001] d..1 214682.212797: block_rq_insert: 8,32 RA 32768 () 786400 + 64 [gc]
              gc-6549  [001] d..1 214682.212802: block_unplug: [gc] 1
              gc-6549  [001] .... 214682.213892: block_bio_queue: 8,32 R 67494144 + 8 [gc]
              gc-6549  [001] .... 214682.213899: block_getrq: 8,32 R 67494144 + 8 [gc]
              gc-6549  [001] .... 214682.213902: block_plug: [gc]
              gc-6549  [001] d..1 214682.213905: block_rq_insert: 8,32 R 4096 () 67494144 + 8 [gc]
              gc-6549  [001] d..1 214682.213908: block_unplug: [gc] 1
              gc-6549  [001] .... 214682.226405: block_bio_queue: 8,32 R 67494152 + 8 [gc]
              gc-6549  [001] .... 214682.226412: block_getrq: 8,32 R 67494152 + 8 [gc]
              gc-6549  [001] .... 214682.226414: block_plug: [gc]
              gc-6549  [001] d..1 214682.226417: block_rq_insert: 8,32 R 4096 () 67494152 + 8 [gc]
              gc-6549  [001] d..1 214682.226420: block_unplug: [gc] 1
              gc-6549  [001] .... 214682.226904: block_bio_queue: 8,32 R 67494160 + 8 [gc]
              gc-6549  [001] .... 214682.226910: block_getrq: 8,32 R 67494160 + 8 [gc]
              gc-6549  [001] .... 214682.226911: block_plug: [gc]
              gc-6549  [001] d..1 214682.226914: block_rq_insert: 8,32 R 4096 () 67494160 + 8 [gc]
              gc-6549  [001] d..1 214682.226916: block_unplug: [gc] 1

After:
              gc-5678  [003] .... 214327.025906: block_bio_queue: 8,32 R 67493824 + 8 [gc]
              gc-5678  [003] .... 214327.025908: block_bio_backmerge: 8,32 R 67493824 + 8 [gc]
              gc-5678  [003] .... 214327.025915: block_bio_queue: 8,32 R 67493832 + 8 [gc]
              gc-5678  [003] .... 214327.025917: block_bio_backmerge: 8,32 R 67493832 + 8 [gc]
              gc-5678  [003] .... 214327.025923: block_bio_queue: 8,32 R 67493840 + 8 [gc]
              gc-5678  [003] .... 214327.025925: block_bio_backmerge: 8,32 R 67493840 + 8 [gc]
              gc-5678  [003] .... 214327.025932: block_bio_queue: 8,32 R 67493848 + 8 [gc]
              gc-5678  [003] .... 214327.025934: block_bio_backmerge: 8,32 R 67493848 + 8 [gc]
              gc-5678  [003] .... 214327.025941: block_bio_queue: 8,32 R 67493856 + 8 [gc]
              gc-5678  [003] .... 214327.025943: block_bio_backmerge: 8,32 R 67493856 + 8 [gc]
              gc-5678  [003] .... 214327.025953: block_bio_queue: 8,32 R 67493864 + 8 [gc]
              gc-5678  [003] .... 214327.025955: block_bio_backmerge: 8,32 R 67493864 + 8 [gc]
              gc-5678  [003] .... 214327.025962: block_bio_queue: 8,32 R 67493872 + 8 [gc]
              gc-5678  [003] .... 214327.025964: block_bio_backmerge: 8,32 R 67493872 + 8 [gc]
              gc-5678  [003] .... 214327.025970: block_bio_queue: 8,32 R 67493880 + 8 [gc]
              gc-5678  [003] .... 214327.025972: block_bio_backmerge: 8,32 R 67493880 + 8 [gc]
              gc-5678  [003] .... 214327.026000: block_bio_queue: 8,32 WS 34123776 + 2048 [gc]
              gc-5678  [003] .... 214327.026019: block_getrq: 8,32 WS 34123776 + 2048 [gc]
              gc-5678  [003] d..1 214327.026021: block_rq_insert: 8,32 R 131072 () 67493632 + 256 [gc]
              gc-5678  [003] d..1 214327.026023: block_unplug: [gc] 1
              gc-5678  [003] d..1 214327.026026: block_rq_issue: 8,32 R 131072 () 67493632 + 256 [gc]
              gc-5678  [003] .... 214327.026046: block_plug: [gc]

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    |  35 ++++++++++-----
 fs/f2fs/gc.c      | 111 +++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/segment.c |  10 ++++-
 3 files changed, 134 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 339b26838f9b..fbed8d59d10a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -877,6 +877,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_summary sum;
 	struct node_info ni;
+	block_t old_blkaddr;
 	pgoff_t fofs;
 	blkcnt_t count = 1;
 	int err;
@@ -898,9 +899,12 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 alloc:
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
-
-	f2fs_allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
+	old_blkaddr = dn->data_blkaddr;
+	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
 					&sum, seg_type, NULL, false);
+	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
+		invalidate_mapping_pages(META_MAPPING(sbi),
+					old_blkaddr, old_blkaddr);
 	f2fs_set_data_blkaddr(dn);
 
 	/* update i_size */
@@ -1616,6 +1620,7 @@ static int f2fs_read_data_pages(struct file *file,
 static int encrypt_one_page(struct f2fs_io_info *fio)
 {
 	struct inode *inode = fio->page->mapping->host;
+	struct page *mpage;
 	gfp_t gfp_flags = GFP_NOFS;
 
 	if (!f2fs_encrypted_file(inode))
@@ -1627,17 +1632,25 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 retry_encrypt:
 	fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
 			PAGE_SIZE, 0, fio->page->index, gfp_flags);
-	if (!IS_ERR(fio->encrypted_page))
-		return 0;
+	if (IS_ERR(fio->encrypted_page)) {
+		/* flush pending IOs and wait for a while in the ENOMEM case */
+		if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
+			f2fs_flush_merged_writes(fio->sbi);
+			congestion_wait(BLK_RW_ASYNC, HZ/50);
+			gfp_flags |= __GFP_NOFAIL;
+			goto retry_encrypt;
+		}
+		return PTR_ERR(fio->encrypted_page);
+	}
 
-	/* flush pending IOs and wait for a while in the ENOMEM case */
-	if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
-		f2fs_flush_merged_writes(fio->sbi);
-		congestion_wait(BLK_RW_ASYNC, HZ/50);
-		gfp_flags |= __GFP_NOFAIL;
-		goto retry_encrypt;
+	mpage = find_lock_page(META_MAPPING(fio->sbi), fio->old_blkaddr);
+	if (mpage) {
+		if (PageUptodate(mpage))
+			memcpy(page_address(mpage),
+				page_address(fio->encrypted_page), PAGE_SIZE);
+		f2fs_put_page(mpage, 1);
 	}
-	return PTR_ERR(fio->encrypted_page);
+	return 0;
 }
 
 static inline bool check_inplace_update_policy(struct inode *inode,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f85b97dd3e2d..d1ef4d3681d2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -605,6 +605,72 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return true;
 }
 
+static int ra_data_block(struct inode *inode, pgoff_t index)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	struct dnode_of_data dn;
+	struct page *page;
+	struct extent_info ei = {0, 0, 0};
+	struct f2fs_io_info fio = {
+		.sbi = sbi,
+		.ino = inode->i_ino,
+		.type = DATA,
+		.temp = COLD,
+		.op = REQ_OP_READ,
+		.op_flags = 0,
+		.encrypted_page = NULL,
+		.in_list = false,
+		.retry = false,
+	};
+	int err;
+
+	page = f2fs_grab_cache_page(mapping, index, true);
+	if (!page)
+		return -ENOMEM;
+
+	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
+		dn.data_blkaddr = ei.blk + index - ei.fofs;
+		goto got_it;
+	}
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+	if (err)
+		goto put_page;
+	f2fs_put_dnode(&dn);
+
+	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
+						DATA_GENERIC))) {
+		err = -EFAULT;
+		goto put_page;
+	}
+got_it:
+	/* read page */
+	fio.page = page;
+	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
+
+	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
+					dn.data_blkaddr,
+					FGP_LOCK | FGP_CREAT, GFP_NOFS);
+	if (!fio.encrypted_page) {
+		err = -ENOMEM;
+		goto put_page;
+	}
+
+	err = f2fs_submit_page_bio(&fio);
+	if (err)
+		goto put_encrypted_page;
+	f2fs_put_page(fio.encrypted_page, 0);
+	f2fs_put_page(page, 1);
+	return 0;
+put_encrypted_page:
+	f2fs_put_page(fio.encrypted_page, 1);
+put_page:
+	f2fs_put_page(page, 1);
+	return err;
+}
+
 /*
  * Move data block via META_MAPPING while keeping locked data page.
  * This can be used to move blocks, aka LBAs, directly on disk.
@@ -626,7 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
 	struct node_info ni;
-	struct page *page;
+	struct page *page, *mpage;
 	block_t newaddr;
 	int err;
 	bool lfs_mode = test_opt(fio.sbi, LFS);
@@ -689,6 +755,23 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		goto recover_block;
 	}
 
+	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
+					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
+	if (mpage) {
+		bool updated = false;
+
+		if (PageUptodate(mpage)) {
+			memcpy(page_address(fio.encrypted_page),
+					page_address(mpage), PAGE_SIZE);
+			updated = true;
+		}
+		f2fs_put_page(mpage, 1);
+		invalidate_mapping_pages(META_MAPPING(fio.sbi),
+					fio.old_blkaddr, fio.old_blkaddr);
+		if (updated)
+			goto write_page;
+	}
+
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
 		goto put_page_out;
@@ -705,6 +788,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		goto put_page_out;
 	}
 
+write_page:
 	set_page_dirty(fio.encrypted_page);
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
@@ -879,12 +963,6 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
 
-			/* if inode uses special I/O path, let's go phase 3 */
-			if (f2fs_post_read_required(inode)) {
-				add_gc_inode(gc_list, inode);
-				continue;
-			}
-
 			if (!down_write_trylock(
 				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
 				iput(inode);
@@ -892,10 +970,23 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
-			start_bidx = f2fs_start_bidx_of_node(nofs, inode);
+			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
+								ofs_in_node;
+
+			if (f2fs_post_read_required(inode)) {
+				int err = ra_data_block(inode, start_bidx);
+
+				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+				if (err) {
+					iput(inode);
+					continue;
+				}
+				add_gc_inode(gc_list, inode);
+				continue;
+			}
+
 			data_page = f2fs_get_read_data_page(inode,
-					start_bidx + ofs_in_node, REQ_RAHEAD,
-					true);
+						start_bidx, REQ_RAHEAD, true);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			if (IS_ERR(data_page)) {
 				iput(inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ba5137ac498..85ff5d7893c1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2152,6 +2152,8 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	if (addr == NEW_ADDR)
 		return;
 
+	invalidate_mapping_pages(META_MAPPING(sbi), addr, addr);
+
 	/* add it into sit main buffer */
 	down_write(&sit_i->sentry_lock);
 
@@ -3053,6 +3055,9 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 reallocate:
 	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio, true);
+	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
+		invalidate_mapping_pages(META_MAPPING(fio->sbi),
+					fio->old_blkaddr, fio->old_blkaddr);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_write(fio);
@@ -3207,8 +3212,11 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 	if (!recover_curseg || recover_newaddr)
 		update_sit_entry(sbi, new_blkaddr, 1);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
+	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO) {
+		invalidate_mapping_pages(META_MAPPING(sbi),
+					old_blkaddr, old_blkaddr);
 		update_sit_entry(sbi, old_blkaddr, -1);
+	}
 
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, new_blkaddr));
-- 
2.18.0

