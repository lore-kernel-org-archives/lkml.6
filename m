Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F2FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C9820854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547702224;
	bh=wdTC8rlKjGEgoNxoQMtmSwqLnPn6ph8PIeRqOZGJBEw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LS1bmGIu4SJo+c12cMeisM0eKl3+8lBIGRsGYE2AF5P8w7vpmjUsnsKdy9TVUnMAl
	 K8XWObEXRRW2M7gv+UKBT98eFzj7zw/GifDJrH0+gM2a2wUwcdBHXR7TXoqBpNWrlb
	 2EyE7D3EcYMJdnV25Cqz9T8UDEoLLoC6CObMiE/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfAQFRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfAQFRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:17:02 -0500
Received: from localhost (c-98-234-55-98.hsd1.ca.comcast.net [98.234.55.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FA920657;
        Thu, 17 Jan 2019 05:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547702221;
        bh=wdTC8rlKjGEgoNxoQMtmSwqLnPn6ph8PIeRqOZGJBEw=;
        h=From:To:Cc:Subject:Date:From;
        b=F4jQp2Im4/OfhMQ40SLBi7MCch4it+MviCS9kQBvV17Ch1LVZsHIbIVrGhWid0iqw
         dTcZy7Vsg+DM39+16jgatV+cJ6RRlBCluydawCJ6wMo0PapIZmSm7VI53UZcIZ3s4+
         SdOmBcHXGT6QFO2j4EBG97pA6dcpA8jJ3RMlnquk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: run gc/discard jobs when put_super
Date:   Wed, 16 Jan 2019 21:17:00 -0800
Message-Id: <20190117051700.52062-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we umount f2fs, we need to avoid long delay due to discard commands, which
is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
patch introduces timeout-based work on it. In addition to discard commands, we
can also do GC during the given time period.

By default, let me give 4 seconds for GC and 4 seconds for discard.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  7 ++++++-
 fs/f2fs/gc.c      | 17 +++++++++++++++++
 fs/f2fs/segment.c | 14 ++++++++++----
 fs/f2fs/super.c   | 37 ++++++++++++++++++-------------------
 fs/f2fs/sysfs.c   |  6 ++++++
 5 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7df41cd1eb35..e56364a2e597 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -191,6 +191,8 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
+#define DEF_UMOUNT_GC_TIMEOUT		4	/* 4 secs */
+#define DEF_UMOUNT_DISCARD_TIMEOUT	4	/* 4 secs */
 
 struct cp_control {
 	int reason;
@@ -1110,6 +1112,8 @@ enum {
 	DISCARD_TIME,
 	GC_TIME,
 	DISABLE_TIME,
+	UMOUNT_GC_TIMEOUT,
+	UMOUNT_DISCARD_TIMEOUT,
 	MAX_TIME,
 };
 
@@ -3007,7 +3011,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
-bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
@@ -3151,6 +3155,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
+int f2fs_gc_timeout(struct f2fs_sb_info *sbi, int time);
 
 /*
  * recovery.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 195cf0f9d9ef..ccfc807e4095 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -159,6 +159,23 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 	sbi->gc_thread = NULL;
 }
 
+int f2fs_gc_timeout(struct f2fs_sb_info *sbi, int time_type)
+{
+	int err = 0;
+
+	f2fs_update_time(sbi, time_type);
+
+	while (!f2fs_time_over(sbi, time_type)) {
+		mutex_lock(&sbi->gc_mutex);
+		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+		if (err == -ENODATA)
+			err = 0;
+		if (err && err != -EAGAIN)
+			break;
+	}
+	return err;
+}
+
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
 {
 	int gc_mode = (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9b79056d705d..cbdb64237f8e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1415,7 +1415,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 }
 
 static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
-					struct discard_policy *dpolicy)
+			struct discard_policy *dpolicy, int timeout)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *pend_list;
@@ -1424,7 +1424,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, issued = 0;
 	bool io_interrupted = false;
 
+	if (timeout != MAX_TIME)
+		f2fs_update_time(sbi, timeout);
+
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		if (timeout != MAX_TIME && f2fs_time_over(sbi, timeout))
+			break;
+
 		if (i + 1 < dpolicy->granularity)
 			break;
 
@@ -1611,7 +1617,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 }
 
 /* This comes from f2fs_put_super */
-bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
@@ -1619,7 +1625,7 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
 					dcc->discard_granularity);
-	__issue_discard_cmd(sbi, &dpolicy);
+	__issue_discard_cmd(sbi, &dpolicy, UMOUNT_DISCARD_TIMEOUT);
 	dropped = __drop_discard_cmd(sbi);
 
 	/* just to make sure there is no pending discard commands */
@@ -1672,7 +1678,7 @@ static int issue_discard_thread(void *data)
 
 		sb_start_intwrite(sbi->sb);
 
-		issued = __issue_discard_cmd(sbi, &dpolicy);
+		issued = __issue_discard_cmd(sbi, &dpolicy, MAX_TIME);
 		if (issued > 0) {
 			__wait_all_discard_cmd(sbi, &dpolicy);
 			wait_ms = dpolicy.min_interval;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cbd97dc280fb..5fa7cb9d4e71 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1029,6 +1029,15 @@ static void f2fs_put_super(struct super_block *sb)
 	int i;
 	bool dropped;
 
+	/* run some GCs when un-mounting the partition */
+	f2fs_gc_timeout(sbi, UMOUNT_GC_TIMEOUT);
+
+	/* be sure to wait for any on-going discard commands */
+	dropped = f2fs_issue_discard_timeout(sbi);
+
+	/* sync dirty data */
+	sync_filesystem(sbi->sb);
+
 	f2fs_quota_off_umount(sb);
 
 	/* prevent remaining shrinker jobs */
@@ -1044,17 +1053,12 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
-		f2fs_write_checkpoint(sbi, &cpc);
-	}
 
-	/* be sure to wait for any on-going discard commands */
-	dropped = f2fs_wait_discard_bios(sbi);
+		if ((f2fs_hw_support_discard(sbi) ||
+				f2fs_hw_should_discard(sbi)) &&
+				!sbi->discard_blks && !dropped)
+			cpc.reason |= CP_TRIMMED;
 
-	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
-					!sbi->discard_blks && !dropped) {
-		struct cp_control cpc = {
-			.reason = CP_UMOUNT | CP_TRIMMED,
-		};
 		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
@@ -1463,16 +1467,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	sbi->sb->s_flags |= SB_ACTIVE;
 
-	f2fs_update_time(sbi, DISABLE_TIME);
-
-	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
-		mutex_lock(&sbi->gc_mutex);
-		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
-		if (err == -ENODATA)
-			break;
-		if (err && err != -EAGAIN)
-			return err;
-	}
+	err = f2fs_gc_timeout(sbi, DISABLE_TIME);
+	if (err)
+		return err;
 
 	err = sync_filesystem(sbi->sb);
 	if (err)
@@ -2706,6 +2703,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
+	sbi->interval_time[UMOUNT_GC_TIMEOUT] = DEF_UMOUNT_GC_TIMEOUT;
+	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] = DEF_UMOUNT_DISCARD_TIMEOUT;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 02d4012a9183..47f25eac9d67 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -420,6 +420,10 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
 					interval_time[DISCARD_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
+		umount_gc_timeout, interval_time[UMOUNT_GC_TIMEOUT]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
+		umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
@@ -477,6 +481,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(idle_interval),
 	ATTR_LIST(discard_idle_interval),
 	ATTR_LIST(gc_idle_interval),
+	ATTR_LIST(umount_gc_timeout),
+	ATTR_LIST(umount_discard_timeout),
 	ATTR_LIST(iostat_enable),
 	ATTR_LIST(readdir_ra),
 	ATTR_LIST(gc_pin_file_thresh),
-- 
2.19.0.605.g01d371f741-goog

