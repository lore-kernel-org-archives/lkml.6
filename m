Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEGM3Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:29:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751978AbeEGM3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:29:16 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/3] f2fs: introduce GC_I for cleanup
Date: Mon, 7 May 2018 20:28:53 +0800
Message-ID: <20180507122854.91506-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
In-Reply-To: <20180507122854.91506-1-yuchao0@huawei.com>
References: <20180507122854.91506-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce GC_I to replace sbi->gc_thread for cleanup, no logic changes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase code.
 fs/f2fs/debug.c   |  2 +-
 fs/f2fs/f2fs.h    |  5 +++++
 fs/f2fs/gc.c      | 14 +++++++-------
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/super.c   |  4 ++--
 fs/f2fs/sysfs.c   |  8 ++++----
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a66107b5cfff..d92a01cb420c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -221,7 +221,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->cache_mem = 0;
 
 	/* build gc */
-	if (sbi->gc_thread)
+	if (GC_I(sbi))
 		si->cache_mem += sizeof(struct f2fs_gc_kthread);
 
 	/* build merge flush thread */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e238d0ea0be7..73a1a39889bc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1412,6 +1412,11 @@ static inline struct sit_info *SIT_I(struct f2fs_sb_info *sbi)
 	return (struct sit_info *)(SM_I(sbi)->sit_info);
 }
 
+static inline struct f2fs_gc_kthread *GC_I(struct f2fs_sb_info *sbi)
+{
+	return (struct f2fs_gc_kthread *)(sbi->gc_thread);
+}
+
 static inline struct free_segmap_info *FREE_I(struct f2fs_sb_info *sbi)
 {
 	return (struct free_segmap_info *)(SM_I(sbi)->free_info);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b74714be7be7..3c7914425b4e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -26,8 +26,8 @@
 static int gc_thread_func(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
-	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
+	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
+	wait_queue_head_t *wq = &gc_th->gc_wait_queue_head;
 	unsigned int wait_ms;
 
 	wait_ms = gc_th->min_sleep_time;
@@ -136,8 +136,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->gc_wake= 0;
 
 	sbi->gc_thread = gc_th;
-	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
-	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
+	init_waitqueue_head(&gc_th->gc_wait_queue_head);
+	gc_th->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
 		err = PTR_ERR(gc_th->f2fs_gc_task);
@@ -150,7 +150,7 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 
 void stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th = GC_I(sbi);
 	if (!gc_th)
 		return;
 	kthread_stop(gc_th->f2fs_gc_task);
@@ -188,7 +188,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->ofs_unit = 1;
 	} else {
 		down_read(&sbi->gc_rwsem);
-		p->gc_mode = select_gc_type(sbi->gc_thread, gc_type);
+		p->gc_mode = select_gc_type(GC_I(sbi), gc_type);
 		up_read(&sbi->gc_rwsem);
 		p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
 		p->max_search = dirty_i->nr_dirty[DIRTY];
@@ -198,7 +198,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 	/* we need to check every dirty segments in the FG_GC case */
 	down_read(&sbi->gc_rwsem);
 	if (gc_type != FG_GC &&
-			(sbi->gc_thread && !sbi->gc_thread->gc_urgent) &&
+			(GC_I(sbi) && !GC_I(sbi)->gc_urgent) &&
 			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 	up_read(&sbi->gc_rwsem);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 33d146939048..c660efad7590 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -180,7 +180,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
 		return false;
 
 	down_read(&sbi->gc_rwsem);
-	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
+	if (GC_I(sbi) && GC_I(sbi)->gc_urgent)
 		gc_urgent = true;
 	up_read(&sbi->gc_rwsem);
 
@@ -1429,7 +1429,7 @@ static int issue_discard_thread(void *data)
 			dcc->discard_wake = 0;
 
 		down_read(&sbi->gc_rwsem);
-		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
+		if (GC_I(sbi) && GC_I(sbi)->gc_urgent)
 			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
 		up_read(&sbi->gc_rwsem);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 55ccc2eaaa2e..6bc0eb2084ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1476,14 +1476,14 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	if ((*flags & SB_RDONLY) || !test_opt(sbi, BG_GC)) {
 		down_write(&sbi->gc_rwsem);
-		if (sbi->gc_thread) {
+		if (GC_I(sbi)) {
 			stop_gc_thread(sbi);
 			need_restart_gc = true;
 		}
 		up_write(&sbi->gc_rwsem);
 	} else {
 		down_write(&sbi->gc_rwsem);
-		if (!sbi->gc_thread) {
+		if (!GC_I(sbi)) {
 			err = start_gc_thread(sbi);
 			if (err) {
 				up_write(&sbi->gc_rwsem);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 34c542dbc459..b0cc273c7e0e 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -46,7 +46,7 @@ struct f2fs_attr {
 static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 {
 	if (struct_type == GC_THREAD)
-		return (unsigned char *)sbi->gc_thread;
+		return (unsigned char *)GC_I(sbi);
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
 	else if (struct_type == DCC_INFO)
@@ -255,9 +255,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	if (gc_entry)
 		down_read(&sbi->gc_rwsem);
 
-	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
-		sbi->gc_thread->gc_wake = 1;
-		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
+	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && GC_I(sbi)) {
+		GC_I(sbi)->gc_wake = 1;
+		wake_up_interruptible_all(&GC_I(sbi)->gc_wait_queue_head);
 		wake_up_discard_thread(sbi, true);
 	}
 
-- 
2.17.0.391.g1f1cddd558b5
