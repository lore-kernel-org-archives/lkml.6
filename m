Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeEHClB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:41:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753525AbeEHCk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:40:59 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to wait atomic pages writeback in block_operations()
Date: Tue, 8 May 2018 10:40:37 +0800
Message-ID: <20180508024037.16636-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. thread A: commit_inmem_pages submit data into block layer, but
haven't waited it writeback.
2. thread A: commit_inmem_pages update related node.
3. thread B: do checkpoint, flush all nodes to disk.
4. SPOR

Then, atomic file becomes corrupted since nodes is flushed before data.

This patch fixes to try to wait all atomic pages writeback in
block_operations().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  4 +++-
 fs/f2fs/data.c       |  2 ++
 fs/f2fs/f2fs.h       |  2 ++
 fs/f2fs/segment.c    | 17 +++++++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 33d2da006789..d53d53f55c51 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1067,6 +1067,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		goto retry_flush_dents;
 	}
 
+	wait_inmem_pages_writeback(sbi);
+
 	/*
 	 * POR: we should ensure that there are no dirty node pages
 	 * until finishing nat/sit flush. inode->i_blocks can be updated.
@@ -1115,7 +1117,7 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 	f2fs_unlock_all(sbi);
 }
 
-static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
+void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 {
 	DEFINE_WAIT(wait);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5a979b5ee278..c181f58948c0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -48,6 +48,8 @@ static bool __is_cp_guaranteed(struct page *page)
 	if (inode->i_ino == F2FS_META_INO(sbi) ||
 			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
 			S_ISDIR(inode->i_mode) ||
+			(S_ISREG(inode->i_mode) &&
+			is_inode_flag_set(inode, FI_ATOMIC_FILE)) ||
 			is_cold_data(page))
 		return true;
 	return false;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bda9c3ce08ef..adfd512ae4a1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2839,6 +2839,7 @@ void destroy_node_manager_caches(void);
 bool need_SSR(struct f2fs_sb_info *sbi);
 void register_inmem_page(struct inode *inode, struct page *page);
 void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure);
+void wait_inmem_pages_writeback(struct f2fs_sb_info *sbi);
 void drop_inmem_pages(struct inode *inode);
 void drop_inmem_page(struct inode *inode, struct page *page);
 int commit_inmem_pages(struct inode *inode);
@@ -2926,6 +2927,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi);
 void update_dirty_page(struct inode *inode, struct page *page);
 void remove_dirty_inode(struct inode *inode);
 int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
+void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi);
 int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void init_ino_entry_info(struct f2fs_sb_info *sbi);
 int __init create_checkpoint_caches(void);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 24b71d450374..e8a81cbd6808 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -305,6 +305,23 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 	goto next;
 }
 
+void wait_inmem_pages_writeback(struct f2fs_sb_info *sbi)
+{
+	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
+	struct f2fs_inode_info *fi;
+
+	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
+	list_for_each_entry(fi, head, inmem_ilist) {
+		if (!down_read_trylock(&fi->i_gc_rwsem[WRITE])) {
+			spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+			wait_on_all_pages_writeback(sbi);
+			return;
+		}
+		up_read(&fi->i_gc_rwsem[WRITE]);
+	}
+	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+}
+
 void drop_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-- 
2.17.0.391.g1f1cddd558b5
