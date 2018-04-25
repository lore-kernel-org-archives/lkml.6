Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDYFqo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeDYFqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:46:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8497217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: enforce fsync_mode=strict for renamed directory
Date: Tue, 24 Apr 2018 23:46:13 -0600
Message-Id: <20180425054613.2700-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180425054613.2700-1-jaegeuk@kernel.org>
References: <20180425054613.2700-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to give a option for user to be able to recover B/foo in the below
case.

mkdir A
sync()
rename(A, B)
creat (B/foo)
fsync (B/foo)
---crash---

Sugessted-by: Velayudhan Pillai <vijay@cs.utexas.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b5f404674cad..fef6e3ab2135 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -973,8 +973,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			f2fs_put_page(old_dir_page, 0);
 		f2fs_i_links_write(old_dir, false);
 	}
-	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+		if (S_ISDIR(old_inode->i_mode))
+			add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
+	}
 
 	f2fs_unlock_op(sbi);
 
-- 
2.17.0.484.g0c8726318c-goog
