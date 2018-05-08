Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeEHSGe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755424AbeEHSG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:26 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 67/76] fs/squashfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:27 -0700
Message-Id: <20180508180436.716-68-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/squashfs/dir.c         | 26 ++++++++++++++------------
 fs/squashfs/export.c      |  2 +-
 fs/squashfs/file.c        | 34 ++++++++++++++++++----------------
 fs/squashfs/file_cache.c  |  5 +++--
 fs/squashfs/file_direct.c |  9 +++++----
 fs/squashfs/inode.c       |  2 +-
 fs/squashfs/namei.c       | 28 ++++++++++++++++------------
 fs/squashfs/symlink.c     |  2 +-
 fs/squashfs/xattr.c       |  4 ++--
 9 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/fs/squashfs/dir.c b/fs/squashfs/dir.c
index a5845f94a2a1..c184017e4e70 100644
--- a/fs/squashfs/dir.c
+++ b/fs/squashfs/dir.c
@@ -110,7 +110,7 @@ static int get_dir_index_using_offset(struct super_block *sb,
 static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	u64 block = squashfs_i(inode)->start + msblk->directory_table;
 	int offset = squashfs_i(inode)->offset, length, err;
 	unsigned int inode_number, dir_count, size, type;
@@ -154,18 +154,18 @@ static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos += size;
 	}
 
