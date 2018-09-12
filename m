Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF9C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC192146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC192146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeIMAfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:35:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbeIMAfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:35:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89F33804BCF4;
        Wed, 12 Sep 2018 19:29:07 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF9E10DCF48;
        Wed, 12 Sep 2018 19:29:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 3/5] vfs: Use dlock list for superblock's inode list
Date:   Wed, 12 Sep 2018 15:28:50 -0400
Message-Id: <1536780532-4092-4-git-send-email-longman@redhat.com>
In-Reply-To: <1536780532-4092-1-git-send-email-longman@redhat.com>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:29:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 12 Sep 2018 19:29:07 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When many threads are trying to add or delete inode to or from
a superblock's s_inodes list, spinlock contention on the list can
become a performance bottleneck.

This patch changes the s_inodes field to become a dlock list which
is a distributed set of lists with per-list spinlocks.  As a result,
the following superblock inode list (sb->s_inodes) iteration functions
in vfs are also being modified:

 1. iterate_bdevs()
 2. drop_pagecache_sb()
 3. evict_inodes()
 4. invalidate_inodes()
 5. fsnotify_unmount_inodes()
 6. add_dquot_ref()
 7. remove_dquot_ref()

With an exit microbenchmark that creates a large number of threads,
attachs many inodes to them in procfs and then exits. The runtimes of
that microbenchmark with various number of threads before and after
the patch on a 4-socket Intel E7-8867 v3 system (64 cores, 128 threads)
on a 4.19-rc3 based kernel were as follows:

  # of threads  Elapsed/Sys Time    Elapsed/Sys Time    Speedup
                Unpatched Kernel     Patched Kernel
  ------------  ----------------    ----------------    -------
      1000      59.17s/123m09.8s    18.90s/24m44.5s      3.13
      1200      73.20s/151m24.1s    27.54s/50m05.3s      2.66
      1400     102.04s/212m00.9s    36.75s/68m26.7s      2.78
      1600     131.13s/272m52.4s    50.16s/94m23.7s      2.61

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c       |  9 ++++-----
 fs/drop_caches.c     |  9 ++++-----
 fs/inode.c           | 34 +++++++++++++---------------------
 fs/notify/fsnotify.c |  9 ++++-----
 fs/quota/dquot.c     | 14 ++++++--------
 fs/super.c           |  7 ++++---
 include/linux/fs.h   |  8 ++++----
 7 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 38b8ce0..7f596241 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2133,9 +2133,9 @@ int __invalidate_device(struct block_device *bdev, bool kill_dirty)
 void iterate_bdevs(void (*func)(struct block_device *, void *), void *arg)
 {
 	struct inode *inode, *old_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &blockdev_superblock->s_inodes);
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		struct address_space *mapping = inode->i_mapping;
 		struct block_device *bdev;
 
@@ -2147,7 +2147,7 @@ void iterate_bdevs(void (*func)(struct block_device *, void *), void *arg)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
 		 * removed from s_inodes list while we dropped the
@@ -2165,8 +2165,7 @@ void iterate_bdevs(void (*func)(struct block_device *, void *), void *arg)
 			func(bdev, arg);
 		mutex_unlock(&bdev->bd_mutex);
 
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 	iput(old_inode);
 }
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 8237701..7ddd5bb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,9 +17,9 @@
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
 		    (inode->i_mapping->nrpages == 0)) {
@@ -28,15 +28,14 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		iput(toput_inode);
 		toput_inode = inode;
 
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 	iput(toput_inode);
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 0b5381b..a99e045 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -29,7 +29,7 @@
  *   inode->i_state, inode->i_hash, __iget()
  * Inode LRU list locks protect:
  *   inode->i_sb->s_inode_lru, inode->i_lru
- * inode->i_sb->s_inode_list_lock protects:
+ * inode->i_sb->s_inodes->head->lock protects:
  *   inode->i_sb->s_inodes, inode->i_sb_list
  * bdi->wb.list_lock protects:
  *   bdi->wb.b_{dirty,io,more_io,dirty_time}, inode->i_io_list
@@ -38,7 +38,7 @@
  *
  * Lock ordering:
  *
- * inode->i_sb->s_inode_list_lock
+ * inode->i_sb->s_inodes->head->lock
  *   inode->i_lock
  *     Inode LRU list locks
  *
@@ -46,7 +46,7 @@
  *   inode->i_lock
  *
  * inode_hash_lock
- *   inode->i_sb->s_inode_list_lock
+ *   inode->i_sb->s_inodes->head->lock
  *   inode->i_lock
  *
  * iunique_lock
@@ -440,19 +440,14 @@ static void inode_lru_list_del(struct inode *inode)
  */
 void inode_sb_list_add(struct inode *inode)
 {
-	spin_lock(&inode->i_sb->s_inode_list_lock);
-	list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
-	spin_unlock(&inode->i_sb->s_inode_list_lock);
+	dlock_lists_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
 static inline void inode_sb_list_del(struct inode *inode)
 {
-	if (!list_empty(&inode->i_sb_list)) {
-		spin_lock(&inode->i_sb->s_inode_list_lock);
-		list_del_init(&inode->i_sb_list);
-		spin_unlock(&inode->i_sb->s_inode_list_lock);
-	}
+	if (!list_empty(&inode->i_sb_list.list))
+		dlock_lists_del(&inode->i_sb_list);
 }
 
 static unsigned long hash(struct super_block *sb, unsigned long hashval)
@@ -607,11 +602,12 @@ static void dispose_list(struct list_head *head)
 void evict_inodes(struct super_block *sb)
 {
 	struct inode *inode;
+	struct dlock_list_iter iter;
 	LIST_HEAD(dispose);
 
 again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	init_dlock_list_iter(&iter, &sb->s_inodes);
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		if (atomic_read(&inode->i_count))
 			continue;
 
@@ -632,13 +628,12 @@ void evict_inodes(struct super_block *sb)
 		 * bit so we don't livelock.
 		 */
 		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
+			dlock_list_unlock(&iter);
 			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
 }
@@ -659,9 +654,9 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 	int busy = 0;
 	struct inode *inode;
 	LIST_HEAD(dispose);
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
@@ -683,7 +678,6 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
 
@@ -906,7 +900,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 		spin_lock(&inode->i_lock);
 		inode->i_state = 0;
 		spin_unlock(&inode->i_lock);
-		INIT_LIST_HEAD(&inode->i_sb_list);
+		init_dlock_list_node(&inode->i_sb_list);
 	}
 	return inode;
 }
