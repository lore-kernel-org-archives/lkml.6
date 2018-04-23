Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbeDWPOf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755397AbeDWPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:14:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCFA20C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: wait IO writeback in commit_inmem_pages()
Date: Mon, 23 Apr 2018 23:14:25 +0800
Message-Id: <20180423151425.5019-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

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
v2:
- clean up codes suggested by Jaegeuk.
 fs/f2fs/file.c    | 4 ++++
 fs/f2fs/segment.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bac059474342..0cfa65c21d3f 100644
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
index 710d817c4350..31336fc54d8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -419,6 +419,8 @@ static int __commit_inmem_pages(struct inode *inode)
 		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
 	} else {
 		__revoke_inmem_pages(inode, &revoke_list, false, false);
+
+		err = filemap_fdatawait(inode->i_mapping);
 	}
 
 	return err;
-- 
2.16.2.17.g38e79b1fd
