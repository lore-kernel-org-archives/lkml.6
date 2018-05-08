Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932943AbeEHSG3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932841AbeEHSGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:23 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 66/76] fs/romfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:26 -0700
Message-Id: <20180508180436.716-67-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/romfs/mmap-nommu.c |  4 ++--
 fs/romfs/super.c      | 24 +++++++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
index 1118a0dc6b45..0dbf9be30283 100644
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -26,7 +26,7 @@ static unsigned long romfs_get_unmapped_area(struct file *file,
 					     unsigned long flags)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct mtd_info *mtd = inode->i_sb->s_mtd;
+	struct mtd_info *mtd = inode_sb(inode)->s_mtd;
 	unsigned long isize, offset, maxpages, lpages;
 	int ret;
 
@@ -72,7 +72,7 @@ static int romfs_mmap(struct file *file, struct vm_area_struct *vma)
 
 static unsigned romfs_mmap_capabilities(struct file *file)
 {
-	struct mtd_info *mtd = file_inode(file)->i_sb->s_mtd;
+	struct mtd_info *mtd = inode_sb(file_inode(file))->s_mtd;
 
 	if (!mtd)
 		return NOMMU_MAP_COPY;
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 8f06fd1f3d69..eb0b7d3775bb 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -122,7 +122,7 @@ static int romfs_readpage(struct file *file, struct page *page)
 
 		pos = ROMFS_I(inode)->i_dataoffset + offset;
 
-		ret = romfs_dev_read(inode->i_sb, pos, buf, fillsize);
+		ret = romfs_dev_read(inode_sb(inode), pos, buf, fillsize);
 		if (ret < 0) {
 			SetPageError(page);
 			fillsize = 0;
@@ -157,12 +157,12 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
 	char fsname[ROMFS_MAXFN];	/* XXX dynamic? */
 	int ret;
 
-	maxoff = romfs_maxsize(i->i_sb);
+	maxoff = romfs_maxsize(inode_sb(i));
 
 	offset = ctx->pos;
 	if (!offset) {
 		offset = i->i_ino & ROMFH_MASK;
-		ret = romfs_dev_read(i->i_sb, offset, &ri, ROMFH_SIZE);
+		ret = romfs_dev_read(inode_sb(i), offset, &ri, ROMFH_SIZE);
 		if (ret < 0)
 			goto out;
 		offset = be32_to_cpu(ri.spec) & ROMFH_MASK;
@@ -178,16 +178,17 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = offset;
 
 		/* Fetch inode info */
-		ret = romfs_dev_read(i->i_sb, offset, &ri, ROMFH_SIZE);
+		ret = romfs_dev_read(inode_sb(i), offset, &ri, ROMFH_SIZE);
 		if (ret < 0)
 			goto out;
 
-		j = romfs_dev_strnlen(i->i_sb, offset + ROMFH_SIZE,
+		j = romfs_dev_strnlen(inode_sb(i), offset + ROMFH_SIZE,
 				      sizeof(fsname) - 1);
 		if (j < 0)
 			goto out;
 
-		ret = romfs_dev_read(i->i_sb, offset + ROMFH_SIZE, fsname, j);
+		ret = romfs_dev_read(inode_sb(i), offset + ROMFH_SIZE, fsname,
+				     j);
 		if (ret < 0)
 			goto out;
 		fsname[j] = '\0';
@@ -219,13 +220,13 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 	int len, ret;
 
 	offset = dir->i_ino & ROMFH_MASK;
-	ret = romfs_dev_read(dir->i_sb, offset, &ri, ROMFH_SIZE);
+	ret = romfs_dev_read(inode_sb(dir), offset, &ri, ROMFH_SIZE);
 	if (ret < 0)
 		goto error;
 
 	/* search all the file entries in the list starting from the one
 	 * pointed to by the directory's special data */
-	maxoff = romfs_maxsize(dir->i_sb);
+	maxoff = romfs_maxsize(inode_sb(dir));
 	offset = be32_to_cpu(ri.spec) & ROMFH_MASK;
 
 	name = dentry->d_name.name;
@@ -235,12 +236,13 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (!offset || offset >= maxoff)
 			goto out0;
 
-		ret = romfs_dev_read(dir->i_sb, offset, &ri, sizeof(ri));
+		ret = romfs_dev_read(inode_sb(dir), offset, &ri, sizeof(ri));
 		if (ret < 0)
 			goto error;
 
 		/* try to match the first 16 bytes of name */
-		ret = romfs_dev_strcmp(dir->i_sb, offset + ROMFH_SIZE, name,
+		ret = romfs_dev_strcmp(inode_sb(dir), offset + ROMFH_SIZE,
+				       name,
 				       len);
 		if (ret < 0)
 			goto error;
@@ -255,7 +257,7 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 	if ((be32_to_cpu(ri.next) & ROMFH_TYPE) == ROMFH_HRD)
 		offset = be32_to_cpu(ri.spec) & ROMFH_MASK;
 
-	inode = romfs_iget(dir->i_sb, offset);
+	inode = romfs_iget(inode_sb(dir), offset);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto error;
-- 
2.15.1
