Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971952AbeEYAIw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:08:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965158AbeEYAIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:46 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/32] [RFC] fs: Add a move_mount() system call [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:44 +0100
Message-ID: <152720692470.9073.11301353609129445901.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[!] NOTE: This patch doesn't quite work to move an O_CLONE_MOUNT-produced
    vfsmount as move_mount() checks that the source vfsmount mnt_ns matches
    the calling process's mnt_ns - but the vfsmount's mnt_ns isn't set
    until one attempts to actually mount it into the namespace.

Add a move_mount() system call that will move a mount from one place to
another and change the flags, where one or both of those places may be
selected by an O_PATH open.

To this end, two additional open()/openat() flags are defined that can be
used with O_PATH:

 (*) O_CLONE_MOUNT - Clone a mount (subtree) and attach it to the file
     descriptor.  This can be used to turn a move_mount() into a copy
     operation.

 (*) O_NON_RECURSIVE - Clone only the targetted mount, and not the entire
     subtree.

Unfortunately, the other extant open flags cannot be reused as when O_PATH
was added, no check was provided that would give an error if any other flag
was given other than O_TMPFILE, O_DIRECTORY, O_NOFOLLOW and O_CLOEXEC -
rather, the flags are just masked off - so there's no guarantee that
userspace isn't attempting to do this somewhere.  Further, O_CREAT has an
effect before the O_PATH handling clears it - though this may be later
ignored.

The new system call looks like the following:

	int move_mount(int from_dfd, const char *from_path,
		       int to_dfd, const char *to_path,
		       unsigned int ms_flags);

As from_dfd and to_dfd can both be obtained from openat(O_PATH), there is
no need to have two sets of AT_NO_FOLLOW-style flags here also.  Further,
either fd can be obtained from the new fsmount() syscall.

New mounts are a case of:

	sbfd = fsopen();
	...
	mfd = fsmount(, MS_RDONLY);
	move_mount(mfd, NULL, AT_FDCWD, "/mnt", MS_RDONLY);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/internal.h                          |    3 +
 fs/namei.c                             |   40 ++++++++++
 fs/namespace.c                         |  125 ++++++++++++++++++++++++++++----
 include/linux/lsm_hooks.h              |    6 ++
 include/linux/security.h               |    7 ++
 include/linux/syscalls.h               |    3 +
 include/uapi/linux/mount.h             |   11 +++
 kernel/sys_ni.c                        |    1 
 security/security.c                    |    5 +
 11 files changed, 186 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index b7e2adda092c..76c95f35a599 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -400,3 +400,4 @@
 386	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
 387	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 388	i386	fspick			sys_fspick			__ia32_sys_fspick
+389	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index fd322986974b..b53080b756e8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 334	common	fsopen			__x64_sys_fsopen
 335	common	fsmount			__x64_sys_fsmount
 336	common	fspick			__x64_sys_fspick
+337	common	move_mount		__x64_sys_move_mount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/internal.h b/fs/internal.h
index e3460a2e6b59..a52cfef7b47b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -17,6 +17,7 @@ struct linux_binprm;
 struct path;
 struct mount;
 struct shrink_control;
+struct fd_cookie;
 
 /*
  * block_dev.c
@@ -55,6 +56,8 @@ extern void __init chrdev_init(void);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
+extern int move_mount_lookup(int, const char __user *, unsigned,
+			     struct path *, struct fd_cookie **);
 long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		unsigned int dev);
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
diff --git a/fs/namei.c b/fs/namei.c
index acb8e27d4288..c4063170fb20 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2333,6 +2333,46 @@ static int filename_lookup(int dfd, struct filename *name, unsigned flags,
 	return retval;
 }
 
+/*
+ * Look up the from for move_mount().  This is a bit tricky as move_mount()
+ * needs to clear FMODE_NEED_UNMOUNT on the file struct pointed to by dfd - if
+ * the pathname is empty and if the move completed successfully, so we need to
+ * pass back the fd information to the caller.
+ */
+int move_mount_lookup(int dfd, const char __user *from_name, unsigned flags,
+		      struct path *path, struct fd_cookie **_dfd_f)
+{
+	struct nameidata nd;
+	struct filename *name;
+	struct file *file;
+	int retval;
+
+	name = getname_flags(from_name, flags, NULL);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+	set_nameidata(&nd, dfd, name);
+	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
+	if (unlikely(retval == -ECHILD))
+		retval = path_lookupat(&nd, flags, path);
+	if (unlikely(retval == -ESTALE))
+		retval = path_lookupat(&nd, flags | LOOKUP_REVAL, path);
+
+	if (likely(!retval)) {
+		audit_inode(name, path->dentry, flags & LOOKUP_PARENT);
+		file = __fdfile(nd.dfd);
+		if (file &&
+		    file->f_path.mnt == path->mnt &&
+		    file->f_path.dentry == path->dentry) {
+			*_dfd_f = nd.dfd;
+			nd.dfd = NULL;
+		}
+	}
+
+	restore_nameidata();
+	putname(name);
+	return retval;
+}
+
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
 static int path_parentat(struct nameidata *nd, unsigned flags,
 				struct path *parent)
diff --git a/fs/namespace.c b/fs/namespace.c
index e73cfcdfb3d1..5cd9b5be149f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2395,26 +2395,22 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 	return 0;
 }
 
