Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755920AbeEHS0h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:26:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755737AbeEHSF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:58 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 48/76] fs/minix: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:08 -0700
Message-Id: <20180508180436.716-49-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/minix/bitmap.c       | 18 ++++++++++--------
 fs/minix/dir.c          | 18 +++++++++---------
 fs/minix/inode.c        | 10 +++++-----
 fs/minix/itree_common.c | 10 +++++-----
 fs/minix/itree_v1.c     |  6 +++---
 fs/minix/itree_v2.c     |  2 +-
 fs/minix/minix.h        |  2 +-
 fs/minix/namei.c        |  6 +++---
 8 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index f4e5e5181a14..c432f181e006 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -41,7 +41,7 @@ static __u32 count_free(struct buffer_head *map[], unsigned blocksize, __u32 num
 
 void minix_free_block(struct inode *inode, unsigned long block)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct buffer_head *bh;
 	int k = sb->s_blocksize_bits + 3;
@@ -70,8 +70,8 @@ void minix_free_block(struct inode *inode, unsigned long block)
 
 int minix_new_block(struct inode * inode)
 {
-	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
-	int bits_per_zone = 8 * inode->i_sb->s_blocksize;
+	struct minix_sb_info *sbi = minix_sb(inode_sb(inode));
+	int bits_per_zone = 8 * inode_sb(inode)->s_blocksize;
 	int i;
 
 	for (i = 0; i < sbi->s_zmap_blocks; i++) {
@@ -161,14 +161,16 @@ static void minix_clear_inode(struct inode *inode)
 
 	if (INODE_VERSION(inode) == MINIX_V1) {
 		struct minix_inode *raw_inode;
-		raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
+		raw_inode = minix_V1_raw_inode(inode_sb(inode), inode->i_ino,
+					       &bh);
 		if (raw_inode) {
 			raw_inode->i_nlinks = 0;
 			raw_inode->i_mode = 0;
 		}
 	} else {
 		struct minix2_inode *raw_inode;
-		raw_inode = minix_V2_raw_inode(inode->i_sb, inode->i_ino, &bh);
+		raw_inode = minix_V2_raw_inode(inode_sb(inode), inode->i_ino,
+					       &bh);
 		if (raw_inode) {
 			raw_inode->i_nlinks = 0;
 			raw_inode->i_mode = 0;
@@ -182,8 +184,8 @@ static void minix_clear_inode(struct inode *inode)
 
 void minix_free_inode(struct inode * inode)
 {
-	struct super_block *sb = inode->i_sb;
-	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	struct super_block *sb = inode_sb(inode);
+	struct minix_sb_info *sbi = minix_sb(inode_sb(inode));
 	struct buffer_head *bh;
 	int k = sb->s_blocksize_bits + 3;
 	unsigned long ino, bit;
@@ -212,7 +214,7 @@ void minix_free_inode(struct inode * inode)
 
 struct inode *minix_new_inode(const struct inode *dir, umode_t mode, int *error)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct minix_sb_info *sbi = minix_sb(sb);
 	struct inode *inode = new_inode(sb);
 	struct buffer_head * bh;
diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index dcfe5b25378b..ea70fc396293 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -81,7 +81,7 @@ static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
 static int minix_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct minix_sb_info *sbi = minix_sb(sb);
 	unsigned chunk_size = sbi->s_dirsize;
 	unsigned long npages = dir_pages(inode);
@@ -153,7 +153,7 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	struct inode * dir = d_inode(dentry->d_parent);
-	struct super_block * sb = dir->i_sb;
+	struct super_block * sb = inode_sb(dir);
 	struct minix_sb_info * sbi = minix_sb(sb);
 	unsigned long n;
 	unsigned long npages = dir_pages(dir);
@@ -202,7 +202,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 	struct inode *dir = d_inode(dentry->d_parent);
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
-	struct super_block * sb = dir->i_sb;
+	struct super_block * sb = inode_sb(dir);
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct page *page = NULL;
 	unsigned long npages = dir_pages(dir);
@@ -291,7 +291,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 	struct inode *inode = page->mapping->host;
 	char *kaddr = page_address(page);
 	loff_t pos = page_offset(page) + (char*)de - kaddr;
-	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	struct minix_sb_info *sbi = minix_sb(inode_sb(inode));
 	unsigned len = sbi->s_dirsize;
 	int err;
 
@@ -315,7 +315,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
 int minix_make_empty(struct inode *inode, struct inode *dir)
 {
 	struct page *page = grab_cache_page(inode->i_mapping, 0);
-	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	struct minix_sb_info *sbi = minix_sb(inode_sb(inode));
 	char *kaddr;
 	int err;
 
@@ -362,7 +362,7 @@ int minix_empty_dir(struct inode * inode)
 {
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
-	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+	struct minix_sb_info *sbi = minix_sb(inode_sb(inode));
 	char *name;
 	__u32 inumber;
 
@@ -413,7 +413,7 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
 	struct inode *inode)
 {
 	struct inode *dir = page->mapping->host;
-	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
+	struct minix_sb_info *sbi = minix_sb(inode_sb(dir));
 	loff_t pos = page_offset(page) +
 			(char *)de-(char*)page_address(page);
 	int err;
@@ -438,7 +438,7 @@ void minix_set_link(struct minix_dir_entry *de, struct page *page,
 struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
 {
 	struct page *page = dir_get_page(dir, 0);
-	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
+	struct minix_sb_info *sbi = minix_sb(inode_sb(dir));
 	struct minix_dir_entry *de = NULL;
 
 	if (!IS_ERR(page)) {
@@ -457,7 +457,7 @@ ino_t minix_inode_by_name(struct dentry *dentry)
 	if (de) {
 		struct address_space *mapping = page->mapping;
 		struct inode *inode = mapping->host;
-		struct minix_sb_info *sbi = minix_sb(inode->i_sb);
+		struct minix_sb_info *sbi = minix_sb(inode_sb(inode));
 
 		if (sbi->s_version == MINIX_V3)
 			res = ((minix3_dirent *) de)->inode;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 72e308c3e66b..c8fd742baa16 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -466,7 +466,7 @@ static struct inode *V1_minix_iget(struct inode *inode)
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
-	raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	raw_inode = minix_V1_raw_inode(inode_sb(inode), inode->i_ino, &bh);
 	if (!raw_inode) {
 		iget_failed(inode);
 		return ERR_PTR(-EIO);
@@ -499,7 +499,7 @@ static struct inode *V2_minix_iget(struct inode *inode)
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
-	raw_inode = minix_V2_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	raw_inode = minix_V2_raw_inode(inode_sb(inode), inode->i_ino, &bh);
 	if (!raw_inode) {
 		iget_failed(inode);
 		return ERR_PTR(-EIO);
@@ -553,7 +553,7 @@ static struct buffer_head * V1_minix_update_inode(struct inode * inode)
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
-	raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	raw_inode = minix_V1_raw_inode(inode_sb(inode), inode->i_ino, &bh);
 	if (!raw_inode)
 		return NULL;
 	raw_inode->i_mode = inode->i_mode;
@@ -580,7 +580,7 @@ static struct buffer_head * V2_minix_update_inode(struct inode * inode)
 	struct minix_inode_info *minix_inode = minix_i(inode);
 	int i;
 
-	raw_inode = minix_V2_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	raw_inode = minix_V2_raw_inode(inode_sb(inode), inode->i_ino, &bh);
 	if (!raw_inode)
 		return NULL;
 	raw_inode->i_mode = inode->i_mode;
@@ -614,7 +614,7 @@ static int minix_write_inode(struct inode *inode, struct writeback_control *wbc)
 		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh)) {
 			printk("IO error syncing minix inode [%s:%08lx]\n",
-				inode->i_sb->s_id, inode->i_ino);
+				inode_sb(inode)->s_id, inode->i_ino);
 			err = -EIO;
 		}
 	}
diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index 043c3fdbc8e7..97441f82e84d 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -33,7 +33,7 @@ static inline Indirect *get_branch(struct inode *inode,
 					Indirect chain[DEPTH],
 					int *err)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	Indirect *p = chain;
 	struct buffer_head *bh;
 
@@ -84,7 +84,7 @@ static int alloc_branch(struct inode *inode,
 		if (!nr)
 			break;
 		branch[n].key = cpu_to_block(nr);
-		bh = sb_getblk(inode->i_sb, parent);
+		bh = sb_getblk(inode_sb(inode), parent);
 		lock_buffer(bh);
 		memset(bh->b_data, 0, bh->b_size);
 		branch[n].bh = bh;
@@ -162,7 +162,7 @@ static int get_block(struct inode * inode, sector_t block,
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
 got_it:
-		map_bh(bh, inode->i_sb, block_to_cpu(chain[depth-1].key));
+		map_bh(bh, inode_sb(inode), block_to_cpu(chain[depth-1].key));
 		/* Clean up and exit */
 		partial = chain+depth-1; /* the whole chain */
 		goto cleanup;
@@ -278,7 +278,7 @@ static void free_branches(struct inode *inode, block_t *p, block_t *q, int depth
 			if (!nr)
 				continue;
 			*p = 0;
-			bh = sb_bread(inode->i_sb, nr);
+			bh = sb_bread(inode_sb(inode), nr);
 			if (!bh)
 				continue;
 			free_branches(inode, (block_t*)bh->b_data,
@@ -293,7 +293,7 @@ static void free_branches(struct inode *inode, block_t *p, block_t *q, int depth
 
 static inline void truncate (struct inode * inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	block_t *idata = i_data(inode);
 	int offsets[DEPTH];
 	Indirect chain[DEPTH];
diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 046cc96ee7ad..dd1a33de552e 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -28,12 +28,12 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
-			block, inode->i_sb->s_bdev);
-	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
+			block, inode_sb(inode)->s_bdev);
+	} else if (block >= (minix_sb(inode_sb(inode))->s_max_size/BLOCK_SIZE)) {
 		if (printk_ratelimit())
 			printk("MINIX-fs: block_to_path: "
 			       "block %ld too big on dev %pg\n",
-				block, inode->i_sb->s_bdev);
+				block, inode_sb(inode)->s_bdev);
 	} else if (block < 7) {
 		offsets[n++] = block;
 	} else if ((block -= 7) < 512) {
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index f7fc7ecccccc..7e457d58c06f 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -27,7 +27,7 @@ static inline block_t *i_data(struct inode *inode)
 static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 {
 	int n = 0;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index df081e8afcc3..3ba7f4a41473 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -6,7 +6,7 @@
 #include <linux/pagemap.h>
 #include <linux/minix_fs.h>
 
-#define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
+#define INODE_VERSION(inode)	minix_sb(inode_sb(inode))->s_version
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
 #define MINIX_V3		0x0003		/* minix V3 fs */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index ccf0f00030bf..6df2738bcdc3 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -24,12 +24,12 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
 	struct inode * inode = NULL;
 	ino_t ino;
 
-	if (dentry->d_name.len > minix_sb(dir->i_sb)->s_namelen)
+	if (dentry->d_name.len > minix_sb(inode_sb(dir))->s_namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = minix_inode_by_name(dentry);
 	if (ino) {
-		inode = minix_iget(dir->i_sb, ino);
+		inode = minix_iget(inode_sb(dir), ino);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
 	}
@@ -80,7 +80,7 @@ static int minix_symlink(struct inode * dir, struct dentry *dentry,
 	int i = strlen(symname)+1;
 	struct inode * inode;
 
-	if (i > dir->i_sb->s_blocksize)
+	if (i > inode_sb(dir)->s_blocksize)
 		goto out;
 
 	inode = minix_new_inode(dir, S_IFLNK | 0777, &err);
-- 
2.15.1
