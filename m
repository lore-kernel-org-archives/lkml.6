Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755956AbeEHSXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:23:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54219 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755808AbeEHSGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:12 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 58/76] fs/overlayfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:18 -0700
Message-Id: <20180508180436.716-59-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/overlayfs/export.c | 2 +-
 fs/overlayfs/inode.c  | 6 +++---
 fs/overlayfs/super.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 87bd4148f4fb..41b23510f5b9 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -316,7 +316,7 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
 
 	dentry = d_find_any_alias(inode);
 	if (!dentry) {
-		dentry = d_alloc_anon(inode->i_sb);
+		dentry = d_alloc_anon(inode_sb(inode));
 		if (!dentry)
 			goto nomem;
 		oe = ovl_alloc_entry(lower ? 1 : 0);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3b1bd469accd..ebf2a857d547 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -199,7 +199,7 @@ int ovl_permission(struct inode *inode, int mask)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds(inode_sb(inode));
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
@@ -342,7 +342,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
 		return NULL;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	old_cred = ovl_override_creds(inode_sb(inode));
 	acl = get_acl(realinode, type);
 	revert_creds(old_cred);
 
@@ -445,7 +445,7 @@ static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *inode)
 	static struct lock_class_key ovl_i_mutex_dir_key[OVL_MAX_NESTING];
 	static struct lock_class_key ovl_i_lock_key[OVL_MAX_NESTING];
 
-	int depth = inode->i_sb->s_stack_depth - 1;
+	int depth = inode_sb(inode)->s_stack_depth - 1;
 
 	if (WARN_ON_ONCE(depth < 0 || depth >= OVL_MAX_NESTING))
 		depth = 0;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7c24619ae7fc..bc04230f3ffb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -127,7 +127,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 		return real;
 bug:
 	WARN(1, "ovl_d_real(%pd4, %s:%lu): real dentry not found\n", dentry,
-	     inode ? inode->i_sb->s_id : "NULL", inode ? inode->i_ino : 0);
+	     inode ? inode_sb(inode)->s_id : "NULL", inode ? inode->i_ino : 0);
 	return dentry;
 }
 
-- 
2.15.1
