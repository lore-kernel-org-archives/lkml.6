Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeEHSFT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755599AbeEHSFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:13 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 17/76] fs/bfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:37 -0700
Message-Id: <20180508180436.716-18-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/bfs/dir.c   | 23 ++++++++++++-----------
 fs/bfs/file.c  |  4 ++--
 fs/bfs/inode.c | 16 +++++++++-------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index ee832ca5f734..124c1eedb53c 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -38,14 +38,14 @@ static int bfs_readdir(struct file *f, struct dir_context *ctx)
 	if (ctx->pos & (BFS_DIRENT_SIZE - 1)) {
 		printf("Bad f_pos=%08lx for %s:%08lx\n",
 					(unsigned long)ctx->pos,
-					dir->i_sb->s_id, dir->i_ino);
+					inode_sb(dir)->s_id, dir->i_ino);
 		return -EINVAL;
 	}
 
 	while (ctx->pos < dir->i_size) {
 		offset = ctx->pos & (BFS_BSIZE - 1);
 		block = BFS_I(dir)->i_sblock + (ctx->pos >> BFS_BSIZE_BITS);
-		bh = sb_bread(dir->i_sb, block);
+		bh = sb_bread(inode_sb(dir), block);
 		if (!bh) {
 			ctx->pos += BFS_BSIZE - offset;
 			continue;
@@ -81,7 +81,7 @@ static int bfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 {
 	int err;
 	struct inode *inode;
-	struct super_block *s = dir->i_sb;
+	struct super_block *s = inode_sb(dir);
 	struct bfs_sb_info *info = BFS_SB(s);
 	unsigned long ino;
 
@@ -130,7 +130,7 @@ static struct dentry *bfs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	struct buffer_head *bh;
 	struct bfs_dirent *de;
-	struct bfs_sb_info *info = BFS_SB(dir->i_sb);
+	struct bfs_sb_info *info = BFS_SB(inode_sb(dir));
 
 	if (dentry->d_name.len > BFS_NAMELEN)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -140,7 +140,7 @@ static struct dentry *bfs_lookup(struct inode *dir, struct dentry *dentry,
 	if (bh) {
 		unsigned long ino = (unsigned long)le16_to_cpu(de->ino);
 		brelse(bh);
-		inode = bfs_iget(dir->i_sb, ino);
+		inode = bfs_iget(inode_sb(dir), ino);
 		if (IS_ERR(inode)) {
 			mutex_unlock(&info->bfs_lock);
 			return ERR_CAST(inode);
@@ -155,7 +155,7 @@ static int bfs_link(struct dentry *old, struct inode *dir,
 						struct dentry *new)
 {
 	struct inode *inode = d_inode(old);
-	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
+	struct bfs_sb_info *info = BFS_SB(inode_sb(inode));
 	int err;
 
 	mutex_lock(&info->bfs_lock);
@@ -180,7 +180,7 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	struct buffer_head *bh;
 	struct bfs_dirent *de;
-	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
+	struct bfs_sb_info *info = BFS_SB(inode_sb(inode));
 
 	mutex_lock(&info->bfs_lock);
 	bh = bfs_find_entry(dir, dentry->d_name.name, dentry->d_name.len, &de);
@@ -189,7 +189,7 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (!inode->i_nlink) {
 		printf("unlinking non-existent file %s:%lu (nlink=%d)\n",
-					inode->i_sb->s_id, inode->i_ino,
+					inode_sb(inode)->s_id, inode->i_ino,
 					inode->i_nlink);
 		set_nlink(inode, 1);
 	}
@@ -225,7 +225,7 @@ static int bfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (S_ISDIR(old_inode->i_mode))
 		return -EINVAL;
 
-	info = BFS_SB(old_inode->i_sb);
+	info = BFS_SB(inode_sb(old_inode));
 
 	mutex_lock(&info->bfs_lock);
 	old_bh = bfs_find_entry(old_dir, 
@@ -296,7 +296,7 @@ static int bfs_add_entry(struct inode *dir, const unsigned char *name,
 	sblock = BFS_I(dir)->i_sblock;
 	eblock = BFS_I(dir)->i_eblock;
 	for (block = sblock; block <= eblock; block++) {
-		bh = sb_bread(dir->i_sb, block);
+		bh = sb_bread(inode_sb(dir), block);
 		if (!bh)
 			return -EIO;
 		for (off = 0; off < BFS_BSIZE; off += BFS_DIRENT_SIZE) {
@@ -345,7 +345,8 @@ static struct buffer_head *bfs_find_entry(struct inode *dir,
 
 	while (block * BFS_BSIZE + offset < dir->i_size) {
 		if (!bh) {
-			bh = sb_bread(dir->i_sb, BFS_I(dir)->i_sblock + block);
+			bh = sb_bread(inode_sb(dir),
+				      BFS_I(dir)->i_sblock + block);
 			if (!bh) {
 				block++;
 				continue;
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 1476cdd90cfb..159ef9ebca2d 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -66,7 +66,7 @@ static int bfs_get_block(struct inode *inode, sector_t block,
 {
 	unsigned long phys;
 	int err;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct bfs_sb_info *info = BFS_SB(sb);
 	struct bfs_inode_info *bi = BFS_I(inode);
 
@@ -122,7 +122,7 @@ static int bfs_get_block(struct inode *inode, sector_t block,
 	}
 
 	if (bi->i_sblock) {
-		err = bfs_move_blocks(inode->i_sb, bi->i_sblock, 
+		err = bfs_move_blocks(inode_sb(inode), bi->i_sblock, 
 						bi->i_eblock, phys);
 		if (err) {
 			dprintf("failed to move ino=%08lx -> fs corruption\n",
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 9a69392f1fb3..8216f6b03fda 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -44,15 +44,17 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(inode->i_sb)->si_lasti)) {
-		printf("Bad inode number %s:%08lx\n", inode->i_sb->s_id, ino);
+	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(inode_sb(inode))->si_lasti)) {
+		printf("Bad inode number %s:%08lx\n", inode_sb(inode)->s_id,
+		       ino);
 		goto error;
 	}
 
 	block = (ino - BFS_ROOT_INO) / BFS_INODES_PER_BLOCK + 1;
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode_sb(inode), block);
 	if (!bh) {
-		printf("Unable to read inode %s:%08lx\n", inode->i_sb->s_id,
+		printf("Unable to read inode %s:%08lx\n",
+									inode_sb(inode)->s_id,
 									ino);
 		goto error;
 	}
@@ -116,7 +118,7 @@ static struct bfs_inode *find_inode(struct super_block *sb, u16 ino, struct buff
 
 static int bfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
-	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
+	struct bfs_sb_info *info = BFS_SB(inode_sb(inode));
 	unsigned int ino = (u16)inode->i_ino;
         unsigned long i_sblock;
 	struct bfs_inode *di;
@@ -125,7 +127,7 @@ static int bfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 
         dprintf("ino=%08x\n", ino);
 
-	di = find_inode(inode->i_sb, ino, &bh);
+	di = find_inode(inode_sb(inode), ino, &bh);
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 
@@ -165,7 +167,7 @@ static void bfs_evict_inode(struct inode *inode)
 	unsigned long ino = inode->i_ino;
 	struct bfs_inode *di;
 	struct buffer_head *bh;
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	struct bfs_sb_info *info = BFS_SB(s);
 	struct bfs_inode_info *bi = BFS_I(inode);
 
-- 
2.15.1
