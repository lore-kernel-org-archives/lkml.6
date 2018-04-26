Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeDZId0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:33:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754592AbeDZIdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:33:21 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to wait IO writeback in __revoke_inmem_pages()
Date: Thu, 26 Apr 2018 16:32:47 +0800
Message-ID: <20180426083247.86337-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A				Thread B
- f2fs_ioc_commit_atomic_write
 - commit_inmem_pages
  - f2fs_submit_merged_write_cond
  : write data
					- write_checkpoint
					 - do_checkpoint
					 : commit all node within CP
					 -> SPO
  - f2fs_do_sync_file
   - file_write_and_wait_range
   : wait data writeback

In above race condition, data/node can be flushed in reversed order when
coming a checkpoint before f2fs_do_sync_file, after SPOR, it results in
atomic written data being corrupted.

This patch adds f2fs_wait_on_page_writeback in __revoke_inmem_pages() to
keep data and node of atomic file being flushed orderly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c    | 4 ++++
 fs/f2fs/segment.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be7578774a47..a352804af244 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -217,6 +217,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	trace_f2fs_sync_file_enter(inode);
 
+	if (atomic)
+		goto write_done;
+
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);
@@ -228,6 +231,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		return ret;
 	}
 
+write_done:
 	/* if the inode is dirty, let's recover all the time */
 	if (!f2fs_skip_inode_update(inode, datasync)) {
 		f2fs_write_inode(inode, NULL);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 584483426584..9ca3d0a43d93 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -230,6 +230,8 @@ static int __revoke_inmem_pages(struct inode *inode,
 
 		lock_page(page);
 
+		f2fs_wait_on_page_writeback(page, DATA, true);
+
 		if (recover) {
 			struct dnode_of_data dn;
 			struct node_info ni;
@@ -415,6 +417,7 @@ static int __commit_inmem_pages(struct inode *inode)
 		/* drop all uncommitted pages */
 		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	} else {
+		/* wait all committed IOs writeback and release them from list */
 		__revoke_inmem_pages(inode, &revoke_list, false, false);
 	}
 
-- 
2.15.0.55.gc2ece9dc4de6
