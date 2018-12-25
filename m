Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2561BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99E121848
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbeLYJoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 04:44:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbeLYJoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 04:44:12 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E897E4D5258B7;
        Tue, 25 Dec 2018 17:44:07 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Dec 2018 17:43:58 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 2/3] f2fs: check PageWriteback flag for ordered case
Date:   Tue, 25 Dec 2018 17:43:42 +0800
Message-ID: <20181225094342.59919-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all ordered cases in f2fs_wait_on_page_writeback(), we need to
check PageWriteback status, so let's clean up to relocate the check
into f2fs_wait_on_page_writeback().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- add parameter to skip check for unlocked page.
 fs/f2fs/checkpoint.c |  8 +++-----
 fs/f2fs/data.c       |  9 ++++-----
 fs/f2fs/dir.c        |  8 ++++----
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       |  6 +++---
 fs/f2fs/gc.c         | 10 +++++-----
 fs/f2fs/inline.c     | 16 ++++++++--------
 fs/f2fs/inode.c      |  4 ++--
 fs/f2fs/node.c       | 19 ++++++++-----------
 fs/f2fs/node.h       |  2 +-
 fs/f2fs/recovery.c   |  2 +-
 fs/f2fs/segment.c    | 14 ++++++++------
 fs/f2fs/xattr.c      |  4 ++--
 13 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4f02461f348c..7b1854772d97 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -44,7 +44,7 @@ struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 		cond_resched();
 		goto repeat;
 	}
-	f2fs_wait_on_page_writeback(page, META, true);
+	f2fs_wait_on_page_writeback(page, META, true, true);
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 	return page;
@@ -370,9 +370,8 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				goto continue_unlock;
 			}
 
-			f2fs_wait_on_page_writeback(page, META, true);
+			f2fs_wait_on_page_writeback(page, META, true, true);
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
@@ -1290,8 +1289,7 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
 	int err;
 
-	f2fs_wait_on_page_writeback(page, META, true);
-	f2fs_bug_on(sbi, PageWriteback(page));
+	f2fs_wait_on_page_writeback(page, META, true, true);
 
 	memcpy(page_address(page), src, PAGE_SIZE);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fd3a1e5ab6d9..b7855e1efdf7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -626,7 +626,7 @@ static void __set_data_blkaddr(struct dnode_of_data *dn)
  */
 void f2fs_set_data_blkaddr(struct dnode_of_data *dn)
 {
-	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
+	f2fs_wait_on_page_writeback(dn->node_page, NODE, true, true);
 	__set_data_blkaddr(dn);
 	if (set_page_dirty(dn->node_page))
 		dn->node_changed = true;
@@ -656,7 +656,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
 						dn->ofs_in_node, count);
 
-	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
+	f2fs_wait_on_page_writeback(dn->node_page, NODE, true, true);
 
 	for (; count > 0; dn->ofs_in_node++) {
 		block_t blkaddr = datablock_addr(dn->inode,
@@ -2149,12 +2149,11 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (PageWriteback(page)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
 					f2fs_wait_on_page_writeback(page,
-								DATA, true);
+							DATA, true, true);
 				else
 					goto continue_unlock;
 			}
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
@@ -2472,7 +2471,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		}
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, false);
+	f2fs_wait_on_page_writeback(page, DATA, false, true);
 
 	if (len == PAGE_SIZE || PageUptodate(page))
 		return 0;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c0c845da12fa..50d0d36280fa 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -293,7 +293,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 {
 	enum page_type type = f2fs_has_inline_dentry(dir) ? NODE : DATA;
 	lock_page(page);
-	f2fs_wait_on_page_writeback(page, type, true);
+	f2fs_wait_on_page_writeback(page, type, true, true);
 	de->ino = cpu_to_le32(inode->i_ino);
 	set_de_type(de, inode->i_mode);
 	set_page_dirty(page);
@@ -307,7 +307,7 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
 {
 	struct f2fs_inode *ri;
 
-	f2fs_wait_on_page_writeback(ipage, NODE, true);
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
 	/* copy name info. to this inode page */
 	ri = F2FS_INODE(ipage);
@@ -550,7 +550,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 	++level;
 	goto start;
 add_dentry:
-	f2fs_wait_on_page_writeback(dentry_page, DATA, true);
+	f2fs_wait_on_page_writeback(dentry_page, DATA, true, true);
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
@@ -705,7 +705,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
 
 	lock_page(page);
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 	dentry_blk = page_address(page);
 	bit_pos = dentry - dentry_blk->dentry;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7cec897146a3..85e39719db37 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3032,7 +3032,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			struct f2fs_summary *sum, int type,
 			struct f2fs_io_info *fio, bool add_list);
 void f2fs_wait_on_page_writeback(struct page *page,
-			enum page_type type, bool ordered);
+			enum page_type type, bool ordered, bool locked);
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca9bdbb8651b..8acec037869a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -82,7 +82,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	/* fill the page */
-	f2fs_wait_on_page_writeback(page, DATA, false);
+	f2fs_wait_on_page_writeback(page, DATA, false, true);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
@@ -578,7 +578,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	if (IS_ERR(page))
 		return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
 truncate_out:
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 	zero_user(page, offset, PAGE_SIZE - offset);
 
 	/* An encrypted inode should have a key and truncate the last page. */
