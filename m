Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeAaChJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:37:09 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:40850 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeAaChH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:37:07 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@lge.com,
        Hyunchul Lee <cheol.lee@lge.com>
Subject: [PATCH v2 2/3] f2fs: support passing down write hints to block layer with F2FS policy
Date: Wed, 31 Jan 2018 11:36:58 +0900
Message-Id: <1517366219-22166-3-git-send-email-hyc.lee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
References: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <cheol.lee@lge.com>

Add 'whint_mode=fs-based' mount option. In this mode, F2FS passes
down write hints with its policy.

* whint_mode=fs-based. F2FS passes down hints with its policy.

User                  F2FS                     Block
----                  ----                     -----
                      META                     WRITE_LIFE_MEDIUM;
                      HOT_NODE                 WRITE_LIFE_NOT_SET
                      WARM_NODE                "
                      COLD_NODE                WRITE_LIFE_NONE
ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
extension list        "                        "

-- buffered io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
WRITE_LIFE_NONE       "                        "
WRITE_LIFE_MEDIUM     "                        "
WRITE_LIFE_LONG       "                        "

-- direct io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG

Many thanks to Chao Yu and Jaegeuk Kim for comments to
implement this patch.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
v2:
 - Change "case" statements to "if" statements in rw_hint_to_seg_type()

 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++---------
 fs/f2fs/super.c   |  5 +++++
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 475637d..8273bc7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1040,6 +1040,7 @@ enum {
 enum {
 	WHINT_MODE_OFF,		/* not pass down write hints */
 	WHINT_MODE_USER,	/* try to pass down hints given by users */
+	WHINT_MODE_FS,		/* pass down hints with F2FS policy */
 };
 
 struct f2fs_sb_info {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 840c8ff..733a733 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2488,6 +2488,32 @@ int rw_hint_to_seg_type(enum rw_hint hint)
  * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
  * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
  *
+ * 3) whint_mode=fs-based. F2FS passes down hints with its policy.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_MEDIUM;
+ *                       HOT_NODE                 WRITE_LIFE_NOT_SET
+ *                       WARM_NODE                "
+ *                       COLD_NODE                WRITE_LIFE_NONE
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
+ * WRITE_LIFE_NONE       "                        "
+ * WRITE_LIFE_MEDIUM     "                        "
+ * WRITE_LIFE_LONG       "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+ * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+ * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
  */
 
 enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
@@ -2495,20 +2521,33 @@ enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 {
 	if (sbi->whint_mode == WHINT_MODE_USER) {
 		if (type == DATA) {
-			switch (temp) {
-			case COLD:
-				return WRITE_LIFE_EXTREME;
-			case HOT:
-				return WRITE_LIFE_SHORT;
-			default:
+			if (temp == WARM)
 				return WRITE_LIFE_NOT_SET;
-			}
+			else if (temp == HOT)
+				return WRITE_LIFE_SHORT;
+			else if (temp == COLD)
+				return WRITE_LIFE_EXTREME;
 		} else {
 			return WRITE_LIFE_NOT_SET;
 		}
-	} else {
-		return WRITE_LIFE_NOT_SET;
+	} else if (sbi->whint_mode == WHINT_MODE_FS) {
+		if (type == DATA) {
+			if (temp == WARM)
+				return WRITE_LIFE_LONG;
+			else if (temp == HOT)
+				return WRITE_LIFE_SHORT;
+			else if (temp == COLD)
+				return WRITE_LIFE_EXTREME;
+		} else if (type == NODE) {
+			if (temp == WARM || temp == HOT)
+				return WRITE_LIFE_NOT_SET;
+			else if (temp == COLD)
+				return WRITE_LIFE_NONE;
+		} else if (type == META) {
+			return WRITE_LIFE_MEDIUM;
+		}
 	}
+	return WRITE_LIFE_NOT_SET;
 }
 
 static int __get_segment_type_2(struct f2fs_io_info *fio)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 139547d..bd013ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -691,6 +691,9 @@ static int parse_options(struct super_block *sb, char *options)
 			} else if (strlen(name) == 3 &&
 					!strncmp(name, "off", 3)) {
 				sbi->whint_mode = WHINT_MODE_OFF;
+			} else if (strlen(name) == 8 &&
+					!strncmp(name, "fs-based", 8)) {
+				sbi->whint_mode = WHINT_MODE_FS;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -1251,6 +1254,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	f2fs_show_quota_options(seq, sbi->sb);
 	if (sbi->whint_mode == WHINT_MODE_USER)
 		seq_printf(seq, ",whint_mode=%s", "user-based");
+	else if (sbi->whint_mode == WHINT_MODE_FS)
+		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
 	return 0;
 }
-- 
1.9.1
