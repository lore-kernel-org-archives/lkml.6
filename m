Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37709ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BCD214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BCD214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbeISHEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:04:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbeISHEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:04:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42BFB74F0EE7E;
        Wed, 19 Sep 2018 09:28:55 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 09:28:45 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: detect and recover corrupted quota file
Date:   Wed, 19 Sep 2018 09:28:37 +0800
Message-ID: <20180919012837.92414-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once quota file is corrupted, kernel will set CP_QUOTA_NEED_FSCK_FLAG
into checkpoint pack, this patch makes fsck supporting to detect the flag
and try to rebuild corrupted quota file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c       |  3 ++-
 fsck/main.c       |  1 +
 fsck/mount.c      | 11 +++++++++--
 include/f2fs_fs.h |  2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 40b95f7054a2..28c913b83355 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2670,7 +2670,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 				flush_curseg_sit_entries(sbi);
 			}
 			fix_checkpoint(sbi);
-		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
+		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG) ||
+			is_set_ckpt_flags(cp, CP_QUOTA_NEED_FSCK_FLAG)) {
 			write_checkpoint(sbi);
 		}
 	}
diff --git a/fsck/main.c b/fsck/main.c
index 714e28a509b9..e20f31ca09e4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -162,6 +162,7 @@ static void add_default_options(void)
 	case CONF_ANDROID:
 		__add_fsck_options();
 	}
+	c.quota_fix = 1;
 }
 
 void f2fs_parse_options(int argc, char *argv[])
diff --git a/fsck/mount.c b/fsck/mount.c
index 6a3382dbd449..21a39a7222c6 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -405,6 +405,8 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 void print_cp_state(u32 flag)
 {
 	MSG(0, "Info: checkpoint state = %x : ", flag);
+	if (flag & CP_QUOTA_NEED_FSCK_FLAG)
+		MSG(0, "%s", " quota_need_fsck");
 	if (flag & CP_LARGE_NAT_BITMAP_FLAG)
 		MSG(0, "%s", " large_nat_bitmap");
 	if (flag & CP_NOCRC_RECOVERY_FLAG)
@@ -2541,12 +2543,17 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	print_ckpt_info(sbi);
 
+	if (c.quota_fix) {
+		if (get_cp(ckpt_flags) & CP_QUOTA_NEED_FSCK_FLAG)
+			c.fix_on = 1;
+	}
+
 	if (c.auto_fix || c.preen_mode) {
 		u32 flag = get_cp(ckpt_flags);
 
 		if (flag & CP_FSCK_FLAG ||
-			(exist_qf_ino(sb) && (!(flag & CP_UMOUNT_FLAG) ||
-						flag & CP_ERROR_FLAG))) {
+			flag & CP_QUOTA_NEED_FSCK_FLAG ||
+			(exist_qf_ino(sb) && (flag & CP_ERROR_FLAG))) {
 			c.fix_on = 1;
 		} else if (!c.preen_mode) {
 			print_cp_state(flag);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9396c785a254..160eaf72f0b6 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -372,6 +372,7 @@ struct f2fs_configuration {
 	int defset;
 	int bug_on;
 	int auto_fix;
+	int quota_fix;
 	int preen_mode;
 	int ro;
 	int preserve_limits;		/* preserve quota limits */
@@ -641,6 +642,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
 #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
 #define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
-- 
2.18.0.rc1