@@ -895,7 +895,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 	zero_user(page, start, len);
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 666518eb7293..8f62f4a771a0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -679,7 +679,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
@@ -768,7 +768,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
@@ -829,7 +829,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	}
 
 write_page:
-	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
+	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
 	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
@@ -838,7 +838,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	ClearPageError(page);
 
 	/* allocate block address */
-	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
+	f2fs_wait_on_page_writeback(dn.node_page, NODE, true, true);
 
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
@@ -924,7 +924,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		bool is_dirty = PageDirty(page);
 
 retry:
-		f2fs_wait_on_page_writeback(page, DATA, true);
+		f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 		set_page_dirty(page);
 		if (clear_page_dirty_for_io(page)) {
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7b0cff7e6051..853c8d0f90fa 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -72,7 +72,7 @@ void f2fs_truncate_inline_inode(struct inode *inode,
 
 	addr = inline_data_addr(inode, ipage);
 
-	f2fs_wait_on_page_writeback(ipage, NODE, true);
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 	memset(addr + from, 0, MAX_INLINE_DATA(inode) - from);
 	set_page_dirty(ipage);
 
@@ -161,7 +161,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	fio.old_blkaddr = dn->data_blkaddr;
 	set_inode_flag(dn->inode, FI_HOT_DATA);
 	f2fs_outplace_write_data(dn, &fio);
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 	if (dirty) {
 		inode_dec_dirty_pages(dn->inode);
 		f2fs_remove_dirty_inode(dn->inode);
@@ -236,7 +236,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 
 	f2fs_bug_on(F2FS_I_SB(inode), page->index);
 
-	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true);
+	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true, true);
 	src_addr = kmap_atomic(page);
 	dst_addr = inline_data_addr(inode, dn.inode_page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
@@ -277,7 +277,7 @@ bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 		ipage = f2fs_get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
 
-		f2fs_wait_on_page_writeback(ipage, NODE, true);
+		f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
 		src_addr = inline_data_addr(inode, npage);
 		dst_addr = inline_data_addr(inode, ipage);
@@ -391,7 +391,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 		goto out;
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, true);
+	f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 	dentry_blk = page_address(page);
 
@@ -505,7 +505,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	return 0;
 recover:
 	lock_page(ipage);
-	f2fs_wait_on_page_writeback(ipage, NODE, true);
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA(dir));
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA(dir));
@@ -565,7 +565,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 		}
 	}
 
-	f2fs_wait_on_page_writeback(ipage, NODE, true);
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
 	name_hash = f2fs_dentry_hash(new_name, NULL);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
@@ -597,7 +597,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int i;
 
 	lock_page(page);
-	f2fs_wait_on_page_writeback(page, NODE, true);
+	f2fs_wait_on_page_writeback(page, NODE, true, true);
 
 	inline_dentry = inline_data_addr(dir, page);
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f63d4fe6156d..bec52961630b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -103,7 +103,7 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 
 	while (start < end) {
 		if (*start++) {
-			f2fs_wait_on_page_writeback(ipage, NODE, true);
+			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
 			set_inode_flag(inode, FI_DATA_EXIST);
 			set_raw_inline(inode, F2FS_INODE(ipage));
@@ -497,7 +497,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	struct f2fs_inode *ri;
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 
-	f2fs_wait_on_page_writeback(node_page, NODE, true);
+	f2fs_wait_on_page_writeback(node_page, NODE, true, true);
 	set_page_dirty(node_page);
 
 	f2fs_inode_synced(inode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c09df777f66f..f4e2586b6380 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1106,7 +1106,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
 			lock_page(page);
 			BUG_ON(page->mapping != NODE_MAPPING(sbi));
-			f2fs_wait_on_page_writeback(page, NODE, true);
+			f2fs_wait_on_page_writeback(page, NODE, true, true);
 			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
 			set_page_dirty(page);
 			unlock_page(page);
@@ -1234,7 +1234,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	new_ni.version = 0;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
-	f2fs_wait_on_page_writeback(page, NODE, true);
+	f2fs_wait_on_page_writeback(page, NODE, true, true);
 	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
 	if (!PageUptodate(page))
@@ -1598,8 +1598,7 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 			.for_reclaim = 0,
 		};
 
-		f2fs_wait_on_page_writeback(node_page, NODE, true);
-		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
+		f2fs_wait_on_page_writeback(node_page, NODE, true, true);
 
 		set_page_dirty(node_page);
 
@@ -1690,8 +1689,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				goto continue_unlock;
 			}
 
-			f2fs_wait_on_page_writeback(page, NODE, true);
-			BUG_ON(PageWriteback(page));
+			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
 			set_fsync_mark(page, 0);
 			set_dentry_mark(page, 0);
@@ -1742,7 +1740,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			"Retry to write fsync mark: ino=%u, idx=%lx",
 					ino, last_page->index);
 		lock_page(last_page);
