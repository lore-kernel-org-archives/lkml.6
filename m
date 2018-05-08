Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755898AbeEHSME (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:12:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54243 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755835AbeEHSGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:15 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 60/76] fs/qnx4: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:20 -0700
Message-Id: <20180508180436.716-61-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/qnx4/dir.c   | 2 +-
 fs/qnx4/inode.c | 4 ++--
 fs/qnx4/namei.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index a6ee23aadd28..c0e764ce79dd 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -31,7 +31,7 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 
 	while (ctx->pos < inode->i_size) {
 		blknum = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS);
-		bh = sb_bread(inode->i_sb, blknum);
+		bh = sb_bread(inode_sb(inode), blknum);
 		if (bh == NULL) {
 			printk(KERN_ERR "qnx4_readdir: bread failed (%ld)\n", blknum);
 			return 0;
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3d46fe302fcb..2b5e5b18e084 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -60,7 +60,7 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
 	phys = qnx4_block_map( inode, iblock );
 	if ( phys ) {
 		// logical block is before EOF
-		map_bh(bh, inode->i_sb, phys);
+		map_bh(bh, inode_sb(inode), phys);
 	}
 	return 0;
 }
@@ -94,7 +94,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 		while ( --nxtnt > 0 ) {
 			if ( ix == 0 ) {
 				// read next xtnt block.
-				bh = sb_bread(inode->i_sb, i_xblk - 1);
+				bh = sb_bread(inode_sb(inode), i_xblk - 1);
 				if ( !bh ) {
 					QNX4DEBUG((KERN_ERR "qnx4: I/O error reading xtnt block [%ld])\n", i_xblk - 1));
 					return -EIO;
diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index eca27878079d..3a84a8f6c6a7 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -67,7 +67,7 @@ static struct buffer_head *qnx4_find_entry(int len, struct inode *dir,
 		if (!bh) {
 			block = qnx4_block_map(dir, blkofs);
 			if (block)
-				bh = sb_bread(dir->i_sb, block);
+				bh = sb_bread(inode_sb(dir), block);
 			if (!bh) {
 				blkofs++;
 				continue;
@@ -113,7 +113,7 @@ struct dentry * qnx4_lookup(struct inode *dir, struct dentry *dentry, unsigned i
 	}
 	brelse(bh);
 
-	foundinode = qnx4_iget(dir->i_sb, ino);
+	foundinode = qnx4_iget(inode_sb(dir), ino);
 	if (IS_ERR(foundinode)) {
 		QNX4DEBUG((KERN_ERR "qnx4: lookup->iget -> error %ld\n",
 			   PTR_ERR(foundinode)));
-- 
2.15.1
