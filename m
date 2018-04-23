Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeDWCgg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:36:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41893 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753894AbeDWCge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:36:34 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: wait IO writeback in commit_inmem_pages()
Date: Mon, 23 Apr 2018 10:36:15 +0800
Message-ID: <20180423023615.33247-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
In-Reply-To: <20180423023615.33247-1-yuchao0@huawei.com>
References: <20180423023615.33247-1-yuchao0@huawei.com>
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

This patch adds filemap_fdatawait() in commit_inmem_pages() to keep data
and node of atomic file being flushed orderly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c    | 21 ++++++++++++---------
 fs/f2fs/segment.c |  2 ++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5d710f7f2684..4ea418cbd189 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -217,15 +217,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	trace_f2fs_sync_file_enter(inode);
 
-	/* if fdatasync is triggered, let's do in-place-update */
-	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
-		set_inode_flag(inode, FI_NEED_IPU);
-	ret = file_write_and_wait_range(file, start, end);
-	clear_inode_flag(inode, FI_NEED_IPU);
-
-	if (ret) {
-		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
-		return ret;
+	if (!atomic) {
+		/* if fdatasync is triggered, let's do in-place-update */
+		if (datasync || get_dirty_pages(inode) <=
+					SM_I(sbi)->min_fsync_blocks)
+			set_inode_flag(inode, FI_NEED_IPU);
+		ret = file_write_and_wait_range(file, start, end);
+		clear_inode_flag(inode, FI_NEED_IPU);
+
+		if (ret) {
+			trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
+			return ret;
+		}
 	}
 
 	/* if the inode is dirty, let's recover all the time */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dcb4fcb8b1b0..3b66c4aa04a6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -420,6 +420,8 @@ static int __commit_inmem_pages(struct inode *inode)
 		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	} else {
 		__revoke_inmem_pages(inode, &revoke_list, false, false);
+
+		err = filemap_fdatawait(inode->i_mapping);
 	}
 
 	return err;
-- 
2.15.0.55.gc2ece9dc4de6
