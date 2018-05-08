Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755979AbeEHS1S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755697AbeEHSFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:54 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 45/76] fs/jfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:05 -0700
Message-Id: <20180508180436.716-46-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/jfs/acl.c          |   2 +-
 fs/jfs/file.c         |   6 +--
 fs/jfs/inode.c        |  14 +++----
 fs/jfs/ioctl.c        |   2 +-
 fs/jfs/jfs_discard.c  |  12 +++---
 fs/jfs/jfs_dmap.c     | 104 +++++++++++++++++++++++++------------------------
 fs/jfs/jfs_dmap.h     |   2 +-
 fs/jfs/jfs_dtree.c    |  30 +++++++--------
 fs/jfs/jfs_dtree.h    |   2 +-
 fs/jfs/jfs_extent.c   |  18 ++++-----
 fs/jfs/jfs_imap.c     | 105 ++++++++++++++++++++++++++------------------------
 fs/jfs/jfs_incore.h   |   2 +-
 fs/jfs/jfs_inode.c    |   2 +-
 fs/jfs/jfs_metapage.c |  20 +++++-----
 fs/jfs/jfs_txnmgr.c   |  12 +++---
 fs/jfs/jfs_xtree.c    |  65 ++++++++++++++++---------------
 fs/jfs/namei.c        |  26 ++++++-------
 fs/jfs/super.c        |   2 +-
 fs/jfs/xattr.c        |   8 ++--
 19 files changed, 222 insertions(+), 212 deletions(-)

diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 2e71b6e7e646..051c24c59ffa 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -111,7 +111,7 @@ int jfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	int update_mode = 0;
 	umode_t mode = inode->i_mode;
 
-	tid = txBegin(inode->i_sb, 0);
+	tid = txBegin(inode_sb(inode), 0);
 	mutex_lock(&JFS_IP(inode)->commit_mutex);
 	if (type == ACL_TYPE_ACCESS && acl) {
 		rc = posix_acl_update_mode(inode, &mode, &acl);
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 36665fd37095..b4eb55e2b291 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -42,7 +42,7 @@ int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (!(inode->i_state & I_DIRTY_ALL) ||
 	    (datasync && !(inode->i_state & I_DIRTY_DATASYNC))) {
 		/* Make sure committed changes hit the disk */
-		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, 1);
+		jfs_flush_journal(JFS_SBI(inode_sb(inode))->log, 1);
 		inode_unlock(inode);
 		return rc;
 	}
@@ -74,7 +74,7 @@ static int jfs_open(struct inode *inode, struct file *file)
 		struct jfs_inode_info *ji = JFS_IP(inode);
 		spin_lock_irq(&ji->ag_lock);
 		if (ji->active_ag == -1) {
-			struct jfs_sb_info *jfs_sb = JFS_SBI(inode->i_sb);
+			struct jfs_sb_info *jfs_sb = JFS_SBI(inode_sb(inode));
 			ji->active_ag = BLKTOAG(addressPXD(&ji->ixpxd), jfs_sb);
 			atomic_inc(&jfs_sb->bmap->db_active[ji->active_ag]);
 		}
@@ -89,7 +89,7 @@ static int jfs_release(struct inode *inode, struct file *file)
 
 	spin_lock_irq(&ji->ag_lock);
 	if (ji->active_ag != -1) {
-		struct bmap *bmap = JFS_SBI(inode->i_sb)->bmap;
+		struct bmap *bmap = JFS_SBI(inode_sb(inode))->bmap;
 		atomic_dec(&bmap->db_active[ji->active_ag]);
 		ji->active_ag = -1;
 	}
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 054cc761b426..6cf6574c235c 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -110,7 +110,7 @@ int jfs_commit_inode(struct inode *inode, int wait)
 		return 0;
 	}
 
-	tid = txBegin(inode->i_sb, COMMIT_INODE);
+	tid = txBegin(inode_sb(inode), COMMIT_INODE);
 	mutex_lock(&JFS_IP(inode)->commit_mutex);
 
 	/*
@@ -137,7 +137,7 @@ int jfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 */
 	if (!test_cflag(COMMIT_Dirty, inode)) {
 		/* Make sure committed changes hit the disk */
-		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, wait);
+		jfs_flush_journal(JFS_SBI(inode_sb(inode))->log, wait);
 		return 0;
 	}
 
@@ -213,7 +213,7 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	else
 		IREAD_LOCK(ip, RDWRLOCK_NORMAL);
 
-	if (((lblock64 << ip->i_sb->s_blocksize_bits) < ip->i_size) &&
+	if (((lblock64 << inode_sb(ip)->s_blocksize_bits) < ip->i_size) &&
 	    (!xtLookup(ip, lblock64, xlen, &xflag, &xaddr, &xlen, 0)) &&
 	    xaddr) {
 		if (xflag & XAD_NOTRECORDED) {
@@ -241,7 +241,7 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 			set_buffer_new(bh_result);
 		}
 
-		map_bh(bh_result, ip->i_sb, xaddr);
+		map_bh(bh_result, inode_sb(ip), xaddr);
 		bh_result->b_size = xlen << ip->i_blkbits;
 		goto unlock;
 	}
@@ -252,14 +252,14 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	 * Allocate a new block
 	 */
 #ifdef _JFS_4K
-	if ((rc = extHint(ip, lblock64 << ip->i_sb->s_blocksize_bits, &xad)))
+	if ((rc = extHint(ip, lblock64 << inode_sb(ip)->s_blocksize_bits, &xad)))
 		goto unlock;
 	rc = extAlloc(ip, xlen, lblock64, &xad, false);
 	if (rc)
 		goto unlock;
 
 	set_buffer_new(bh_result);
-	map_bh(bh_result, ip->i_sb, addressXAD(&xad));
+	map_bh(bh_result, inode_sb(ip), addressXAD(&xad));
 	bh_result->b_size = lengthXAD(&xad) << ip->i_blkbits;
 
 #else				/* _JFS_4K */
@@ -385,7 +385,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
 	}
 
 	do {
-		tid = txBegin(ip->i_sb, 0);
+		tid = txBegin(inode_sb(ip), 0);
 
 		/*
 		 * The commit_mutex cannot be taken before txBegin.
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index ba34dae8bd9f..d2130d8ad594 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -129,7 +129,7 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case FITRIM:
 	{
-		struct super_block *sb = inode->i_sb;
+		struct super_block *sb = inode_sb(inode);
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
 		struct fstrim_range range;
 		s64 ret = 0;
diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index f76ff0a46444..b5f80e3426dd 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -44,7 +44,7 @@
  */
 void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	int r = 0;
 
 	r = sb_issue_discard(sb, blkno, nblocks, GFP_NOFS, 0);
@@ -77,9 +77,9 @@ void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
  */
 int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 {
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
-	struct super_block *sb = ipbmap->i_sb;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ip))->bmap;
+	struct super_block *sb = inode_sb(ipbmap);
 	int agno, agno_end;
 	u64 start, end, minlen;
 	u64 trimmed = 0;
@@ -107,8 +107,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	/**
 	 * we trim all ag's within the range
 	 */
-	agno = BLKTOAG(start, JFS_SBI(ip->i_sb));
-	agno_end = BLKTOAG(end, JFS_SBI(ip->i_sb));
+	agno = BLKTOAG(start, JFS_SBI(inode_sb(ip)));
+	agno_end = BLKTOAG(end, JFS_SBI(inode_sb(ip)));
 	while (agno <= agno_end) {
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 2d514c7affc2..da343532ed16 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -179,7 +179,7 @@ int dbMount(struct inode *ipbmap)
 
 	/* read the on-disk bmap descriptor. */
 	mp = read_metapage(ipbmap,
-			   BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
+			   BMAPBLKNO << JFS_SBI(inode_sb(ipbmap))->l2nbperpage,
 			   PSIZE, 0);
 	if (mp == NULL) {
 		kfree(bmp);
@@ -210,7 +210,7 @@ int dbMount(struct inode *ipbmap)
 
 	/* bind the bmap inode and the bmap descriptor to each other. */
 	bmp->db_ipbmap = ipbmap;
-	JFS_SBI(ipbmap->i_sb)->bmap = bmp;
+	JFS_SBI(inode_sb(ipbmap))->bmap = bmp;
 
 	memset(bmp->db_active, 0, sizeof(bmp->db_active));
 
@@ -241,7 +241,7 @@ int dbMount(struct inode *ipbmap)
  */
 int dbUnmount(struct inode *ipbmap, int mounterror)
 {
-	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ipbmap))->bmap;
 
 	if (!(mounterror || isReadOnly(ipbmap)))
 		dbSync(ipbmap);
@@ -263,7 +263,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
 int dbSync(struct inode *ipbmap)
 {
 	struct dbmap_disk *dbmp_le;
-	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ipbmap))->bmap;
 	struct metapage *mp;
 	int i;
 
@@ -272,7 +272,7 @@ int dbSync(struct inode *ipbmap)
 	 */
 	/* get the buffer for the on-disk bmap descriptor. */
 	mp = read_metapage(ipbmap,
-			   BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
+			   BMAPBLKNO << JFS_SBI(inode_sb(ipbmap))->l2nbperpage,
 			   PSIZE, 0);
 	if (mp == NULL) {
 		jfs_err("dbSync: read_metapage failed!");
@@ -334,9 +334,9 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 	struct dmap *dp;
 	int nb, rc;
 	s64 lblkno, rem;
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
-	struct super_block *sb = ipbmap->i_sb;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ip))->bmap;
+	struct super_block *sb = inode_sb(ipbmap);
 
 	IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
@@ -346,7 +346,8 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 		printk(KERN_ERR "blkno = %Lx, nblocks = %Lx\n",
 		       (unsigned long long) blkno,
 		       (unsigned long long) nblocks);
-		jfs_error(ip->i_sb, "block to be freed is outside the map\n");
+		jfs_error(inode_sb(ip),
+			  "block to be freed is outside the map\n");
 		return -EIO;
 	}
 
