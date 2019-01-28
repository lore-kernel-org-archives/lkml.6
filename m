Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A211C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEFE217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719243;
	bh=mqNYcavY4qKf7gsIE6SfySGKCpU77qJw9gsQ1Mdej8Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nL77Eu89IYG2hlgL8rXZGaXqRP2b36UnvVUKc1ViDt8+FKs2B0yIAFc6+/A8eKxmW
	 NwSwBnKq+/IFQ7dtnaFYfREtbkBAvX0u2tQZeotVz3WTddxPt0M8LhqsoEi67ro5DB
	 IbGAr613vNrxs9BZ0cN/rxjQ8JRZoSHuJfs1tvyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfA1XrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfA1XrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:21 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF9C2171F;
        Mon, 28 Jan 2019 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719240;
        bh=mqNYcavY4qKf7gsIE6SfySGKCpU77qJw9gsQ1Mdej8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=1g4F89Zr3982f4UI8vI8XZUet1DayuAl9jvDkXqhKyl2emquY8wWSRADj1Ohadl3Z
         6fjTrPZHr7PzmH+sBtVPVb6VCwZiGhxlL6oroaa2OiWNFIJVy4lRdQ4rU0us0098JH
         TmyUcdjrQuvXu7zrk2CvaHsGa6gn31BwcD6G9TGw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/7] f2fs: run discard jobs when put_super
Date:   Tue, 29 Jan 2019 07:47:11 +0800
Message-Id: <20190128234717.77225-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we umount f2fs, we need to avoid long delay due to discard commands, which
is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
patch introduces timeout-based work on it.

By default, let me give 5 seconds for discard.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
 fs/f2fs/f2fs.h                          |  5 ++++-
 fs/f2fs/segment.c                       | 11 ++++++++++-
 fs/f2fs/super.c                         |  4 +++-
 fs/f2fs/sysfs.c                         |  3 +++
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index a7ce33199457..91822ce25831 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -86,6 +86,13 @@ Description:
 		The unit size is one block, now only support configuring in range
 		of [1, 512].
 
+What:          /sys/fs/f2fs/<disk>/umount_discard_timeout
+Date:          January 2019
+Contact:       "Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:
+		Set timeout to issue discard commands during umount.
+		Default: 5 secs
+
 What:		/sys/fs/f2fs/<disk>/max_victim_search
 Date:		January 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f564883e078..6b6ec5600089 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -191,6 +191,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
+#define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
 struct cp_control {
 	int reason;
@@ -310,6 +311,7 @@ struct discard_policy {
 	bool sync;			/* submit discard with REQ_SYNC flag */
 	bool ordered;			/* issue discard by lba order */
 	unsigned int granularity;	/* discard granularity */
+	int timeout;			/* discard timeout for put_super */
 };
 
 struct discard_cmd_control {
@@ -1110,6 +1112,7 @@ enum {
 	DISCARD_TIME,
 	GC_TIME,
 	DISABLE_TIME,
+	UMOUNT_DISCARD_TIMEOUT,
 	MAX_TIME,
 };
 
@@ -3006,7 +3009,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
-bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9b79056d705d..5b2b9be6f28d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1037,6 +1037,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 
 	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
 	dpolicy->io_aware_gran = MAX_PLIST_NUM;
+	dpolicy->timeout = 0;
 
 	if (discard_type == DPOLICY_BG) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
@@ -1424,7 +1425,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, issued = 0;
 	bool io_interrupted = false;
 
+	if (dpolicy->timeout != 0)
+		f2fs_update_time(sbi, dpolicy->timeout);
+
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		if (dpolicy->timeout != 0 &&
+				f2fs_time_over(sbi, dpolicy->timeout))
+			break;
+
 		if (i + 1 < dpolicy->granularity)
 			break;
 
@@ -1611,7 +1619,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 }
 
 /* This comes from f2fs_put_super */
-bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
@@ -1619,6 +1627,7 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
 					dcc->discard_granularity);
+	dpolicy.timeout = UMOUNT_DISCARD_TIMEOUT;
 	__issue_discard_cmd(sbi, &dpolicy);
 	dropped = __drop_discard_cmd(sbi);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ea514acede36..24efd76ca151 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1048,7 +1048,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	dropped = f2fs_wait_discard_bios(sbi);
+	dropped = f2fs_issue_discard_timeout(sbi);
 
 	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
 					!sbi->discard_blks && !dropped) {
@@ -2706,6 +2706,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
+	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] =
+				DEF_UMOUNT_DISCARD_TIMEOUT;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5b83e1d66cb3..18c627e8fc90 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -426,6 +426,8 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
 					interval_time[DISCARD_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
+		umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
@@ -483,6 +485,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(idle_interval),
 	ATTR_LIST(discard_idle_interval),
 	ATTR_LIST(gc_idle_interval),
+	ATTR_LIST(umount_discard_timeout),
 	ATTR_LIST(iostat_enable),
 	ATTR_LIST(readdir_ra),
 	ATTR_LIST(gc_pin_file_thresh),
-- 
2.19.0.605.g01d371f741-goog

