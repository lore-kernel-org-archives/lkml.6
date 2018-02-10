Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeBJC2p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 21:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeBJC2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 21:28:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6A42172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: handle quota for orphan inodes
Date: Fri,  9 Feb 2018 18:28:41 -0800
Message-Id: <20180210022841.5707-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to fix missing dquot_initialize for orphan inodes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8b0945ba284d..e3bf753a47be 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -569,13 +569,8 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	struct node_info ni;
 	int err = acquire_orphan_inode(sbi);
 
-	if (err) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_msg(sbi->sb, KERN_WARNING,
-				"%s: orphan failed (ino=%x), run fsck to fix.",
-				__func__, ino);
-		return err;
-	}
+	if (err)
+		goto err_out;
 
 	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
 
@@ -589,6 +584,11 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 		return PTR_ERR(inode);
 	}
 
+	err = dquot_initialize(inode);
+	if (err)
+		goto err_out;
+
+	dquot_initialize(inode);
 	clear_nlink(inode);
 
 	/* truncate all the data during iput */
@@ -598,14 +598,18 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 
 	/* ENOMEM was fully retried in f2fs_evict_inode. */
 	if (ni.blk_addr != NULL_ADDR) {
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_msg(sbi->sb, KERN_WARNING,
-			"%s: orphan failed (ino=%x) by kernel, retry mount.",
-				__func__, ino);
-		return -EIO;
+		err = -EIO;
+		goto err_out;
 	}
 	__remove_ino_entry(sbi, ino, ORPHAN_INO);
 	return 0;
+
+err_out:
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_msg(sbi->sb, KERN_WARNING,
+			"%s: orphan failed (ino=%x), run fsck to fix.",
+			__func__, ino);
+	return err;
 }
 
 int recover_orphan_inodes(struct f2fs_sb_info *sbi)
-- 
2.15.0.531.g2ccb3012c9-goog
