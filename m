Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907EDECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D735E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P3lMWJaB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WcT5cazW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D735E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbeISO0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:26:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbeISO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:26:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D76160C4B; Wed, 19 Sep 2018 08:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537346948;
        bh=fMt2CtnwZFLQDT9HaaXkvaePKjMGDQ+ehYwe3LrL/II=;
        h=From:To:Cc:Subject:Date:From;
        b=P3lMWJaBYabuvhrl7UOIK4W4mH0FKPtgGTDigiJ8EVl4e1PM5OYRk4Lh1lQxZdgEq
         GEYy/wf0Wdq4rCONWeMGh3uJvyuwCvRp6wPDc9B+yIQBkLW/8bXcT47Izjd5MIxJ33
         Gjm3KrY3EbnMaS9RhrzWLTtcdz7StKJQn8fa6+Y0=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD9D607C6;
        Wed, 19 Sep 2018 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537346947;
        bh=fMt2CtnwZFLQDT9HaaXkvaePKjMGDQ+ehYwe3LrL/II=;
        h=From:To:Cc:Subject:Date:From;
        b=WcT5cazWwNwbGI8S42oGdGT9Wwt1NaKtJbpIO9wSZdj8nU0VL0STC1SuUI/J7PAsW
         hHW3jpUiaR2lV7eoSnXrBeNnxAhCddlH8rNIkneFYgC57kjgkmkuKivYo3qip+MY/o
         VcM5Z9P5n0+/bD05nuHsRRQ7axrJKFJugccwZn84=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AD9D607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v4] f2fs: add new idle interval timing for discard and gc paths
Date:   Wed, 19 Sep 2018 14:18:47 +0530
Message-Id: <1537346927-9649-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps to control the frequency of submission of discard and
GC requests independently, based on the need.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v4:
- initialize and use sbi->last_time[discard_time], sbi->last_time[gc_time]

 Documentation/ABI/testing/sysfs-fs-f2fs | 17 ++++++++++++++++-
 fs/f2fs/f2fs.h                          | 30 +++++++++++++++++++++++++++---
 fs/f2fs/gc.c                            |  2 +-
 fs/f2fs/segment.c                       | 14 +++++---------
 fs/f2fs/super.c                         |  2 ++
 fs/f2fs/sysfs.c                         |  5 +++++
 6 files changed, 56 insertions(+), 14 deletions(-)

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
index 88b8d50..c47b7d2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1095,6 +1095,8 @@ enum {
 enum {
 	CP_TIME,
 	REQ_TIME,
+	DISCARD_TIME,
+	GC_TIME,
 	MAX_TIME,
 };
 
@@ -1346,7 +1348,15 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
 {
-	sbi->last_time[type] = jiffies;
+	unsigned long now = jiffies;
+
+	sbi->last_time[type] = now;
+
+	/* DISCARD_TIME and GC_TIME are based on REQ_TIME */
+	if (type == REQ_TIME) {
+		sbi->last_time[DISCARD_TIME] = now;
+		sbi->last_time[GC_TIME] = now;
+	}
 }
 
 static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
@@ -1356,7 +1366,21 @@ static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
 	return time_after(jiffies, sbi->last_time[type] + interval);
 }
 
-static inline bool is_idle(struct f2fs_sb_info *sbi)
+static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
+						int type)
+{
+	unsigned long interval = sbi->interval_time[type] * HZ;
+	unsigned int wait_ms = 0;
+	long delta;
+
+	delta = (sbi->last_time[type] + interval) - jiffies;
+	if (delta > 0)
+		wait_ms = jiffies_to_msecs(delta);
+
+	return wait_ms;
+}
+
+static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
@@ -1365,7 +1389,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
 	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
 		return false;
 
-	return f2fs_time_over(sbi, REQ_TIME);
+	return f2fs_time_over(sbi, type);
 }
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5c8d004..49e2328 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -83,7 +83,7 @@ static int gc_thread_func(void *data)
 		if (!mutex_trylock(&sbi->gc_mutex))
 			goto next;
 
-		if (!is_idle(sbi)) {
+		if (!is_idle(sbi, GC_TIME)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
 			goto next;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 187c848..67cf7e4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -511,7 +511,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (!is_idle(sbi) &&
+	if (!is_idle(sbi, REQ_TIME) &&
 		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
 		return;
 
@@ -1311,7 +1311,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		if (dc->state != D_PREP)
 			goto next;
 
-		if (dpolicy->io_aware && !is_idle(sbi)) {
+		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
 			io_interrupted = true;
 			break;
 		}
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
+			wait_ms = f2fs_time_to_wait(sbi, DISCARD_TIME);
+			if (!wait_ms)
 				wait_ms = dpolicy.mid_interval;
 		} else {
 			wait_ms = dpolicy.max_interval;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3106da1..2f67948 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2463,6 +2463,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
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

