Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbeEHSIe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932988AbeEHSGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:32 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 71/76] fs/ufs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:31 -0700
Message-Id: <20180508180436.716-72-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ufs/balloc.c | 23 ++++++++++++-----------
 fs/ufs/dir.c    | 34 +++++++++++++++++-----------------
 fs/ufs/ialloc.c |  4 ++--
 fs/ufs/inode.c  | 37 +++++++++++++++++++------------------
 fs/ufs/namei.c  |  6 +++---
 5 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index e727ee07dbe4..b6053d9c0e64 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -45,7 +45,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	unsigned cgno, bit, end_bit, bbase, blkmap, i;
 	u64 blkno;
 	
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 	
 	UFSD("ENTER, fragment %llu, count %u\n",
@@ -141,7 +141,7 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 	unsigned overflow, cgno, bit, end_bit, i;
 	u64 blkno;
 	
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 
 	UFSD("ENTER, fragment %llu, count %u\n",
@@ -268,7 +268,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 			if (!page)/* it was truncated */
 				continue;
 			if (IS_ERR(page)) {/* or EIO */
-				ufs_error(inode->i_sb, __func__,
+				ufs_error(inode_sb(inode), __func__,
 					  "read of page %llu failed\n",
 					  (unsigned long long)index);
 				continue;
@@ -294,12 +294,13 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
 			pos = (i - beg) + j;
 
 			if (!buffer_mapped(bh))
-					map_bh(bh, inode->i_sb, oldb + pos);
+					map_bh(bh, inode_sb(inode),
+					       oldb + pos);
 			if (!buffer_uptodate(bh)) {
 				ll_rw_block(REQ_OP_READ, 0, 1, &bh);
 				wait_on_buffer(bh);
 				if (!buffer_uptodate(bh)) {
-					ufs_error(inode->i_sb, __func__,
+					ufs_error(inode_sb(inode), __func__,
 						  "read of block failed\n");
 					break;
 				}
@@ -329,9 +330,9 @@ static void ufs_clear_frags(struct inode *inode, sector_t beg, unsigned int n,
 	sector_t end = beg + n;
 
 	for (; beg < end; ++beg) {
-		bh = sb_getblk(inode->i_sb, beg);
+		bh = sb_getblk(inode_sb(inode), beg);
 		lock_buffer(bh);
-		memset(bh->b_data, 0, inode->i_sb->s_blocksize);
+		memset(bh->b_data, 0, inode_sb(inode)->s_blocksize);
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
@@ -355,7 +356,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 	     inode->i_ino, (unsigned long long)fragment,
 	     (unsigned long long)goal, count);
 	
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
 	*err = -ENOSPC;
@@ -517,7 +518,7 @@ static u64 ufs_add_fragments(struct inode *inode, u64 fragment,
 	UFSD("ENTER, fragment %llu, oldcount %u, newcount %u\n",
 	     (unsigned long long)fragment, oldcount, newcount);
 	
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 	count = newcount - oldcount;
 	
@@ -597,7 +598,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	UFSD("ENTER, ino %lu, cgno %u, goal %llu, count %u\n",
 	     inode->i_ino, cgno, (unsigned long long)goal, count);
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 	oldcg = cgno;
 	
@@ -708,7 +709,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 
 	UFSD("ENTER, goal %llu\n", (unsigned long long)goal);
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
 
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index b721d0bda5e5..ebe0ddc8b708 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -75,7 +75,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	
 	de = ufs_find_entry(dir, qstr, &page);
 	if (de) {
-		res = fs32_to_cpu(dir->i_sb, de->d_ino);
+		res = fs32_to_cpu(inode_sb(dir), de->d_ino);
 		ufs_put_page(page);
 	}
 	return res;
@@ -89,15 +89,15 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 {
 	loff_t pos = page_offset(page) +
 			(char *) de - (char *) page_address(page);
-	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
+	unsigned len = fs16_to_cpu(inode_sb(dir), de->d_reclen);
 	int err;
 
 	lock_page(page);
 	err = ufs_prepare_chunk(page, pos, len);
 	BUG_ON(err);
 
-	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
-	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
+	de->d_ino = cpu_to_fs32(inode_sb(dir), inode->i_ino);
+	ufs_set_de_type(inode_sb(dir), de, inode->i_mode);
 
 	err = ufs_commit_chunk(page, pos, len);
 	ufs_put_page(page);
@@ -110,7 +110,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 static bool ufs_check_page(struct page *page)
 {
 	struct inode *dir = page->mapping->host;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	char *kaddr = page_address(page);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_SIZE;
@@ -232,7 +232,7 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 	struct ufs_dir_entry *de = NULL;
 
 	if (!IS_ERR(page)) {
-		de = ufs_next_entry(dir->i_sb,
+		de = ufs_next_entry(inode_sb(dir),
 				    (struct ufs_dir_entry *)page_address(page));
 		*p = page;
 	}
@@ -250,7 +250,7 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 				     struct page **res_page)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	const unsigned char *name = qstr->name;
 	int namelen = qstr->len;
 	unsigned reclen = UFS_DIR_REC_LEN(namelen);
@@ -307,7 +307,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	struct inode *dir = d_inode(dentry->d_parent);
 	const unsigned char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	unsigned reclen = UFS_DIR_REC_LEN(namelen);
 	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
 	unsigned short rec_len, name_len;
@@ -348,7 +348,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			}
 			if (de->d_reclen == 0) {
-				ufs_error(dir->i_sb, __func__,
+				ufs_error(inode_sb(dir), __func__,
 					  "zero-length directory entry");
 				err = -EIO;
 				goto out_unlock;
@@ -424,7 +424,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 {
 	loff_t pos = ctx->pos;
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned int offset = pos & ~PAGE_MASK;
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
@@ -495,7 +495,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		     struct page * page)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	char *kaddr = page_address(page);
 	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
 	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
@@ -513,7 +513,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 
 	while ((char*)de < (char*)dir) {
 		if (de->d_reclen == 0) {
-			ufs_error(inode->i_sb, __func__,
+			ufs_error(inode_sb(inode), __func__,
 				  "zero-length directory entry");
 			err = -EIO;
 			goto out;
@@ -542,7 +542,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 
 int ufs_make_empty(struct inode * inode, struct inode *dir)
 {
-	struct super_block * sb = dir->i_sb;
+	struct super_block * sb = inode_sb(dir);
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page = grab_cache_page(mapping, 0);
 	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
@@ -590,7 +590,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
  */
 int ufs_empty_dir(struct inode * inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 
@@ -608,9 +608,9 @@ int ufs_empty_dir(struct inode * inode)
 
 		while ((char *)de <= kaddr) {
 			if (de->d_reclen == 0) {
-				ufs_error(inode->i_sb, __func__,
-					"zero-length directory entry: "
-					"kaddr=%p, de=%p\n", kaddr, de);
+				ufs_error(inode_sb(inode), __func__,
+					  "zero-length directory entry: "
+					  "kaddr=%p, de=%p\n", kaddr, de);
 				goto not_empty;
 			}
 			if (de->d_ino) {
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index e1ef0f0a1353..077fb36d5f3e 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -65,7 +65,7 @@ void ufs_free_inode (struct inode * inode)
 	
 	UFSD("ENTER, ino %lu\n", inode->i_ino);
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 	
 	ino = inode->i_ino;
@@ -187,7 +187,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
 		return ERR_PTR(-EPERM);
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c843ec858cf7..eb606975737e 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -45,7 +45,7 @@
 
 static int ufs_block_to_path(struct inode *inode, sector_t i_block, unsigned offsets[4])
 {
-	struct ufs_sb_private_info *uspi = UFS_SB(inode->i_sb)->s_uspi;
+	struct ufs_sb_private_info *uspi = UFS_SB(inode_sb(inode))->s_uspi;
 	int ptrs = uspi->s_apb;
 	int ptrs_bits = uspi->s_apbshift;
 	const long direct_blocks = UFS_NDADDR,
@@ -70,7 +70,8 @@ static int ufs_block_to_path(struct inode *inode, sector_t i_block, unsigned off
 		offsets[n++] = (i_block >> ptrs_bits) & (ptrs - 1);
 		offsets[n++] = i_block & (ptrs - 1);
 	} else {
-		ufs_warning(inode->i_sb, "ufs_block_to_path", "block > big");
+		ufs_warning(inode_sb(inode), "ufs_block_to_path",
+			    "block > big");
 	}
 	return n;
 }
@@ -124,7 +125,7 @@ static inline int grow_chain64(struct ufs_inode_info *ufsi,
 static u64 ufs_frag_map(struct inode *inode, unsigned offsets[4], int depth)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	u64 mask = (u64) uspi->s_apbmask>>uspi->s_fpbshift;
 	int shift = uspi->s_apbshift-uspi->s_fpbshift;
@@ -222,7 +223,7 @@ ufs_extend_tail(struct inode *inode, u64 writes_to,
 		  int *err, struct page *locked_page)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	unsigned lastfrag = ufsi->i_lastfrag;	/* it's a short file, so unsigned is enough */
 	unsigned block = ufs_fragstoblks(lastfrag);
@@ -257,7 +258,7 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 		  int *new, struct page *locked_page)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	u64 tmp, goal, lastfrag;
 	unsigned nfrags = uspi->s_fpb;
@@ -335,7 +336,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 		  unsigned index, sector_t new_fragment, int *err,
 		  int *new, struct page *locked_page)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	int shift = uspi->s_apbshift - uspi->s_fpbshift;
 	u64 tmp = 0, goal;
@@ -395,7 +396,7 @@ ufs_inode_getblock(struct inode *inode, u64 ind_block,
 
 static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	int err = 0, new = 0;
 	unsigned offsets[4];
@@ -554,13 +555,13 @@ static void ufs_set_inode_ops(struct inode *inode)
 		}
 	} else
 		init_special_inode(inode, inode->i_mode,
-				   ufs_get_inode_dev(inode->i_sb, UFS_I(inode)));
+				   ufs_get_inode_dev(inode_sb(inode), UFS_I(inode)));
 }
 
 static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	umode_t mode;
 
 	/*
@@ -605,7 +606,7 @@ static int ufs1_read_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 static int ufs2_read_inode(struct inode *inode, struct ufs2_inode *ufs2_inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	umode_t mode;
 
 	UFSD("Reading ufs2 inode, ino %lu\n", inode->i_ino);
@@ -713,7 +714,7 @@ struct inode *ufs_iget(struct super_block *sb, unsigned long ino)
 
 static void ufs1_update_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
  	struct ufs_inode_info *ufsi = UFS_I(inode);
 
 	ufs_inode->ui_mode = cpu_to_fs16(sb, inode->i_mode);
@@ -756,7 +757,7 @@ static void ufs1_update_inode(struct inode *inode, struct ufs_inode *ufs_inode)
 
 static void ufs2_update_inode(struct inode *inode, struct ufs2_inode *ufs_inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
  	struct ufs_inode_info *ufsi = UFS_I(inode);
 
 	UFSD("ENTER\n");
@@ -796,7 +797,7 @@ static void ufs2_update_inode(struct inode *inode, struct ufs2_inode *ufs_inode)
 
 static int ufs_update_inode(struct inode * inode, int do_sync)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct buffer_head * bh;
 
@@ -897,7 +898,7 @@ static void ufs_trunc_direct(struct inode *inode)
 
 	UFSD("ENTER: ino %lu\n", inode->i_ino);
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	uspi = UFS_SB(sb)->s_uspi;
 
 	frag1 = DIRECT_FRAGMENT;
@@ -975,7 +976,7 @@ static void ufs_trunc_direct(struct inode *inode)
 
 static void free_full_branch(struct inode *inode, u64 ind_block, int depth)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct ufs_buffer_head *ubh = ubh_bread(sb, ind_block, uspi->s_bsize);
 	unsigned i;
@@ -1008,7 +1009,7 @@ static void free_full_branch(struct inode *inode, u64 ind_block, int depth)
 
 static void free_branch_tail(struct inode *inode, unsigned from, struct ufs_buffer_head *ubh, int depth)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	unsigned i;
 
@@ -1048,7 +1049,7 @@ static void free_branch_tail(struct inode *inode, unsigned from, struct ufs_buff
 static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 {
 	int err = 0;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	unsigned i, end;
@@ -1117,7 +1118,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 static void ufs_truncate_blocks(struct inode *inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	unsigned offsets[4];
 	int depth;
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 32545cd00ceb..4a672aca7f53 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -59,7 +59,7 @@ static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, unsi
 
 	ino = ufs_inode_by_name(dir, &dentry->d_name);
 	if (ino)
-		inode = ufs_iget(dir->i_sb, ino);
+		inode = ufs_iget(inode_sb(dir), ino);
 	return d_splice_alias(inode, dentry);
 }
 
@@ -99,7 +99,7 @@ static int ufs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, mode, rdev);
-		ufs_set_inode_dev(inode->i_sb, UFS_I(inode), rdev);
+		ufs_set_inode_dev(inode_sb(inode), UFS_I(inode), rdev);
 		mark_inode_dirty(inode);
 		err = ufs_add_nondir(dentry, inode);
 	}
@@ -109,7 +109,7 @@ static int ufs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev
 static int ufs_symlink (struct inode * dir, struct dentry * dentry,
 	const char * symname)
 {
-	struct super_block * sb = dir->i_sb;
+	struct super_block * sb = inode_sb(dir);
 	int err;
 	unsigned l = strlen(symname)+1;
 	struct inode * inode;
-- 
2.15.1
