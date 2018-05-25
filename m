Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161653AbeEYAHr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:07:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S971843AbeEYAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:07:42 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/32] VFS: Implement fsmount() to effect a pre-configured
 mount [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:07:40 +0100
Message-ID: <152720686035.9073.17015443936296474540.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a system call by which a filesystem opened with fsopen() and
configured by a series of writes can be mounted:

	int ret = fsmount(int fsfd, int dfd, const char *path,
			  unsigned int at_flags, unsigned int flags);

where fsfd is the fd returned by fsopen(), dfd, path and at_flags locate
the mountpoint and flags are the applicable MS_* flags.  dfd can be
AT_FDCWD or an fd open to a directory.

In the event that fsmount() fails, it may be possible to get an error
message by calling read().  If no message is available, ENODATA will be
reported.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/namespace.c                         |  133 ++++++++++++++++++++++++++++++++
 include/linux/fs_context.h             |    2 
 include/linux/syscalls.h               |    2 
 include/uapi/linux/fs.h                |    7 ++
 kernel/sys_ni.c                        |    1 
 7 files changed, 147 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0e084cc11638..bdcb0c4a0491 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,3 +398,4 @@
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
+387	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7200d5bb65ca..7d932d3897fa 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,7 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	fsopen			__x64_sys_fsopen
+335	common	fsmount			__x64_sys_fsmount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/namespace.c b/fs/namespace.c
index ead49e822418..03ade803b948 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3198,6 +3198,139 @@ struct vfsmount *kern_mount(struct file_system_type *type)
 }
 EXPORT_SYMBOL_GPL(kern_mount);
 
+/*
+ * Create a kernel mount representation for a new, prepared superblock
+ * (specified by fs_fd) and attach to an O_PATH-class file descriptor.
+ */
+SYSCALL_DEFINE5(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags,
+		void *, spare_4, void *, spare_5)
+{
+	struct fs_context *fc;
+	struct inode *inode;
+	struct file *file;
+	struct path newmount;
+	struct fd f;
+	unsigned int mnt_flags = 0;
+	long ret;
+
+	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0 || spare_4 || spare_5)
+		return -EINVAL;
+
+	if (ms_flags & ~(MS_RDONLY | MS_NOSUID | MS_NODEV | MS_NOEXEC |
+			 MS_NOATIME | MS_NODIRATIME | MS_RELATIME |
+			 MS_STRICTATIME))
+		return -EINVAL;
+
+	if (ms_flags & MS_RDONLY)
+		mnt_flags |= MNT_READONLY;
+	if (ms_flags & MS_NOSUID)
+		mnt_flags |= MNT_NOSUID;
+	if (ms_flags & MS_NODEV)
+		mnt_flags |= MNT_NODEV;
+	if (ms_flags & MS_NOEXEC)
+		mnt_flags |= MNT_NOEXEC;
+	if (ms_flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
+
+	if (ms_flags & MS_STRICTATIME) {
+		if (ms_flags & MS_NOATIME)
+			return -EINVAL;
+	} else if (ms_flags & MS_NOATIME) {
+		mnt_flags |= MNT_NOATIME;
+	} else {
+		mnt_flags |= MNT_RELATIME;
+	}
+
+	f = fdget(fs_fd);
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EINVAL;
+	if (f.file->f_op != &fscontext_fs_fops)
+		goto err_fsfd;
+
+	fc = f.file->private_data;
+
+	ret = -EPERM;
+	if (!may_mount() ||
+	    ((fc->sb_flags & SB_MANDLOCK) && !may_mandlock()))
+		goto err_fsfd;
+
+	/* There must be a valid superblock or we can't mount it */
+	ret = -EINVAL;
+	if (!fc->root)
+		goto err_fsfd;
+
+	ret = -EPERM;
+	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
+		pr_warn("VFS: Mount too revealing\n");
+		goto err_fsfd;
+	}
+
+	inode = file_inode(f.file);
+	ret = inode_lock_killable(inode);
+	if (ret < 0)
+		goto err_fsfd;
+
+	ret = -EBUSY;
+	if (fc->phase != FS_CONTEXT_AWAITING_MOUNT)
+		goto err_unlock;
+
+	newmount.mnt = vfs_create_mount(fc, mnt_flags);
+	if (IS_ERR(newmount.mnt)) {
+		ret = PTR_ERR(newmount.mnt);
+		goto err_unlock;
+	}
+	newmount.dentry = dget(fc->root);
+
+	/* We've done the mount bit - now move the file context into more or
+	 * less the same state as if we'd done an fspick().  We don't want to
+	 * do any memory allocation or anything like that at this point as we
+	 * don't want to have to handle any errors incurred.
+	 */
+	if (fc->ops && fc->ops->free)
+		fc->ops->free(fc);
+	fc->fs_private = NULL;
+	fc->s_fs_info = NULL;
+	fc->sb_flags = 0;
+	fc->sloppy = false;
+	fc->silent = false;
+	fc->source_is_dev = false;
+	security_fs_context_free(fc);
+	fc->security = NULL;
+	kfree(fc->subtype);
+	fc->subtype = NULL;
+	kfree(fc->source);
+	fc->source = NULL;
+
+	fc->purpose = FS_CONTEXT_FOR_RECONFIGURE;
+	fc->phase = FS_CONTEXT_AWAITING_RECONF;
+
+	/* Attach to an apparent O_PATH fd with a note that we need to unmount
+	 * it, not just simply put it.
+	 */
+	file = dentry_open(&newmount, O_PATH, fc->cred);
+	if (IS_ERR(file))
+		goto err_path;
+	file->f_mode |= FMODE_NEED_UNMOUNT;
+
+	ret = get_unused_fd_flags(flags & FSMOUNT_CLOEXEC);
+	if (ret < 0)
+		goto err_file;
+
+	fd_install(ret, file);
+
+err_file:
+	fput(file);
+err_path:
+	path_put(&newmount);
+err_unlock:
+	inode_unlock(inode);
+err_fsfd:
+	fdput(f);
+	return ret;
+}
+
 /*
  * Return true if path is reachable from root
  *
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 368fe5bb1efd..bec4022e3f4b 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -115,4 +115,6 @@ extern int vfs_get_super(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
 
+extern const struct file_operations fscontext_fs_fops;
+
 #endif /* _LINUX_FS_CONTEXT_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e0f19406af92..178370cad1dd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -898,6 +898,8 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_fsopen(const char *fs_name, unsigned int flags,
 			   void *reserved3, void *reserved4, void *reserved5);
+asmlinkage long sys_fsmount(int fsfd, int dfd, const char *path, unsigned int at_flags,
+			    unsigned int flags);
 
 
 /*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 5da6c2d96af5..edb1983a9990 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -338,4 +338,11 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/*
+ * Flags for fsopen() and co.
+ */
+#define FSOPEN_CLOEXEC		0x00000001
+
+#define FSMOUNT_CLOEXEC		0x00000001
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 6bb0e1bb3eae..632a937ca09c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -435,3 +435,4 @@ COND_SYSCALL(setuid16);
 
 /* fd-based mount */
 COND_SYSCALL(sys_fsopen);
+COND_SYSCALL(sys_fsmount);