@@ -927,8 +921,6 @@ struct inode *new_inode(struct super_block *sb)
 {
 	struct inode *inode;
 
-	spin_lock_prefetch(&sb->s_inode_list_lock);
-
 	inode = new_inode_pseudo(sb);
 	if (inode)
 		inode_sb_list_add(inode);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ababdbf..0c9084b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -51,9 +51,9 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 void fsnotify_unmount_inodes(struct super_block *sb)
 {
 	struct inode *inode, *iput_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		/*
 		 * We cannot __iget() an inode in state I_FREEING,
 		 * I_WILL_FREE, or I_NEW which is fine because by that point
@@ -78,7 +78,7 @@ void fsnotify_unmount_inodes(struct super_block *sb)
 
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 		if (iput_inode)
 			iput(iput_inode);
@@ -90,9 +90,8 @@ void fsnotify_unmount_inodes(struct super_block *sb)
 
 		iput_inode = inode;
 
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	if (iput_inode)
 		iput(iput_inode);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06..2cd91d7 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -941,13 +941,13 @@ static int dqinit_needed(struct inode *inode, int type)
 static int add_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode, *old_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 #ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
 #endif
 	int err = 0;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
 		    !atomic_read(&inode->i_writecount) ||
@@ -957,7 +957,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 #ifdef CONFIG_QUOTA_DEBUG
 		if (unlikely(inode_get_rsv_space(inode) > 0))
@@ -979,9 +979,8 @@ static int add_dquot_ref(struct super_block *sb, int type)
 		 * later.
 		 */
 		old_inode = inode;
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 	iput(old_inode);
 out:
 #ifdef CONFIG_QUOTA_DEBUG
@@ -1050,9 +1049,9 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 {
 	struct inode *inode;
 	int reserved = 0;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		/*
 		 *  We have to scan also I_NEW inodes because they can already
 		 *  have quota pointer initialized. Luckily, we need to touch
@@ -1067,7 +1066,6 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		}
 		spin_unlock(&dq_data_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 #ifdef CONFIG_QUOTA_DEBUG
 	if (reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
diff --git a/fs/super.c b/fs/super.c
index f3a8c00..dbbe96a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -177,6 +177,7 @@ static void destroy_unused_super(struct super_block *s)
 	up_write(&s->s_umount);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
+	free_dlock_list_heads(&s->s_inodes);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -242,8 +243,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
-	INIT_LIST_HEAD(&s->s_inodes);
-	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
@@ -262,6 +261,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.count_objects = super_cache_count;
 	s->s_shrink.batch = 1024;
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
+	if (alloc_dlock_list_heads(&s->s_inodes))
+		goto fail;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
 	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
@@ -455,7 +456,7 @@ void generic_shutdown_super(struct super_block *sb)
 		if (sop->put_super)
 			sop->put_super(sb);
 
-		if (!list_empty(&sb->s_inodes)) {
+		if (!dlock_lists_empty(&sb->s_inodes)) {
 			printk("VFS: Busy inodes after unmount of %s. "
 			   "Self-destruct in 5 seconds.  Have a nice day...\n",
 			   sb->s_id);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3332270..6f84731 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -37,6 +37,7 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
+#include <linux/dlock-list.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -647,7 +648,7 @@ struct inode {
 	u16			i_wb_frn_history;
 #endif
 	struct list_head	i_lru;		/* inode LRU list */
-	struct list_head	i_sb_list;
+	struct dlock_list_node	i_sb_list;
 	struct list_head	i_wb_list;	/* backing dev writeback list */
 	union {
 		struct hlist_head	i_dentry;
@@ -1458,9 +1459,8 @@ struct super_block {
 	 */
 	int s_stack_depth;
 
-	/* s_inode_list_lock protects s_inodes */
-	spinlock_t		s_inode_list_lock ____cacheline_aligned_in_smp;
-	struct list_head	s_inodes;	/* all inodes */
+	/* The internal per-list locks protect s_inodes */
+	struct dlock_list_heads s_inodes;	/* all inodes */
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
-- 
1.8.3.1

