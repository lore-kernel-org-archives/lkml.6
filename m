Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeEHSKN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:10:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54289 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755864AbeEHSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:27 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 68/76] fs/sysv: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:28 -0700
Message-Id: <20180508180436.716-69-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/sysv/dir.c    | 12 ++++++------
 fs/sysv/ialloc.c |  8 ++++----
 fs/sysv/inode.c  |  6 +++---
 fs/sysv/itree.c  | 29 +++++++++++++++--------------
 fs/sysv/namei.c  |  4 ++--
 5 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9..84a11fda6a28 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -65,7 +65,7 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 {
 	unsigned long pos = ctx->pos;
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned long npages = dir_pages(inode);
 	unsigned offset;
 	unsigned long n;
@@ -214,7 +214,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 		goto out_unlock;
 	memcpy (de->name, name, namelen);
 	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
-	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode_sb(inode)), inode->i_ino);
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
@@ -265,10 +265,10 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 	memset(base, 0, PAGE_SIZE);
 
 	de = (struct sysv_dir_entry *) base;
-	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode_sb(inode)), inode->i_ino);
 	strcpy(de->name,".");
 	de++;
-	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode_sb(inode)), dir->i_ino);
 	strcpy(de->name,"..");
 
 	kunmap(page);
@@ -283,7 +283,7 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
  */
 int sysv_empty_dir(struct inode * inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 
@@ -335,7 +335,7 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	lock_page(page);
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	BUG_ON(err);
-	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
+	de->inode = cpu_to_fs16(SYSV_SB(inode_sb(inode)), inode->i_ino);
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
 	dir_put_page(page);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
index 6c9801986af6..2515367bf047 100644
--- a/fs/sysv/ialloc.c
+++ b/fs/sysv/ialloc.c
@@ -100,14 +100,14 @@ static int refill_free_cache(struct super_block *sb)
 
 void sysv_free_inode(struct inode * inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	unsigned int ino;
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
 	unsigned count;
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	ino = inode->i_ino;
 	if (ino <= SYSV_ROOT_INO || ino > sbi->s_ninodes) {
 		printk("sysv_free_inode: inode 0,1,2 or nonexistent inode\n");
@@ -116,7 +116,7 @@ void sysv_free_inode(struct inode * inode)
 	raw_inode = sysv_raw_inode(sb, ino, &bh);
 	if (!raw_inode) {
 		printk("sysv_free_inode: unable to read inode block on device "
-		       "%s\n", inode->i_sb->s_id);
+		       "%s\n", inode_sb(inode)->s_id);
 		return;
 	}
 	mutex_lock(&sbi->s_lock);
@@ -135,7 +135,7 @@ void sysv_free_inode(struct inode * inode)
 
 struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	struct inode *inode;
 	sysv_ino_t ino;
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index bec9f79adb25..9d04a4a2c248 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -192,7 +192,7 @@ struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
 	raw_inode = sysv_raw_inode(sb, ino, &bh);
 	if (!raw_inode) {
 		printk("Major problem: unable to read inode from dev %s\n",
-		       inode->i_sb->s_id);
+		       inode_sb(inode)->s_id);
 		goto bad_inode;
 	}
 	/* SystemV FS: kludge permissions if ino==SYSV_ROOT_INO ?? */
@@ -230,7 +230,7 @@ struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
 
 static int __sysv_write_inode(struct inode *inode, int wait)
 {
-	struct super_block * sb = inode->i_sb;
+	struct super_block * sb = inode_sb(inode);
 	struct sysv_sb_info * sbi = SYSV_SB(sb);
 	struct buffer_head * bh;
 	struct sysv_inode * raw_inode;
@@ -241,7 +241,7 @@ static int __sysv_write_inode(struct inode *inode, int wait)
 	ino = inode->i_ino;
 	if (!ino || ino > sbi->s_ninodes) {
 		printk("Bad inode number on dev %s: %d is out of range\n",
-		       inode->i_sb->s_id, ino);
+		       inode_sb(inode)->s_id, ino);
 		return -EIO;
 	}
 	raw_inode = sysv_raw_inode(sb, ino, &bh);
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index bcb67b0cabe7..f69d30bc4217 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -22,7 +22,7 @@ static inline void dirty_indirect(struct buffer_head *bh, struct inode *inode)
 
 static int block_to_path(struct inode *inode, long block, int offsets[DEPTH])
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	int ptrs_bits = sbi->s_ind_per_block_bits;
 	unsigned long	indirect_blocks = sbi->s_ind_per_block,
@@ -91,7 +91,7 @@ static Indirect *get_branch(struct inode *inode,
 			    Indirect chain[],
 			    int *err)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	Indirect *p = chain;
 	struct buffer_head *bh;
 
@@ -127,24 +127,25 @@ static int alloc_branch(struct inode *inode,
 			int *offsets,
 			Indirect *branch)
 {
-	int blocksize = inode->i_sb->s_blocksize;
+	int blocksize = inode_sb(inode)->s_blocksize;
 	int n = 0;
 	int i;
 
-	branch[0].key = sysv_new_block(inode->i_sb);
+	branch[0].key = sysv_new_block(inode_sb(inode));
 	if (branch[0].key) for (n = 1; n < num; n++) {
 		struct buffer_head *bh;
 		int parent;
 		/* Allocate the next block */
-		branch[n].key = sysv_new_block(inode->i_sb);
+		branch[n].key = sysv_new_block(inode_sb(inode));
 		if (!branch[n].key)
 			break;
 		/*
 		 * Get buffer_head for parent block, zero it out and set 
 		 * the pointer to new one, then send parent to disk.
 		 */
-		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
-		bh = sb_getblk(inode->i_sb, parent);
+		parent = block_to_cpu(SYSV_SB(inode_sb(inode)),
+				      branch[n-1].key);
+		bh = sb_getblk(inode_sb(inode), parent);
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
@@ -161,7 +162,7 @@ static int alloc_branch(struct inode *inode,
 	for (i = 1; i < n; i++)
 		bforget(branch[i].bh);
 	for (i = 0; i < n; i++)
-		sysv_free_block(inode->i_sb, branch[i].key);
+		sysv_free_block(inode_sb(inode), branch[i].key);
 	return -ENOSPC;
 }
 
@@ -196,7 +197,7 @@ static inline int splice_branch(struct inode *inode,
 	for (i = 1; i < num; i++)
 		bforget(where[i].bh);
 	for (i = 0; i < num; i++)
-		sysv_free_block(inode->i_sb, where[i].key);
+		sysv_free_block(inode_sb(inode), where[i].key);
 	return -EAGAIN;
 }
 
@@ -205,7 +206,7 @@ static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *b
 	int err = -EIO;
 	int offsets[DEPTH];
 	Indirect chain[DEPTH];
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	Indirect *partial;
 	int left;
 	int depth = block_to_path(inode, iblock, offsets);
@@ -329,7 +330,7 @@ static inline void free_data(struct inode *inode, sysv_zone_t *p, sysv_zone_t *q
 		sysv_zone_t nr = *p;
 		if (nr) {
 			*p = 0;
-			sysv_free_block(inode->i_sb, nr);
+			sysv_free_block(inode_sb(inode), nr);
 			mark_inode_dirty(inode);
 		}
 	}
@@ -338,7 +339,7 @@ static inline void free_data(struct inode *inode, sysv_zone_t *p, sysv_zone_t *q
 static void free_branches(struct inode *inode, sysv_zone_t *p, sysv_zone_t *q, int depth)
 {
 	struct buffer_head * bh;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (depth--) {
 		for ( ; p < q ; p++) {
@@ -376,9 +377,9 @@ void sysv_truncate (struct inode * inode)
 	    S_ISLNK(inode->i_mode)))
 		return;
 
-	blocksize = inode->i_sb->s_blocksize;
+	blocksize = inode_sb(inode)->s_blocksize;
 	iblock = (inode->i_size + blocksize-1)
-					>> inode->i_sb->s_blocksize_bits;
+					>> inode_sb(inode)->s_blocksize_bits;
 
 	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
 
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index 250b0755b908..31f0fa48e273 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -53,7 +53,7 @@ static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry, un
 	ino = sysv_inode_by_name(dentry);
 
 	if (ino) {
-		inode = sysv_iget(dir->i_sb, ino);
+		inode = sysv_iget(inode_sb(dir), ino);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
 	}
@@ -92,7 +92,7 @@ static int sysv_symlink(struct inode * dir, struct dentry * dentry,
 	int l = strlen(symname)+1;
 	struct inode * inode;
 
-	if (l > dir->i_sb->s_blocksize)
+	if (l > inode_sb(dir)->s_blocksize)
 		goto out;
 
 	inode = sysv_new_inode(dir, S_IFLNK|0777);
-- 
2.15.1
