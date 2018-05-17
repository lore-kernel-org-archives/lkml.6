Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeEQVy1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeEQVy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:54:26 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@zeniv.linux.org.uk
Cc: jack@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lurodriguez@suse.de,
        willy@infradead.org
Subject: [PATCH v3] vfs: avoid dereferencing pointers in iterate_supers callbacks
Date: Thu, 17 May 2018 17:54:20 -0400
Message-Id: <20180517215420.1810-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517154646.18751-1-jlayton@kernel.org>
References: <20180517154646.18751-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

All of the callback functions for iterate_supers either ignore the
opaque argument, or dereference the pointer only to fetch the int
to which it points.

Change quota_sync_one to just cast the int from the pointer,
and change sync_fs_one_sb to just use a NULL/non-NULL pointer as a
flag.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/quota/quota.c |  4 ++--
 fs/sync.c        | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

v3: reinstate wait/nowait variables for clarity

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 860bfbe7a07a..8dc76d5f87c7 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -48,7 +48,7 @@ static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 
 static void quota_sync_one(struct super_block *sb, void *arg)
 {
-	int type = *(int *)arg;
+	int type = (unsigned long)arg;
 
 	if (sb->s_qcop && sb->s_qcop->quota_sync &&
 	    (sb->s_quota_types & (1 << type)))
@@ -63,7 +63,7 @@ static int quota_sync_all(int type)
 		return -EINVAL;
 	ret = security_quotactl(Q_SYNC, type, 0, NULL);
 	if (!ret)
-		iterate_supers(quota_sync_one, &type);
+		iterate_supers(quota_sync_one, (void *)((unsigned long)type));
 	return ret;
 }
 
diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..a863cd2490ce 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -76,8 +76,10 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 
 static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
+	int wait = arg ? 1 : 0;
+
 	if (!sb_rdonly(sb) && sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, *(int *)arg);
+		sb->s_op->sync_fs(sb, wait);
 }
 
 static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
@@ -107,12 +109,12 @@ static void fdatawait_one_bdev(struct block_device *bdev, void *arg)
  */
 void ksys_sync(void)
 {
-	int nowait = 0, wait = 1;
+	void *nowait = NULL, *wait = (void *)1UL;
 
 	wakeup_flusher_threads(WB_REASON_SYNC);
 	iterate_supers(sync_inodes_one_sb, NULL);
-	iterate_supers(sync_fs_one_sb, &nowait);
-	iterate_supers(sync_fs_one_sb, &wait);
+	iterate_supers(sync_fs_one_sb, nowait);
+	iterate_supers(sync_fs_one_sb, wait);
 	iterate_bdevs(fdatawrite_one_bdev, NULL);
 	iterate_bdevs(fdatawait_one_bdev, NULL);
 	if (unlikely(laptop_mode))
@@ -127,17 +129,17 @@ SYSCALL_DEFINE0(sync)
 
 static void do_sync_work(struct work_struct *work)
 {
-	int nowait = 0;
+	void *nowait = NULL;
 
 	/*
 	 * Sync twice to reduce the possibility we skipped some inodes / pages
 	 * because they were temporarily locked
 	 */
-	iterate_supers(sync_inodes_one_sb, &nowait);
-	iterate_supers(sync_fs_one_sb, &nowait);
+	iterate_supers(sync_inodes_one_sb, NULL);
+	iterate_supers(sync_fs_one_sb, nowait);
 	iterate_bdevs(fdatawrite_one_bdev, NULL);
-	iterate_supers(sync_inodes_one_sb, &nowait);
-	iterate_supers(sync_fs_one_sb, &nowait);
+	iterate_supers(sync_inodes_one_sb, NULL);
+	iterate_supers(sync_fs_one_sb, nowait);
 	iterate_bdevs(fdatawrite_one_bdev, NULL);
 	printk("Emergency Sync complete\n");
 	kfree(work);
-- 
2.17.0
