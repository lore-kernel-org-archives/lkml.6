Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030935AbeEZBET (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 21:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030834AbeEZBES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 21:04:18 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [RFC PATCH] f2fs: add fsync_mode=nobarrier for non-atomic files
Date: Fri, 25 May 2018 18:04:14 -0700
Message-Id: <20180526010414.66014-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-atomic files, this patch adds an option to give nobarrier which
doesn't issue flush commands to the device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.txt | 16 +++++++++-------
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/file.c                     |  2 +-
 fs/f2fs/super.c                    |  4 ++++
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 12a147c9f87f..69f8de995739 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -182,13 +182,15 @@ whint_mode=%s          Control which write hints are passed down to block
                        passes down hints with its policy.
 alloc_mode=%s          Adjust block allocation policy, which supports "reuse"
                        and "default".
-fsync_mode=%s          Control the policy of fsync. Currently supports "posix"
-                       and "strict". In "posix" mode, which is default, fsync
-                       will follow POSIX semantics and does a light operation
-                       to improve the filesystem performance. In "strict" mode,
-                       fsync will be heavy and behaves in line with xfs, ext4
-                       and btrfs, where xfstest generic/342 will pass, but the
-                       performance will regress.
+fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
+                       "strict", and "nobarrier". In "posix" mode, which is
+                       default, fsync will follow POSIX semantics and does a
+                       light operation to improve the filesystem performance.
+                       In "strict" mode, fsync will be heavy and behaves in line
+                       with xfs, ext4 and btrfs, where xfstest generic/342 will
+                       pass, but the performance will regress. "nobarrier" is
+                       based on "posix", but doesn't issue flush command for
+                       non-atomic files likewise "nobarrier" mount option.
 test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
                        context. The fake fscrypt context is used by xfstests.
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6e0677aff8ca..659c63dae81c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1093,6 +1093,7 @@ enum {
 enum fsync_mode {
 	FSYNC_MODE_POSIX,	/* fsync follows posix semantics */
 	FSYNC_MODE_STRICT,	/* fsync behaves in line with ext4 */
+	FSYNC_MODE_NOBARRIER,	/* fsync behaves nobarrier based on posix */
 };
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ac216bb560d..fab65a0bd4cc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -306,7 +306,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
-	if (!atomic)
+	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
 		ret = f2fs_issue_flush(sbi, inode->i_ino);
 	if (!ret) {
 		remove_ino_entry(sbi, ino, UPDATE_INO);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b42fc7e4b29..12282b144651 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -740,6 +740,10 @@ static int parse_options(struct super_block *sb, char *options)
 			} else if (strlen(name) == 6 &&
 					!strncmp(name, "strict", 6)) {
 				F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_STRICT;
+			} else if (strlen(name) == 9 &&
+					!strncmp(name, "nobarrier", 9)) {
+				F2FS_OPTION(sbi).fsync_mode =
+							FSYNC_MODE_NOBARRIER;
 			} else {
 				kfree(name);
 				return -EINVAL;
-- 
2.17.0.441.gb46fe60e1d-goog
