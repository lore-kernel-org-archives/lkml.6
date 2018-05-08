Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeEHSF0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53949 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755588AbeEHSFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:21 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 23/76] fs/cramfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:43 -0700
Message-Id: <20180508180436.716-24-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/cramfs/inode.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 017b0ab19bc4..eb633de7ccbe 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -294,7 +294,7 @@ static void *cramfs_read(struct super_block *sb, unsigned int offset,
  */
 static u32 cramfs_get_block_range(struct inode *inode, u32 pgoff, u32 *pages)
 {
-	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
+	struct cramfs_sb_info *sbi = CRAMFS_SB(inode_sb(inode));
 	int i;
 	u32 *blockptrs, first_block_addr;
 
@@ -335,7 +335,7 @@ static u32 cramfs_get_block_range(struct inode *inode, u32 pgoff, u32 *pages)
  */
 static bool cramfs_last_page_is_shared(struct inode *inode)
 {
-	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
+	struct cramfs_sb_info *sbi = CRAMFS_SB(inode_sb(inode));
 	u32 partial, last_page, blockaddr, *blockptrs;
 	char *tail_data;
 
@@ -353,7 +353,7 @@ static bool cramfs_last_page_is_shared(struct inode *inode)
 static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
-	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
+	struct cramfs_sb_info *sbi = CRAMFS_SB(inode_sb(inode));
 	unsigned int pages, max_pages, offset;
 	unsigned long address, pgoff = vma->vm_pgoff;
 	char *bailout_reason;
@@ -451,7 +451,7 @@ static unsigned long cramfs_physmem_get_unmapped_area(struct file *file,
 			unsigned long pgoff, unsigned long flags)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct cramfs_sb_info *sbi = CRAMFS_SB(sb);
 	unsigned int pages, block_pages, max_pages, offset;
 
@@ -696,7 +696,7 @@ static int cramfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static int cramfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	char *buf;
 	unsigned int offset;
 
@@ -763,14 +763,15 @@ static struct dentry *cramfs_lookup(struct inode *dir, struct dentry *dentry, un
 	int sorted;
 
 	mutex_lock(&read_mutex);
-	sorted = CRAMFS_SB(dir->i_sb)->flags & CRAMFS_FLAG_SORTED_DIRS;
+	sorted = CRAMFS_SB(inode_sb(dir))->flags & CRAMFS_FLAG_SORTED_DIRS;
 	while (offset < dir->i_size) {
 		struct cramfs_inode *de;
 		char *name;
 		int namelen, retval;
 		int dir_off = OFFSET(dir) + offset;
 
-		de = cramfs_read(dir->i_sb, dir_off, sizeof(*de)+CRAMFS_MAXPATHLEN);
+		de = cramfs_read(inode_sb(dir), dir_off,
+				 sizeof(*de)+CRAMFS_MAXPATHLEN);
 		name = (char *)(de+1);
 
 		/* Try to take advantage of sorted directories */
@@ -799,7 +800,7 @@ static struct dentry *cramfs_lookup(struct inode *dir, struct dentry *dentry, un
 		if (retval > 0)
 			continue;
 		if (!retval) {
-			inode = get_cramfs_inode(dir->i_sb, de, dir_off);
+			inode = get_cramfs_inode(inode_sb(dir), de, dir_off);
 			break;
 		}
 		/* else (retval < 0) */
@@ -826,7 +827,7 @@ static int cramfs_readpage(struct file *file, struct page *page)
 	pgdata = kmap(page);
 
 	if (page->index < maxblock) {
-		struct super_block *sb = inode->i_sb;
+		struct super_block *sb = inode_sb(inode);
 		u32 blkptr_offset = OFFSET(inode) + page->index * 4;
 		u32 block_ptr, block_start, block_len;
 		bool uncompressed, direct;
-- 
2.15.1
