Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A95C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F18A2150B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18A2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI0QvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:51:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbeI0QvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:51:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 288FA9611CA2C;
        Thu, 27 Sep 2018 18:33:31 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 18:33:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: refactor ->page_mkwrite() flow
Date:   Thu, 27 Sep 2018 18:33:18 +0800
Message-ID: <20180927103318.36631-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A				Thread B
- f2fs_vm_page_mkwrite
					- f2fs_setattr
					 - down_write(i_mmap_sem)
					 - truncate_setsize
					 - f2fs_truncate
					 - up_write(i_mmap_sem)
 - f2fs_reserve_block
 reserve NEW_ADDR
 - skip dirty page due to truncation

1. we don't need to rserve new block address for a truncated page.
2. dn.data_blkaddr is used out of node page lock coverage.

Refactor ->page_mkwrite() flow to fix above issues:
- use __do_map_lock() to avoid racing checkpoint()
- lock data page in prior to dnode page
- cover f2fs_reserve_block with i_mmap_sem lock
- wait page writeback before zeroing page

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- handle error path correctly
- wait page writeback before zeroing page
 fs/f2fs/data.c |  2 +-
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 45 ++++++++++++++++++++++-----------------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41102c227eee..b287422c8eeb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -972,7 +972,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	return err;
 }
 
-static inline void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
+void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
 {
 	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
 		if (lock)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b32fd9f7da95..8f4a46603c61 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3050,6 +3050,7 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
+void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			int create, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 357422a4c319..6db808c80813 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -47,7 +47,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct dnode_of_data dn;
+	struct dnode_of_data dn = { .node_changed = false };
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -59,19 +59,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	/* block allocation */
-	f2fs_lock_op(sbi);
-	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = f2fs_reserve_block(&dn, page->index);
-	if (err) {
-		f2fs_unlock_op(sbi);
-		goto out;
-	}
-	f2fs_put_dnode(&dn);
-	f2fs_unlock_op(sbi);
-
-	f2fs_balance_fs(sbi, dn.node_changed);
-
 	file_update_time(vmf->vma->vm_file);
 	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
@@ -83,11 +70,28 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 	}
 
+	/* block allocation */
+	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = f2fs_get_block(&dn, page->index);
+	f2fs_put_dnode(&dn);
+	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+	if (err) {
+		unlock_page(page);
+		goto out_sem;
+	}
+
+	/* fill the page */
+	f2fs_wait_on_page_writeback(page, DATA, false);
+
+	/* wait for GCed page writeback via META_MAPPING */
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	/*
 	 * check to see if the page is mapped already (no holes)
 	 */
 	if (PageMappedToDisk(page))
-		goto mapped;
+		goto out_sem;
 
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
@@ -104,16 +108,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
 
 	trace_f2fs_vm_page_mkwrite(page, DATA);
-mapped:
-	/* fill the page */
-	f2fs_wait_on_page_writeback(page, DATA, false);
-
-	/* wait for GCed page writeback via META_MAPPING */
-	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
-
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
-out:
+
+	f2fs_balance_fs(sbi, dn.node_changed);
+
 	sb_end_pagefault(inode->i_sb);
 	f2fs_update_time(sbi, REQ_TIME);
 err:
-- 
2.18.0.rc1

