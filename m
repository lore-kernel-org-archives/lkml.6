Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbeEHSFj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54013 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932460AbeEHSF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:29 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 28/76] fs/exofs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:48 -0700
Message-Id: <20180508180436.716-29-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/exofs/dir.c   |  6 +++---
 fs/exofs/inode.c | 12 ++++++------
 fs/exofs/namei.c |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/exofs/dir.c b/fs/exofs/dir.c
index f0138674c1ed..592471362243 100644
--- a/fs/exofs/dir.c
+++ b/fs/exofs/dir.c
@@ -36,7 +36,7 @@
 
 static inline unsigned exofs_chunk_size(struct inode *inode)
 {
-	return inode->i_sb->s_blocksize;
+	return inode_sb(inode)->s_blocksize;
 }
 
 static inline void exofs_put_page(struct page *page)
@@ -430,7 +430,7 @@ int exofs_add_link(struct dentry *dentry, struct inode *inode)
 	unsigned reclen = EXOFS_DIR_REC_LEN(namelen);
 	unsigned short rec_len, name_len;
 	struct page *page = NULL;
-	struct exofs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct exofs_sb_info *sbi = inode_sb(inode)->s_fs_info;
 	struct exofs_dir_entry *de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
@@ -520,7 +520,7 @@ int exofs_delete_entry(struct exofs_dir_entry *dir, struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
-	struct exofs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct exofs_sb_info *sbi = inode_sb(inode)->s_fs_info;
 	char *kaddr = page_address(page);
 	unsigned from = ((char *)dir - kaddr) & ~(exofs_chunk_size(inode)-1);
 	unsigned to = ((char *)dir - kaddr) + le16_to_cpu(dir->rec_len);
diff --git a/fs/exofs/inode.c b/fs/exofs/inode.c
index 0ac62811b341..c52a83f76a7a 100644
--- a/fs/exofs/inode.c
+++ b/fs/exofs/inode.c
@@ -66,7 +66,7 @@ struct page_collect {
 static void _pcol_init(struct page_collect *pcol, unsigned expected_pages,
 		       struct inode *inode)
 {
-	struct exofs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct exofs_sb_info *sbi = inode_sb(inode)->s_fs_info;
 
 	pcol->sbi = sbi;
 	pcol->inode = inode;
@@ -996,7 +996,7 @@ static inline int exofs_inode_is_fast_symlink(struct inode *inode)
 static int _do_truncate(struct inode *inode, loff_t newsize)
 {
 	struct exofs_i_info *oi = exofs_i(inode);
-	struct exofs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct exofs_sb_info *sbi = inode_sb(inode)->s_fs_info;
 	int ret;
 
 	inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -1256,7 +1256,7 @@ static void create_done(struct ore_io_state *ios, void *p)
 {
 	struct inode *inode = p;
 	struct exofs_i_info *oi = exofs_i(inode);
-	struct exofs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct exofs_sb_info *sbi = inode_sb(inode)->s_fs_info;
 	int ret;
 
 	ret = ore_check_io(ios, NULL);
@@ -1286,7 +1286,7 @@ static void create_done(struct ore_io_state *ios, void *p)
  */
 struct inode *exofs_new_inode(struct inode *dir, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct exofs_sb_info *sbi = sb->s_fs_info;
 	struct inode *inode;
 	struct exofs_i_info *oi;
@@ -1366,7 +1366,7 @@ static void updatei_done(struct ore_io_state *ios, void *p)
 static int exofs_update_inode(struct inode *inode, int do_sync)
 {
 	struct exofs_i_info *oi = exofs_i(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct exofs_sb_info *sbi = sb->s_fs_info;
 	struct ore_io_state *ios;
 	struct osd_attr attr;
@@ -1468,7 +1468,7 @@ static void delete_done(struct ore_io_state *ios, void *p)
 void exofs_evict_inode(struct inode *inode)
 {
 	struct exofs_i_info *oi = exofs_i(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct exofs_sb_info *sbi = sb->s_fs_info;
 	struct ore_io_state *ios;
 	int ret;
diff --git a/fs/exofs/namei.c b/fs/exofs/namei.c
index 7295cd722770..655400486da5 100644
--- a/fs/exofs/namei.c
+++ b/fs/exofs/namei.c
@@ -55,7 +55,7 @@ static struct dentry *exofs_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = exofs_inode_by_name(dir, dentry);
-	inode = ino ? exofs_iget(dir->i_sb, ino) : NULL;
+	inode = ino ? exofs_iget(inode_sb(dir), ino) : NULL;
 	return d_splice_alias(inode, dentry);
 }
 
@@ -93,7 +93,7 @@ static int exofs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int exofs_symlink(struct inode *dir, struct dentry *dentry,
 			  const char *symname)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	int err = -ENAMETOOLONG;
 	unsigned l = strlen(symname)+1;
 	struct inode *inode;
-- 
2.15.1