@@ -383,7 +384,7 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 
 		/* free the blocks. */
 		if ((rc = dbFreeDmap(bmp, dp, blkno, nb))) {
-			jfs_error(ip->i_sb, "error in block map\n");
+			jfs_error(inode_sb(ip), "error in block map\n");
 			release_metapage(mp);
 			IREAD_UNLOCK(ipbmap);
 			return (rc);
@@ -426,7 +427,7 @@ dbUpdatePMap(struct inode *ipbmap,
 {
 	int nblks, dbitno, wbitno, rbits;
 	int word, nbits, nwords;
-	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ipbmap))->bmap;
 	s64 lblkno, rem, lastlblkno;
 	u32 mask;
 	struct dmap *dp;
@@ -440,7 +441,7 @@ dbUpdatePMap(struct inode *ipbmap,
 		printk(KERN_ERR "blkno = %Lx, nblocks = %Lx\n",
 		       (unsigned long long) blkno,
 		       (unsigned long long) nblocks);
-		jfs_error(ipbmap->i_sb, "blocks are outside the map\n");
+		jfs_error(inode_sb(ipbmap), "blocks are outside the map\n");
 		return -EIO;
 	}
 
@@ -607,7 +608,7 @@ int dbNextAG(struct inode *ipbmap)
 	s64 hwm = 0;
 	int i;
 	int next_best = -1;
-	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ipbmap))->bmap;
 
 	BMAP_LOCK(bmp);
 
@@ -700,7 +701,7 @@ int dbNextAG(struct inode *ipbmap)
 int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 {
 	int rc, agno;
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
 	struct bmap *bmp;
 	struct metapage *mp;
 	s64 lblkno, blkno;
@@ -718,13 +719,13 @@ int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 	 */
 	l2nb = BLKSTOL2(nblocks);
 
-	bmp = JFS_SBI(ip->i_sb)->bmap;
+	bmp = JFS_SBI(inode_sb(ip))->bmap;
 
 	mapSize = bmp->db_mapsize;
 
 	/* the hint should be within the map */
 	if (hint >= mapSize) {
-		jfs_error(ip->i_sb, "the hint is outside the map\n");
+		jfs_error(inode_sb(ip), "the hint is outside the map\n");
 		return -EIO;
 	}
 
@@ -893,8 +894,8 @@ int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 int dbAllocExact(struct inode *ip, s64 blkno, int nblocks)
 {
 	int rc;
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ip))->bmap;
 	struct dmap *dp;
 	s64 lblkno;
 	struct metapage *mp;
@@ -1025,7 +1026,7 @@ dbReAlloc(struct inode *ip,
  */
 static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	s64 lblkno, lastblkno, extblkno;
 	uint rel_block;
 	struct metapage *mp;
@@ -1055,7 +1056,8 @@ static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks)
 	bmp = sbi->bmap;
 	if (lastblkno < 0 || lastblkno >= bmp->db_mapsize) {
 		IREAD_UNLOCK(ipbmap);
-		jfs_error(ip->i_sb, "the block is outside the filesystem\n");
+		jfs_error(inode_sb(ip),
+			  "the block is outside the filesystem\n");
 		return -EIO;
 	}
 
