Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeBKOyk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 09:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeBKOyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 09:54:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F77E20CA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: introduce sb_lock to make encrypt pwsalt update exclusive
Date: Sun, 11 Feb 2018 22:53:20 +0800
Message-Id: <20180211145321.11285-1-chao@kernel.org>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

f2fs_super_block.encrypt_pw_salt can be udpated and persisted
concurrently, result in getting different pwsalt in separated
threads, so let's introduce sb_lock to exclude concurrent
accessers.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 19 +++++++++++--------
 fs/f2fs/super.c |  2 ++
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7ed17cd657b5..0332c44a1d93 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1048,6 +1048,7 @@ struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
 	struct f2fs_super_block *raw_super;	/* raw super block pointer */
+	struct mutex sb_lock;			/* lock for raw super block */
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef362899df4e..f26a0bd17469 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1965,13 +1965,15 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_encrypt(inode->i_sb))
 		return -EOPNOTSUPP;
 
-	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
-		goto got_it;
-
 	err = mnt_want_write_file(filp);
 	if (err)
 		return err;
 
+	mutex_lock(&sbi->sb_lock);
+
+	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
+		goto got_it;
+
 	/* update superblock with uuid */
 	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
 
@@ -1979,15 +1981,16 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 	if (err) {
 		/* undo new data */
 		memset(sbi->raw_super->encrypt_pw_salt, 0, 16);
-		mnt_drop_write_file(filp);
-		return err;
+		goto out_err;
 	}
-	mnt_drop_write_file(filp);
 got_it:
 	if (copy_to_user((__u8 __user *)arg, sbi->raw_super->encrypt_pw_salt,
 									16))
-		return -EFAULT;
-	return 0;
+		err = -EFAULT;
+out_err:
+	mutex_unlock(&sbi->sb_lock);
+	mnt_drop_write_file(filp);
+	return err;
 }
 
 static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 52986c9cc677..1b49ad477dd9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2232,6 +2232,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	sbi->dirty_device = 0;
 	spin_lock_init(&sbi->dev_lock);
+
+	mutex_init(&sbi->sb_lock);
 }
 
 static int init_percpu_info(struct f2fs_sb_info *sbi)
-- 
2.14.1.145.gb3622a4ee