-	length = get_dir_index_using_offset(inode->i_sb, &block, &offset,
-				squashfs_i(inode)->dir_idx_start,
-				squashfs_i(inode)->dir_idx_offset,
-				squashfs_i(inode)->dir_idx_cnt,
-				ctx->pos);
+	length = get_dir_index_using_offset(inode_sb(inode), &block, &offset,
+					    squashfs_i(inode)->dir_idx_start,
+					    squashfs_i(inode)->dir_idx_offset,
+					    squashfs_i(inode)->dir_idx_cnt,
+					    ctx->pos);
 
 	while (length < i_size_read(inode)) {
 		/*
 		 * Read directory header
 		 */
-		err = squashfs_read_metadata(inode->i_sb, &dirh, &block,
-					&offset, sizeof(dirh));
+		err = squashfs_read_metadata(inode_sb(inode), &dirh, &block,
+					     &offset, sizeof(dirh));
 		if (err < 0)
 			goto failed_read;
 
@@ -180,8 +180,9 @@ static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 			/*
 			 * Read directory entry.
 			 */
-			err = squashfs_read_metadata(inode->i_sb, dire, &block,
-					&offset, sizeof(*dire));
+			err = squashfs_read_metadata(inode_sb(inode), dire,
+						     &block,
+						     &offset, sizeof(*dire));
 			if (err < 0)
 				goto failed_read;
 
@@ -191,8 +192,9 @@ static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 			if (size > SQUASHFS_NAME_LEN)
 				goto failed_read;
 
-			err = squashfs_read_metadata(inode->i_sb, dire->name,
-					&block, &offset, size);
+			err = squashfs_read_metadata(inode_sb(inode),
+						     dire->name,
+						     &block, &offset, size);
 			if (err < 0)
 				goto failed_read;
 
diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
index 8073b6532cf0..ce7615f66d5c 100644
--- a/fs/squashfs/export.c
+++ b/fs/squashfs/export.c
@@ -113,7 +113,7 @@ static struct dentry *squashfs_get_parent(struct dentry *child)
 	struct inode *inode = d_inode(child);
 	unsigned int parent_ino = squashfs_i(inode)->parent;
 
-	return squashfs_export_iget(inode->i_sb, parent_ino);
+	return squashfs_export_iget(inode_sb(inode), parent_ino);
 }
 
 
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 13d80947bf9e..afad108e0d36 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -61,7 +61,7 @@ static struct meta_index *locate_meta_index(struct inode *inode, int offset,
 				int index)
 {
 	struct meta_index *meta = NULL;
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	int i;
 
 	mutex_lock(&msblk->meta_index_mutex);
@@ -99,7 +99,7 @@ static struct meta_index *locate_meta_index(struct inode *inode, int offset,
 static struct meta_index *empty_meta_index(struct inode *inode, int offset,
 				int skip)
 {
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	struct meta_index *meta = NULL;
 	int i;
 
@@ -159,7 +159,7 @@ static struct meta_index *empty_meta_index(struct inode *inode, int offset,
 
 static void release_meta_index(struct inode *inode, struct meta_index *meta)
 {
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	mutex_lock(&msblk->meta_index_mutex);
 	meta->locked = 0;
 	mutex_unlock(&msblk->meta_index_mutex);
@@ -236,7 +236,7 @@ static inline int calculate_skip(int blocks)
 static int fill_meta_index(struct inode *inode, int index,
 		u64 *index_block, int *index_offset, u64 *data_block)
 {
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	int skip = calculate_skip(i_size_read(inode) >> msblk->block_log);
 	int offset = 0;
 	struct meta_index *meta;
@@ -282,8 +282,9 @@ static int fill_meta_index(struct inode *inode, int index,
 		for (i = meta->offset + meta->entries; i <= index &&
 				i < meta->offset + SQUASHFS_META_ENTRIES; i++) {
 			int blocks = skip * SQUASHFS_META_INDEXES;
-			long long res = read_indexes(inode->i_sb, blocks,
-					&cur_index_block, &cur_offset);
+			long long res = read_indexes(inode_sb(inode), blocks,
+						     &cur_index_block,
+						     &cur_offset);
 
 			if (res < 0) {
 				if (meta->entries == 0)
@@ -354,7 +355,8 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
 	 * extra block indexes needed.
 	 */
 	if (res < index) {
-		blks = read_indexes(inode->i_sb, index - res, &start, &offset);
+		blks = read_indexes(inode_sb(inode), index - res, &start,
+				    &offset);
 		if (blks < 0)
 			return (int) blks;
 		*block += blks;
@@ -363,8 +365,8 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
 	/*
 	 * Read length of block specified by index.
 	 */
-	res = squashfs_read_metadata(inode->i_sb, &size, &start, &offset,
-			sizeof(size));
+	res = squashfs_read_metadata(inode_sb(inode), &size, &start, &offset,
+				     sizeof(size));
 	if (res < 0)
 		return res;
 	return le32_to_cpu(size);
@@ -375,7 +377,7 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 	int bytes, int offset)
 {
 	struct inode *inode = page->mapping->host;
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	void *pageaddr;
 	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	int start_index = page->index & ~mask, end_index = start_index | mask;
@@ -419,10 +421,10 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 static int squashfs_readpage_fragment(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
-		squashfs_i(inode)->fragment_block,
-		squashfs_i(inode)->fragment_size);
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
+	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode_sb(inode),
+								    squashfs_i(inode)->fragment_block,
+								    squashfs_i(inode)->fragment_size);
 	int res = buffer->error;
 
 	if (res)
@@ -441,7 +443,7 @@ static int squashfs_readpage_fragment(struct page *page)
 static int squashfs_readpage_sparse(struct page *page, int index, int file_end)
 {
 	struct inode *inode = page->mapping->host;
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	int bytes = index == file_end ?
 			(i_size_read(inode) & (msblk->block_size - 1)) :
 			 msblk->block_size;
@@ -453,7 +455,7 @@ static int squashfs_readpage_sparse(struct page *page, int index, int file_end)
 static int squashfs_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 	int index = page->index >> (msblk->block_log - PAGE_SHIFT);
 	int file_end = i_size_read(inode) >> msblk->block_log;
 	int res;
diff --git a/fs/squashfs/file_cache.c b/fs/squashfs/file_cache.c
index f2310d2a2019..7aedf57d500d 100644
--- a/fs/squashfs/file_cache.c
+++ b/fs/squashfs/file_cache.c
@@ -23,8 +23,9 @@
 int squashfs_readpage_block(struct page *page, u64 block, int bsize)
 {
 	struct inode *i = page->mapping->host;
-	struct squashfs_cache_entry *buffer = squashfs_get_datablock(i->i_sb,
-		block, bsize);
+	struct squashfs_cache_entry *buffer = squashfs_get_datablock(inode_sb(i),
+								     block,
+								     bsize);
 	int res = buffer->error;
 
 	if (res)
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index cb485d8e0e91..b336f6872816 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -28,7 +28,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize)
 
 {
 	struct inode *inode = target_page->mapping->host;
-	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(inode)->s_fs_info;
 
 	int file_end = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
@@ -91,7 +91,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize)
 	}
 
 	/* Decompress directly into the page cache buffers */
-	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
+	res = squashfs_read_data(inode_sb(inode), block, bsize, NULL, actor);
 	if (res < 0)
 		goto mark_errored;
 
@@ -141,8 +141,9 @@ static int squashfs_read_cache(struct page *target_page, u64 block, int bsize,
 	int pages, struct page **page)
 {
 	struct inode *i = target_page->mapping->host;
-	struct squashfs_cache_entry *buffer = squashfs_get_datablock(i->i_sb,
-						 block, bsize);
+	struct squashfs_cache_entry *buffer = squashfs_get_datablock(inode_sb(i),
+								     block,
+								     bsize);
 	int bytes = buffer->length, res = buffer->error, n, offset = 0;
 	void *pageaddr;
 
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index e9793b1e49a5..686083434be3 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -112,7 +112,7 @@ struct inode *squashfs_iget(struct super_block *sb, long long ino,
  */
 int squashfs_read_inode(struct inode *inode, long long ino)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	u64 block = SQUASHFS_INODE_BLK(ino) + msblk->inode_table;
 	int err, type, offset = SQUASHFS_INODE_OFFSET(ino);
diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 40c10d9974c9..82bd0f01630b 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -142,7 +142,7 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 	const unsigned char *name = dentry->d_name.name;
 	int len = dentry->d_name.len;
 	struct inode *inode = NULL;
-	struct squashfs_sb_info *msblk = dir->i_sb->s_fs_info;
+	struct squashfs_sb_info *msblk = inode_sb(dir)->s_fs_info;
 	struct squashfs_dir_header dirh;
 	struct squashfs_dir_entry *dire;
 	u64 block = squashfs_i(dir)->start + msblk->directory_table;
@@ -163,17 +163,18 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 		goto failed;
 	}
 
-	length = get_dir_index_using_name(dir->i_sb, &block, &offset,
-				squashfs_i(dir)->dir_idx_start,
-				squashfs_i(dir)->dir_idx_offset,
-				squashfs_i(dir)->dir_idx_cnt, name, len);
+	length = get_dir_index_using_name(inode_sb(dir), &block, &offset,
+					  squashfs_i(dir)->dir_idx_start,
+					  squashfs_i(dir)->dir_idx_offset,
+					  squashfs_i(dir)->dir_idx_cnt, name,
+					  len);
 
 	while (length < i_size_read(dir)) {
 		/*
 		 * Read directory header.
 		 */
-		err = squashfs_read_metadata(dir->i_sb, &dirh, &block,
-				&offset, sizeof(dirh));
+		err = squashfs_read_metadata(inode_sb(dir), &dirh, &block,
+					     &offset, sizeof(dirh));
 		if (err < 0)
 			goto read_failure;
 
@@ -188,8 +189,9 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 			/*
 			 * Read directory entry.
 			 */
-			err = squashfs_read_metadata(dir->i_sb, dire, &block,
-					&offset, sizeof(*dire));
+			err = squashfs_read_metadata(inode_sb(dir), dire,
+						     &block,
+						     &offset, sizeof(*dire));
 			if (err < 0)
 				goto read_failure;
 
@@ -199,8 +201,9 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 			if (size > SQUASHFS_NAME_LEN)
 				goto data_error;
 
-			err = squashfs_read_metadata(dir->i_sb, dire->name,
-					&block, &offset, size);
+			err = squashfs_read_metadata(inode_sb(dir),
+						     dire->name,
+						     &block, &offset, size);
 			if (err < 0)
 				goto read_failure;
 
@@ -222,7 +225,8 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 					"entry %s, inode  %x:%x, %d\n", name,
 					blk, off, ino_num);
 
-				inode = squashfs_iget(dir->i_sb, ino, ino_num);
+				inode = squashfs_iget(inode_sb(dir), ino,
+						      ino_num);
 				goto exit_lookup;
 			}
 		}
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index befeba0fa70a..76a5af382016 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -46,7 +46,7 @@
 static int squashfs_symlink_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	int index = page->index << PAGE_SHIFT;
 	u64 block = squashfs_i(inode)->start;
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index 1548b3784548..b6eec3779af4 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -40,7 +40,7 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 	size_t buffer_size)
 {
 	struct inode *inode = d_inode(d);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	u64 start = SQUASHFS_XATTR_BLK(squashfs_i(inode)->xattr)
 						 + msblk->xattr_table;
@@ -118,7 +118,7 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 static int squashfs_xattr_get(struct inode *inode, int name_index,
 	const char *name, void *buffer, size_t buffer_size)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	u64 start = SQUASHFS_XATTR_BLK(squashfs_i(inode)->xattr)
 						 + msblk->xattr_table;
-- 
2.15.1
