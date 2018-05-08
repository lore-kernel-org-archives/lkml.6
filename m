Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbeEHShF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:37:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755428AbeEHSFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:11 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 16/76] fs/befs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:36 -0700
Message-Id: <20180508180436.716-17-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/befs/linuxvfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index af2832aaeec5..fc997025b9a0 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -131,7 +131,7 @@ static int
 befs_get_block(struct inode *inode, sector_t block,
 	       struct buffer_head *bh_result, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	befs_data_stream *ds = &BEFS_I(inode)->i_data.ds;
 	befs_block_run run = BAD_IADDR;
 	int res;
@@ -157,7 +157,7 @@ befs_get_block(struct inode *inode, sector_t block,
 
 	disk_off = (ulong) iaddr2blockno(sb, &run);
 
-	map_bh(bh_result, inode->i_sb, disk_off);
+	map_bh(bh_result, inode_sb(inode), disk_off);
 
 	befs_debug(sb, "<--- %s for inode %lu, block %ld, disk address %lu",
 		  __func__, (unsigned long)inode->i_ino, (long)block,
@@ -170,7 +170,7 @@ static struct dentry *
 befs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	const befs_data_stream *ds = &BEFS_I(dir)->i_data.ds;
 	befs_off_t offset;
 	int ret;
@@ -206,7 +206,7 @@ befs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 		return ERR_PTR(-ENODATA);
 	}
 
-	inode = befs_iget(dir->i_sb, (ino_t) offset);
+	inode = befs_iget(inode_sb(dir), (ino_t) offset);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
@@ -221,7 +221,7 @@ static int
 befs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	const befs_data_stream *ds = &BEFS_I(inode)->i_data.ds;
 	befs_off_t value;
 	int result;
@@ -482,7 +482,7 @@ befs_destroy_inodecache(void)
 static int befs_symlink_readpage(struct file *unused, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct befs_inode_info *befs_ino = BEFS_I(inode);
 	befs_data_stream *data = &befs_ino->i_data.ds;
 	befs_off_t len = data->size;
-- 
2.15.1