-static int do_move_mount(struct path *path, const char *old_name)
+static int do_move_mount(struct path *old_path, struct path *new_path,
+			 const struct file *dfd_ref)
 {
-	struct path old_path, parent_path;
+	struct path parent_path;
 	struct mount *p;
 	struct mount *old;
 	struct mountpoint *mp;
 	int err;
-	if (!old_name || !*old_name)
-		return -EINVAL;
-	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
-	if (err)
-		return err;
 
-	mp = lock_mount(path);
+	mp = lock_mount(new_path);
 	err = PTR_ERR(mp);
 	if (IS_ERR(mp))
 		goto out;
 
-	old = real_mount(old_path.mnt);
-	p = real_mount(path->mnt);
+	old = real_mount(old_path->mnt);
+	p = real_mount(new_path->mnt);
 
 	err = -EINVAL;
 	if (!check_mnt(p) || !check_mnt(old))
@@ -2424,14 +2420,19 @@ static int do_move_mount(struct path *path, const char *old_name)
 		goto out1;
 
 	err = -EINVAL;
-	if (old_path.dentry != old_path.mnt->mnt_root)
+	if (old_path->dentry != old_path->mnt->mnt_root)
 		goto out1;
 
-	if (!mnt_has_parent(old))
-		goto out1;
+	if (!mnt_has_parent(old)) {
+		/* We need to allow open(O_PATH|O_CLONE_MOUNT) or fsmount()
+		 * followed by move_mount(), but mustn't allow "/" to be moved.
+		 */
+		if (!dfd_ref || !(dfd_ref->f_mode & FMODE_NEED_UNMOUNT))
+			goto out1;
+	}
 
-	if (d_is_dir(path->dentry) !=
-	      d_is_dir(old_path.dentry))
+	if (d_is_dir(new_path->dentry) !=
+	    d_is_dir(old_path->dentry))
 		goto out1;
 	/*
 	 * Don't move a mount residing in a shared parent.
@@ -2449,7 +2450,8 @@ static int do_move_mount(struct path *path, const char *old_name)
 		if (p == old)
 			goto out1;
 
-	err = attach_recursive_mnt(old, real_mount(path->mnt), mp, &parent_path);
+	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
+				   &parent_path);
 	if (err)
 		goto out1;
 
@@ -2461,6 +2463,22 @@ static int do_move_mount(struct path *path, const char *old_name)
 out:
 	if (!err)
 		path_put(&parent_path);
+	return err;
+}
+
+static int do_move_mount_old(struct path *path, const char *old_name)
+{
+	struct path old_path;
+	int err;
+
+	if (!old_name || !*old_name)
+		return -EINVAL;
+
+	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
+	if (err)
+		return err;
+
+	err = do_move_mount(&old_path, path, NULL);
 	path_put(&old_path);
 	return err;
 }
@@ -2903,7 +2921,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
 		retval = do_change_type(&path, flags);
 	else if (flags & MS_MOVE)
-		retval = do_move_mount(&path, dev_name);
+		retval = do_move_mount_old(&path, dev_name);
 	else
 		retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
 				      dev_name, data_page, data_size);
@@ -3375,6 +3393,79 @@ SYSCALL_DEFINE5(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags
 	return ret;
 }
 
+/*
+ * Move a mount from one place to another.  In combination with
+ * fsopen()/fsmount() this is used to install a new mount and in combination
+ * with open(O_PATH|O_CLONE_MOUNT[|O_NON_RECURSIVE]) it can be used to copy a
+ * mount subtree.
+ *
+ * Note the flags value is a combination of MOVE_MOUNT_* flags.
+ */
+SYSCALL_DEFINE5(move_mount,
+		int, from_dfd, const char *, from_pathname,
+		int, to_dfd, const char *, to_pathname,
+		unsigned int, flags)
+{
+	struct path from_path, to_path;
+	struct fd_cookie *from_f = NULL;
+	unsigned int lflags;
+	int ret = 0;
+
+	if (!may_mount())
+		return -EPERM;
+
+	if (flags & ~MOVE_MOUNT__MASK)
+		return -EINVAL;
+
+	/* If someone gives a pathname, they aren't permitted to move
+	 * from an fd that requires unmount as we can't get at the flag
+	 * to clear it afterwards.
+	 */
+	lflags = 0;
+	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
+	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
+
+	ret = move_mount_lookup(from_dfd, from_pathname, lflags, &from_path,
+				&from_f);
+	if (ret < 0)
+		return ret;
+
+	lflags = 0;
+	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
+	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
+
+	ret = user_path_at(to_dfd, to_pathname, lflags, &to_path);
+	if (ret < 0)
+		goto out_from;
+
+	ret = security_move_mount(&from_path, &to_path);
+	if (ret < 0)
+		goto out_to;
+
+	ret = do_move_mount(&from_path, &to_path, __fdfile(from_f));
+
+out_to:
+	path_put(&to_path);
+out_from:
+	path_put(&from_path);
+	if (from_f) {
+		if (ret == 0) {
+			struct file *file = __fdfile(from_f);
+
+			/* If successful, move_mount() should always clear the
+			 * unmount-on-close flag, but it may race with another
+			 * move_mount() when doing so.
+			 */
+			WRITE_ONCE(file->f_flags,
+				   READ_ONCE(file->f_flags) & ~FMODE_NEED_UNMOUNT);
+		}
+		__fdput(from_f);
+	}
+	return ret;
+}
+
 /*
  * Return true if path is reachable from root
  *
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5d8f8bd39b52..85fea328dbac 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -198,6 +198,10 @@
  *	Parse a string of security data filling in the opts structure
  *	@options string containing all mount options known by the LSM
  *	@opts binary data structure usable by the LSM
+ * @move_mount:
+ *	Check permission before a mount is moved.
+ *	@from_path indicates the mount that is going to be moved.
+ *	@to_path indicates the mountpoint that will be mounted upon.
  * @dentry_init_security:
  *	Compute a context for a dentry as the inode is not yet available
  *	since NFSv4 has no label backed by an EA anyway.
@@ -1535,6 +1539,7 @@ union security_list_options {
 					unsigned long kern_flags,
 					unsigned long *set_kern_flags);
 	int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
+	int (*move_mount)(const struct path *from_path, const struct path *to_path);
 	int (*dentry_init_security)(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen);
@@ -1873,6 +1878,7 @@ struct security_hook_heads {
 	struct hlist_head sb_set_mnt_opts;
 	struct hlist_head sb_clone_mnt_opts;
 	struct hlist_head sb_parse_opts_str;
+	struct hlist_head move_mount;
 	struct hlist_head dentry_init_security;
 	struct hlist_head dentry_create_files_as;
 #ifdef CONFIG_SECURITY_PATH
diff --git a/include/linux/security.h b/include/linux/security.h
index 5040455a747d..fcc6f5d04006 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -261,6 +261,7 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags);
 int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
+int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen);
@@ -655,6 +656,12 @@ static inline int security_sb_parse_opts_str(char *options, struct security_mnt_
 	return 0;
 }
 
+static inline int security_move_mount(const struct path *from_path,
+				      const struct path *to_path)
+{
+	return 0;
+}
+
 static inline int security_inode_alloc(struct inode *inode)
 {
 	return 0;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5130fd687a85..bf89f57046dc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -901,6 +901,9 @@ asmlinkage long sys_fsopen(const char *fs_name, unsigned int flags,
 asmlinkage long sys_fsmount(int fsfd, int dfd, const char *path, unsigned int at_flags,
 			    unsigned int flags);
 asmlinkage long sys_fspick(int dfd, const char *path, unsigned int at_flags);
+asmlinkage long sys_move_mount(int from_dfd, const char *from_path,
+			       int to_dfd, const char *to_path,
+			       unsigned int ms_flags);
 
 
 /*
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 3f9ec42510b0..2084596eb1d9 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -55,4 +55,15 @@
 #define MS_MGC_VAL 0xC0ED0000
 #define MS_MGC_MSK 0xffff0000
 
+/*
+ * move_mount() flags.
+ */
+#define MOVE_MOUNT_F_SYMLINKS		0x00000001 /* Follow symlinks on from path */  
+#define MOVE_MOUNT_F_AUTOMOUNTS		0x00000002 /* Follow automounts on from path */
+#define MOVE_MOUNT_F_EMPTY_PATH		0x00000004 /* Empty from path permitted */
+#define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */  
+#define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
+#define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */	     
+#define MOVE_MOUNT__MASK		0x00000077
+	
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 152fdc95d426..e65b5d587251 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -437,3 +437,4 @@ COND_SYSCALL(setuid16);
 COND_SYSCALL(sys_fsopen);
 COND_SYSCALL(sys_fsmount);
 COND_SYSCALL(sys_fspick);
+COND_SYSCALL(sys_move_mount);
diff --git a/security/security.c b/security/security.c
index 3b155f7ee3ba..f7af4093706a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -480,6 +480,11 @@ int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
 }
 EXPORT_SYMBOL(security_sb_parse_opts_str);
 
+int security_move_mount(const struct path *from_path, const struct path *to_path)
+{
+	return call_int_hook(move_mount, 0, from_path, to_path);
+}
+
 int security_inode_alloc(struct inode *inode)
 {
 	inode->i_security = NULL;
