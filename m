Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDHINi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 04:13:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751040AbeDHINh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 04:13:37 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: set deadline to drop expired inmem pages
Date: Sun, 8 Apr 2018 16:13:12 +0800
Message-ID: <20180408081312.6190-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.15.0.55.gc2ece9dc4de6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs doesn't allow abuse on atomic write class interface, so except
limiting in-mem pages' total memory usage capacity, we need to limit
start-commit time as well, otherwise we may run into infinite loop
during foreground GC because target blocks in victim segment are
belong to atomic opened file for long time.

Now, we will check the condition with f2fs_balance_fs_bg in
background threads, once if user doesn't commit data exceeding 30
seconds, we will drop all cached data, so I expect it can keep our
system running safely to prevent Dos attack.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/segment.h |  2 ++
 fs/f2fs/super.c   |  1 +
 4 files changed, 45 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1725b82d9fb2..5b617231970b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -653,6 +653,7 @@ struct f2fs_inode_info {
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
 	struct list_head inmem_ilist;	/* list for inmem inodes */
+	struct timespec inmem_time;	/* atomic write start time */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct task_struct *inmem_task;	/* store inmemory task */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
@@ -2859,6 +2860,7 @@ void destroy_node_manager_caches(void);
 bool need_SSR(struct f2fs_sb_info *sbi);
 void register_inmem_page(struct inode *inode, struct page *page);
 void drop_inmem_pages_all(struct f2fs_sb_info *sbi);
+void drop_inmem_pages_exceed_time(struct f2fs_sb_info *sbi);
 void drop_inmem_pages(struct inode *inode);
 void drop_inmem_page(struct inode *inode, struct page *page);
 int commit_inmem_pages(struct inode *inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e61faff9b109..8a558f038f9f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -208,6 +208,8 @@ void register_inmem_page(struct inode *inode, struct page *page)
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (list_empty(&fi->inmem_ilist))
 		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
+	if (!timespec_valid(&fi->inmem_time))
+		fi->inmem_time = current_kernel_time();
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
 	mutex_unlock(&fi->inmem_lock);
@@ -295,6 +297,36 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi)
 	goto next;
 }
 
+void drop_inmem_pages_exceed_time(struct f2fs_sb_info *sbi)
+{
+	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
+	struct inode *inode;
+	struct f2fs_inode_info *fi, *tmp;
+
+next:
+	inode = NULL;
+
+	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
+	list_for_each_entry_safe(fi, tmp, head, inmem_ilist) {
+		struct timespec ts = current_kernel_time();
+
+		ts.tv_sec -= DEF_ATOMIC_COMMIT_INTERVAL;
+		if (timespec_compare(&fi->inmem_time, &ts) >= 0)
+			continue;
+		inode = igrab(&fi->vfs_inode);
+		break;
+	}
+	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+
+	if (inode) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"drop inmem pages of inode (ino:%lu)", inode->i_ino);
+		drop_inmem_pages(inode);
+		iput(inode);
+		goto next;
+	}
+}
+
 void drop_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -306,6 +338,9 @@ void drop_inmem_pages(struct inode *inode)
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+
+	fi->inmem_time.tv_sec = -1;
+
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
@@ -441,6 +476,9 @@ int commit_inmem_pages(struct inode *inode)
 	if (!list_empty(&fi->inmem_ilist))
 		list_del_init(&fi->inmem_ilist);
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+
+	fi->inmem_time.tv_sec = -1;
+
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
@@ -491,6 +529,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		build_free_nids(sbi, false, false);
 
+	drop_inmem_pages_exceed_time(sbi);
+
 	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
 		return;
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3325d0769723..f5410dcb76b4 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -215,6 +215,8 @@ struct segment_allocation {
 #define IS_DUMMY_WRITTEN_PAGE(page)			\
 		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
 
+#define DEF_ATOMIC_COMMIT_INTERVAL		30
+
 struct inmem_pages {
 	struct list_head list;
 	struct page *page;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f758f66ef26..2e997d63c64a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -819,6 +819,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->gdirty_list);
 	INIT_LIST_HEAD(&fi->inmem_ilist);
+	fi->inmem_time.tv_sec = -1;
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
 	init_rwsem(&fi->dio_rwsem[READ]);
-- 
2.15.0.55.gc2ece9dc4de6