@@ -1131,7 +1133,7 @@ static int dbAllocNext(struct bmap * bmp, struct dmap * dp, s64 blkno,
 	u32 mask;
 
 	if (dp->tree.leafidx != cpu_to_le32(LEAFIND)) {
-		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmap page\n");
+		jfs_error(inode_sb(bmp->db_ipbmap), "Corrupt dmap page\n");
 		return -EIO;
 	}
 
@@ -1261,7 +1263,7 @@ dbAllocNear(struct bmap * bmp,
 	s8 *leaf;
 
 	if (dp->tree.leafidx != cpu_to_le32(LEAFIND)) {
-		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmap page\n");
+		jfs_error(inode_sb(bmp->db_ipbmap), "Corrupt dmap page\n");
 		return -EIO;
 	}
 
@@ -1375,7 +1377,7 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	 * allocation group size.
 	 */
 	if (l2nb > bmp->db_agl2size) {
-		jfs_error(bmp->db_ipbmap->i_sb,
+		jfs_error(inode_sb(bmp->db_ipbmap),
 			  "allocation request is larger than the allocation group size\n");
 		return -EIO;
 	}
@@ -1410,7 +1412,7 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 			printk(KERN_ERR "blkno = %Lx, blocks = %Lx\n",
 			       (unsigned long long) blkno,
 			       (unsigned long long) nblocks);
-			jfs_error(bmp->db_ipbmap->i_sb,
+			jfs_error(inode_sb(bmp->db_ipbmap),
 				  "dbAllocCtl failed in free AG\n");
 		}
 		return (rc);
@@ -1427,7 +1429,7 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	budmin = dcp->budmin;
 
 	if (dcp->leafidx != cpu_to_le32(CTLLEAFIND)) {
-		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
+		jfs_error(inode_sb(bmp->db_ipbmap), "Corrupt dmapctl page\n");
 		release_metapage(mp);
 		return -EIO;
 	}
@@ -1467,7 +1469,7 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 				}
 			}
 			if (n == 4) {
-				jfs_error(bmp->db_ipbmap->i_sb,
+				jfs_error(inode_sb(bmp->db_ipbmap),
 					  "failed descending stree\n");
 				release_metapage(mp);
 				return -EIO;
@@ -1507,7 +1509,7 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 			     dbFindCtl(bmp, l2nb, bmp->db_aglevel - 1,
 				       &blkno))) {
 				if (rc == -ENOSPC) {
-					jfs_error(bmp->db_ipbmap->i_sb,
+					jfs_error(inode_sb(bmp->db_ipbmap),
 						  "control page inconsistent\n");
 					return -EIO;
 				}
@@ -1519,7 +1521,7 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 		 */
 		rc = dbAllocCtl(bmp, nblocks, l2nb, blkno, results);
 		if (rc == -ENOSPC) {
-			jfs_error(bmp->db_ipbmap->i_sb,
+			jfs_error(inode_sb(bmp->db_ipbmap),
 				  "unable to allocate blocks\n");
 			rc = -EIO;
 		}
@@ -1579,7 +1581,8 @@ static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results)
 	 */
 	rc = dbAllocCtl(bmp, nblocks, l2nb, blkno, results);
 	if (rc == -ENOSPC) {
-		jfs_error(bmp->db_ipbmap->i_sb, "unable to allocate blocks\n");
+		jfs_error(inode_sb(bmp->db_ipbmap),
+			  "unable to allocate blocks\n");
 		return -EIO;
 	}
 	return (rc);
@@ -1618,12 +1621,12 @@ static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results)
  */
 s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 {
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ip))->bmap;
 	s64 nblocks, blkno;
 	u64 trimmed = 0;
 	int rc, l2nb;
-	struct super_block *sb = ipbmap->i_sb;
+	struct super_block *sb = inode_sb(ipbmap);
 
 	struct range2trim {
 		u64 blkno;
@@ -1643,7 +1646,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 	range_cnt = min_t(u64, max_ranges + 1, 32 * 1024);
 	totrim = kmalloc(sizeof(struct range2trim) * range_cnt, GFP_NOFS);
 	if (totrim == NULL) {
-		jfs_error(bmp->db_ipbmap->i_sb, "no memory for trim array\n");
+		jfs_error(inode_sb(bmp->db_ipbmap),
+			  "no memory for trim array\n");
 		IWRITE_UNLOCK(ipbmap);
 		return 0;
 	}
@@ -1672,7 +1676,7 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 			nblocks = 1 << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
-			jfs_error(bmp->db_ipbmap->i_sb, "-EIO\n");
+			jfs_error(inode_sb(bmp->db_ipbmap), "-EIO\n");
 			break;
 		}
 
@@ -1749,7 +1753,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		budmin = dcp->budmin;
 
 		if (dcp->leafidx != cpu_to_le32(CTLLEAFIND)) {
-			jfs_error(bmp->db_ipbmap->i_sb,
+			jfs_error(inode_sb(bmp->db_ipbmap),
 				  "Corrupt dmapctl page\n");
 			release_metapage(mp);
 			return -EIO;
@@ -1770,7 +1774,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
 		 */
 		if (rc) {
 			if (lev != level) {
-				jfs_error(bmp->db_ipbmap->i_sb,
+				jfs_error(inode_sb(bmp->db_ipbmap),
 					  "dmap inconsistent\n");
 				return -EIO;
 			}
@@ -1894,7 +1898,7 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 		 */
 		if (dp->tree.stree[ROOT] != L2BPERDMAP) {
 			release_metapage(mp);
-			jfs_error(bmp->db_ipbmap->i_sb,
+			jfs_error(inode_sb(bmp->db_ipbmap),
 				  "the dmap is not all free\n");
 			rc = -EIO;
 			goto backout;
@@ -1941,7 +1945,7 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			/* could not back out.  mark the file system
 			 * to indicate that we have leaked blocks.
 			 */
-			jfs_error(bmp->db_ipbmap->i_sb,
+			jfs_error(inode_sb(bmp->db_ipbmap),
 				  "I/O Error: Block Leakage\n");
 			continue;
 		}
@@ -1954,7 +1958,7 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			 * to indicate that we have leaked blocks.
 			 */
 			release_metapage(mp);
-			jfs_error(bmp->db_ipbmap->i_sb, "Block Leakage\n");
+			jfs_error(inode_sb(bmp->db_ipbmap), "Block Leakage\n");
 			continue;
 		}
 
@@ -2250,7 +2254,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			 */
 			for (; nwords > 0; nwords -= nw) {
 				if (leaf[word] < BUDMIN) {
-					jfs_error(bmp->db_ipbmap->i_sb,
+					jfs_error(inode_sb(bmp->db_ipbmap),
 						  "leaf page corrupt\n");
 					break;
 				}
@@ -2524,7 +2528,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 	dcp = (struct dmapctl *) mp->data;
 
 	if (dcp->leafidx != cpu_to_le32(CTLLEAFIND)) {
-		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
+		jfs_error(inode_sb(bmp->db_ipbmap), "Corrupt dmapctl page\n");
 		release_metapage(mp);
 		return -EIO;
 	}
@@ -2624,7 +2628,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 			 */
 			assert(level == bmp->db_maxlevel);
 			if (bmp->db_maxfreebud != oldroot) {
-				jfs_error(bmp->db_ipbmap->i_sb,
+				jfs_error(inode_sb(bmp->db_ipbmap),
 					  "the maximum free buddy is not the old root\n");
 			}
 			bmp->db_maxfreebud = dcp->stree[ROOT];
@@ -3211,8 +3215,8 @@ int dbAllocBottomUp(struct inode *ip, s64 blkno, s64 nblocks)
 	struct dmap *dp;
 	int nb, rc;
 	s64 lblkno, rem;
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ip))->bmap;
 
 	IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
@@ -3383,7 +3387,7 @@ static int dbAllocDmapBU(struct bmap * bmp, struct dmap * dp, s64 blkno,
  */
 int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ipbmap->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ipbmap));
 	int nbperpage = sbi->nbperpage;
 	int i, i0 = true, j, j0 = true, k, n;
 	s64 newsize;
@@ -3467,7 +3471,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 	p = BMAPBLKNO + nbperpage;	/* L2 page */
 	l2mp = read_metapage(ipbmap, p, PSIZE, 0);
 	if (!l2mp) {
-		jfs_error(ipbmap->i_sb, "L2 page could not be read\n");
+		jfs_error(inode_sb(ipbmap), "L2 page could not be read\n");
 		return -EIO;
 	}
 	l2dcp = (struct dmapctl *) l2mp->data;
@@ -3632,7 +3636,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 		}
 	}			/* for each L1 in a L2 */
 
-	jfs_error(ipbmap->i_sb, "function has not returned as expected\n");
+	jfs_error(inode_sb(ipbmap), "function has not returned as expected\n");
 errout:
 	if (l0mp)
 		release_metapage(l0mp);
@@ -3655,7 +3659,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
  */
 void dbFinalizeBmap(struct inode *ipbmap)
 {
-	struct bmap *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
+	struct bmap *bmp = JFS_SBI(inode_sb(ipbmap))->bmap;
 	int actags, inactags, l2nl;
 	s64 ag_rem, actfree, inactfree, avgfree;
 	int i, n;
@@ -3701,7 +3705,7 @@ void dbFinalizeBmap(struct inode *ipbmap)
 				break;
 		}
 		if (bmp->db_agpref >= bmp->db_numag) {
-			jfs_error(ipbmap->i_sb,
+			jfs_error(inode_sb(ipbmap),
 				  "cannot find ag with average freespace\n");
 		}
 	}
@@ -4051,7 +4055,7 @@ static int dbGetL2AGSize(s64 nblocks)
 
 s64 dbMapFileSizeToMapSize(struct inode * ipbmap)
 {
-	struct super_block *sb = ipbmap->i_sb;
+	struct super_block *sb = inode_sb(ipbmap);
 	s64 nblocks;
 	s64 npages, ndmaps;
 	int level, i;
diff --git a/fs/jfs/jfs_dmap.h b/fs/jfs/jfs_dmap.h
index 562b9a7e4311..656bb54da901 100644
--- a/fs/jfs/jfs_dmap.h
+++ b/fs/jfs/jfs_dmap.h
@@ -137,7 +137,7 @@ static inline signed char TREEMAX(signed char *cp)
  * number.
  */
 #define AGTOBLK(a,ip)	\
-	((s64)(a) << (JFS_SBI((ip)->i_sb)->bmap->db_agl2size))
+	((s64)(a) << (JFS_SBI(inode_sb((ip)))->bmap->db_agl2size))
 
 /*
  *	dmap summary tree
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index de2bcb36e079..0126d32c76d9 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -132,7 +132,7 @@ do {									\
 		     (((BN) == 0) ? DTROOTMAXSLOT : (P)->header.maxslot)) || \
 		    ((BN) && ((P)->header.maxslot > DTPAGEMAXSLOT))) {	\
 			BT_PUTPAGE(MP);					\
-			jfs_error((IP)->i_sb,				\
+			jfs_error(inode_sb((IP)),				\
 				  "DT_GETPAGE: dtree page corrupt\n");	\
 			MP = NULL;					\
 			RC = -EIO;					\
@@ -279,7 +279,7 @@ static struct dir_table_slot *find_index(struct inode *ip, u32 index,
 		offset = (index - 2) * sizeof(struct dir_table_slot);
 		page_offset = offset & (PSIZE - 1);
 		blkno = ((offset + 1) >> L2PSIZE) <<
-		    JFS_SBI(ip->i_sb)->l2nbperpage;
+		    JFS_SBI(inode_sb(ip))->l2nbperpage;
 
 		if (*mp && (*lblock != blkno)) {
 			release_metapage(*mp);
@@ -333,7 +333,7 @@ static inline void lock_index(tid_t tid, struct inode *ip, struct metapage * mp,
  */
 static u32 add_index(tid_t tid, struct inode *ip, s64 bn, int slot)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
 	u64 blkno;
@@ -592,7 +592,7 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 	int psize = 288;	/* initial in-line directory */
 	ino_t inumber;
 	struct component_name ciKey;
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 
 	ciKey.name = kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t), GFP_NOFS);
 	if (!ciKey.name) {
@@ -789,7 +789,7 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		/* get the child page block number */
 		pxd = (pxd_t *) & p->slot[stbl[index]];
 		bn = addressPXD(pxd);
-		psize = lengthPXD(pxd) << JFS_SBI(ip->i_sb)->l2bsize;
+		psize = lengthPXD(pxd) << JFS_SBI(inode_sb(ip))->l2bsize;
 
 		/* unpin the parent page */
 		DT_PUTPAGE(mp);
@@ -930,7 +930,7 @@ int dtInsert(tid_t tid, struct inode *ip,
 static int dtSplitUp(tid_t tid,
 	  struct inode *ip, struct dtsplit * split, struct btstack * btstack)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	int rc = 0;
 	struct metapage *smp;
 	dtpage_t *sp;		/* split page */
@@ -1642,7 +1642,7 @@ static int dtSplitPage(tid_t tid, struct inode *ip, struct dtsplit * split,
 static int dtExtendPage(tid_t tid,
 	     struct inode *ip, struct dtsplit * split, struct btstack * btstack)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	int rc;
 	struct metapage *smp, *pmp, *mp;
 	dtpage_t *sp, *pp;
@@ -1875,7 +1875,7 @@ static int dtExtendPage(tid_t tid,
 static int dtSplitRoot(tid_t tid,
 	    struct inode *ip, struct dtsplit * split, struct metapage ** rmpp)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	struct metapage *smp;
 	dtroot_t *sp;
 	struct metapage *rmp;
@@ -2577,7 +2577,7 @@ int dtRelocate(tid_t tid, struct inode *ip, s64 lmxaddr, pxd_t * opxd,
 	dtlck->index++;
 
 	/* update the buffer extent descriptor of the dtpage */
-	xsize = xlen << JFS_SBI(ip->i_sb)->l2bsize;
+	xsize = xlen << JFS_SBI(inode_sb(ip))->l2bsize;
 
 	/* unpin the relocated page */
 	DT_PUTPAGE(mp);
@@ -2688,7 +2688,7 @@ static int dtSearchNode(struct inode *ip, s64 lmxaddr, pxd_t * kpxd,
 
 		/* get the child page block address */
 		bn = addressPXD(pxd);
-		psize = lengthPXD(pxd) << JFS_SBI(ip->i_sb)->l2bsize;
+		psize = lengthPXD(pxd) << JFS_SBI(inode_sb(ip))->l2bsize;
 		/* unpin the parent page */
 		DT_PUTPAGE(mp);
 	}
@@ -2929,7 +2929,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	tid_t tid;
 	struct tlock *tlck;
 
-	tid = txBegin(inode->i_sb, 0);
+	tid = txBegin(inode_sb(inode), 0);
 
 	DT_GETPAGE(inode, bn, mp, PSIZE, p, rc);
 
@@ -3005,7 +3005,7 @@ static inline struct jfs_dirent *next_jfs_dirent(struct jfs_dirent *dirent)
 int jfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *ip = file_inode(file);
-	struct nls_table *codepage = JFS_SBI(ip->i_sb)->nls_tab;
+	struct nls_table *codepage = JFS_SBI(inode_sb(ip))->nls_tab;
 	int rc = 0;
 	loff_t dtpos;	/* legacy OS/2 style position */
 	struct dtoffset {
@@ -3259,7 +3259,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 				d_namleft -= len;
 				/* Sanity Check */
 				if (d_namleft == 0) {
-					jfs_error(ip->i_sb,
+					jfs_error(inode_sb(ip),
 						  "JFS:Dtree error: ino = %ld, bn=%lld, index = %d\n",
 						  (long)ip->i_ino,
 						  (long long)bn,
@@ -3380,7 +3380,7 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 		 */
 		if (BT_STACK_FULL(btstack)) {
 			DT_PUTPAGE(mp);
-			jfs_error(ip->i_sb, "btstack overrun\n");
+			jfs_error(inode_sb(ip), "btstack overrun\n");
 			BT_STACK_DUMP(btstack);
 			return -EIO;
 		}
@@ -3393,7 +3393,7 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
 		/* get the child page block address */
 		bn = addressPXD(xd);
-		psize = lengthPXD(xd) << JFS_SBI(ip->i_sb)->l2bsize;
+		psize = lengthPXD(xd) << JFS_SBI(inode_sb(ip))->l2bsize;
 
 		/* unpin the parent page */
 		DT_PUTPAGE(mp);
diff --git a/fs/jfs/jfs_dtree.h b/fs/jfs/jfs_dtree.h
index fd4169e6e698..815a8280717e 100644
--- a/fs/jfs/jfs_dtree.h
+++ b/fs/jfs/jfs_dtree.h
@@ -101,7 +101,7 @@ struct ldtentry {
 /*
  * Keep persistent index for directory entries
  */
-#define DO_INDEX(INODE) (JFS_SBI((INODE)->i_sb)->mntflag & JFS_DIR_INDEX)
+#define DO_INDEX(INODE) (JFS_SBI(inode_sb((INODE)))->mntflag & JFS_DIR_INDEX)
 
 /*
  * Maximum entry in inline directory table
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 2ae7d59ab10a..bbe40021b5fd 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -85,13 +85,13 @@ static s64 extRoundDown(s64 nb);
 int
 extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	s64 nxlen, nxaddr, xoff, hint, xaddr = 0;
 	int rc;
 	int xflag;
 
 	/* This blocks if we are low on resources */
-	txBeginAnon(ip->i_sb);
+	txBeginAnon(inode_sb(ip));
 
 	/* Avoid race with jfs_commit_inode() */
 	mutex_lock(&JFS_IP(ip)->commit_mutex);
@@ -214,14 +214,14 @@ extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
  */
 int extRealloc(struct inode *ip, s64 nxlen, xad_t * xp, bool abnr)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	s64 xaddr, xlen, nxaddr, delta, xoff;
 	s64 ntail, nextend, ninsert;
 	int rc, nbperpage = JFS_SBI(sb)->nbperpage;
 	int xflag;
 
 	/* This blocks if we are low on resources */
-	txBeginAnon(ip->i_sb);
+	txBeginAnon(inode_sb(ip));
 
 	mutex_lock(&JFS_IP(ip)->commit_mutex);
 	/* validate extent length */
@@ -363,7 +363,7 @@ int extRealloc(struct inode *ip, s64 nxlen, xad_t * xp, bool abnr)
  */
 int extHint(struct inode *ip, s64 offset, xad_t * xp)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	int nbperpage = JFS_SBI(sb)->nbperpage;
 	s64 prev;
 	int rc = 0;
@@ -388,7 +388,7 @@ int extHint(struct inode *ip, s64 offset, xad_t * xp)
 
 	if ((rc == 0) && xlen) {
 		if (xlen != nbperpage) {
-			jfs_error(ip->i_sb, "corrupt xtree\n");
+			jfs_error(inode_sb(ip), "corrupt xtree\n");
 			rc = -EIO;
 		}
 		XADaddress(xp, xaddr);
@@ -425,7 +425,7 @@ int extRecord(struct inode *ip, xad_t * xp)
 {
 	int rc;
 
-	txBeginAnon(ip->i_sb);
+	txBeginAnon(inode_sb(ip));
 
 	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
@@ -455,7 +455,7 @@ int extRecord(struct inode *ip, xad_t * xp)
  */
 int extFill(struct inode *ip, xad_t * xp)
 {
-	int rc, nbperpage = JFS_SBI(ip->i_sb)->nbperpage;
+	int rc, nbperpage = JFS_SBI(inode_sb(ip))->nbperpage;
 	s64 blkno = offsetXAD(xp) >> ip->i_blkbits;
 
 //	assert(ISSPARSE(ip));
@@ -509,7 +509,7 @@ static int
 extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 {
 	struct jfs_inode_info *ji = JFS_IP(ip);
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	s64 nb, nblks, daddr, max;
 	int rc, nbperpage = sbi->nbperpage;
 	struct bmap *bmp = sbi->bmap;
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index f36ef68905a7..28873d804bd9 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -124,7 +124,7 @@ int diMount(struct inode *ipimap)
 	/* read the on-disk inode map control structure. */
 
 	mp = read_metapage(ipimap,
-			   IMAPBLKNO << JFS_SBI(ipimap->i_sb)->l2nbperpage,
+			   IMAPBLKNO << JFS_SBI(inode_sb(ipimap))->l2nbperpage,
 			   PSIZE, 0);
 	if (mp == NULL) {
 		kfree(imap);
@@ -228,7 +228,7 @@ int diSync(struct inode *ipimap)
 	 */
 	/* read the on-disk inode map control structure */
 	mp = get_metapage(ipimap,
-			  IMAPBLKNO << JFS_SBI(ipimap->i_sb)->l2nbperpage,
+			  IMAPBLKNO << JFS_SBI(inode_sb(ipimap))->l2nbperpage,
 			  PSIZE, 0);
 	if (mp == NULL) {
 		jfs_err("diSync: get_metapage failed!");
@@ -303,7 +303,7 @@ int diSync(struct inode *ipimap)
  */
 int diRead(struct inode *ip)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	int iagno, ino, extno, rc;
 	struct inode *ipimap;
 	struct dinode *dp;
@@ -386,7 +386,7 @@ int diRead(struct inode *ip)
 	dp += rel_inode;
 
 	if (ip->i_ino != le32_to_cpu(dp->di_number)) {
-		jfs_error(ip->i_sb, "i_ino != di_number\n");
+		jfs_error(inode_sb(ip), "i_ino != di_number\n");
 		rc = -EIO;
 	} else if (le32_to_cpu(dp->di_nlink) == 0)
 		rc = -ESTALE;
@@ -516,7 +516,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 
 void diWriteSpecial(struct inode *ip, int secondary)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	uint address;
 	struct dinode *dp;
 	ino_t inum = ip->i_ino;
@@ -597,7 +597,7 @@ void diFreeSpecial(struct inode *ip)
  */
 int diWrite(tid_t tid, struct inode *ip)
 {
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
 	int rc = 0;
 	s32 ino;
@@ -624,7 +624,7 @@ int diWrite(tid_t tid, struct inode *ip)
 	if (!addressPXD(&(jfs_ip->ixpxd)) ||
 	    (lengthPXD(&(jfs_ip->ixpxd)) !=
 	     JFS_IP(ipimap)->i_imap->im_nbperiext)) {
-		jfs_error(ip->i_sb, "ixpxd invalid\n");
+		jfs_error(inode_sb(ip), "ixpxd invalid\n");
 		return -EIO;
 	}
 
@@ -868,7 +868,7 @@ int diFree(struct inode *ip)
 	int iagno, ino, extno, bitno, sword, agno;
 	int back, fwd;
 	u32 bitmap, mask;
-	struct inode *ipimap = JFS_SBI(ip->i_sb)->ipimap;
+	struct inode *ipimap = JFS_SBI(inode_sb(ip))->ipimap;
 	struct inomap *imap = JFS_IP(ipimap)->i_imap;
 	pxd_t freepxd;
 	tid_t tid;
@@ -892,14 +892,15 @@ int diFree(struct inode *ip)
 	if (iagno >= imap->im_nextiag) {
 		print_hex_dump(KERN_ERR, "imap: ", DUMP_PREFIX_ADDRESS, 16, 4,
 			       imap, 32, 0);
-		jfs_error(ip->i_sb, "inum = %d, iagno = %d, nextiag = %d\n",
+		jfs_error(inode_sb(ip),
+			  "inum = %d, iagno = %d, nextiag = %d\n",
 			  (uint) inum, iagno, imap->im_nextiag);
 		return -EIO;
 	}
 
 	/* get the allocation group for this ino.
 	 */
-	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb));
+	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(inode_sb(ip)));
 
 	/* Lock the AG specific inode map information
 	 */
@@ -928,14 +929,14 @@ int diFree(struct inode *ip)
 	mask = HIGHORDER >> bitno;
 
 	if (!(le32_to_cpu(iagp->wmap[extno]) & mask)) {
-		jfs_error(ip->i_sb, "wmap shows inode already free\n");
+		jfs_error(inode_sb(ip), "wmap shows inode already free\n");
 	}
 
 	if (!addressPXD(&iagp->inoext[extno])) {
 		release_metapage(mp);
 		IREAD_UNLOCK(ipimap);
 		AG_UNLOCK(imap, agno);
-		jfs_error(ip->i_sb, "invalid inoext\n");
+		jfs_error(inode_sb(ip), "invalid inoext\n");
 		return -EIO;
 	}
 
@@ -947,7 +948,7 @@ int diFree(struct inode *ip)
 		release_metapage(mp);
 		IREAD_UNLOCK(ipimap);
 		AG_UNLOCK(imap, agno);
-		jfs_error(ip->i_sb, "numfree > numinos\n");
+		jfs_error(inode_sb(ip), "numfree > numinos\n");
 		return -EIO;
 	}
 	/*
@@ -1196,7 +1197,7 @@ int diFree(struct inode *ip)
 	 * for the inode being freed.
 	 */
 	if (iagp->pmap[extno] != 0) {
-		jfs_error(ip->i_sb, "the pmap does not show inode free\n");
+		jfs_error(inode_sb(ip), "the pmap does not show inode free\n");
 	}
 	iagp->wmap[extno] = 0;
 	PXDlength(&iagp->inoext[extno], 0);
@@ -1245,7 +1246,7 @@ int diFree(struct inode *ip)
 	 * BUT with new/different backing inode extent from the extent
 	 * to be freed by the transaction;
 	 */
-	tid = txBegin(ipimap->i_sb, COMMIT_FORCE);
+	tid = txBegin(inode_sb(ipimap), COMMIT_FORCE);
 	mutex_lock(&JFS_IP(ipimap)->commit_mutex);
 
 	/* acquire tlock of the iag page of the freed ixad
@@ -1351,7 +1352,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	/* get the pointers to the inode map inode and the
 	 * corresponding imap control structure.
 	 */
-	ipimap = JFS_SBI(pip->i_sb)->ipimap;
+	ipimap = JFS_SBI(inode_sb(pip))->ipimap;
 	imap = JFS_IP(ipimap)->i_imap;
 	JFS_IP(ip)->ipimap = ipimap;
 	JFS_IP(ip)->fileset = FILESYSTEM_I;
@@ -1360,7 +1361,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	 * at the ag level using the preferred ag.
 	 */
 	if (dir) {
-		agno = dbNextAG(JFS_SBI(pip->i_sb)->ipbmap);
+		agno = dbNextAG(JFS_SBI(inode_sb(pip))->ipbmap);
 		AG_LOCK(imap, agno);
 		goto tryag;
 	}
@@ -1375,15 +1376,15 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	 */
 
 	/* get the ag number of this iag */
-	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
+	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(inode_sb(pip)));
 
-	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
+	if (atomic_read(&JFS_SBI(inode_sb(pip))->bmap->db_active[agno])) {
 		/*
 		 * There is an open file actively growing.  We want to
 		 * allocate new inodes from a different ag to avoid
 		 * fragmentation problems.
 		 */
-		agno = dbNextAG(JFS_SBI(pip->i_sb)->ipbmap);
+		agno = dbNextAG(JFS_SBI(inode_sb(pip))->ipbmap);
 		AG_LOCK(imap, agno);
 		goto tryag;
 	}
@@ -1514,7 +1515,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 					IREAD_UNLOCK(ipimap);
 					release_metapage(mp);
 					AG_UNLOCK(imap, agno);
-					jfs_error(ip->i_sb,
+					jfs_error(inode_sb(ip),
 						  "can't find free bit in wmap\n");
 					return -EIO;
 				}
@@ -1656,7 +1657,7 @@ diAllocAG(struct inomap * imap, int agno, bool dir, struct inode *ip)
 	numinos = imap->im_agctl[agno].numinos;
 
 	if (numfree > numinos) {
-		jfs_error(ip->i_sb, "numfree > numinos\n");
+		jfs_error(inode_sb(ip), "numfree > numinos\n");
 		return -EIO;
 	}
 
@@ -1718,7 +1719,7 @@ static int
 diAllocAny(struct inomap * imap, int agno, bool dir, struct inode *ip)
 {
 	int ag, rc;
-	int maxag = JFS_SBI(imap->im_ipimap->i_sb)->bmap->db_maxag;
+	int maxag = JFS_SBI(inode_sb(imap->im_ipimap))->bmap->db_maxag;
 
 
 	/* try to allocate from the ags following agno up to
@@ -1807,7 +1808,8 @@ static int diAllocIno(struct inomap * imap, int agno, struct inode *ip)
 	if (!iagp->nfreeinos) {
 		IREAD_UNLOCK(imap->im_ipimap);
 		release_metapage(mp);
-		jfs_error(ip->i_sb, "nfreeinos = 0, but iag on freelist\n");
+		jfs_error(inode_sb(ip),
+			  "nfreeinos = 0, but iag on freelist\n");
 		return -EIO;
 	}
 
@@ -1818,7 +1820,7 @@ static int diAllocIno(struct inomap * imap, int agno, struct inode *ip)
 		if (sword >= SMAPSZ) {
 			IREAD_UNLOCK(imap->im_ipimap);
 			release_metapage(mp);
-			jfs_error(ip->i_sb,
+			jfs_error(inode_sb(ip),
 				  "free inode not found in summary map\n");
 			return -EIO;
 		}
@@ -1834,7 +1836,7 @@ static int diAllocIno(struct inomap * imap, int agno, struct inode *ip)
 	if (rem >= EXTSPERSUM) {
 		IREAD_UNLOCK(imap->im_ipimap);
 		release_metapage(mp);
-		jfs_error(ip->i_sb, "no free extent found\n");
+		jfs_error(inode_sb(ip), "no free extent found\n");
 		return -EIO;
 	}
 	extno = (sword << L2EXTSPERSUM) + rem;
@@ -1845,7 +1847,7 @@ static int diAllocIno(struct inomap * imap, int agno, struct inode *ip)
 	if (rem >= INOSPEREXT) {
 		IREAD_UNLOCK(imap->im_ipimap);
 		release_metapage(mp);
-		jfs_error(ip->i_sb, "free inode not found\n");
+		jfs_error(inode_sb(ip), "free inode not found\n");
 		return -EIO;
 	}
 
@@ -1931,7 +1933,7 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 		IREAD_LOCK(imap->im_ipimap, RDWRLOCK_IMAP);
 		if ((rc = diIAGRead(imap, iagno, &mp))) {
 			IREAD_UNLOCK(imap->im_ipimap);
-			jfs_error(ip->i_sb, "error reading iag\n");
+			jfs_error(inode_sb(ip), "error reading iag\n");
 			return rc;
 		}
 		iagp = (struct iag *) mp->data;
@@ -1943,7 +1945,8 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 		if (sword >= SMAPSZ) {
 			release_metapage(mp);
 			IREAD_UNLOCK(imap->im_ipimap);
-			jfs_error(ip->i_sb, "free ext summary map not found\n");
+			jfs_error(inode_sb(ip),
+				  "free ext summary map not found\n");
 			return -EIO;
 		}
 		if (~iagp->extsmap[sword])
@@ -1956,7 +1959,7 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 	if (rem >= EXTSPERSUM) {
 		release_metapage(mp);
 		IREAD_UNLOCK(imap->im_ipimap);
-		jfs_error(ip->i_sb, "free extent not found\n");
+		jfs_error(inode_sb(ip), "free extent not found\n");
 		return -EIO;
 	}
 	extno = (sword << L2EXTSPERSUM) + rem;
@@ -2057,7 +2060,8 @@ static int diAllocBit(struct inomap * imap, struct iag * iagp, int ino)
 	/* get the ag number, extent number, inode number within
 	 * the extent.
 	 */
-	agno = BLKTOAG(le64_to_cpu(iagp->agstart), JFS_SBI(imap->im_ipimap->i_sb));
+	agno = BLKTOAG(le64_to_cpu(iagp->agstart),
+		       JFS_SBI(inode_sb(imap->im_ipimap)));
 	extno = ino >> L2INOSPEREXT;
 	bitno = ino & (INOSPEREXT - 1);
 
@@ -2075,7 +2079,7 @@ static int diAllocBit(struct inomap * imap, struct iag * iagp, int ino)
 		if (bmp)
 			release_metapage(bmp);
 
-		jfs_error(imap->im_ipimap->i_sb, "iag inconsistent\n");
+		jfs_error(inode_sb(imap->im_ipimap), "iag inconsistent\n");
 		return -EIO;
 	}
 
@@ -2182,14 +2186,14 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* better have free extents.
 	 */
 	if (!iagp->nfreeexts) {
-		jfs_error(imap->im_ipimap->i_sb, "no free extents\n");
+		jfs_error(inode_sb(imap->im_ipimap), "no free extents\n");
 		return -EIO;
 	}
 
 	/* get the inode map inode.
 	 */
 	ipimap = imap->im_ipimap;
-	sbi = JFS_SBI(ipimap->i_sb);
+	sbi = JFS_SBI(inode_sb(ipimap));
 
 	amp = bmp = cmp = NULL;
 
@@ -2253,7 +2257,7 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 				ciagp = (struct iag *) cmp->data;
 			}
 			if (ciagp == NULL) {
-				jfs_error(imap->im_ipimap->i_sb,
+				jfs_error(inode_sb(imap->im_ipimap),
 					  "ciagp == NULL\n");
 				rc = -EIO;
 				goto error_out;
@@ -2464,7 +2468,7 @@ diNewIAG(struct inomap * imap, int *iagnop, int agno, struct metapage ** mpp)
 
 	/* pick up pointers to the inode map and mount inodes */
 	ipimap = imap->im_ipimap;
-	sb = ipimap->i_sb;
+	sb = inode_sb(ipimap);
 	sbi = JFS_SBI(sb);
 
 	/* acquire the free iag lock */
@@ -2490,7 +2494,7 @@ diNewIAG(struct inomap * imap, int *iagnop, int agno, struct metapage ** mpp)
 		if (ipimap->i_size >> L2PSIZE != imap->im_nextiag + 1) {
 			IWRITE_UNLOCK(ipimap);
 			IAGFREE_UNLOCK(imap);
-			jfs_error(imap->im_ipimap->i_sb,
+			jfs_error(inode_sb(imap->im_ipimap),
 				  "ipimap->i_size is wrong\n");
 			return -EIO;
 		}
@@ -2677,7 +2681,7 @@ static int diIAGRead(struct inomap * imap, int iagno, struct metapage ** mpp)
 	s64 blkno;
 
 	/* compute the logical block number of the iag. */
-	blkno = IAGTOLBLK(iagno, JFS_SBI(ipimap->i_sb)->l2nbperpage);
+	blkno = IAGTOLBLK(iagno, JFS_SBI(inode_sb(ipimap))->l2nbperpage);
 
 	/* read the iag. */
 	*mpp = read_metapage(ipimap, blkno, PSIZE, 0);
@@ -2751,7 +2755,7 @@ diUpdatePMap(struct inode *ipimap,
 	iagno = INOTOIAG(inum);
 	/* make sure that the iag is contained within the map */
 	if (iagno >= imap->im_nextiag) {
-		jfs_error(ipimap->i_sb, "the iag is outside the map\n");
+		jfs_error(inode_sb(ipimap), "the iag is outside the map\n");
 		return -EIO;
 	}
 	/* read the iag */
@@ -2779,12 +2783,12 @@ diUpdatePMap(struct inode *ipimap,
 		 * of last reference release;
 		 */
 		if (!(le32_to_cpu(iagp->wmap[extno]) & mask)) {
-			jfs_error(ipimap->i_sb,
+			jfs_error(inode_sb(ipimap),
 				  "inode %ld not marked as allocated in wmap!\n",
 				  inum);
 		}
 		if (!(le32_to_cpu(iagp->pmap[extno]) & mask)) {
-			jfs_error(ipimap->i_sb,
+			jfs_error(inode_sb(ipimap),
 				  "inode %ld not marked as allocated in pmap!\n",
 				  inum);
 		}
@@ -2800,13 +2804,13 @@ diUpdatePMap(struct inode *ipimap,
 		 */
 		if (!(le32_to_cpu(iagp->wmap[extno]) & mask)) {
 			release_metapage(mp);
-			jfs_error(ipimap->i_sb,
+			jfs_error(inode_sb(ipimap),
 				  "the inode is not allocated in the working map\n");
 			return -EIO;
 		}
 		if ((le32_to_cpu(iagp->pmap[extno]) & mask) != 0) {
 			release_metapage(mp);
-			jfs_error(ipimap->i_sb,
+			jfs_error(inode_sb(ipimap),
 				  "the inode is not free in the persistent map\n");
 			return -EIO;
 		}
@@ -2860,7 +2864,7 @@ int diExtendFS(struct inode *ipimap, struct inode *ipbmap)
 	int rc, rcx = 0;
 	struct inomap *imap = JFS_IP(ipimap)->i_imap;
 	struct iag *iagp = NULL, *hiagp = NULL;
-	struct bmap *mp = JFS_SBI(ipbmap->i_sb)->bmap;
+	struct bmap *mp = JFS_SBI(inode_sb(ipbmap))->bmap;
 	struct metapage *bp, *hbp;
 	int i, n, head;
 	int numinos, xnuminos = 0, xnumfree = 0;
@@ -2899,7 +2903,8 @@ int diExtendFS(struct inode *ipimap, struct inode *ipbmap)
 		iagp = (struct iag *) bp->data;
 		if (le32_to_cpu(iagp->iagnum) != i) {
 			release_metapage(bp);
-			jfs_error(ipimap->i_sb, "unexpected value of iagnum\n");
+			jfs_error(inode_sb(ipimap),
+				  "unexpected value of iagnum\n");
 			return -EIO;
 		}
 
@@ -2975,7 +2980,7 @@ int diExtendFS(struct inode *ipimap, struct inode *ipbmap)
 
 	if (xnuminos != atomic_read(&imap->im_numinos) ||
 	    xnumfree != atomic_read(&imap->im_numfree)) {
-		jfs_error(ipimap->i_sb, "numinos or numfree incorrect\n");
+		jfs_error(inode_sb(ipimap), "numinos or numfree incorrect\n");
 		return -EIO;
 	}
 
@@ -3045,7 +3050,7 @@ static void duplicateIXtree(struct super_block *sb, s64 blkno,
 static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 {
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 
 	jfs_ip->fileset = le32_to_cpu(dip->di_fileset);
 	jfs_ip->mode2 = le32_to_cpu(dip->di_mode);
@@ -3087,7 +3092,7 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 	ip->i_mtime.tv_nsec = le32_to_cpu(dip->di_mtime.tv_nsec);
 	ip->i_ctime.tv_sec = le32_to_cpu(dip->di_ctime.tv_sec);
 	ip->i_ctime.tv_nsec = le32_to_cpu(dip->di_ctime.tv_nsec);
-	ip->i_blocks = LBLK2PBLK(ip->i_sb, le64_to_cpu(dip->di_nblocks));
+	ip->i_blocks = LBLK2PBLK(inode_sb(ip), le64_to_cpu(dip->di_nblocks));
 	ip->i_generation = le32_to_cpu(dip->di_gen);
 
 	jfs_ip->ixpxd = dip->di_ixpxd;	/* in-memory pxd's are little-endian */
@@ -3129,14 +3134,14 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 static void copy_to_dinode(struct dinode * dip, struct inode *ip)
 {
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
-	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	struct jfs_sb_info *sbi = JFS_SBI(inode_sb(ip));
 
 	dip->di_fileset = cpu_to_le32(jfs_ip->fileset);
 	dip->di_inostamp = cpu_to_le32(sbi->inostamp);
 	dip->di_number = cpu_to_le32(ip->i_ino);
 	dip->di_gen = cpu_to_le32(ip->i_generation);
 	dip->di_size = cpu_to_le64(ip->i_size);
-	dip->di_nblocks = cpu_to_le64(PBLK2LBLK(ip->i_sb, ip->i_blocks));
+	dip->di_nblocks = cpu_to_le64(PBLK2LBLK(inode_sb(ip), ip->i_blocks));
 	dip->di_nlink = cpu_to_le32(ip->i_nlink);
 	if (!uid_valid(sbi->uid))
 		dip->di_uid = cpu_to_le32(i_uid_read(ip));
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 1f26d1910409..b41b26ab850e 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -221,7 +221,7 @@ static inline struct jfs_sb_info *JFS_SBI(struct super_block *sb)
 
 static inline int isReadOnly(struct inode *inode)
 {
-	if (JFS_SBI(inode->i_sb)->log)
+	if (JFS_SBI(inode_sb(inode))->log)
 		return 0;
 	return 1;
 }
diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 5e9b7bb3aabf..4d80820a38a5 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -53,7 +53,7 @@ void jfs_set_inode_flags(struct inode *inode)
  */
 struct inode *ialloc(struct inode *parent, umode_t mode)
 {
-	struct super_block *sb = parent->i_sb;
+	struct super_block *sb = inode_sb(parent);
 	struct inode *inode;
 	struct jfs_inode_info *jfs_inode;
 	int rc;
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 1a3b0cc22ad3..76ada7bf5680 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -250,7 +250,7 @@ static sector_t metapage_get_blocks(struct inode *inode, sector_t lblock,
 	int rc = 0;
 	int xflag;
 	s64 xaddr;
-	sector_t file_blocks = (inode->i_size + inode->i_sb->s_blocksize - 1) >>
+	sector_t file_blocks = (inode->i_size + inode_sb(inode)->s_blocksize - 1) >>
 			       inode->i_blkbits;
 
 	if (lblock >= file_blocks)
@@ -350,7 +350,7 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	struct bio *bio = NULL;
 	int block_offset;	/* block offset of mp within page */
 	struct inode *inode = page->mapping->host;
-	int blocks_per_mp = JFS_SBI(inode->i_sb)->nbperpage;
+	int blocks_per_mp = JFS_SBI(inode_sb(inode))->nbperpage;
 	int len;
 	int xlen;
 	struct metapage *mp;
@@ -427,10 +427,10 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 			bad_blocks++;
 			continue;
 		}
-		len = min(xlen, (int)JFS_SBI(inode->i_sb)->nbperpage);
+		len = min(xlen, (int)JFS_SBI(inode_sb(inode))->nbperpage);
 
 		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, inode->i_sb->s_bdev);
+		bio_set_dev(bio, inode_sb(inode)->s_bdev);
 		bio->bi_iter.bi_sector = pblock << (inode->i_blkbits - 9);
 		bio->bi_end_io = metapage_write_end_io;
 		bio->bi_private = page;
@@ -510,7 +510,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
 				submit_bio(bio);
 
 			bio = bio_alloc(GFP_NOFS, 1);
-			bio_set_dev(bio, inode->i_sb->s_bdev);
+			bio_set_dev(bio, inode_sb(inode)->s_bdev);
 			bio->bi_iter.bi_sector =
 				pblock << (inode->i_blkbits - 9);
 			bio->bi_end_io = metapage_read_end_io;
@@ -611,7 +611,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		return NULL;
 	}
 	if (absolute)
-		mapping = JFS_SBI(inode->i_sb)->direct_inode->i_mapping;
+		mapping = JFS_SBI(inode_sb(inode))->direct_inode->i_mapping;
 	else {
 		/*
 		 * If an nfs client tries to read an inode that is larger
@@ -642,7 +642,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 	mp = page_to_mp(page, page_offset);
 	if (mp) {
 		if (mp->logical_size != size) {
-			jfs_error(inode->i_sb,
+			jfs_error(inode_sb(inode),
 				  "get_mp->logical_size != size\n");
 			jfs_err("logical_size = %d, size = %d",
 				mp->logical_size, size);
@@ -653,7 +653,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		lock_metapage(mp);
 		if (test_bit(META_discard, &mp->flag)) {
 			if (!new) {
-				jfs_error(inode->i_sb,
+				jfs_error(inode_sb(inode),
 					  "using a discarded metapage\n");
 				discard_metapage(mp);
 				goto unlock;
@@ -666,7 +666,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		if (!mp)
 			goto unlock;
 		mp->page = page;
-		mp->sb = inode->i_sb;
+		mp->sb = inode_sb(inode);
 		mp->flag = 0;
 		mp->xflag = COMMIT_PAGE;
 		mp->count = 1;
@@ -781,7 +781,7 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 	int BlocksPerPage = 1 << l2BlocksPerPage;
 	/* All callers are interested in block device's mapping */
 	struct address_space *mapping =
-		JFS_SBI(ip->i_sb)->direct_inode->i_mapping;
+		JFS_SBI(inode_sb(ip))->direct_inode->i_mapping;
 	struct metapage *mp;
 	struct page *page;
 	unsigned int offset;
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 4d973524c887..ca16cecc7949 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1155,7 +1155,7 @@ int txCommit(tid_t tid,		/* transaction identifier */
 		goto TheEnd;
 	}
 
-	sb = cd.sb = iplist[0]->i_sb;
+	sb = cd.sb = inode_sb(iplist[0]);
 	cd.tid = tid;
 
 	if (tid == 0)
@@ -1396,7 +1396,7 @@ static int txLog(struct jfs_log * log, struct tblock * tblk, struct commit * cd)
 
 		/* initialize lrd common */
 		ip = tlck->ip;
-		lrd->aggregate = cpu_to_le32(JFS_SBI(ip->i_sb)->aggregate);
+		lrd->aggregate = cpu_to_le32(JFS_SBI(inode_sb(ip))->aggregate);
 		lrd->log.redopage.fileset = cpu_to_le32(JFS_IP(ip)->fileset);
 		lrd->log.redopage.inode = cpu_to_le32(ip->i_ino);
 
@@ -2437,7 +2437,7 @@ static void txUpdateMap(struct tblock * tblk)
 static void txAllocPMap(struct inode *ip, struct maplock * maplock,
 			struct tblock * tblk)
 {
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
 	struct xdlistlock *xadlistlock;
 	xad_t *xad;
 	s64 xaddr;
@@ -2495,7 +2495,7 @@ static void txAllocPMap(struct inode *ip, struct maplock * maplock,
 void txFreeMap(struct inode *ip,
 	       struct maplock * maplock, struct tblock * tblk, int maptype)
 {
-	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
+	struct inode *ipbmap = JFS_SBI(inode_sb(ip))->ipbmap;
 	struct xdlistlock *xadlistlock;
 	xad_t *xad;
 	s64 xaddr;
@@ -2875,7 +2875,7 @@ void txQuiesce(struct super_block *sb)
 		 * when it is committed
 		 */
 		TXN_UNLOCK();
-		tid = txBegin(ip->i_sb, COMMIT_INODE | COMMIT_FORCE);
+		tid = txBegin(inode_sb(ip), COMMIT_INODE | COMMIT_FORCE);
 		mutex_lock(&jfs_ip->commit_mutex);
 		txCommit(tid, 1, &ip, 0);
 		txEnd(tid);
@@ -2952,7 +2952,7 @@ int jfs_sync(void *arg)
 				 * when it is committed
 				 */
 				TXN_UNLOCK();
-				tid = txBegin(ip->i_sb, COMMIT_INODE);
+				tid = txBegin(inode_sb(ip), COMMIT_INODE);
 				txCommit(tid, 1, &ip, 0);
 				txEnd(tid);
 				mutex_unlock(&jfs_ip->commit_mutex);
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index 5cde6d2fcfca..e2495b369fba 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -73,7 +73,7 @@ do {									\
 		     le16_to_cpu((P)->header.maxentry)) ||		\
 		    (le16_to_cpu((P)->header.maxentry) >		\
 		     (((BN) == 0) ? XTROOTMAXSLOT : PSIZE >> L2XTSLOTSIZE))) { \
-			jfs_error((IP)->i_sb,				\
+			jfs_error(inode_sb((IP)),				\
 				  "XT_GETPAGE: xtree page corrupt\n");	\
 			BT_PUTPAGE(MP);					\
 			MP = NULL;					\
@@ -163,8 +163,8 @@ int xtLookup(struct inode *ip, s64 lstart,
 
 	if (!no_check) {
 		/* is lookup offset beyond eof ? */
-		size = ((u64) ip->i_size + (JFS_SBI(ip->i_sb)->bsize - 1)) >>
-		    JFS_SBI(ip->i_sb)->l2bsize;
+		size = ((u64) ip->i_size + (JFS_SBI(inode_sb(ip))->bsize - 1)) >>
+		    JFS_SBI(inode_sb(ip))->l2bsize;
 		if (lstart >= size)
 			return 0;
 	}
@@ -500,7 +500,7 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
 
 		/* push (bn, index) of the parent page/entry */
 		if (BT_STACK_FULL(btstack)) {
-			jfs_error(ip->i_sb, "stack overrun!\n");
+			jfs_error(inode_sb(ip), "stack overrun!\n");
 			XT_PUTPAGE(mp);
 			return -EIO;
 		}
@@ -764,7 +764,7 @@ xtSplitUp(tid_t tid,
 		split->pxdlist = &pxdlist;
 		pxdlist.maxnpxd = pxdlist.npxd = 0;
 		pxd = &pxdlist.pxd[0];
-		xlen = JFS_SBI(ip->i_sb)->nbperpage;
+		xlen = JFS_SBI(inode_sb(ip))->nbperpage;
 		for (; nsplit > 0; nsplit--, pxd++) {
 			if ((rc = dbAlloc(ip, (s64) 0, (s64) xlen, &xaddr))
 			    == 0) {
@@ -856,7 +856,7 @@ xtSplitUp(tid_t tid,
 			split->index = skip;	/* index at insert */
 			split->flag = XAD_NEW;
 			split->off = offsetXAD(&rcp->xad[XTENTRYSTART]);
-			split->len = JFS_SBI(ip->i_sb)->nbperpage;
+			split->len = JFS_SBI(inode_sb(ip))->nbperpage;
 			split->addr = rcbn;
 
 			/* unpin previous right child page */
@@ -904,7 +904,7 @@ xtSplitUp(tid_t tid,
 			xad = &sp->xad[skip];
 			XT_PUTENTRY(xad, XAD_NEW,
 				    offsetXAD(&rcp->xad[XTENTRYSTART]),
-				    JFS_SBI(ip->i_sb)->nbperpage, rcbn);
+				    JFS_SBI(inode_sb(ip))->nbperpage, rcbn);
 
 			/* advance next available entry index. */
 			le16_add_cpu(&sp->header.nextindex, 1);
@@ -1325,7 +1325,7 @@ xtSplitRoot(tid_t tid,
 	BT_MARK_DIRTY(split->mp, ip);
 
 	xad = &sp->xad[XTENTRYSTART];
-	XT_PUTENTRY(xad, XAD_NEW, 0, JFS_SBI(ip->i_sb)->nbperpage, rbn);
+	XT_PUTENTRY(xad, XAD_NEW, 0, JFS_SBI(inode_sb(ip))->nbperpage, rbn);
 
 	/* update page header of root */
 	sp->header.flag &= ~BT_LEAF;
@@ -1386,7 +1386,7 @@ int xtExtend(tid_t tid,		/* transaction id */
 
 	if (cmp != 0) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb, "xtSearch did not find extent\n");
+		jfs_error(inode_sb(ip), "xtSearch did not find extent\n");
 		return -EIO;
 	}
 
@@ -1394,7 +1394,7 @@ int xtExtend(tid_t tid,		/* transaction id */
 	xad = &p->xad[index];
 	if ((offsetXAD(xad) + lengthXAD(xad)) != xoff) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb, "extension is not contiguous\n");
+		jfs_error(inode_sb(ip), "extension is not contiguous\n");
 		return -EIO;
 	}
 
@@ -1553,7 +1553,7 @@ printf("xtTailgate: nxoff:0x%lx nxlen:0x%x nxaddr:0x%lx\n",
 
 	if (cmp != 0) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb, "couldn't find extent\n");
+		jfs_error(inode_sb(ip), "couldn't find extent\n");
 		return -EIO;
 	}
 
@@ -1561,7 +1561,8 @@ printf("xtTailgate: nxoff:0x%lx nxlen:0x%x nxaddr:0x%lx\n",
 	nextindex = le16_to_cpu(p->header.nextindex);
 	if (index != nextindex - 1) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb, "the entry found is not the last entry\n");
+		jfs_error(inode_sb(ip),
+			  "the entry found is not the last entry\n");
 		return -EIO;
 	}
 
@@ -1734,7 +1735,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 
 	if (cmp != 0) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb, "Could not find extent\n");
+		jfs_error(inode_sb(ip), "Could not find extent\n");
 		return -EIO;
 	}
 
@@ -1757,7 +1758,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 	if ((xoff > nxoff) ||
 	    (nxoff + nxlen > xoff + xlen)) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb,
+		jfs_error(inode_sb(ip),
 			  "nXAD in not completely contained within XAD\n");
 		return -EIO;
 	}
@@ -1907,7 +1908,7 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 
 	if (xoff >= nxoff) {
 		XT_PUTPAGE(mp);
-		jfs_error(ip->i_sb, "xoff >= nxoff\n");
+		jfs_error(inode_sb(ip), "xoff >= nxoff\n");
 		return -EIO;
 	}
 /* #endif _JFS_WIP_COALESCE */
@@ -2048,13 +2049,13 @@ int xtUpdate(tid_t tid, struct inode *ip, xad_t * nxad)
 
 		if (cmp != 0) {
 			XT_PUTPAGE(mp);
-			jfs_error(ip->i_sb, "xtSearch failed\n");
+			jfs_error(inode_sb(ip), "xtSearch failed\n");
 			return -EIO;
 		}
 
 		if (index0 != index) {
 			XT_PUTPAGE(mp);
-			jfs_error(ip->i_sb, "unexpected value of index\n");
+			jfs_error(inode_sb(ip), "unexpected value of index\n");
 			return -EIO;
 		}
 	}
@@ -2237,7 +2238,7 @@ int xtAppend(tid_t tid,		/* transaction id */
 	split.pxdlist = &pxdlist;
 	pxdlist.maxnpxd = pxdlist.npxd = 0;
 	pxd = &pxdlist.pxd[0];
-	nblocks = JFS_SBI(ip->i_sb)->nbperpage;
+	nblocks = JFS_SBI(inode_sb(ip))->nbperpage;
 	for (; nsplit > 0; nsplit--, pxd++, xaddr += nblocks, maxblocks -= nblocks) {
 		if ((rc = dbAllocBottomUp(ip, xaddr, (s64) nblocks)) == 0) {
 			PXDaddress(pxd, xaddr);
@@ -2493,7 +2494,7 @@ xtDeleteUp(tid_t tid, struct inode *ip,
 				xaddr = addressPXD(&p->header.self);
 				/* free the page extent */
 				dbFree(ip, xaddr,
-				       (s64) JFS_SBI(ip->i_sb)->nbperpage);
+				       (s64) JFS_SBI(inode_sb(ip))->nbperpage);
 
 				/* unpin/free the buffer page */
 				discard_metapage(mp);
@@ -2587,7 +2588,7 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
 	xlen = lengthXAD(oxad);
 
 	/* validate extent offset */
-	offset = xoff << JFS_SBI(ip->i_sb)->l2bsize;
+	offset = xoff << JFS_SBI(inode_sb(ip))->l2bsize;
 	if (offset >= ip->i_size)
 		return -ESTALE;	/* stale extent */
 
@@ -2669,9 +2670,9 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
 		 * it is a good strategy because it may disrupt cache
 		 * policy to keep the pages in memory afterwards.
 		 */
-		offset = xoff << JFS_SBI(ip->i_sb)->l2bsize;
+		offset = xoff << JFS_SBI(inode_sb(ip))->l2bsize;
 		assert((offset & CM_OFFSET) == 0);
-		nbytes = xlen << JFS_SBI(ip->i_sb)->l2bsize;
+		nbytes = xlen << JFS_SBI(inode_sb(ip))->l2bsize;
 		pno = offset >> CM_L2BSIZE;
 		npages = (nbytes + (CM_BSIZE - 1)) >> CM_L2BSIZE;
 /*
@@ -2695,7 +2696,7 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
 			assert(!cp->cm_modified);
 
 			/* bind buffer with the new extent address */
-			nblks = nb >> JFS_IP(ip->i_sb)->l2bsize;
+			nblks = nb >> JFS_IP(inode_sb(ip))->l2bsize;
 			cmSetXD(ip, cp, pno, dxaddr, nblks);
 
 			/* release the cbuf, mark it as modified */
@@ -2803,7 +2804,7 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
 		    le16_to_cpu(p->header.nextindex) - xtlck->lwm.offset;
 
 		/* update the buffer extent descriptor of target xtpage */
-		xsize = xlen << JFS_SBI(ip->i_sb)->l2bsize;
+		xsize = xlen << JFS_SBI(inode_sb(ip))->l2bsize;
 		bmSetXD(mp, nxaddr, xsize);
 
 		/* unpin the target page to new homeward bound */
@@ -3225,8 +3226,8 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
 	 * (this will allow continued access of data/index of
 	 * temporary file (zerolink count file truncated to zero-length)).
 	 */
-	teof = (newsize + (JFS_SBI(ip->i_sb)->bsize - 1)) >>
-	    JFS_SBI(ip->i_sb)->l2bsize;
+	teof = (newsize + (JFS_SBI(inode_sb(ip))->bsize - 1)) >>
+	    JFS_SBI(inode_sb(ip))->l2bsize;
 
 	/* clear stack */
 	BT_CLR(&btstack);
@@ -3291,7 +3292,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
 			 * to avoid exhausting pagecache & tlocks
 			 */
 			XT_PUTPAGE(mp);
-			newsize = (xoff + xlen) << JFS_SBI(ip->i_sb)->l2bsize;
+			newsize = (xoff + xlen) << JFS_SBI(inode_sb(ip))->l2bsize;
 			goto getParent;
 		}
 		tlck = txLock(tid, ip, mp, tlckXTREE);
@@ -3649,7 +3650,7 @@ s64 xtTruncate(tid_t tid, struct inode *ip, s64 newsize, int flag)
       getChild:
 	/* save current parent entry for the child page */
 	if (BT_STACK_FULL(&btstack)) {
-		jfs_error(ip->i_sb, "stack overrun!\n");
+		jfs_error(inode_sb(ip), "stack overrun!\n");
 		XT_PUTPAGE(mp);
 		return -EIO;
 	}
@@ -3741,7 +3742,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 	BT_CLR(&btstack);
 
 	if (committed_size) {
-		xoff = (committed_size >> JFS_SBI(ip->i_sb)->l2bsize) - 1;
+		xoff = (committed_size >> JFS_SBI(inode_sb(ip))->l2bsize) - 1;
 		rc = xtSearch(ip, xoff, NULL, &cmp, &btstack, 0);
 		if (rc)
 			return rc;
@@ -3750,7 +3751,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 
 		if (cmp != 0) {
 			XT_PUTPAGE(mp);
-			jfs_error(ip->i_sb, "did not find extent\n");
+			jfs_error(inode_sb(ip), "did not find extent\n");
 			return -EIO;
 		}
 	} else {
@@ -3789,7 +3790,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
 		xoff = offsetXAD(xad);
 		xlen = lengthXAD(xad);
 		XT_PUTPAGE(mp);
-		return (xoff + xlen) << JFS_SBI(ip->i_sb)->l2bsize;
+		return (xoff + xlen) << JFS_SBI(inode_sb(ip))->l2bsize;
 	}
 	tlck = txLock(tid, ip, mp, tlckXTREE);
 	tlck->type = tlckXTREE | tlckFREE;
@@ -3849,7 +3850,7 @@ s64 xtTruncate_pmap(tid_t tid, struct inode *ip, s64 committed_size)
       getChild:
 	/* save current parent entry for the child page */
 	if (BT_STACK_FULL(&btstack)) {
-		jfs_error(ip->i_sb, "stack overrun!\n");
+		jfs_error(inode_sb(ip), "stack overrun!\n");
 		XT_PUTPAGE(mp);
 		return -EIO;
 	}
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index b41596d71858..fd14fb2879b2 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -108,7 +108,7 @@ static int jfs_create(struct inode *dip, struct dentry *dentry, umode_t mode,
 		goto out2;
 	}
 
-	tid = txBegin(dip->i_sb, 0);
+	tid = txBegin(inode_sb(dip), 0);
 
 	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -242,7 +242,7 @@ static int jfs_mkdir(struct inode *dip, struct dentry *dentry, umode_t mode)
 		goto out2;
 	}
 
-	tid = txBegin(dip->i_sb, 0);
+	tid = txBegin(inode_sb(dip), 0);
 
 	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -376,7 +376,7 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
 		goto out;
 	}
 
-	tid = txBegin(dip->i_sb, 0);
+	tid = txBegin(inode_sb(dip), 0);
 
 	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -503,7 +503,7 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
 
 	IWRITE_LOCK(ip, RDWRLOCK_NORMAL);
 
-	tid = txBegin(dip->i_sb, 0);
+	tid = txBegin(inode_sb(dip), 0);
 
 	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -576,7 +576,7 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
 	mutex_unlock(&JFS_IP(dip)->commit_mutex);
 
 	while (new_size && (rc == 0)) {
-		tid = txBegin(dip->i_sb, 0);
+		tid = txBegin(inode_sb(dip), 0);
 		mutex_lock(&JFS_IP(ip)->commit_mutex);
 		new_size = xtTruncate_pmap(tid, ip, new_size);
 		if (new_size < 0) {
@@ -815,7 +815,7 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
-	tid = txBegin(ip->i_sb, 0);
+	tid = txBegin(inode_sb(ip), 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -930,7 +930,7 @@ static int jfs_symlink(struct inode *dip, struct dentry *dentry,
 		goto out2;
 	}
 
-	tid = txBegin(dip->i_sb, 0);
+	tid = txBegin(inode_sb(dip), 0);
 
 	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -991,7 +991,7 @@ static int jfs_symlink(struct inode *dip, struct dentry *dentry,
 		 * path name) is treated as non-journaled user data,
 		 * it is read/written thru buffer cache for performance.
 		 */
-		sb = ip->i_sb;
+		sb = inode_sb(ip);
 		bmask = JFS_SBI(sb)->bsize - 1;
 		xsize = (ssize + bmask) & ~bmask;
 		xaddr = 0;
@@ -1163,7 +1163,7 @@ static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	/*
 	 * The real work starts here
 	 */
-	tid = txBegin(new_dir->i_sb, 0);
+	tid = txBegin(inode_sb(new_dir), 0);
 
 	/*
 	 * How do we know the locking is safe from deadlocks?
@@ -1199,7 +1199,7 @@ static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
 				if (!S_ISDIR(old_ip->i_mode) && new_ip)
 					IWRITE_UNLOCK(new_ip);
-				jfs_error(new_ip->i_sb,
+				jfs_error(inode_sb(new_ip),
 					  "new_ip->i_nlink != 0\n");
 				return -EIO;
 			}
@@ -1322,7 +1322,7 @@ static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
 
 	while (new_size && (rc == 0)) {
-		tid = txBegin(new_ip->i_sb, 0);
+		tid = txBegin(inode_sb(new_ip), 0);
 		mutex_lock(&JFS_IP(new_ip)->commit_mutex);
 		new_size = xtTruncate_pmap(tid, new_ip, new_size);
 		if (new_size < 0) {
@@ -1392,7 +1392,7 @@ static int jfs_mknod(struct inode *dir, struct dentry *dentry,
 	}
 	jfs_ip = JFS_IP(ip);
 
-	tid = txBegin(dir->i_sb, 0);
+	tid = txBegin(inode_sb(dir), 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
 	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
@@ -1479,7 +1479,7 @@ static struct dentry *jfs_lookup(struct inode *dip, struct dentry *dentry, unsig
 		jfs_err("jfs_lookup: dtSearch returned %d", rc);
 		ip = ERR_PTR(rc);
 	} else {
-		ip = jfs_iget(dip->i_sb, inum);
+		ip = jfs_iget(inode_sb(dip), inum);
 		if (IS_ERR(ip))
 			jfs_err("jfs_lookup: iget failed on inum %d", (uint)inum);
 	}
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 1b9264fd54b6..2a49d6d31b42 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -139,7 +139,7 @@ static void jfs_destroy_inode(struct inode *inode)
 
 	spin_lock_irq(&ji->ag_lock);
 	if (ji->active_ag != -1) {
-		struct bmap *bmap = JFS_SBI(inode->i_sb)->bmap;
+		struct bmap *bmap = JFS_SBI(inode_sb(inode))->bmap;
 		atomic_dec(&bmap->db_active[ji->active_ag]);
 		ji->active_ag = -1;
 	}
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index c60f3d32ee91..323de7df3334 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -214,7 +214,7 @@ static int ea_write_inline(struct inode *ip, struct jfs_ea_list *ealist,
 static int ea_write(struct inode *ip, struct jfs_ea_list *ealist, int size,
 		       dxd_t * ea)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	struct jfs_inode_info *ji = JFS_IP(ip);
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	int nblocks;
@@ -363,7 +363,7 @@ static int ea_read_inline(struct inode *ip, struct jfs_ea_list *ealist)
  */
 static int ea_read(struct inode *ip, struct jfs_ea_list *ealist)
 {
-	struct super_block *sb = ip->i_sb;
+	struct super_block *sb = inode_sb(ip);
 	struct jfs_inode_info *ji = JFS_IP(ip);
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	int nblocks;
@@ -439,7 +439,7 @@ static int ea_read(struct inode *ip, struct jfs_ea_list *ealist)
 static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 {
 	struct jfs_inode_info *ji = JFS_IP(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int size;
 	int ea_size = sizeDXD(&ji->ea);
 	int blocks_needed, current_blocks;
@@ -923,7 +923,7 @@ static int __jfs_xattr_set(struct inode *inode, const char *name,
 	tid_t tid;
 	int rc;
 
-	tid = txBegin(inode->i_sb, 0);
+	tid = txBegin(inode_sb(inode), 0);
 	mutex_lock(&ji->commit_mutex);
 	rc = __jfs_setxattr(tid, inode, name, value, size, flags);
 	if (!rc)
-- 
2.15.1
