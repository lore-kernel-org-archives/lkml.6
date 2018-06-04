Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeFDPXA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752413AbeFDPW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:22:56 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to clear FI_VOLATILE_FILE correctly
Date: Mon,  4 Jun 2018 23:20:51 +0800
Message-Id: <20180604152051.26123-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Thread A			Thread B
- f2fs_release_file
 - clear_inode_flag(FI_VOLATILE_FILE)
				- wb_writeback
				 - writeback_sb_inodes
				  - __writeback_single_inode
				   - do_writepages
				    - f2fs_write_data_pages
				     - __write_data_page
				     all volatile file's pages
				     are writebacked to storage
 - set_inode_flag(FI_DROP_CACHE)
 - filemap_fdatawrite

There is a hole that mm can flush all dirty pages of volatile file as
inode is not tagged with both FI_VOLATILE_FILE and FI_DROP_CACHE flags,
we should never writeback the page #0 and also it's unneeded to writeback
other pages.

This patch adjusts to relocate clear_inode_flag(FI_VOLATILE_FILE), so that
FI_VOLATILE_FILE flag can be remained before all dirty pages were dropped
to avoid issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 16fd50abbf40..13f2f6845e87 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1564,11 +1564,11 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		f2fs_drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
-		clear_inode_flag(inode, FI_VOLATILE_FILE);
-		stat_dec_volatile_write(inode);
 		set_inode_flag(inode, FI_DROP_CACHE);
 		filemap_fdatawrite(inode->i_mapping);
 		clear_inode_flag(inode, FI_DROP_CACHE);
+		clear_inode_flag(inode, FI_VOLATILE_FILE);
+		stat_dec_volatile_write(inode);
 	}
 	return 0;
 }
-- 
2.16.2.17.g38e79b1fd
