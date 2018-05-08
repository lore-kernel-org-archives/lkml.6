Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeEHSFM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755488AbeEHSFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:10 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 15/76] fs/autofs4: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:35 -0700
Message-Id: <20180508180436.716-16-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/autofs4/dev-ioctl.c |  2 +-
 fs/autofs4/root.c      | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index b7c816f39404..6b28b01e5022 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -166,7 +166,7 @@ static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
 
 	if (f) {
 		inode = file_inode(f);
-		sbi = autofs4_sbi(inode->i_sb);
+		sbi = autofs4_sbi(inode_sb(inode));
 	}
 	return sbi;
 }
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 82e8f6edfb48..41b0a0b73bce 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -513,7 +513,7 @@ static struct dentry *autofs4_lookup(struct inode *dir,
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	sbi = autofs4_sbi(dir->i_sb);
+	sbi = autofs4_sbi(inode_sb(dir));
 
 	pr_debug("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
 		 current->pid, task_pgrp_nr(current), sbi->catatonic,
@@ -553,7 +553,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 			       struct dentry *dentry,
 			       const char *symname)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(inode_sb(dir));
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	struct inode *inode;
@@ -577,7 +577,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 
 	strcpy(cp, symname);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFLNK | 0555);
+	inode = autofs4_get_inode(inode_sb(dir), S_IFLNK | 0555);
 	if (!inode) {
 		kfree(cp);
 		return -ENOMEM;
@@ -614,7 +614,7 @@ static int autofs4_dir_symlink(struct inode *dir,
  */
 static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(inode_sb(dir));
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
@@ -694,7 +694,7 @@ static void autofs_clear_leaf_automount_flags(struct dentry *dentry)
 
 static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(inode_sb(dir));
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
@@ -733,7 +733,7 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 static int autofs4_dir_mkdir(struct inode *dir,
 			     struct dentry *dentry, umode_t mode)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(inode_sb(dir));
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	struct inode *inode;
@@ -749,7 +749,7 @@ static int autofs4_dir_mkdir(struct inode *dir,
 
 	autofs4_del_active(dentry);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | 0555);
+	inode = autofs4_get_inode(inode_sb(dir), S_IFDIR | 0555);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
@@ -868,7 +868,7 @@ int is_autofs4_dentry(struct dentry *dentry)
 static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 				       unsigned int cmd, unsigned long arg)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
+	struct autofs_sb_info *sbi = autofs4_sbi(inode_sb(inode));
 	void __user *p = (void __user *)arg;
 
 	pr_debug("cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
@@ -905,11 +905,11 @@ static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 
 	/* return a single thing to expire */
 	case AUTOFS_IOC_EXPIRE:
-		return autofs4_expire_run(inode->i_sb,
+		return autofs4_expire_run(inode_sb(inode),
 					  filp->f_path.mnt, sbi, p);
 	/* same as above, but can send multiple expires through pipe */
 	case AUTOFS_IOC_EXPIRE_MULTI:
-		return autofs4_expire_multi(inode->i_sb,
+		return autofs4_expire_multi(inode_sb(inode),
 					    filp->f_path.mnt, sbi, p);
 
 	default:
-- 
2.15.1
