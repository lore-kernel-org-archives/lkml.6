Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeDWCg7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:36:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754137AbeDWCgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:36:44 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: clean up commit_inmem_pages()
Date: Mon, 23 Apr 2018 10:36:14 +0800
Message-ID: <20180423023615.33247-2-yuchao0@huawei.com>
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

This patch moves error handling from commit_inmem_pages() into
__commit_inmem_page() for cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 24299f81f80d..dcb4fcb8b1b0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -347,8 +347,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
 }
 
-static int __commit_inmem_pages(struct inode *inode,
-					struct list_head *revoke_list)
+static int __commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -361,9 +360,12 @@ static int __commit_inmem_pages(struct inode *inode,
 		.op_flags = REQ_SYNC | REQ_PRIO,
 		.io_type = FS_DATA_IO,
 	};
+	struct list_head revoke_list;
 	pgoff_t last_idx = ULONG_MAX;
 	int err = 0;
 
+	INIT_LIST_HEAD(&revoke_list);
+
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
 		struct page *page = cur->page;
 
@@ -397,14 +399,28 @@ static int __commit_inmem_pages(struct inode *inode,
 			last_idx = page->index;
 		}
 		unlock_page(page);
-		list_move_tail(&cur->list, revoke_list);
+		list_move_tail(&cur->list, &revoke_list);
 	}
 
 	if (last_idx != ULONG_MAX)
 		f2fs_submit_merged_write_cond(sbi, inode, 0, last_idx, DATA);
 
-	if (!err)
-		__revoke_inmem_pages(inode, revoke_list, false, false);
+	if (err) {
+		/*
+		 * try to revoke all committed pages, but still we could fail
+		 * due to no memory or other reason, if that happened, EAGAIN
+		 * will be returned, which means in such case, transaction is
+		 * already not integrity, caller should use journal to do the
+		 * recovery or rewrite & commit last transaction. For other
+		 * error number, revoking was done by filesystem itself.
+		 */
+		err = __revoke_inmem_pages(inode, &revoke_list, false, true);
+
+		/* drop all uncommitted pages */
+		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
+	} else {
+		__revoke_inmem_pages(inode, &revoke_list, false, false);
+	}
 
 	return err;
 }
@@ -413,34 +429,16 @@ int commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct list_head revoke_list;
 	int err;
 
-	INIT_LIST_HEAD(&revoke_list);
 	f2fs_balance_fs(sbi, true);
 	f2fs_lock_op(sbi);
 
 	set_inode_flag(inode, FI_ATOMIC_COMMIT);
 
 	mutex_lock(&fi->inmem_lock);
-	err = __commit_inmem_pages(inode, &revoke_list);
-	if (err) {
-		int ret;
-		/*
-		 * try to revoke all committed pages, but still we could fail
-		 * due to no memory or other reason, if that happened, EAGAIN
-		 * will be returned, which means in such case, transaction is
-		 * already not integrity, caller should use journal to do the
-		 * recovery or rewrite & commit last transaction. For other
-		 * error number, revoking was done by filesystem itself.
-		 */
-		ret = __revoke_inmem_pages(inode, &revoke_list, false, true);
-		if (ret)
-			err = ret;
+	err = __commit_inmem_pages(inode);
 
-		/* drop all uncommitted pages */
-		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
-	}
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
-- 
2.15.0.55.gc2ece9dc4de6
