Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbeEHSjn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755380AbeEHSE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:59 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 07/76] kernel: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:27 -0700
Message-Id: <20180508180436.716-8-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 kernel/audit.c          | 2 +-
 kernel/audit_fsnotify.c | 2 +-
 kernel/audit_watch.c    | 5 +++--
 kernel/auditsc.c        | 8 ++++----
 kernel/bpf/inode.c      | 6 +++---
 kernel/bpf/offload.c    | 4 ++--
 kernel/events/core.c    | 4 ++--
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 227db99b0f19..23159573aafd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2050,7 +2050,7 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
 		      struct inode *inode)
 {
 	name->ino   = inode->i_ino;
-	name->dev   = inode->i_sb->s_dev;
+	name->dev   = inode_sb(inode)->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 52f368b6561e..981432cef19c 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -76,7 +76,7 @@ int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_
 static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
 			     const struct inode *inode)
 {
-	audit_mark->dev = inode ? inode->i_sb->s_dev : AUDIT_DEV_UNSET;
+	audit_mark->dev = inode ? inode_sb(inode)->s_dev : AUDIT_DEV_UNSET;
 	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
 }
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 9eb8b3511636..3e785d4cf8aa 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -499,7 +499,8 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
 	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
+		audit_update_watch(parent, dname, inode_sb(inode)->s_dev,
+				   inode->i_ino, 0);
 	else if (mask & (FS_DELETE|FS_MOVED_FROM))
 		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
@@ -553,7 +554,7 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 	if (!exe_file)
 		return 0;
 	ino = file_inode(exe_file)->i_ino;
-	dev = file_inode(exe_file)->i_sb->s_dev;
+	dev = inode_sb(file_inode(exe_file))->s_dev;
 	fput(exe_file);
 	return audit_mark_compare(mark, ino, dev);
 }
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f7e132..9cb16a1ebedd 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1797,7 +1797,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		if (n->ino) {
 			/* valid inode number, use that for the comparison */
 			if (n->ino != inode->i_ino ||
-			    n->dev != inode->i_sb->s_dev)
+			    n->dev != inode_sb(inode)->s_dev)
 				continue;
 		} else if (n->name) {
 			/* inode number has not been set, check the name */
@@ -1883,8 +1883,8 @@ void __audit_inode_child(struct inode *parent,
 				struct audit_field *f = &e->rule.fields[i];
 
 				if (f->type == AUDIT_FSTYPE) {
-					if (audit_comparator(parent->i_sb->s_magic,
-					    f->op, f->val)) {
+					if (audit_comparator(inode_sb(parent)->s_magic,
+						             f->op, f->val)) {
 						if (e->rule.action == AUDIT_NEVER) {
 							rcu_read_unlock();
 							return;
@@ -1906,7 +1906,7 @@ void __audit_inode_child(struct inode *parent,
 		     n->type != AUDIT_TYPE_UNKNOWN))
 			continue;
 
-		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
+		if (n->ino == parent->i_ino && n->dev == inode_sb(parent)->s_dev &&
 		    !audit_compare_dname_path(dname,
 					      n->name->name, n->name_len)) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 81e2f6995adb..130d9edc11eb 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -136,7 +136,7 @@ static int bpf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 
-	inode = bpf_get_inode(dir->i_sb, dir, mode | S_IFDIR);
+	inode = bpf_get_inode(inode_sb(dir), dir, mode | S_IFDIR);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -154,7 +154,7 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 			 const struct inode_operations *iops)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
-	struct inode *inode = bpf_get_inode(dir->i_sb, dir, mode);
+	struct inode *inode = bpf_get_inode(inode_sb(dir), dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -193,7 +193,7 @@ static int bpf_symlink(struct inode *dir, struct dentry *dentry,
 	if (!link)
 		return -ENOMEM;
 
-	inode = bpf_get_inode(dir->i_sb, dir, S_IRWXUGO | S_IFLNK);
+	inode = bpf_get_inode(inode_sb(dir), dir, S_IRWXUGO | S_IFLNK);
 	if (IS_ERR(inode)) {
 		kfree(link);
 		return PTR_ERR(inode);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index c9401075b58c..6ff86b395175 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -265,7 +265,7 @@ int bpf_prog_offload_info_fill(struct bpf_prog_info *info,
 	up_read(&bpf_devs_lock);
 
 	ns_inode = ns_path.dentry->d_inode;
-	info->netns_dev = new_encode_dev(ns_inode->i_sb->s_dev);
+	info->netns_dev = new_encode_dev(inode_sb(ns_inode)->s_dev);
 	info->netns_ino = ns_inode->i_ino;
 	path_put(&ns_path);
 
@@ -461,7 +461,7 @@ int bpf_map_offload_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 	}
 
 	ns_inode = ns_path.dentry->d_inode;
-	info->netns_dev = new_encode_dev(ns_inode->i_sb->s_dev);
+	info->netns_dev = new_encode_dev(inode_sb(ns_inode)->s_dev);
 	info->netns_ino = ns_inode->i_ino;
 	path_put(&ns_path);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 709a55b9ad97..58c02221e066 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6713,7 +6713,7 @@ static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
 	error = ns_get_path(&ns_path, task, ns_ops);
 	if (!error) {
 		ns_inode = ns_path.dentry->d_inode;
-		ns_link_info->dev = new_encode_dev(ns_inode->i_sb->s_dev);
+		ns_link_info->dev = new_encode_dev(inode_sb(ns_inode)->s_dev);
 		ns_link_info->ino = ns_inode->i_ino;
 		path_put(&ns_path);
 	}
@@ -6918,7 +6918,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 			goto cpy_name;
 		}
 		inode = file_inode(vma->vm_file);
-		dev = inode->i_sb->s_dev;
+		dev = inode_sb(inode)->s_dev;
 		ino = inode->i_ino;
 		gen = inode->i_generation;
 		maj = MAJOR(dev);
-- 
2.15.1
