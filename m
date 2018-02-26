Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBZRrf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751175AbeBZRrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:47:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297BF21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: add mount option for segment allocation policy
Date: Mon, 26 Feb 2018 09:47:27 -0800
Message-Id: <20180226174731.26679-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an mount option, "alloc_mode=%s" having two options, "default"
and "reuse".

In "alloc_mode=reuse" case, f2fs starts to allocate segments from 0'th segment
all the time to reassign segments. It'd be useful for small-sized eMMC parts.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  8 ++++++++
 fs/f2fs/segment.c |  5 +++++
 fs/f2fs/super.c   | 24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4e79a7b6f2e9..1ed17ec682ef 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1043,6 +1043,11 @@ enum {
 	WHINT_MODE_FS,		/* pass down hints with F2FS policy */
 };
 
+enum {
+	ALLOC_MODE_DEFAULT,	/* stay default */
+	ALLOC_MODE_REUSE,	/* reuse segments as much as possible */
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1229,6 +1234,9 @@ struct f2fs_sb_info {
 #endif
 	/* For which write hints are passed down to block layer */
 	int whint_mode;
+
+	/* segment allocation policy */
+	int alloc_mode;
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0646d5de8cd0..5e5e2936a26a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2170,6 +2170,11 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
 		return SIT_I(sbi)->last_victim[ALLOC_NEXT];
+
+	/* find segments from 0 to reuse freed segments */
+	if (sbi->alloc_mode == ALLOC_MODE_REUSE)
+		return 0;
+
 	return CURSEG_I(sbi, type)->segno;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2e4f5673d65d..b7c0bdd1e532 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -130,6 +130,7 @@ enum {
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
 	Opt_whint,
+	Opt_alloc,
 	Opt_err,
 };
 
@@ -184,6 +185,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
 	{Opt_whint, "whint_mode=%s"},
+	{Opt_alloc, "alloc_mode=%s"},
 	{Opt_err, NULL},
 };
 
@@ -700,6 +702,23 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			kfree(name);
 			break;
+		case Opt_alloc:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+
+			if (strlen(name) == 7 &&
+					!strncmp(name, "default", 7)) {
+				sbi->alloc_mode = ALLOC_MODE_DEFAULT;
+			} else if (strlen(name) == 5 &&
+					!strncmp(name, "reuse", 5)) {
+				sbi->alloc_mode = ALLOC_MODE_REUSE;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -1264,6 +1283,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (sbi->whint_mode == WHINT_MODE_FS)
 		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
+	if (sbi->alloc_mode == ALLOC_MODE_DEFAULT)
+		seq_printf(seq, ",alloc_mode=%s", "default");
+	else if (sbi->alloc_mode == ALLOC_MODE_REUSE)
+		seq_printf(seq, ",alloc_mode=%s", "reuse");
 	return 0;
 }
 
@@ -1273,6 +1296,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->active_logs = NR_CURSEG_TYPE;
 	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
 	sbi->whint_mode = WHINT_MODE_OFF;
+	sbi->alloc_mode = ALLOC_MODE_DEFAULT;
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
-- 
2.15.0.531.g2ccb3012c9-goog
