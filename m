Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeDMKvv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:51:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33889 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753859AbeDMKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:51:49 -0400
X-Google-Smtp-Source: AIpwx4/a7yHElFJ1VJ5c07wJnn93Tw1z1q40JlvrS2UcN7o0fmvCcIv/zm4kp/t+wpHlVfrVYVf1yw==
From: Gwendal Grignou <gwendal@chromium.org>
To: jlbec@evilplan.org
Cc: drosen@google.com, linux-kernel@vger.kernel.org, jorgelo@chromium.org
Subject: [PATCH] configfs: inherit file and directory owners
Date: Fri, 13 Apr 2018 03:51:35 -0700
Message-Id: <20180413105135.216944-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <CAMHSBOX0sP5vnFJ8uzsRxoHi=cP874FZazp8uJs3UN8wu73ipw@mail.gmail.com>
References: <CAMHSBOX0sP5vnFJ8uzsRxoHi=cP874FZazp8uJs3UN8wu73ipw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All entries in configfs are currently owned by root,
regardless of context. Instead, this preserves the
current ownership, allowing userspace to choose who
has permissions to configure the system through
any particular configfs subsystem.

This means anyone who can create a group will now
have the ability to create any groups inside of that
group.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 fs/configfs/inode.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index ad718e5e37bb..1b55374de953 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -54,6 +54,28 @@ static const struct inode_operations configfs_inode_operations ={
 	.setattr	= configfs_setattr,
 };
 
+static struct iattr *alloc_iattr(struct configfs_dirent *sd_parent,
+						struct configfs_dirent *sd)
+{
+	struct iattr *sd_iattr;
+
+	sd_iattr = kzalloc(sizeof(struct iattr), GFP_KERNEL);
+	if (!sd_iattr)
+		return NULL;
+	/* assign default attributes */
+	sd_iattr->ia_mode = sd->s_mode;
+	if (sd_parent && sd_parent->s_iattr) {
+		sd_iattr->ia_uid = sd_parent->s_iattr->ia_uid;
+		sd_iattr->ia_gid = sd_parent->s_iattr->ia_gid;
+	} else {
+		sd_iattr->ia_uid = GLOBAL_ROOT_UID;
+		sd_iattr->ia_gid = GLOBAL_ROOT_GID;
+	}
+	sd_iattr->ia_atime = sd_iattr->ia_mtime =
+			sd_iattr->ia_ctime = CURRENT_TIME;
+	return sd_iattr;
+}
+
 int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
 {
 	struct inode * inode = d_inode(dentry);
@@ -68,15 +90,9 @@ int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
 	sd_iattr = sd->s_iattr;
 	if (!sd_iattr) {
 		/* setting attributes for the first time, allocate now */
-		sd_iattr = kzalloc(sizeof(struct iattr), GFP_KERNEL);
+		sd_iattr = alloc_iattr(NULL, sd);
 		if (!sd_iattr)
 			return -ENOMEM;
-		/* assign default attributes */
-		sd_iattr->ia_mode = sd->s_mode;
-		sd_iattr->ia_uid = GLOBAL_ROOT_UID;
-		sd_iattr->ia_gid = GLOBAL_ROOT_GID;
-		sd_iattr->ia_atime = sd_iattr->ia_mtime =
-			sd_iattr->ia_ctime = current_time(inode);
 		sd->s_iattr = sd_iattr;
 	}
 	/* attributes were changed atleast once in past */
@@ -184,6 +200,7 @@ int configfs_create(struct dentry * dentry, umode_t mode, void (*init)(struct in
 	struct inode *inode = NULL;
 	struct configfs_dirent *sd;
 	struct inode *p_inode;
+	struct dentry *parent;
 
 	if (!dentry)
 		return -ENOENT;
@@ -192,6 +209,13 @@ int configfs_create(struct dentry * dentry, umode_t mode, void (*init)(struct in
 		return -EEXIST;
 
 	sd = dentry->d_fsdata;
+	parent = dget_parent(dentry);
+	if (parent && !sd->s_iattr) {
+		sd->s_iattr = alloc_iattr(parent->d_fsdata, sd);
+		if (!sd->s_iattr)
+			return -ENOMEM;
+	}
+	dput(parent);
 	inode = configfs_new_inode(mode, sd, dentry->d_sb);
 	if (!inode)
 		return -ENOMEM;
-- 
2.17.0.484.g0c8726318c-goog
