Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeB0Opu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753292AbeB0Opt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:45:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C273E2168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid race in between atomic write and background GC
Date: Tue, 27 Feb 2018 22:45:24 +0800
Message-Id: <20180227144524.8296-1-chao@kernel.org>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Sqlite user			Background GC
				- move_data_block
				  : move page #1
				 - f2fs_is_atomic_file
- f2fs_ioc_start_atomic_write
- f2fs_ioc_commit_atomic_write
 - commit_inmem_pages
   : commit page #1 & set node #2 dirty
				 - f2fs_submit_page_write
				  - f2fs_update_data_blkaddr
				   - set_page_dirty
				     : set node #2 dirty
 - f2fs_do_sync_file
  - fsync_node_pages
   : commit node #1 & node #2, then sudden power-cut

In a race case, we may check FI_ATOMIC_FILE flag before starting atomic
write flow, then we will commit meta data before data with reversed
order, after a sudden pow-cut, database transaction will be inconsistent.

So we'd better to exclude gc/atomic_write to each other by using lock
instead of flag checking.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4821ea97e080..d3d5ef6596f6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1716,6 +1716,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	if (f2fs_is_volatile_file(inode))
 		goto err_out;
 
@@ -1734,6 +1736,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
 err_out:
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.14.1.145.gb3622a4ee
