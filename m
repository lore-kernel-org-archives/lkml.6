Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756024AbeEHSbX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54045 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932643AbeEHSFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:38 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 34/76] fs/freevxfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:54 -0700
Message-Id: <20180508180436.716-35-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/freevxfs/vxfs_bmap.c   | 14 +++++++-------
 fs/freevxfs/vxfs_inode.c  |  2 +-
 fs/freevxfs/vxfs_lookup.c | 10 +++++-----
 fs/freevxfs/vxfs_subr.c   |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index 1fd41cf98b9f..55cfb03efb35 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -66,7 +66,7 @@ vxfs_typdump(struct vxfs_typed *typ)
 static daddr_t
 vxfs_bmap_ext4(struct inode *ip, long bn)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	struct vxfs_inode_info *vip = VXFS_INO(ip);
 	struct vxfs_sb_info *sbi = VXFS_SBI(sb);
 	unsigned long bsize = sb->s_blocksize;
@@ -130,22 +130,22 @@ vxfs_bmap_ext4(struct inode *ip, long bn)
 static daddr_t
 vxfs_bmap_indir(struct inode *ip, long indir, int size, long block)
 {
-	struct vxfs_sb_info		*sbi = VXFS_SBI(ip->i_sb);
+	struct vxfs_sb_info		*sbi = VXFS_SBI(inode_sb(ip));
 	struct buffer_head		*bp = NULL;
 	daddr_t				pblock = 0;
 	int				i;
 
-	for (i = 0; i < size * VXFS_TYPED_PER_BLOCK(ip->i_sb); i++) {
+	for (i = 0; i < size * VXFS_TYPED_PER_BLOCK(inode_sb(ip)); i++) {
 		struct vxfs_typed	*typ;
 		int64_t			off;
 
-		bp = sb_bread(ip->i_sb,
-				indir + (i / VXFS_TYPED_PER_BLOCK(ip->i_sb)));
+		bp = sb_bread(inode_sb(ip),
+				indir + (i / VXFS_TYPED_PER_BLOCK(inode_sb(ip))));
 		if (!bp || !buffer_mapped(bp))
 			return 0;
 
 		typ = ((struct vxfs_typed *)bp->b_data) +
-			(i % VXFS_TYPED_PER_BLOCK(ip->i_sb));
+			(i % VXFS_TYPED_PER_BLOCK(inode_sb(ip)));
 		off = fs64_to_cpu(sbi, typ->vt_hdr) & VXFS_TYPED_OFFSETMASK;
 
 		if (block < off) {
@@ -210,7 +210,7 @@ static daddr_t
 vxfs_bmap_typed(struct inode *ip, long iblock)
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(ip);
-	struct vxfs_sb_info		*sbi = VXFS_SBI(ip->i_sb);
+	struct vxfs_sb_info		*sbi = VXFS_SBI(inode_sb(ip));
 	daddr_t				pblock = 0;
 	int				i;
 
diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
index 1f41b25ef38b..fdb36340a25f 100644
--- a/fs/freevxfs/vxfs_inode.c
+++ b/fs/freevxfs/vxfs_inode.c
@@ -221,7 +221,7 @@ __vxfs_iget(struct inode *ilistp, struct vxfs_inode_info *vip, ino_t ino)
 		caddr_t			kaddr = (char *)page_address(pp);
 
 		dip = (struct vxfs_dinode *)(kaddr + offset);
-		dip2vip_cpy(VXFS_SBI(ilistp->i_sb), vip, dip);
+		dip2vip_cpy(VXFS_SBI(inode_sb(ilistp)), vip, dip);
 		vip->vfs_inode.i_mapping->a_ops = &vxfs_aops;
 #ifdef DIAGNOSTIC
 		vxfs_dumpi(vip, ino);
diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index ce4785fd81c6..f2011edf525c 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -80,13 +80,13 @@ const struct file_operations vxfs_dir_operations = {
 static struct vxfs_direct *
 vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 {
-	u_long bsize = ip->i_sb->s_blocksize;
+	u_long bsize = inode_sb(ip)->s_blocksize;
 	const char *name = dp->d_name.name;
 	int namelen = dp->d_name.len;
 	loff_t limit = VXFS_DIRROUND(ip->i_size);
 	struct vxfs_direct *de_exit = NULL;
 	loff_t pos = 0;
-	struct vxfs_sb_info *sbi = VXFS_SBI(ip->i_sb);
+	struct vxfs_sb_info *sbi = VXFS_SBI(inode_sb(ip));
 
 	while (pos < limit) {
 		struct page *pp;
@@ -161,7 +161,7 @@ vxfs_inode_by_name(struct inode *dip, struct dentry *dp)
 
 	de = vxfs_find_entry(dip, dp, &pp);
 	if (de) {
-		ino = fs32_to_cpu(VXFS_SBI(dip->i_sb), de->d_ino);
+		ino = fs32_to_cpu(VXFS_SBI(inode_sb(dip)), de->d_ino);
 		kunmap(pp);
 		put_page(pp);
 	}
@@ -194,7 +194,7 @@ vxfs_lookup(struct inode *dip, struct dentry *dp, unsigned int flags)
 				 
 	ino = vxfs_inode_by_name(dip, dp);
 	if (ino) {
-		ip = vxfs_iget(dip->i_sb, ino);
+		ip = vxfs_iget(inode_sb(dip), ino);
 		if (IS_ERR(ip))
 			return ERR_CAST(ip);
 	}
@@ -219,7 +219,7 @@ static int
 vxfs_readdir(struct file *fp, struct dir_context *ctx)
 {
 	struct inode		*ip = file_inode(fp);
-	struct super_block	*sbp = ip->i_sb;
+	struct super_block	*sbp = inode_sb(ip);
 	u_long			bsize = sbp->s_blocksize;
 	loff_t			pos, limit;
 	struct vxfs_sb_info	*sbi = VXFS_SBI(sbp);
diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index e806694d4145..8dfa00bd783c 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -105,7 +105,7 @@ vxfs_bread(struct inode *ip, int block)
 	daddr_t			pblock;
 
 	pblock = vxfs_bmap1(ip, block);
-	bp = sb_bread(ip->i_sb, pblock);
+	bp = sb_bread(inode_sb(ip), pblock);
 
 	return (bp);
 }
@@ -133,7 +133,7 @@ vxfs_getblk(struct inode *ip, sector_t iblock,
 
 	pblock = vxfs_bmap1(ip, iblock);
 	if (pblock != 0) {
-		map_bh(bp, ip->i_sb, pblock);
+		map_bh(bp, inode_sb(ip), pblock);
 		return 0;
 	}
 
-- 
2.15.1
