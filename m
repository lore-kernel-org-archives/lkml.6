Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032666AbeCAPlA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032240AbeCAPk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:40:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342FF21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: wrap sb_rdonly with f2fs_readonly
Date: Thu,  1 Mar 2018 23:40:31 +0800
Message-Id: <20180301154032.6325-1-chao@kernel.org>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Use f2fs_readonly to wrap sb_rdonly for cleanup, and spread it in
all places.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 4 ++--
 fs/f2fs/super.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6dc70666ebb..ae0671b60e3f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2467,9 +2467,9 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 	return ret;
 }
 
-static inline int f2fs_readonly(struct super_block *sb)
+static inline bool f2fs_readonly(struct super_block *sb)
 {
-	return sb->s_flags & SB_RDONLY;
+	return sb_rdonly(sb);
 }
 
 static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30b93ad44b9d..d8357ba19159 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -336,7 +336,7 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 			"QUOTA feature is enabled, so ignore jquota_fmt");
 		sbi->s_jquota_fmt = 0;
 	}
-	if (f2fs_sb_has_quota_ino(sbi->sb) && sb_rdonly(sbi->sb)) {
+	if (f2fs_sb_has_quota_ino(sbi->sb) && f2fs_readonly(sbi->sb)) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			 "Filesystem with quota feature cannot be mounted RDWR "
 			 "without CONFIG_QUOTA");
@@ -2805,7 +2805,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * Turn on quotas which were not enabled for read-only mounts if
 	 * filesystem has quota feature, so that they are updated correctly.
 	 */
-	if (f2fs_sb_has_quota_ino(sb) && !sb_rdonly(sb)) {
+	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
 		err = f2fs_enable_quotas(sb);
 		if (err) {
 			f2fs_msg(sb, KERN_ERR,
@@ -2890,7 +2890,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 free_meta:
 #ifdef CONFIG_QUOTA
-	if (f2fs_sb_has_quota_ino(sb) && !sb_rdonly(sb))
+	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb))
 		f2fs_quota_off_umount(sbi->sb);
 #endif
 	f2fs_sync_inode_meta(sbi);
-- 
2.14.1.145.gb3622a4ee
