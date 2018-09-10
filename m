Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1545C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE6320854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eMOoCowE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GmePcuIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE6320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeIJIIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:08:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeIJIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:08:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6ACBB607B5; Mon, 10 Sep 2018 03:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536549404;
        bh=DlOfC9B/0gHIc4VBLX8wZnGqKS1+cIw+CFPt+hHOtMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eMOoCowELxX1GTkqTvXJbfSTmOg7OrwNJkb0tvMILXANLuVYX9w5r0DDjeM2c/5WK
         Ypr3vEytD35jZ+PYssfSsbjaqrmQ8872sBvofCClUEKvZbgOkFbPecEh6wJD+t84fg
         HEihjleAlKTO5l/jZcV7Y+467Zr8z82QQaocW7oE=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7898B60558;
        Mon, 10 Sep 2018 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536549403;
        bh=DlOfC9B/0gHIc4VBLX8wZnGqKS1+cIw+CFPt+hHOtMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GmePcuIskOOegDWPAjPezcLVHUKsUDjLpPa4Cxb3r3XjYicSS5XC3acaABcmQMrtk
         rSZ3HBXiTzciHbNOKL1FO/Wi/4bjwh3oCeEP2w/zup+xLQlV5UflW7w9SPEuvXfb2R
         gyZXn8dxOp0B1tMS03MafjHw2LwRNV0KxBB4RUno=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7898B60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: add new idle interval timing for discard and gc paths
Date:   Mon, 10 Sep 2018 08:46:22 +0530
Message-Id: <1536549382-23584-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps to control the frequency of submission of discard and
GC requests independently, based on the need. The sleep timing of
GC thread is now aligned with this idle time when the dev is busy,
to avoid unnecessary periodic wakeups.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 17 ++++++++++++++++-
 fs/f2fs/f2fs.h                          | 31 +++++++++++++++++++++++++++----
 fs/f2fs/gc.c                            |  6 ++++--
 fs/f2fs/segment.c                       | 14 +++++---------
 fs/f2fs/super.c                         |  2 ++
 fs/f2fs/sysfs.c                         |  5 +++++
 6 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 94a24ae..3ac4177 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -121,7 +121,22 @@ What:		/sys/fs/f2fs/<disk>/idle_interval
 Date:		January 2016
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
-		 Controls the idle timing.
+		 Controls the idle timing for all paths other than
+		 discard and gc path.
+
+What:		/sys/fs/f2fs/<disk>/discard_idle_interval
+Date:		September 2018
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
+Description:
+		 Controls the idle timing for discard path.
+
+What:		/sys/fs/f2fs/<disk>/gc_idle_interval
+Date:		September 2018
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
+Description:
+		 Controls the idle timing for gc path.
 
 What:		/sys/fs/f2fs/<disk>/iostat_enable
 Date:		August 2017
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index abf9256..6070681 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1093,6 +1093,8 @@ enum {
 enum {
 	CP_TIME,
 	REQ_TIME,
+	DISCARD_TIME,
+	GC_TIME,
 	MAX_TIME,
 };
 
@@ -1347,14 +1349,35 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
 	sbi->last_time[type] = jiffies;
 }
 
-static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
+static inline bool f2fs_time_over_cp(struct f2fs_sb_info *sbi)
+{
+	unsigned long interval = sbi->interval_time[CP_TIME] * HZ;
+
+	return time_after(jiffies, sbi->last_time[CP_TIME] + interval);
+}
+
+static inline bool f2fs_time_over_req(struct f2fs_sb_info *sbi, int type)
+{
+	unsigned long interval = sbi->interval_time[type] * HZ;
+
+	return time_after(jiffies, sbi->last_time[REQ_TIME] + interval);
+}
+
+static inline unsigned int f2fs_get_wait_time(struct f2fs_sb_info *sbi,
+						int type)
 {
 	unsigned long interval = sbi->interval_time[type] * HZ;
+	unsigned int wait_ms = 0;
+	long delta;
+
+	delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
+	if (delta > 0)
+		wait_ms = jiffies_to_msecs(delta);
 
-	return time_after(jiffies, sbi->last_time[type] + interval);
+	return wait_ms;
 }
 
-static inline bool is_idle(struct f2fs_sb_info *sbi)
+static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
@@ -1363,7 +1386,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
 	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
 		return false;
 
-	return f2fs_time_over(sbi, REQ_TIME);
+	return f2fs_time_over_req(sbi, type);
 }
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5c8d004..c0bafea 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -83,8 +83,10 @@ static int gc_thread_func(void *data)
 		if (!mutex_trylock(&sbi->gc_mutex))
 			goto next;
 
-		if (!is_idle(sbi)) {
-			increase_sleep_time(gc_th, &wait_ms);
+		if (!is_idle(sbi, GC_TIME)) {
+			wait_ms = f2fs_get_wait_time(sbi, GC_TIME);
+			if (!wait_ms)
+				increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
 			goto next;
 		}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c5024f8..f8a6a7b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -511,7 +511,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (!is_idle(sbi) &&
+	if (!is_idle(sbi, REQ_TIME) &&
 		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
 		return;
 
@@ -521,7 +521,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
 			excess_dirty_nodes(sbi) ||
-			f2fs_time_over(sbi, CP_TIME)) {
+			f2fs_time_over_cp(sbi)) {
 		if (test_opt(sbi, DATA_FLUSH)) {
 			struct blk_plug plug;
 
@@ -1371,7 +1371,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
-								!is_idle(sbi)) {
+						!is_idle(sbi, DISCARD_TIME)) {
 				io_interrupted = true;
 				break;
 			}
@@ -1564,8 +1564,6 @@ static int issue_discard_thread(void *data)
 	struct discard_policy dpolicy;
 	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 	int issued;
-	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
-	long delta;
 
 	set_freezable();
 
@@ -1602,10 +1600,8 @@ static int issue_discard_thread(void *data)
 			__wait_all_discard_cmd(sbi, &dpolicy);
 			wait_ms = dpolicy.min_interval;
 		} else if (issued == -1){
-			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
-			if (delta > 0)
-				wait_ms = jiffies_to_msecs(delta);
-			else
+			wait_ms = f2fs_get_wait_time(sbi, DISCARD_TIME);
+			if (!wait_ms)
 				wait_ms = dpolicy.mid_interval;
 		} else {
 			wait_ms = dpolicy.max_interval;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 896b885..1706f45 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2423,6 +2423,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
 	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
+	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
+	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 81c0e53..0afe99c 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -407,6 +407,9 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
+					interval_time[DISCARD_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
@@ -460,6 +463,8 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	ATTR_LIST(dirty_nats_ratio),
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
+	ATTR_LIST(discard_idle_interval),
+	ATTR_LIST(gc_idle_interval),
 	ATTR_LIST(iostat_enable),
 	ATTR_LIST(readdir_ra),
 	ATTR_LIST(gc_pin_file_thresh),
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

