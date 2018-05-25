Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971966AbeEYAJj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:09:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968746AbeEYAIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:40 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/32] vfs: Allow cloning of a mount tree with
 open(O_PATH|O_CLONE_MOUNT) [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:38 +0100
Message-ID: <152720691829.9073.10564431140980997005.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to clone a mount tree with a new pair of open flags that
are used in conjunction with O_PATH:

 (1) O_CLONE_MOUNT - Clone the mount or mount tree at the path.

 (2) O_NON_RECURSIVE - Don't clone recursively.

Note that it's not a good idea to reuse other flags (such as O_CREAT)
because the open routine for O_PATH does not give an error if any other
flags are used in conjunction with O_PATH, but rather just masks off any it
doesn't use.

The resultant file struct is marked FMODE_NEED_UNMOUNT to as it pins an
extra reference for the mount.  This will be cleared by the upcoming
move_mount() syscall when it successfully moves a cloned mount into the
filesystem tree.

Note that care needs to be taken with the error handling in do_o_path() in
the case that vfs_open() fails as the path may or may not have been
attached to the file struct and FMODE_NEED_UNMOUNT may or may not be set.
Note that O_DIRECT | O_PATH could be a problem with error handling too.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fcntl.c                       |    2 +-
 fs/internal.h                    |    1 +
 fs/namei.c                       |   26 ++++++++++++++++++----
 fs/namespace.c                   |   44 ++++++++++++++++++++++++++++++++++++++
 fs/open.c                        |    7 +++++-
 include/linux/fcntl.h            |    3 ++-
 include/uapi/asm-generic/fcntl.h |    8 +++++++
 7 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 60bc5bf2f4cf..42a53cf03737 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1028,7 +1028,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(19 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
 		     HWEIGHT32(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
diff --git a/fs/internal.h b/fs/internal.h
index c29552e0522f..e3460a2e6b59 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -75,6 +75,7 @@ extern struct vfsmount *lookup_mnt(const struct path *);
 extern int finish_automount(struct vfsmount *, struct path *);
 
 extern int sb_prepare_remount_readonly(struct super_block *);
+extern int copy_mount_for_o_path(struct path *, struct path *, bool);
 
 extern void __init mnt_init(void);
 
diff --git a/fs/namei.c b/fs/namei.c
index 5cbd980b4031..acb8e27d4288 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3458,13 +3458,29 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 
 static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 {
-	struct path path;
-	int error = path_lookupat(nd, flags, &path);
-	if (!error) {
-		audit_inode(nd->name, path.dentry, 0);
-		error = vfs_open(&path, file, current_cred());
+	struct path path, tmp;
+	int error;
+
+	error = path_lookupat(nd, flags, &path);
+	if (error)
+		return error;
+
+	if (file->f_flags & O_CLONE_MOUNT) {
+		error = copy_mount_for_o_path(
+			&path, &tmp, !(file->f_flags & O_NON_RECURSIVE));
 		path_put(&path);
+		if (error < 0)
+			return error;
+		path = tmp;
 	}
+
+	audit_inode(nd->name, path.dentry, 0);
+	error = vfs_open(&path, file, current_cred());
+	if (error < 0 &&
+	    (flags & O_CLONE_MOUNT) &&
+	    !(file->f_mode & FMODE_NEED_UNMOUNT))
+		__detach_mounts(path.dentry);
+	path_put(&path);
 	return error;
 }
 
diff --git a/fs/namespace.c b/fs/namespace.c
index dba680aa1ea4..e73cfcdfb3d1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2218,6 +2218,50 @@ static int do_loopback(struct path *path, const char *old_name,
 	return err;
 }
 
+/*
+ * Copy the mount or mount subtree at the specified path for
+ * open(O_PATH|O_CLONE_MOUNT).
+ */
+int copy_mount_for_o_path(struct path *from, struct path *to, bool recurse)
+{
+	struct mountpoint *mp;
+	struct mount *mnt = NULL, *f = real_mount(from->mnt);
+	int ret;
+
+	mp = lock_mount(from);
+	if (IS_ERR(mp))
+		return PTR_ERR(mp);
+
+	ret = -EINVAL;
+	if (IS_MNT_UNBINDABLE(f))
+		goto out_unlock;
+
+	if (!check_mnt(f) && from->dentry->d_op != &ns_dentry_operations)
+		goto out_unlock;
+
+	if (!recurse && has_locked_children(f, from->dentry))
+		goto out_unlock;
+
+	if (recurse)
+		mnt = copy_tree(f, from->dentry, CL_COPY_MNT_NS_FILE);
+	else
+		mnt = clone_mnt(f, from->dentry, 0);
+	if (IS_ERR(mnt)) {
+		ret = PTR_ERR(mnt);
+		goto out_unlock;
+	}
+
+	mnt->mnt.mnt_flags &= ~MNT_LOCKED;
+
+	to->mnt = &mnt->mnt;
+	to->dentry = dget(from->dentry);
+	ret = 0;
+
+out_unlock:
+	unlock_mount(mp);
+	return ret;
+}
+
 static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
 {
 	int error = 0;
diff --git a/fs/open.c b/fs/open.c
index 79a8a1bd740d..27ce9c60345a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -748,6 +748,8 @@ static int do_dentry_open(struct file *f,
 
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode |= FMODE_PATH;
+		if (f->f_flags & O_CLONE_MOUNT)
+			f->f_mode |= FMODE_NEED_UNMOUNT;
 		f->f_op = &empty_fops;
 		goto done;
 	}
@@ -977,8 +979,11 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		 * If we have O_PATH in the open flag. Then we
 		 * cannot have anything other than the below set of flags
 		 */
-		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
+		flags &= (O_DIRECTORY | O_NOFOLLOW | O_PATH |
+			  O_CLONE_MOUNT | O_NON_RECURSIVE);
 		acc_mode = 0;
+	} else if (flags & (O_CLONE_MOUNT | O_NON_RECURSIVE)) {
+		return -EINVAL;
 	}
 
 	op->open_flag = flags;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a60693e..8f60e2244740 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,8 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | \
+	 O_CLONE_MOUNT | O_NON_RECURSIVE)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (BITS_PER_LONG != 32)
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 0b1c7e35090c..f533e35ea19b 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,14 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_CLONE_MOUNT
+#define O_CLONE_MOUNT	040000000	/* Used with O_PATH to clone the mount subtree at path */
+#endif
+
+#ifndef O_NON_RECURSIVE
+#define O_NON_RECURSIVE	0100000000	/* Used with O_CLONE_MOUNT to only clone one mount */
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
