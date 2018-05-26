Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031717AbeEZKEF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 06:04:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45713 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031487AbeEZKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 06:04:03 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: clean up with clear_radix_tree_dirty_tag
Date: Sat, 26 May 2018 18:03:35 +0800
Message-ID: <20180526100335.63001-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
In-Reply-To: <20180526100335.63001-1-yuchao0@huawei.com>
References: <20180526100335.63001-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce clear_radix_tree_dirty_tag to include common codes for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c   | 11 +++++++++++
 fs/f2fs/dir.c    |  8 +-------
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/inline.c |  7 +------
 fs/f2fs/node.c   | 12 ++----------
 5 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 98a12526e3d0..9d3e2e1c1e33 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2594,6 +2594,17 @@ const struct address_space_operations f2fs_dblock_aops = {
 #endif
 };
 
+void clear_radix_tree_dirty_tag(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+	unsigned long flags;
+
+	xa_lock_irqsave(&mapping->i_pages, flags);
+	radix_tree_tag_clear(&mapping->i_pages, page_index(page),
+						PAGECACHE_TAG_DIRTY);
+	xa_unlock_irqrestore(&mapping->i_pages, flags);
+}
+
 int __init f2fs_init_post_read_processing(void)
 {
 	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, 0);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8c9c2f31b253..e20539ba0554 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -698,8 +698,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	struct	f2fs_dentry_block *dentry_blk;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
-	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 	int i;
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
@@ -732,11 +730,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 			!truncate_hole(dir, page->index, page->index + 1)) {
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		radix_tree_tag_clear(&mapping->i_pages, page_index(page),
-				     PAGECACHE_TAG_DIRTY);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
-
+		clear_radix_tree_dirty_tag(page);
 		clear_page_dirty_for_io(page);
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 659c63dae81c..da43959b725a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2966,6 +2966,7 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
 bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
+void clear_radix_tree_dirty_tag(struct page *page);
 
 /*
  * gc.c
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 1eaa2049eafa..83e6881fd21e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -204,8 +204,6 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
 	struct dnode_of_data dn;
-	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 	int err;
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -227,10 +225,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	kunmap_atomic(src_addr);
 	set_page_dirty(dn.inode_page);
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
-	radix_tree_tag_clear(&mapping->i_pages, page_index(page),
-			     PAGECACHE_TAG_DIRTY);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	clear_radix_tree_dirty_tag(page);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 67b3e89975af..59041acbf7ac 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -102,18 +102,10 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 
 static void clear_node_page_dirty(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-	unsigned int long flags;
-
 	if (PageDirty(page)) {
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		radix_tree_tag_clear(&mapping->i_pages,
-				page_index(page),
-				PAGECACHE_TAG_DIRTY);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
-
+		clear_radix_tree_dirty_tag(page);
 		clear_page_dirty_for_io(page);
-		dec_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_NODES);
+		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 	}
 	ClearPageUptodate(page);
 }
-- 
2.17.0.391.g1f1cddd558b5
