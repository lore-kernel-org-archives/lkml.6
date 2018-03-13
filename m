Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbeCMMSz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:18:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46020 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCMMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:18:07 -0400
X-Google-Smtp-Source: AG47ELtp+sWjXlh0R79W7KsA4Os4WSjxLI+jLMdYG+5BbvSHSBpfN2gkjakm1fb2whuZYOCCbWMAng==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: containers@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/4 v5] devpts: hoist out check for DEVPTS_SUPER_MAGIC
Date: Tue, 13 Mar 2018 13:17:10 +0100
Message-Id: <20180313121713.32551-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313121713.32551-1-christian.brauner@ubuntu.com>
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoist the check whether we have already found a suitable devpts filesystem
out of devpts_ptmx_path() in preparation for the devpts bind-mount
resolution patch. This is a non-functional change.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
ChangeLog v4->v5:
* dput() dentry
ChangeLog v3->v4:
* patch unchanged
ChangeLog v2->v3:
* patch unchanged
ChangeLog v1->v2:
* patch added
ChangeLog v0->v1:
* patch not present
---
 fs/devpts/inode.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e31d6ed3ec32..71b901936113 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -138,10 +138,6 @@ static int devpts_ptmx_path(struct path *path)
 	struct super_block *sb;
 	int err;
 
-	/* Has the devpts filesystem already been found? */
-	if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
-		return 0;
-
 	/* Is a devpts filesystem at "pts" in the same directory? */
 	err = path_pts(path);
 	if (err)
@@ -159,21 +155,25 @@ static int devpts_ptmx_path(struct path *path)
 struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 {
 	struct path path;
-	int err;
+	int err = 0;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
+		err = devpts_ptmx_path(&path);
 	dput(path.dentry);
 	if (err) {
 		mntput(path.mnt);
 		return ERR_PTR(err);
 	}
+
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
 		return ERR_PTR(-ENODEV);
 	}
+
 	return path.mnt;
 }
 
@@ -182,15 +182,19 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
 	struct pts_fs_info *result;
 	struct path path;
 	struct super_block *sb;
-	int err;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
-	if (err) {
-		result = ERR_PTR(err);
-		goto out;
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
+		int err;
+
+		err = devpts_ptmx_path(&path);
+		if (err) {
+			result = ERR_PTR(err);
+			goto out;
+		}
 	}
 
 	/*
-- 
2.15.1
