Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756309AbeEHSii (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:38:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:53891 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755478AbeEHSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:06 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 12/76] fs/adfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:32 -0700
Message-Id: <20180508180436.716-13-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/adfs/dir.c   | 6 +++---
 fs/adfs/inode.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 29444c83da48..e28357fcb2d4 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -20,7 +20,7 @@ static int
 adfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	const struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct object_info obj;
 	struct adfs_dir dir;
@@ -128,7 +128,7 @@ adfs_match(const struct qstr *name, struct object_info *obj)
 static int
 adfs_dir_lookup_byname(struct inode *inode, const struct qstr *name, struct object_info *obj)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	const struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct adfs_dir dir;
 	int ret;
@@ -271,7 +271,7 @@ adfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 		 * This only returns NULL if get_empty_inode
 		 * fails.
 		 */
-		inode = adfs_iget(dir->i_sb, &obj);
+		inode = adfs_iget(inode_sb(dir), &obj);
 		if (inode)
 			error = 0;
 	}
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 8dbd36f5e581..c946b072ef7f 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -23,9 +23,9 @@ adfs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh,
 		if (block >= inode->i_blocks)
 			goto abort_toobig;
 
-		block = __adfs_block_map(inode->i_sb, inode->i_ino, block);
+		block = __adfs_block_map(inode_sb(inode), inode->i_ino, block);
 		if (block)
-			map_bh(bh, inode->i_sb, block);
+			map_bh(bh, inode_sb(inode), block);
 		return 0;
 	}
 	/* don't support allocation of blocks yet */
@@ -299,7 +299,7 @@ int
 adfs_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned int ia_valid = attr->ia_valid;
 	int error;
 	
@@ -354,7 +354,7 @@ adfs_notify_change(struct dentry *dentry, struct iattr *attr)
  */
 int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct object_info obj;
 	int ret;
 
-- 
2.15.1
