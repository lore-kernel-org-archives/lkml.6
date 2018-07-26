Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA4E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA4E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeGZNpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:45:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730439AbeGZNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:45:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58E24B83115A7;
        Thu, 26 Jul 2018 20:28:38 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:28:33 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 22/25] staging: erofs: introduce workstation for decompression
Date:   Thu, 26 Jul 2018 20:22:05 +0800
Message-ID: <1532607728-103372-23-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces another concept used by the unzip
subsystem called 'workstation'. It can be seen as a sparse
array that stores pointers pointed to data structures
related to the corresponding physical blocks.

All lookup cases are protected by RCU read lock. Besides,
reference count and spin_lock are also introduced to
manage its lifetime and serialize all update operations.

'workstation' is currently implemented on the in-kernel
radix tree approach for backward compatibility.
With the evolution of linux kernel, it could be migrated
into XArray implementation in the future.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 93 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/erofs/super.c    |  9 ++++
 drivers/staging/erofs/utils.c    | 81 ++++++++++++++++++++++++++++++++--
 3 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 42455f0..b07cd7a 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -79,6 +79,9 @@ struct erofs_sb_info {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* cluster size in bit shift */
 	unsigned char clusterbits;
+
+	/* the dedicated workstation for compression */
+	struct radix_tree_root workstn_tree;
 #endif
 
 	u32 build_time_nsec;
@@ -149,6 +152,96 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
 #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
 
+#ifdef CONFIG_EROFS_FS_ZIP
+#define erofs_workstn_lock(sbi)         xa_lock(&(sbi)->workstn_tree)
+#define erofs_workstn_unlock(sbi)       xa_unlock(&(sbi)->workstn_tree)
+
+/* basic unit of the workstation of a super_block */
+struct erofs_workgroup {
+	/* the workgroup index in the workstation */
+	pgoff_t index;
+
+	/* overall workgroup reference count */
+	atomic_t refcount;
+};
+
+#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
+
+static inline bool erofs_workgroup_try_to_freeze(
+	struct erofs_workgroup *grp, int v)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	if (v != atomic_cmpxchg(&grp->refcount,
+		v, EROFS_LOCKED_MAGIC))
+		return false;
+	preempt_disable();
+#else
+	preempt_disable();
+	if (atomic_read(&grp->refcount) != v) {
+		preempt_enable();
+		return false;
+	}
+#endif
+	return true;
+}
+
+static inline void erofs_workgroup_unfreeze(
+	struct erofs_workgroup *grp, int v)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	atomic_set(&grp->refcount, v);
+#endif
+	preempt_enable();
+}
+
+static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
+{
+	const int locked = (int)EROFS_LOCKED_MAGIC;
+	int o;
+
+repeat:
+	o = atomic_read(&grp->refcount);
+
+	/* spin if it is temporarily locked at the reclaim path */
+	if (unlikely(o == locked)) {
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+		do
+			cpu_relax();
+		while (atomic_read(&grp->refcount) == locked);
+#endif
+		goto repeat;
+	}
+
+	if (unlikely(o <= 0))
+		return -1;
+
+	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
+		goto repeat;
+
+	*ocnt = o;
+	return 0;
+}
+
+#define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
+
+extern int erofs_workgroup_put(struct erofs_workgroup *grp);
+
+extern struct erofs_workgroup *erofs_find_workgroup(
+	struct super_block *sb, pgoff_t index, bool *tag);
+
+extern int erofs_register_workgroup(struct super_block *sb,
+	struct erofs_workgroup *grp, bool tag);
+
+extern unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
+	unsigned long nr_shrink, bool cleanup);
+
+static inline void erofs_workstation_cleanup_all(struct super_block *sb)
+{
+	erofs_shrink_workstation(EROFS_SB(sb), ~0UL, true);
+}
+
+#endif
+
 /* we strictly follow PAGE_SIZE and no buffer head yet */
 #define LOG_BLOCK_SIZE		PAGE_SHIFT
 
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index ef85884..e155a2b 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -296,6 +296,10 @@ static int erofs_read_super(struct super_block *sb,
 	if (!silent)
 		infoln("root inode @ nid %llu", ROOT_NID(sbi));
 
+#ifdef CONFIG_EROFS_FS_ZIP
+	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
+#endif
+
 	/* get the root inode */
 	inode = erofs_iget(sb, ROOT_NID(sbi), true);
 	if (IS_ERR(inode)) {
@@ -376,6 +380,11 @@ static void erofs_put_super(struct super_block *sb)
 	__putname(sbi->dev_name);
 
 	mutex_lock(&sbi->umount_mutex);
+
+#ifdef CONFIG_EROFS_FS_ZIP
+	erofs_workstation_cleanup_all(sb);
+#endif
+
 	erofs_unregister_super(sb);
 	mutex_unlock(&sbi->umount_mutex);
 
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index c1d83ce..0d4eae2 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -29,6 +29,83 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 	return page;
 }
 
+/* global shrink count (for all mounted EROFS instances) */
+static atomic_long_t erofs_global_shrink_cnt;
+
+#ifdef CONFIG_EROFS_FS_ZIP
+
+/* radix_tree and the future XArray both don't use tagptr_t yet */
+struct erofs_workgroup *erofs_find_workgroup(
+	struct super_block *sb, pgoff_t index, bool *tag)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_workgroup *grp;
+	int oldcount;
+
+repeat:
+	rcu_read_lock();
+	grp = radix_tree_lookup(&sbi->workstn_tree, index);
+	if (grp != NULL) {
+		*tag = radix_tree_exceptional_entry(grp);
+		grp = (void *)((unsigned long)grp &
+			~RADIX_TREE_EXCEPTIONAL_ENTRY);
+
+		if (erofs_workgroup_get(grp, &oldcount)) {
+			/* prefer to relax rcu read side */
+			rcu_read_unlock();
+			goto repeat;
+		}
+
+		/* decrease refcount added by erofs_workgroup_put */
+		if (unlikely(oldcount == 1))
+			atomic_long_dec(&erofs_global_shrink_cnt);
+		BUG_ON(index != grp->index);
+	}
+	rcu_read_unlock();
+	return grp;
+}
+
+int erofs_register_workgroup(struct super_block *sb,
+			     struct erofs_workgroup *grp,
+			     bool tag)
+{
+	struct erofs_sb_info *sbi;
+	int err;
+
+	/* grp->refcount should not < 1 */
+	BUG_ON(!atomic_read(&grp->refcount));
+
+	err = radix_tree_preload(GFP_NOFS);
+	if (err)
+		return err;
+
+	sbi = EROFS_SB(sb);
+	erofs_workstn_lock(sbi);
+
+	if (tag)
+		grp = (void *)((unsigned long)grp |
+			1UL << RADIX_TREE_EXCEPTIONAL_SHIFT);
+
+	err = radix_tree_insert(&sbi->workstn_tree,
+		grp->index, grp);
+
+	if (!err) {
+		__erofs_workgroup_get(grp);
+	}
+
+	erofs_workstn_unlock(sbi);
+	radix_tree_preload_end();
+	return err;
+}
+
+unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
+				       unsigned long nr_shrink,
+				       bool cleanup)
+{
+	return 0;
+}
+
+#endif
 
 /* protected by 'erofs_sb_list_lock' */
 static unsigned int shrinker_run_no;
@@ -37,9 +114,6 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 static DEFINE_SPINLOCK(erofs_sb_list_lock);
 static LIST_HEAD(erofs_sb_list);
 
-/* global shrink count (for all mounted EROFS instances) */
-static atomic_long_t erofs_global_shrink_cnt;
-
 void erofs_register_super(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -112,6 +186,7 @@ unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		list_move_tail(&sbi->list, &erofs_sb_list);
 		mutex_unlock(&sbi->umount_mutex);
 
+		freed += erofs_shrink_workstation(sbi, nr, false);
 		if (freed >= nr)
 			break;
 	}
-- 
1.9.1

