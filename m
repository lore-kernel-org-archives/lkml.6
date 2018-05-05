Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeEEKCZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:02:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750971AbeEEKCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:02:24 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: fix to avoid race during access gc_thread pointer
Date: Sat, 5 May 2018 18:02:01 +0800
Message-ID: <20180505100201.49818-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A			Thread B		Thread C
- f2fs_remount
 - stop_gc_thread
				- f2fs_sbi_store
							- issue_discard_thread
   sbi->gc_thread = NULL;
				  sbi->gc_thread->gc_wake = 1
							  access sbi->gc_thread->gc_urgent

Previously, we allocate memory for sbi->gc_thread based on background
gc thread mount option, the memory can be released if we turn off
that mount option, but still there are several places access gc_thread
pointer without considering race condition, result in NULL point
dereference.

In order to fix this issue, use sb->s_umount to exclude those operations

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- use sb->s_umount to make all race cases exclusive.
 fs/f2fs/gc.c      |  4 ++++
 fs/f2fs/segment.c | 11 ++++++++++-
 fs/f2fs/sysfs.c   | 14 +++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9bb2ddbbed1e..d7d469f9be0a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -187,17 +187,21 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->max_search = dirty_i->nr_dirty[type];
 		p->ofs_unit = 1;
 	} else {
+		down_read(&sbi->sb->s_umount);
 		p->gc_mode = select_gc_type(sbi->gc_thread, gc_type);
+		up_read(&sbi->sb->s_umount);
 		p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
 		p->max_search = dirty_i->nr_dirty[DIRTY];
 		p->ofs_unit = sbi->segs_per_sec;
 	}
 
 	/* we need to check every dirty segments in the FG_GC case */
+	down_read(&sbi->sb->s_umount);
 	if (gc_type != FG_GC &&
 			(sbi->gc_thread && !sbi->gc_thread->gc_urgent) &&
 			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
+	up_read(&sbi->sb->s_umount);
 
 	/* let's select beginning hot/small space first in no_heap mode*/
 	if (test_opt(sbi, NOHEAP) &&
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 320cc1c57246..74e184ab0544 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -174,11 +174,18 @@ bool need_SSR(struct f2fs_sb_info *sbi)
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
 	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
+	bool gc_urgent = false;
 
 	if (test_opt(sbi, LFS))
 		return false;
+
+	down_read(&sbi->sb->s_umount);
 	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
-		return true;
+		gc_urgent = true;
+	up_read(&sbi->sb->s_umount);
+
+	if (gc_urgent)
+		return false;
 
 	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
 			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
@@ -1421,8 +1428,10 @@ static int issue_discard_thread(void *data)
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
 
+		down_read(&sbi->sb->s_umount);
 		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
 			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
+		up_read(&sbi->sb->s_umount);
 
 		sb_start_intwrite(sbi->sb);
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6d8d8f41e517..1cba68812b32 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -173,6 +173,7 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	unsigned long t;
 	unsigned int *ui;
 	ssize_t ret;
+	bool gc_entry = (a->struct_type == GC_THREAD);
 
 	ptr = __struct_ptr(sbi, a->struct_type);
 	if (!ptr)
@@ -248,16 +249,23 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "trim_sections"))
 		return -EINVAL;
 
-	*ui = t;
-
-	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
+	if (!strcmp(a->attr.name, "iostat_enable") && t == 0)
 		f2fs_reset_iostat(sbi);
+
+	if (gc_entry)
+		down_read(&sbi->sb->s_umount);
+
 	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
 		sbi->gc_thread->gc_wake = 1;
 		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
 		wake_up_discard_thread(sbi, true);
 	}
 
+	*ui = t;
+
+	if (gc_entry)
+		up_read(&sbi->sb->s_umount);
+
 	return count;
 }
 
-- 
2.17.0.391.g1f1cddd558b5
