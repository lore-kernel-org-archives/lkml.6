Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756068AbeEHSav (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:30:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54049 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932660AbeEHSFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:39 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 35/76] fs/fuse: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:55 -0700
Message-Id: <20180508180436.716-36-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/fuse/dir.c    | 13 +++++++------
 fs/fuse/file.c   |  6 +++---
 fs/fuse/fuse_i.h |  2 +-
 fs/fuse/inode.c  |  7 ++++---
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 24967382a7b1..b68adb3bd70d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -357,7 +357,8 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	bool outarg_valid = true;
 
 	fuse_lock_inode(dir);
-	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
+	err = fuse_lookup_name(inode_sb(dir), get_node_id(dir),
+			       &entry->d_name,
 			       &outarg, &inode);
 	fuse_unlock_inode(dir);
 	if (err == -ENOENT) {
@@ -456,7 +457,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->fh = outopen.fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
-	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
+	inode = fuse_iget(inode_sb(dir), outentry.nodeid, outentry.generation,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
@@ -562,7 +563,7 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
 		goto out_put_forget_req;
 
-	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
+	inode = fuse_iget(inode_sb(dir), outarg.nodeid, outarg.generation,
 			  &outarg.attr, entry_attr_timeout(&outarg), 0);
 	if (!inode) {
 		fuse_queue_forget(fc, forget, outarg.nodeid, 1);
@@ -854,7 +855,7 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 		attr->ctimensec = inode->i_ctime.tv_nsec;
 	}
 
-	stat->dev = inode->i_sb->s_dev;
+	stat->dev = inode_sb(inode)->s_dev;
 	stat->ino = attr->ino;
 	stat->mode = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
 	stat->nlink = attr->nlink;
@@ -873,7 +874,7 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = inode->i_sb->s_blocksize_bits;
+		blkbits = inode_sb(inode)->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
 }
@@ -1255,7 +1256,7 @@ static int fuse_direntplus_link(struct file *file,
 		 * which bumps nlookup inside
 		 */
 	} else {
-		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
+		inode = fuse_iget(inode_sb(dir), o->nodeid, o->generation,
 				  &o->attr, entry_attr_timeout(o),
 				  attr_version);
 		if (!inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a201fb0ac64f..14e55c348da7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2250,12 +2250,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
-	if (!inode->i_sb->s_bdev || fc->no_bmap)
+	if (!inode_sb(inode)->s_bdev || fc->no_bmap)
 		return 0;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.block = block;
-	inarg.blocksize = inode->i_sb->s_blocksize;
+	inarg.blocksize = inode_sb(inode)->s_blocksize;
 	args.in.h.opcode = FUSE_BMAP;
 	args.in.h.nodeid = get_node_id(inode);
 	args.in.numargs = 1;
@@ -2305,7 +2305,7 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 		return err;
 	}
 
-	return vfs_setpos(file, outarg.offset, inode->i_sb->s_maxbytes);
+	return vfs_setpos(file, outarg.offset, inode_sb(inode)->s_maxbytes);
 
 fallback:
 	err = fuse_update_attributes(inode, file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c4c093bbf456..5ea9ddb9fa19 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -674,7 +674,7 @@ static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
 
 static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
 {
-	return get_fuse_conn_super(inode->i_sb);
+	return get_fuse_conn_super(inode_sb(inode));
 }
 
 static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..d6d2fbe6c3ec 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -130,7 +130,7 @@ static void fuse_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
-	if (inode->i_sb->s_flags & SB_ACTIVE) {
+	if (inode_sb(inode)->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_inode *fi = get_fuse_inode(inode);
 		fuse_queue_forget(fc, fi->forget, fi->nodeid, fi->nlookup);
@@ -187,7 +187,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize != 0)
 		inode->i_blkbits = ilog2(attr->blksize);
 	else
-		inode->i_blkbits = inode->i_sb->s_blocksize_bits;
+		inode->i_blkbits = inode_sb(inode)->s_blocksize_bits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -778,7 +778,8 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	if (!fc->export_support)
 		return ERR_PTR(-ESTALE);
 
-	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
+	err = fuse_lookup_name(inode_sb(child_inode),
+			       get_node_id(child_inode),
 			       &name, &outarg, &inode);
 	if (err) {
 		if (err == -ENOENT)
-- 
2.15.1