-		f2fs_wait_on_page_writeback(last_page, NODE, true);
+		f2fs_wait_on_page_writeback(last_page, NODE, true, true);
 		set_page_dirty(last_page);
 		unlock_page(last_page);
 		goto retry;
@@ -1823,9 +1821,8 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				goto lock_node;
 			}
 
-			f2fs_wait_on_page_writeback(page, NODE, true);
+			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
@@ -1892,7 +1889,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 		get_page(page);
 		spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
 
-		f2fs_wait_on_page_writeback(page, NODE, true);
+		f2fs_wait_on_page_writeback(page, NODE, true, false);
 		if (TestClearPageError(page))
 			ret = -EIO;
 
@@ -2470,7 +2467,7 @@ void f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 	src_addr = inline_xattr_addr(inode, page);
 	inline_size = inline_xattr_size(inode);
 
-	f2fs_wait_on_page_writeback(ipage, NODE, true);
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
 	f2fs_update_inode(inode, ipage);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 1c73d879a9bc..e05af5df5648 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -361,7 +361,7 @@ static inline int set_nid(struct page *p, int off, nid_t nid, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(p);
 
-	f2fs_wait_on_page_writeback(p, NODE, true);
+	f2fs_wait_on_page_writeback(p, NODE, true, true);
 
 	if (i)
 		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c22f9d0011ba..e3883db868d8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -539,7 +539,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto out;
 	}
 
-	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
+	f2fs_wait_on_page_writeback(dn.node_page, NODE, true, true);
 
 	err = f2fs_get_node_info(sbi, dn.nid, &ni);
 	if (err)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e2e971e89b2d..48f4cd027b38 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -229,7 +229,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 
 		lock_page(page);
 
-		f2fs_wait_on_page_writeback(page, DATA, true);
+		f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 		if (recover) {
 			struct dnode_of_data dn;
@@ -387,7 +387,7 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
 		if (page->mapping == inode->i_mapping) {
 			trace_f2fs_commit_inmem_page(page, INMEM);
 
-			f2fs_wait_on_page_writeback(page, DATA, true);
+			f2fs_wait_on_page_writeback(page, DATA, true, true);
 
 			set_page_dirty(page);
 			if (clear_page_dirty_for_io(page)) {
@@ -3275,16 +3275,18 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 }
 
 void f2fs_wait_on_page_writeback(struct page *page,
-				enum page_type type, bool ordered)
+				enum page_type type, bool ordered, bool locked)
 {
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
-		if (ordered)
+		if (ordered) {
 			wait_on_page_writeback(page);
-		else
+			f2fs_bug_on(sbi, locked && PageWriteback(page));
+		} else {
 			wait_for_stable_page(page);
+		}
 	}
 }
 
@@ -3301,7 +3303,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
 	if (cpage) {
-		f2fs_wait_on_page_writeback(cpage, DATA, true);
+		f2fs_wait_on_page_writeback(cpage, DATA, true, true);
 		f2fs_put_page(cpage, 1);
 	}
 }
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 7261245c208d..f44b0c38398b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -415,7 +415,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 		}
 
 		f2fs_wait_on_page_writeback(ipage ? ipage : in_page,
-							NODE, true);
+							NODE, true, true);
 		/* no need to use xattr node block */
 		if (hsize <= inline_size) {
 			err = f2fs_truncate_xattr_node(inode);
@@ -439,7 +439,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 			goto in_page_out;
 		}
 		f2fs_bug_on(sbi, new_nid);
-		f2fs_wait_on_page_writeback(xpage, NODE, true);
+		f2fs_wait_on_page_writeback(xpage, NODE, true, true);
 	} else {
 		struct dnode_of_data dn;
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
-- 
2.18.0.rc1

