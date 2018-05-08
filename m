Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755969AbeEHSXr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755790AbeEHSGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:08 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 55/76] fs/omfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:15 -0700
Message-Id: <20180508180436.716-56-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/omfs/dir.c   | 24 ++++++++++++------------
 fs/omfs/file.c  | 37 +++++++++++++++++++------------------
 fs/omfs/inode.c | 19 ++++++++++---------
 3 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index b7146526afff..5a589c5a852f 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -28,7 +28,7 @@ static struct buffer_head *omfs_get_bucket(struct inode *dir,
 	int bucket = omfs_hash(name, namelen, nbuckets);
 
 	*ofs = OMFS_DIR_START + bucket * 8;
-	return omfs_bread(dir->i_sb, dir->i_ino);
+	return omfs_bread(inode_sb(dir), dir->i_ino);
 }
 
 static struct buffer_head *omfs_scan_list(struct inode *dir, u64 block,
@@ -41,14 +41,14 @@ static struct buffer_head *omfs_scan_list(struct inode *dir, u64 block,
 	*prev_block = ~0;
 
 	while (block != ~0) {
-		bh = omfs_bread(dir->i_sb, block);
+		bh = omfs_bread(inode_sb(dir), block);
 		if (!bh) {
 			err = -EIO;
 			goto err;
 		}
 
 		oi = (struct omfs_inode *) bh->b_data;
-		if (omfs_is_bad(OMFS_SB(dir->i_sb), &oi->i_head, block)) {
+		if (omfs_is_bad(OMFS_SB(inode_sb(dir)), &oi->i_head, block)) {
 			brelse(bh);
 			goto err;
 		}
@@ -131,7 +131,7 @@ static int omfs_add_link(struct dentry *dentry, struct inode *inode)
 	brelse(bh);
 
 	/* now set the sibling and parent pointers on the new inode */
-	bh = omfs_bread(dir->i_sb, inode->i_ino);
+	bh = omfs_bread(inode_sb(dir), inode->i_ino);
 	if (!bh)
 		goto out;
 
@@ -187,7 +187,7 @@ static int omfs_delete_entry(struct dentry *dentry)
 	if (prev != ~0) {
 		/* found in middle of list, get list ptr */
 		brelse(bh);
-		bh = omfs_bread(dir->i_sb, prev);
+		bh = omfs_bread(inode_sb(dir), prev);
 		if (!bh)
 			goto out;
 
@@ -199,7 +199,7 @@ static int omfs_delete_entry(struct dentry *dentry)
 	mark_buffer_dirty(bh);
 
 	if (prev != ~0) {
-		dirty = omfs_iget(dir->i_sb, prev);
+		dirty = omfs_iget(inode_sb(dir), prev);
 		if (!IS_ERR(dirty)) {
 			mark_inode_dirty(dirty);
 			iput(dirty);
@@ -220,7 +220,7 @@ static int omfs_dir_is_empty(struct inode *inode)
 	u64 *ptr;
 	int i;
 
-	bh = omfs_bread(inode->i_sb, inode->i_ino);
+	bh = omfs_bread(inode_sb(inode), inode->i_ino);
 
 	if (!bh)
 		return 0;
@@ -263,7 +263,7 @@ static int omfs_add_node(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	err = omfs_make_empty(inode, dir->i_sb);
+	err = omfs_make_empty(inode, inode_sb(dir));
 	if (err)
 		goto out_free_inode;
 
@@ -304,7 +304,7 @@ static struct dentry *omfs_lookup(struct inode *dir, struct dentry *dentry,
 		struct omfs_inode *oi = (struct omfs_inode *)bh->b_data;
 		ino_t ino = be64_to_cpu(oi->i_head.h_self);
 		brelse(bh);
-		inode = omfs_iget(dir->i_sb, ino);
+		inode = omfs_iget(inode_sb(dir), ino);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
 	}
@@ -332,7 +332,7 @@ static bool omfs_fill_chain(struct inode *dir, struct dir_context *ctx,
 {
 	/* follow chain in this bucket */
 	while (fsblock != ~0) {
-		struct buffer_head *bh = omfs_bread(dir->i_sb, fsblock);
+		struct buffer_head *bh = omfs_bread(inode_sb(dir), fsblock);
 		struct omfs_inode *oi;
 		u64 self;
 		unsigned char d_type;
@@ -341,7 +341,7 @@ static bool omfs_fill_chain(struct inode *dir, struct dir_context *ctx,
 			return true;
 
 		oi = (struct omfs_inode *) bh->b_data;
-		if (omfs_is_bad(OMFS_SB(dir->i_sb), &oi->i_head, fsblock)) {
+		if (omfs_is_bad(OMFS_SB(inode_sb(dir)), &oi->i_head, fsblock)) {
 			brelse(bh);
 			return true;
 		}
@@ -428,7 +428,7 @@ static int omfs_readdir(struct file *file, struct dir_context *ctx)
 	hchain = (ctx->pos >> 20) - 1;
 	hindex = ctx->pos & 0xfffff;
 
-	bh = omfs_bread(dir->i_sb, dir->i_ino);
+	bh = omfs_bread(inode_sb(dir), dir->i_ino);
 	if (!bh)
 		return -EINVAL;
 
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index bf83e6644333..a714a3ba6d6a 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -30,7 +30,7 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
 
 int omfs_shrink_inode(struct inode *inode)
 {
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
+	struct omfs_sb_info *sbi = OMFS_SB(inode_sb(inode));
 	struct omfs_extent *oe;
 	struct omfs_extent_entry *entry;
 	struct buffer_head *bh;
@@ -49,7 +49,7 @@ int omfs_shrink_inode(struct inode *inode)
 	if (inode->i_size != 0)
 		goto out;
 
-	bh = omfs_bread(inode->i_sb, next);
+	bh = omfs_bread(inode_sb(inode), next);
 	if (!bh)
 		goto out;
 
@@ -76,7 +76,7 @@ int omfs_shrink_inode(struct inode *inode)
 			start = be64_to_cpu(entry->e_cluster);
 			count = be64_to_cpu(entry->e_blocks);
 
-			omfs_clear_range(inode->i_sb, start, (int) count);
+			omfs_clear_range(inode_sb(inode), start, (int) count);
 			entry++;
 		}
 		omfs_make_empty_table(bh, (char *) oe - bh->b_data);
@@ -84,12 +84,13 @@ int omfs_shrink_inode(struct inode *inode)
 		brelse(bh);
 
 		if (last != inode->i_ino)
-			omfs_clear_range(inode->i_sb, last, sbi->s_mirrors);
+			omfs_clear_range(inode_sb(inode), last,
+					 sbi->s_mirrors);
 
 		if (next == ~0)
 			break;
 
-		bh = omfs_bread(inode->i_sb, next);
+		bh = omfs_bread(inode_sb(inode), next);
 		if (!bh)
 			goto out;
 		oe = (struct omfs_extent *) (&bh->b_data[OMFS_EXTENT_CONT]);
@@ -118,7 +119,7 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 {
 	struct omfs_extent_entry *terminator;
 	struct omfs_extent_entry *entry = &oe->e_entry;
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
+	struct omfs_sb_info *sbi = OMFS_SB(inode_sb(inode));
 	u32 extent_count = be32_to_cpu(oe->e_extent_count);
 	u64 new_block = 0;
 	u32 max_count;
@@ -145,7 +146,7 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 		new_block = be64_to_cpu(entry->e_cluster) +
 			be64_to_cpu(entry->e_blocks);
 
-		if (omfs_allocate_block(inode->i_sb, new_block)) {
+		if (omfs_allocate_block(inode_sb(inode), new_block)) {
 			be64_add_cpu(&entry->e_blocks, 1);
 			terminator->e_blocks = ~(cpu_to_be64(
 				be64_to_cpu(~terminator->e_blocks) + 1));
@@ -159,8 +160,8 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 		return -EIO;
 
 	/* try to allocate a new cluster */
-	ret = omfs_allocate_range(inode->i_sb, 1, sbi->s_clustersize,
-		&new_block, &new_count);
+	ret = omfs_allocate_range(inode_sb(inode), 1, sbi->s_clustersize,
+				  &new_block, &new_count);
 	if (ret)
 		goto out_fail;
 
@@ -194,8 +195,8 @@ static sector_t find_block(struct inode *inode, struct omfs_extent_entry *ent,
 	/* count > 1 because of terminator */
 	sector_t searched = 0;
 	for (; count > 1; count--) {
-		int numblocks = clus_to_blk(OMFS_SB(inode->i_sb),
-			be64_to_cpu(ent->e_blocks));
+		int numblocks = clus_to_blk(OMFS_SB(inode_sb(inode)),
+					    be64_to_cpu(ent->e_blocks));
 
 		if (block >= searched  &&
 		    block < searched + numblocks) {
@@ -204,8 +205,8 @@ static sector_t find_block(struct inode *inode, struct omfs_extent_entry *ent,
 			 * numblocks - (block - searched) is remainder
 			 */
 			*left = numblocks - (block - searched);
-			return clus_to_blk(OMFS_SB(inode->i_sb),
-				be64_to_cpu(ent->e_cluster)) +
+			return clus_to_blk(OMFS_SB(inode_sb(inode)),
+					   be64_to_cpu(ent->e_cluster)) +
 				block - searched;
 		}
 		searched += numblocks;
@@ -225,12 +226,12 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 	int extent_count;
 	struct omfs_extent *oe;
 	struct omfs_extent_entry *entry;
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
+	struct omfs_sb_info *sbi = OMFS_SB(inode_sb(inode));
 	int max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int remain;
 
 	ret = -EIO;
-	bh = omfs_bread(inode->i_sb, inode->i_ino);
+	bh = omfs_bread(inode_sb(inode), inode->i_ino);
 	if (!bh)
 		goto out;
 
@@ -253,7 +254,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 		offset = find_block(inode, entry, block, extent_count, &remain);
 		if (offset > 0) {
 			ret = 0;
-			map_bh(bh_result, inode->i_sb, offset);
+			map_bh(bh_result, inode_sb(inode), offset);
 			if (remain > max_blocks)
 				remain = max_blocks;
 			bh_result->b_size = (remain << inode->i_blkbits);
@@ -263,7 +264,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 			break;
 
 		brelse(bh);
-		bh = omfs_bread(inode->i_sb, next);
+		bh = omfs_bread(inode_sb(inode), next);
 		if (!bh)
 			goto out;
 		oe = (struct omfs_extent *) (&bh->b_data[OMFS_EXTENT_CONT]);
@@ -274,7 +275,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 		if (ret == 0) {
 			mark_buffer_dirty(bh);
 			mark_inode_dirty(inode);
-			map_bh(bh_result, inode->i_sb,
+			map_bh(bh_result, inode_sb(inode),
 					clus_to_blk(sbi, new_block));
 		}
 	}
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index ee14af9e26f2..4e319c7712c9 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -36,14 +36,15 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
 	u64 new_block;
 	int err;
 	int len;
-	struct omfs_sb_info *sbi = OMFS_SB(dir->i_sb);
+	struct omfs_sb_info *sbi = OMFS_SB(inode_sb(dir));
 
-	inode = new_inode(dir->i_sb);
+	inode = new_inode(inode_sb(dir));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	err = omfs_allocate_range(dir->i_sb, sbi->s_mirrors, sbi->s_mirrors,
-			&new_block, &len);
+	err = omfs_allocate_range(inode_sb(dir), sbi->s_mirrors,
+				  sbi->s_mirrors,
+				  &new_block, &len);
 	if (err)
 		goto fail;
 
@@ -102,7 +103,7 @@ static void omfs_update_checksums(struct omfs_inode *oi)
 static int __omfs_write_inode(struct inode *inode, int wait)
 {
 	struct omfs_inode *oi;
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
+	struct omfs_sb_info *sbi = OMFS_SB(inode_sb(inode));
 	struct buffer_head *bh, *bh2;
 	u64 ctime;
 	int i;
@@ -110,7 +111,7 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 	int sync_failed = 0;
 
 	/* get current inode since we may have written sibling ptrs etc. */
-	bh = omfs_bread(inode->i_sb, inode->i_ino);
+	bh = omfs_bread(inode_sb(inode), inode->i_ino);
 	if (!bh)
 		goto out;
 
@@ -149,7 +150,7 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 
 	/* if mirroring writes, copy to next fsblock */
 	for (i = 1; i < sbi->s_mirrors; i++) {
-		bh2 = omfs_bread(inode->i_sb, inode->i_ino + i);
+		bh2 = omfs_bread(inode_sb(inode), inode->i_ino + i);
 		if (!bh2)
 			goto out_brelse;
 
@@ -196,7 +197,7 @@ static void omfs_evict_inode(struct inode *inode)
 		omfs_shrink_inode(inode);
 	}
 
-	omfs_clear_range(inode->i_sb, inode->i_ino, 2);
+	omfs_clear_range(inode_sb(inode), inode->i_ino, 2);
 }
 
 struct inode *omfs_iget(struct super_block *sb, ino_t ino)
@@ -214,7 +215,7 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	bh = omfs_bread(inode->i_sb, ino);
+	bh = omfs_bread(inode_sb(inode), ino);
 	if (!bh)
 		goto iget_failed;
 
-- 
2.15.1
