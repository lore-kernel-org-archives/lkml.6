Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C05C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30732183F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719247;
	bh=McoGrVRvjDB3kRVgWgxDchFDCxcGIsoc3rUxuc0d8c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1/fgzUHtvp/DvSYOiXuc8v/7lEiNDe7qPPkWijJI3tA3luEAILm04TlS3k5zrByI
	 P/wn8ouZsUIUye1SY2+8H0A5cA7UXIxDet5MLyNWH3WUPAdoGc6VKMuANc7huxz8Ph
	 DKWEM3hQaUk9PBUpRhNB6dFNVc5drqka7gDHGHVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfA1Xr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfA1XrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:24 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289392175B;
        Mon, 28 Jan 2019 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719243;
        bh=McoGrVRvjDB3kRVgWgxDchFDCxcGIsoc3rUxuc0d8c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXeKOOsLMuY3aQrBiVPHXH4zgifCZdQoazVfw4lxj8yGWBOjdlzpCRNdBTGgdxQR8
         xYvZ7CN+Gd9i+VDHNhMieALJZfv2BzsTHlz2qaUzhvRNtGgCgLYJBqotaoxny8qllj
         1FT1S6j/ZeeKClIga3BC4rGtxwyLz4ddxJyWczqA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/7] f2fs: add quick mode of checkpoint=disable for QA
Date:   Tue, 29 Jan 2019 07:47:12 +0800
Message-Id: <20190128234717.77225-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mode returns mount() quickly with EAGAIN. We can trigger this by
shutdown(F2FS_GOING_DOWN_NEED_FSCK).

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c    | 5 +++++
 fs/f2fs/f2fs.h          | 2 ++
 fs/f2fs/file.c          | 6 +++---
 fs/f2fs/segment.c       | 3 +++
 fs/f2fs/super.c         | 5 +++++
 include/linux/f2fs_fs.h | 1 +
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f955cd3e0677..622dca707752 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1259,6 +1259,11 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		__clear_ckpt_flags(ckpt, CP_DISABLED_FLAG);
 
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK))
+		__set_ckpt_flags(ckpt, CP_DISABLED_QUICK_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_DISABLED_QUICK_FLAG);
+
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
 	else
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6b6ec5600089..fe95abb05d40 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -191,6 +191,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
+#define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
 struct cp_control {
@@ -1101,6 +1102,7 @@ enum {
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
 	SBI_IS_RECOVERED,			/* recovered orphan/data */
 	SBI_CP_DISABLED,			/* CP was disabled last mount */
+	SBI_CP_DISABLED_QUICK,			/* CP was disabled quickly */
 	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
 	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
 	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d461321edfc..fe6f92fbba38 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1972,11 +1972,11 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		break;
 	case F2FS_GOING_DOWN_NEED_FSCK:
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
+		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret)
-			goto out;
-		break;
+		goto out;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5b2b9be6f28d..342b720fb4db 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -868,6 +868,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
 
 	if (holes[DATA] > ovp || holes[NODE] > ovp)
 		return -EAGAIN;
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
+		dirty_segments(sbi) > overprovision_segments(sbi))
+		return -EAGAIN;
 	return 0;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 24efd76ca151..5e1f8573a17f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3205,6 +3205,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_DISABLED_QUICK_FLAG)) {
+		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
+		sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_QUICK_INTERVAL;
+	}
 
 	/* Initialize device list */
 	err = f2fs_scan_devices(sbi);
@@ -3392,6 +3396,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
 	f2fs_update_time(sbi, REQ_TIME);
+	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
 	return 0;
 
 free_meta:
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..d6befe1f9dc7 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -116,6 +116,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_DISABLED_QUICK_FLAG		0x00002000
 #define CP_DISABLED_FLAG		0x00001000
 #define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
 #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
-- 
2.19.0.605.g01d371f741-goog

