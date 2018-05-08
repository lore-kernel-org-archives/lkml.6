Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeEHSFn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:54053 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932460AbeEHSFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:41 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 36/76] fs/gfs2: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:56 -0700
Message-Id: <20180508180436.716-37-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/gfs2/aops.c    | 9 +++++----
 fs/gfs2/bmap.c    | 9 +++++----
 fs/gfs2/dir.c     | 3 ++-
 fs/gfs2/export.c  | 2 +-
 fs/gfs2/file.c    | 4 ++--
 fs/gfs2/incore.h  | 2 +-
 fs/gfs2/inode.c   | 8 ++++----
 fs/gfs2/meta_io.h | 2 +-
 fs/gfs2/super.c   | 2 +-
 9 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 2f725b4a386b..bd771df8b227 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -189,7 +189,8 @@ static int __gfs2_jdata_writepage(struct page *page, struct writeback_control *w
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
 		if (!page_has_buffers(page)) {
-			create_empty_buffers(page, inode->i_sb->s_blocksize,
+			create_empty_buffers(page,
+					     inode_sb(inode)->s_blocksize,
 					     BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
 		gfs2_page_add_databufs(ip, page, 0, sdp->sd_vfs->s_blocksize);
@@ -271,7 +272,7 @@ static int gfs2_write_jdata_pagevec(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	unsigned nrblocks = nr_pages * (PAGE_SIZE/inode->i_sb->s_blocksize);
+	unsigned nrblocks = nr_pages * (PAGE_SIZE/inode_sb(inode)->s_blocksize);
 	int i;
 	int ret;
 
@@ -776,7 +777,7 @@ static int gfs2_write_begin(struct file *file, struct address_space *mapping,
  */
 static void adjust_fs_space(struct inode *inode)
 {
-	struct gfs2_sbd *sdp = inode->i_sb->s_fs_info;
+	struct gfs2_sbd *sdp = inode_sb(inode)->s_fs_info;
 	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
 	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
@@ -1112,7 +1113,7 @@ static ssize_t gfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			truncate_inode_pages_range(mapping, lstart, end);
 	}
 
-	rv = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
+	rv = __blockdev_direct_IO(iocb, inode, inode_sb(inode)->s_bdev, iter,
 				  gfs2_get_block_direct, NULL, NULL, 0);
 out:
 	gfs2_glock_dq(&gh);
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51f940e76c5e..f523d2e7a71a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -86,7 +86,7 @@ static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
 	bh = page_buffers(page);
 
 	if (!buffer_mapped(bh))
-		map_bh(bh, inode->i_sb, block);
+		map_bh(bh, inode_sb(inode), block);
 
 	set_buffer_uptodate(bh);
 	if (!gfs2_is_jdata(ip))
@@ -856,7 +856,8 @@ int gfs2_block_map(struct inode *inode, sector_t lblock,
 		iomap.flags &= ~IOMAP_F_BOUNDARY;
 	}
 	if (iomap.addr != IOMAP_NULL_ADDR)
-		map_bh(bh_map, inode->i_sb, iomap.addr >> inode->i_blkbits);
+		map_bh(bh_map, inode_sb(inode),
+		       iomap.addr >> inode->i_blkbits);
 	bh_map->b_size = iomap.length;
 	if (iomap.flags & IOMAP_F_BOUNDARY)
 		set_buffer_boundary(bh_map);
@@ -913,8 +914,8 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 	if (!page)
 		return 0;
 
-	blocksize = inode->i_sb->s_blocksize;
-	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+	blocksize = inode_sb(inode)->s_blocksize;
+	iblock = index << (PAGE_SHIFT - inode_sb(inode)->s_blocksize_bits);
 
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 7c21aea0266b..5ab5ed92ce78 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1665,7 +1665,8 @@ struct inode *gfs2_dir_search(struct inode *dir, const struct qstr *name,
 		brelse(bh);
 		if (fail_on_exist)
 			return ERR_PTR(-EEXIST);
-		inode = gfs2_inode_lookup(dir->i_sb, dtype, addr, formal_ino,
+		inode = gfs2_inode_lookup(inode_sb(dir), dtype, addr,
+					  formal_ino,
 					  GFS2_BLKST_FREE /* ignore */);
 		if (!IS_ERR(inode))
 			GFS2_I(inode)->i_rahead = rahead;
diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index a332f3cd925e..42e7f8e30683 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -32,7 +32,7 @@ static int gfs2_encode_fh(struct inode *inode, __u32 *p, int *len,
 			  struct inode *parent)
 {
 	__be32 *fh = (__force __be32 *)p;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 
 	if (parent && (*len < GFS2_LARGE_FH_SIZE)) {
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 4f88e201b3f0..ed7dc7ca8cbf 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -401,7 +401,7 @@ static int gfs2_page_mkwrite(struct vm_fault *vmf)
 	loff_t size;
 	int ret;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 
 	ret = gfs2_rsqa_alloc(ip);
 	if (ret)
@@ -492,7 +492,7 @@ static int gfs2_page_mkwrite(struct vm_fault *vmf)
 		wait_for_stable_page(page);
 	}
 out:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return block_page_mkwrite_return(ret);
 }
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e0557b8a590a..b548684449fa 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -424,7 +424,7 @@ static inline struct gfs2_inode *GFS2_I(struct inode *inode)
 
 static inline struct gfs2_sbd *GFS2_SB(const struct inode *inode)
 {
-	return inode->i_sb->s_fs_info;
+	return inode_sb(inode)->s_fs_info;
 }
 
 struct gfs2_file {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 59e0560180ec..9f6f63bb987d 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -280,7 +280,7 @@ struct inode *gfs2_lookup_simple(struct inode *dip, const char *name)
 struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 			   int is_root)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct gfs2_inode *dip = GFS2_I(dir);
 	struct gfs2_holder d_gh;
 	int error = 0;
@@ -1279,7 +1279,7 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 static int gfs2_ok_to_move(struct gfs2_inode *this, struct gfs2_inode *to)
 {
 	struct inode *dir = &to->i_inode;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode *tmp;
 	int error = 0;
 
@@ -2056,7 +2056,7 @@ loff_t gfs2_seek_data(struct file *file, loff_t offset)
 
 	if (ret < 0)
 		return ret;
-	return vfs_setpos(file, ret, inode->i_sb->s_maxbytes);
+	return vfs_setpos(file, ret, inode_sb(inode)->s_maxbytes);
 }
 
 loff_t gfs2_seek_hole(struct file *file, loff_t offset)
@@ -2075,7 +2075,7 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 
 	if (ret < 0)
 		return ret;
-	return vfs_setpos(file, ret, inode->i_sb->s_maxbytes);
+	return vfs_setpos(file, ret, inode_sb(inode)->s_maxbytes);
 }
 
 const struct inode_operations gfs2_file_iops = {
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index ffdf6aa3509d..fecae733bb95 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -48,7 +48,7 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 	else if (mapping->a_ops == &gfs2_rgrp_aops)
 		return container_of(mapping, struct gfs2_sbd, sd_aspace);
 	else
-		return inode->i_sb->s_fs_info;
+		return inode_sb(inode)->s_fs_info;
 }
 
 extern struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 620be0521866..296952eea729 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1568,7 +1568,7 @@ static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
 
 static void gfs2_evict_inode(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
-- 
2.15.1
