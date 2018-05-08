Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeEHSFl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54009 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932452AbeEHSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:27 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 27/76] fs/efs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:47 -0700
Message-Id: <20180508180436.716-28-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/efs/dir.c     | 2 +-
 fs/efs/file.c    | 2 +-
 fs/efs/inode.c   | 6 +++---
 fs/efs/namei.c   | 4 ++--
 fs/efs/symlink.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/efs/dir.c b/fs/efs/dir.c
index f892ac7c2a35..55663c4f49ce 100644
--- a/fs/efs/dir.c
+++ b/fs/efs/dir.c
@@ -42,7 +42,7 @@ static int efs_readdir(struct file *file, struct dir_context *ctx)
 		struct buffer_head *bh;
 
 		/* read the dir block */
-		bh = sb_bread(inode->i_sb, efs_bmap(inode, block));
+		bh = sb_bread(inode_sb(inode), efs_bmap(inode, block));
 
 		if (!bh) {
 			pr_err("%s(): failed to read dir block %d\n",
diff --git a/fs/efs/file.c b/fs/efs/file.c
index 9e641da6fab2..4e7cf6d70872 100644
--- a/fs/efs/file.c
+++ b/fs/efs/file.c
@@ -30,7 +30,7 @@ int efs_get_block(struct inode *inode, sector_t iblock,
 	}
 	phys = efs_map_block(inode, iblock);
 	if (phys)
-		map_bh(bh_result, inode->i_sb, phys);
+		map_bh(bh_result, inode_sb(inode), phys);
 	return 0;
 }
 
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index cdf0872382af..a62f6029fc1c 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -87,7 +87,7 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 			(EFS_BLOCKSIZE / sizeof(struct efs_dinode))) *
 		sizeof(struct efs_dinode);
 
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode_sb(inode), block);
 	if (!bh) {
 		pr_warn("%s() failed at block %d\n", __func__, block);
 		goto read_inode_error;
@@ -196,7 +196,7 @@ efs_extent_check(efs_extent *ptr, efs_block_t block, struct efs_sb_info *sb) {
 }
 
 efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
-	struct efs_sb_info    *sb = SUPER_INFO(inode->i_sb);
+	struct efs_sb_info    *sb = SUPER_INFO(inode_sb(inode));
 	struct efs_inode_info *in = INODE_INFO(inode);
 	struct buffer_head    *bh = NULL;
 
@@ -275,7 +275,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		if (first || lastblock != iblock) {
 			if (bh) brelse(bh);
 
-			bh = sb_bread(inode->i_sb, iblock);
+			bh = sb_bread(inode_sb(inode), iblock);
 			if (!bh) {
 				pr_err("%s() failed at block %d\n",
 				       __func__, iblock);
diff --git a/fs/efs/namei.c b/fs/efs/namei.c
index 38961ee1d1af..d1f3132b50a8 100644
--- a/fs/efs/namei.c
+++ b/fs/efs/namei.c
@@ -30,7 +30,7 @@ static efs_ino_t efs_find_entry(struct inode *inode, const char *name, int len)
 
 	for(block = 0; block < inode->i_blocks; block++) {
 
-		bh = sb_bread(inode->i_sb, efs_bmap(inode, block));
+		bh = sb_bread(inode_sb(inode), efs_bmap(inode, block));
 		if (!bh) {
 			pr_err("%s(): failed to read dir block %d\n",
 			       __func__, block);
@@ -69,7 +69,7 @@ struct dentry *efs_lookup(struct inode *dir, struct dentry *dentry, unsigned int
 
 	inodenum = efs_find_entry(dir, dentry->d_name.name, dentry->d_name.len);
 	if (inodenum)
-		inode = efs_iget(dir->i_sb, inodenum);
+		inode = efs_iget(inode_sb(dir), inodenum);
 
 	return d_splice_alias(inode, dentry);
 }
diff --git a/fs/efs/symlink.c b/fs/efs/symlink.c
index 923eb91654d5..f6b8b33e9600 100644
--- a/fs/efs/symlink.c
+++ b/fs/efs/symlink.c
@@ -26,13 +26,13 @@ static int efs_symlink_readpage(struct file *file, struct page *page)
   
 	/* read first 512 bytes of link target */
 	err = -EIO;
-	bh = sb_bread(inode->i_sb, efs_bmap(inode, 0));
+	bh = sb_bread(inode_sb(inode), efs_bmap(inode, 0));
 	if (!bh)
 		goto fail;
 	memcpy(link, bh->b_data, (size > EFS_BLOCKSIZE) ? EFS_BLOCKSIZE : size);
 	brelse(bh);
 	if (size > EFS_BLOCKSIZE) {
-		bh = sb_bread(inode->i_sb, efs_bmap(inode, 1));
+		bh = sb_bread(inode_sb(inode), efs_bmap(inode, 1));
 		if (!bh)
 			goto fail;
 		memcpy(link + EFS_BLOCKSIZE, bh->b_data, size - EFS_BLOCKSIZE);
-- 
2.15.1
