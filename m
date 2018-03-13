Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeCMACV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:02:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36987 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbeCMABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:01:42 -0400
X-Google-Smtp-Source: AG47ELuUEofWj7X4IDUNmJVoVESEVygO0GBAP02D2HZdXZhtBT8Vsyj/o+iSs02xZpeKIBpF06uqxg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3 v4] devpts: hoist out check for DEVPTS_SUPER_MAGIC
Date: Tue, 13 Mar 2018 01:01:29 +0100
Message-Id: <20180313000131.28971-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313000131.28971-1-christian.brauner@ubuntu.com>
References: <20180313000131.28971-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoist the check whether we have already found a suitable devpts filesystem
out of devpts_ptmx_path() in preparation for the devpts bind-mount
resolution patch. This is a non-functional change.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
 ---
ChangeLog v3->v4:
* patch unchanged
ChangeLog v2->v3:
* patch unchanged
ChangeLog v1->v2:
* patch added
ChangeLog v0->v1:
* patch not present
---
 fs/devpts/inode.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e31d6ed3ec32..d3ddbb888874 100644
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
@@ -159,17 +155,22 @@ static int devpts_ptmx_path(struct path *path)
 struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 {
 	struct path path;
-	int err;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
-	dput(path.dentry);
-	if (err) {
-		mntput(path.mnt);
-		return ERR_PTR(err);
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
+		int err;
+
+		err = devpts_ptmx_path(&path);
+		dput(path.dentry);
+		if (err) {
+			mntput(path.mnt);
+			return ERR_PTR(err);
+		}
 	}
+
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
 		return ERR_PTR(-ENODEV);
@@ -182,15 +183,19 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
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
