Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeEHSGQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:54202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755806AbeEHSGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:11 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 57/76] fs/orangefs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:17 -0700
Message-Id: <20180508180436.716-58-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/orangefs/file.c            |  2 +-
 fs/orangefs/namei.c           | 12 ++++++++----
 fs/orangefs/orangefs-kernel.h |  8 ++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 0d228cd087e6..123a0c5b4a22 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -722,7 +722,7 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 {
 	int rc = -EINVAL;
 
-	if (ORANGEFS_SB(file_inode(filp)->i_sb)->flags & ORANGEFS_OPT_LOCAL_LOCK) {
+	if (ORANGEFS_SB(inode_sb(file_inode(filp)))->flags & ORANGEFS_OPT_LOCAL_LOCK) {
 		if (cmd == F_GETLK) {
 			rc = 0;
 			posix_test_lock(filp, fl);
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 6e3134e6d98a..79b76f8f0ba8 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -60,7 +60,8 @@ static int orangefs_create(struct inode *dir,
 	ref = new_op->downcall.resp.create.refn;
 	op_release(new_op);
 
-	inode = orangefs_new_inode(dir->i_sb, dir, S_IFREG | mode, 0, &ref);
+	inode = orangefs_new_inode(inode_sb(dir), dir, S_IFREG | mode, 0,
+				   &ref);
 	if (IS_ERR(inode)) {
 		gossip_err("%s: Failed to allocate inode for file :%pd:\n",
 			   __func__,
@@ -192,7 +193,8 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
 
 	orangefs_set_timeout(dentry);
 
-	inode = orangefs_iget(dir->i_sb, &new_op->downcall.resp.lookup.refn);
+	inode = orangefs_iget(inode_sb(dir),
+			      &new_op->downcall.resp.lookup.refn);
 	if (IS_ERR(inode)) {
 		gossip_debug(GOSSIP_NAME_DEBUG,
 			"error %ld from iget\n", PTR_ERR(inode));
@@ -320,7 +322,8 @@ static int orangefs_symlink(struct inode *dir,
 	ref = new_op->downcall.resp.sym.refn;
 	op_release(new_op);
 
-	inode = orangefs_new_inode(dir->i_sb, dir, S_IFLNK | mode, 0, &ref);
+	inode = orangefs_new_inode(inode_sb(dir), dir, S_IFLNK | mode, 0,
+				   &ref);
 	if (IS_ERR(inode)) {
 		gossip_err
 		    ("*** Failed to allocate orangefs symlink inode\n");
@@ -391,7 +394,8 @@ static int orangefs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	ref = new_op->downcall.resp.mkdir.refn;
 	op_release(new_op);
 
-	inode = orangefs_new_inode(dir->i_sb, dir, S_IFDIR | mode, 0, &ref);
+	inode = orangefs_new_inode(inode_sb(dir), dir, S_IFDIR | mode, 0,
+				   &ref);
 	if (IS_ERR(inode)) {
 		gossip_err("*** Failed to allocate orangefs dir inode\n");
 		ret = PTR_ERR(inode);
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index eebbaece85ef..c006a3f6dedd 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -325,11 +325,11 @@ static inline int is_root_handle(struct inode *inode)
 	gossip_debug(GOSSIP_DCACHE_DEBUG,
 		     "%s: root handle: %pU, this handle: %pU:\n",
 		     __func__,
-		     &ORANGEFS_SB(inode->i_sb)->root_khandle,
+		     &ORANGEFS_SB(inode_sb(inode))->root_khandle,
 		     get_khandle_from_ino(inode));
 
-	if (ORANGEFS_khandle_cmp(&(ORANGEFS_SB(inode->i_sb)->root_khandle),
-			     get_khandle_from_ino(inode)))
+	if (ORANGEFS_khandle_cmp(&(ORANGEFS_SB(inode_sb(inode))->root_khandle),
+				 get_khandle_from_ino(inode)))
 		return 0;
 	else
 		return 1;
@@ -513,7 +513,7 @@ int service_operation(struct orangefs_kernel_op_s *op,
 		      int flags);
 
 #define get_interruptible_flag(inode) \
-	((ORANGEFS_SB(inode->i_sb)->flags & ORANGEFS_OPT_INTR) ? \
+	((ORANGEFS_SB(inode_sb(inode))->flags & ORANGEFS_OPT_INTR) ? \
 		ORANGEFS_OP_INTERRUPTIBLE : 0)
 
 #define fill_default_sys_attrs(sys_attr, type, mode)			\
-- 
2.15.1
