Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754539AbeDIUmu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754243AbeDIUmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A6821785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Mon, 9 Apr 2018 13:42:44 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: don't use GFP_ZERO for page caches
Message-ID: <20180409204244.GA25905@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409190012.21552-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change log from v1:
 - don't memset for recovered page

Related to https://lkml.org/lkml/2018/4/8/661

Sometimes, we need to write meta data to new allocated block address,
then we will allocate a zeroed page in inner inode's address space, and
fill partial data in it, and leave other place with zero value which means
some fields are initial status.

There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
I have just checked them, for both of them, we can avoid using __GFP_ZERO,
and do initialization by ourselves to avoid unneeded/redundant zeroing
from mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 4 ++--
 fs/f2fs/node.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 417c9dcd0269..87535bf63421 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -320,10 +320,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 make_now:
 	if (ino == F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_node_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (ino == F2FS_META_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_meta_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9a99243054ba..5a4469093e43 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1096,7 +1096,8 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
 	f2fs_wait_on_page_writeback(page, NODE, true);
-	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
+	memset(F2FS_NODE(page), 0, PAGE_SIZE);
+	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, false);
 	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
-- 
2.15.0.531.g2ccb3012c9-goog
