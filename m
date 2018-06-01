Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeFADSe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 23:18:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57076 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFADSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 23:18:31 -0400
Date: Fri, 1 Jun 2018 04:18:29 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/32] vfs: Make close() unmount the attached mount if so
 flagged [ver #8]
Message-ID: <20180601031829.GQ30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720685405.9073.17445116582570028610.stgit@warthog.procyon.org.uk>
 <20180531191955.GG30522@ZenIV.linux.org.uk>
 <20180601015255.GP30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601015255.GP30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, this on top of your current branch (I'll fold and reorder) gets
your move_mount(2) test work, AFAICS:

diff --git a/fs/file_table.c b/fs/file_table.c
index 06e979e1347e..6dd9760b3ddc 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -200,9 +200,6 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
-	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
-		drop_collected_mounts(mnt);
-
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
@@ -228,7 +225,10 @@ static void __fput(struct file *file)
 	file->f_inode = NULL;
 	file_free(file);
 	dput(dentry);
-	mntput(mnt);
+	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
+		umount_on_fput(mnt);
+	else
+		mntput(mnt);
 }
 
 static LLIST_HEAD(delayed_fput_list);
diff --git a/fs/internal.h b/fs/internal.h
index 6d0538af32d9..7ec629916f6d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -75,7 +75,7 @@ extern struct vfsmount *lookup_mnt(const struct path *);
 extern int finish_automount(struct vfsmount *, struct path *);
 
 extern int sb_prepare_remount_readonly(struct super_block *);
-extern int copy_mount_for_o_path(struct path *, struct path *, bool);
+extern int copy_mount_for_o_path(struct path *, bool);
 
 extern void __init mnt_init(void);
 
@@ -86,6 +86,8 @@ extern void __mnt_drop_write(struct vfsmount *);
 extern void __mnt_drop_write_file(struct file *);
 extern void mnt_drop_write_file_path(struct file *);
 
+extern void umount_on_fput(struct vfsmount *);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namei.c b/fs/namei.c
index 7430e000c1d2..b1c451b6b508 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3454,28 +3454,20 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 
 static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 {
-	struct path path, tmp;
-	int error;
-
-	error = path_lookupat(nd, flags, &path);
+	struct path path;
+	int error = path_lookupat(nd, flags, &path);
 	if (error)
 		return error;
 
 	if (file->f_flags & O_CLONE_MOUNT) {
-		error = copy_mount_for_o_path(
-			&path, &tmp, !(file->f_flags & O_NON_RECURSIVE));
-		path_put(&path);
+		error = copy_mount_for_o_path(&path,
+				!(file->f_flags & O_NON_RECURSIVE));
 		if (error < 0)
 			return error;
-		path = tmp;
 	}
 
 	audit_inode(nd->name, path.dentry, 0);
 	error = vfs_open(&path, file, current_cred());
-	if (error < 0 &&
-	    (flags & O_CLONE_MOUNT) &&
-	    !(file->f_mode & FMODE_NEED_UNMOUNT))
-		__detach_mounts(path.dentry);
 	path_put(&path);
 	return error;
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index dd9cf81c2aea..74c68a23d088 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1793,7 +1793,7 @@ struct vfsmount *collect_mounts(const struct path *path)
 	return &tree->mnt;
 }
 
-void drop_collected_mounts(struct vfsmount *mnt)
+void umount_on_fput(struct vfsmount *mnt)
 {
 	namespace_lock();
 	lock_mount_hash();
@@ -1803,6 +1803,15 @@ void drop_collected_mounts(struct vfsmount *mnt)
 	namespace_unlock();
 }
 
+void drop_collected_mounts(struct vfsmount *mnt)
+{
+	namespace_lock();
+	lock_mount_hash();
+	umount_tree(real_mount(mnt), UMOUNT_SYNC);
+	unlock_mount_hash();
+	namespace_unlock();
+}
+
 /**
  * clone_private_mount - create a private clone of a path
  *
@@ -2153,6 +2162,30 @@ static bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return false;
 }
 
+static struct mount *__do_loopback(struct path *old_path, int recurse)
+{
+	struct mount *mnt = ERR_PTR(-EINVAL), *old = real_mount(old_path->mnt);
+
+	if (IS_MNT_UNBINDABLE(old))
+		return mnt;
+
+	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
+		return mnt;
+
+	if (!recurse && has_locked_children(old, old_path->dentry))
+		return mnt;
+
+	if (recurse)
+		mnt = copy_tree(old, old_path->dentry, CL_COPY_MNT_NS_FILE);
+	else
+		mnt = clone_mnt(old, old_path->dentry, 0);
+
+	if (!IS_ERR(mnt))
+		mnt->mnt.mnt_flags &= ~MNT_LOCKED;
+
+	return mnt;
+}
+
 /*
  * do loopback mount.
  */
@@ -2160,7 +2193,7 @@ static int do_loopback(struct path *path, const char *old_name,
 				int recurse)
 {
 	struct path old_path;
-	struct mount *mnt = NULL, *old, *parent;
+	struct mount *mnt = NULL, *parent;
 	struct mountpoint *mp;
 	int err;
 	if (!old_name || !*old_name)
@@ -2174,38 +2207,21 @@ static int do_loopback(struct path *path, const char *old_name,
 		goto out;
 
 	mp = lock_mount(path);
-	err = PTR_ERR(mp);
-	if (IS_ERR(mp))
+	if (IS_ERR(mp)) {
+		err = PTR_ERR(mp);
 		goto out;
+	}
 
-	old = real_mount(old_path.mnt);
 	parent = real_mount(path->mnt);
-
-	err = -EINVAL;
-	if (IS_MNT_UNBINDABLE(old))
-		goto out2;
-
 	if (!check_mnt(parent))
 		goto out2;
 
-	if (!check_mnt(old) && old_path.dentry->d_op != &ns_dentry_operations)
-		goto out2;
-
-	if (!recurse && has_locked_children(old, old_path.dentry))
-		goto out2;
-
-	if (recurse)
-		mnt = copy_tree(old, old_path.dentry, CL_COPY_MNT_NS_FILE);
-	else
-		mnt = clone_mnt(old, old_path.dentry, 0);
-
+	mnt = __do_loopback(&old_path, recurse);
 	if (IS_ERR(mnt)) {
 		err = PTR_ERR(mnt);
 		goto out2;
 	}
 
-	mnt->mnt.mnt_flags &= ~MNT_LOCKED;
-
 	err = graft_tree(mnt, parent, mp);
 	if (err) {
 		lock_mount_hash();
@@ -2223,44 +2239,16 @@ static int do_loopback(struct path *path, const char *old_name,
  * Copy the mount or mount subtree at the specified path for
  * open(O_PATH|O_CLONE_MOUNT).
  */
-int copy_mount_for_o_path(struct path *from, struct path *to, bool recurse)
+int copy_mount_for_o_path(struct path *path, bool recurse)
 {
-	struct mountpoint *mp;
-	struct mount *mnt = NULL, *f = real_mount(from->mnt);
-	int ret;
-
-	mp = lock_mount(from);
-	if (IS_ERR(mp))
-		return PTR_ERR(mp);
-
-	ret = -EINVAL;
-	if (IS_MNT_UNBINDABLE(f))
-		goto out_unlock;
-
-	if (!check_mnt(f) && from->dentry->d_op != &ns_dentry_operations)
-		goto out_unlock;
-
-	if (!recurse && has_locked_children(f, from->dentry))
-		goto out_unlock;
-
-	if (recurse)
-		mnt = copy_tree(f, from->dentry, CL_COPY_MNT_NS_FILE);
-	else
-		mnt = clone_mnt(f, from->dentry, 0);
+	struct mount *mnt = __do_loopback(path, recurse);
 	if (IS_ERR(mnt)) {
-		ret = PTR_ERR(mnt);
-		goto out_unlock;
+		path_put(path);
+		return PTR_ERR(mnt);
 	}
-
-	mnt->mnt.mnt_flags &= ~MNT_LOCKED;
-
-	to->mnt = &mnt->mnt;
-	to->dentry = dget(from->dentry);
-	ret = 0;
-
-out_unlock:
-	unlock_mount(mp);
-	return ret;
+	mntput(path->mnt);
+	path->mnt = &mnt->mnt;
+	return 0;
 }
 
 static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
@@ -2398,11 +2386,12 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 
 static int do_move_mount(struct path *old_path, struct path *new_path)
 {
-	struct path parent_path;
+	struct path parent_path = {.mnt = NULL, .dentry = NULL};
 	struct mount *p;
 	struct mount *old;
 	struct mountpoint *mp;
 	int err;
+	bool attached;
 
 	mp = lock_mount(new_path);
 	err = PTR_ERR(mp);
@@ -2420,10 +2409,11 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (old->mnt_ns && !check_mnt(old))
 		goto out1;
 
+	attached = mnt_has_parent(old);
 	/* We need to allow open(O_PATH|O_CLONE_MOUNT) or fsmount() followed by
 	 * move_mount(), but mustn't allow "/" to be moved.
 	 */
-	if (old->mnt_ns && !mnt_has_parent(old))
+	if (old->mnt_ns && !attached)
 		goto out1;
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
@@ -2438,7 +2428,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	/*
 	 * Don't move a mount residing in a shared parent.
 	 */
-	if (IS_MNT_SHARED(old->mnt_parent))
+	if (attached && IS_MNT_SHARED(old->mnt_parent))
 		goto out1;
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
@@ -2452,7 +2442,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 			goto out1;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   &parent_path);
+				   attached ? &parent_path : NULL);
 	if (err)
 		goto out1;
 
