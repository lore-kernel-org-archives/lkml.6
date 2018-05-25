Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971857AbeEYAH4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:07:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161655AbeEYAHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:07:48 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/32] vfs: Provide an fspick() system call [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:07:46 +0100
Message-ID: <152720686681.9073.2993011607682983090.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an fspick() system call that can be used to pick an existing
mountpoint into an fs_context which can thereafter be used to reconfigure a
superblock (equivalent of the superblock side of -o remount).

This looks like:

	int fd = fspick(AT_FDCWD, "/mnt",
			FSPICK_CLOEXEC | FSPICK_NO_AUTOMOUNT);
	write(fd, "o intr");
	write(fd, "o noac");
	write(fd, "x reconfigure");

At the point of fspick being called, the file descriptor referring to the
filesystem context is in exactly the same state as the one that was created
by fsopen() after fsmount() has been successfully called.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/fsopen.c                            |   94 +++++++++++++++++++++++++-------
 include/linux/syscalls.h               |    1 
 include/uapi/linux/fs.h                |    5 ++
 kernel/sys_ni.c                        |    1 
 6 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index bdcb0c4a0491..b7e2adda092c 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -399,3 +399,4 @@
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
 387	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
+388	i386	fspick			sys_fspick			__ia32_sys_fspick
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7d932d3897fa..fd322986974b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -344,6 +344,7 @@
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	fsopen			__x64_sys_fsopen
 335	common	fsmount			__x64_sys_fsmount
+336	common	fspick			__x64_sys_fspick
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 26565ddd7c9e..d69155b9303e 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -17,6 +17,7 @@
 #include <linux/magic.h>
 #include <linux/syscalls.h>
 #include <linux/security.h>
+#include <linux/namei.h>
 #include "mount.h"
 
 static struct vfsmount *fscontext_fs_mnt __read_mostly;
@@ -286,6 +287,36 @@ static int __init init_fscontext_fs(void)
 
 fs_initcall(init_fscontext_fs);
 
+/*
+ * Attach a filesystem context to a file and an fd.
+ */
+static int fsopen_create_fd(struct fs_context *fc, bool cloexec)
+{
+	struct file *file;
+	int ret;
+
+	file = create_fscontext_file(fc);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto err_fc;
+	}
+
+	ret = get_unused_fd_flags(cloexec);
+	if (ret < 0)
+		goto err_file;
+
+	fd_install(ret, file);
+	return ret;
+
+err_fc:
+	put_fs_context(fc);
+	goto err;
+err_file:
+	fput(file);
+err:
+	return ret;
+}
+
 /*
  * Open a filesystem by name so that it can be configured for mounting.
  *
@@ -298,9 +329,7 @@ SYSCALL_DEFINE5(fsopen, const char __user *, _fs_name, unsigned int, flags,
 {
 	struct file_system_type *fs_type;
 	struct fs_context *fc;
-	struct file *file;
 	const char *fs_name;
-	int fd, ret;
 
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -324,29 +353,54 @@ SYSCALL_DEFINE5(fsopen, const char __user *, _fs_name, unsigned int, flags,
 
 	fc->phase = FS_CONTEXT_CREATE_PARAMS;
 
-	ret = -EOPNOTSUPP;
-	if (!fc->ops)
-		goto err_fc;
+	return fsopen_create_fd(fc, flags & FSOPEN_CLOEXEC);
+}
 
-	file = create_fscontext_file(fc);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto err_fc;
-	}
+/*
+ * Pick a superblock into a context for reconfiguration.
+ */
+SYSCALL_DEFINE3(fspick, int, dfd, const char *, path, unsigned int, flags)
+{
+	struct fs_context *fc;
+	struct path target;
+	unsigned int lookup_flags;
+	int ret;
+
+	if ((flags & ~(FSPICK_CLOEXEC |
+		       FSPICK_SYMLINK_NOFOLLOW |
+		       FSPICK_NO_AUTOMOUNT |
+		       FSPICK_EMPTY_PATH)) != 0)
+		return -EINVAL;
 
-	ret = get_unused_fd_flags(flags & O_CLOEXEC);
+	lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	if (flags & FSPICK_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & FSPICK_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & FSPICK_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+	ret = user_path_at(dfd, path, lookup_flags, &target);
 	if (ret < 0)
-		goto err_file;
+		goto err;
+
+	ret = -EOPNOTSUPP;
+	if (!target.dentry->d_sb->s_op->reconfigure)
+		goto err;
+
+	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
+				0, FS_CONTEXT_FOR_RECONFIGURE);
+	if (IS_ERR(fc)) {
+		ret = PTR_ERR(fc);
+		goto err_path;
+	}
 
-	fd = ret;
-	fd_install(fd, file);
-	return fd;
+	fc->phase = FS_CONTEXT_RECONF_PARAMS;
 
-err_file:
-	fput(file);
-	return ret;
+	path_put(&target);
+	return fsopen_create_fd(fc, flags & FSPICK_CLOEXEC);
 
-err_fc:
-	put_fs_context(fc);
+err_path:
+	path_put(&target);
+err:
 	return ret;
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 178370cad1dd..5130fd687a85 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -900,6 +900,7 @@ asmlinkage long sys_fsopen(const char *fs_name, unsigned int flags,
 			   void *reserved3, void *reserved4, void *reserved5);
 asmlinkage long sys_fsmount(int fsfd, int dfd, const char *path, unsigned int at_flags,
 			    unsigned int flags);
+asmlinkage long sys_fspick(int dfd, const char *path, unsigned int at_flags);
 
 
 /*
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index edb1983a9990..f3875a84349d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -345,4 +345,9 @@ typedef int __bitwise __kernel_rwf_t;
 
 #define FSMOUNT_CLOEXEC		0x00000001
 
+#define FSPICK_CLOEXEC		0x00000001
+#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
+#define FSPICK_NO_AUTOMOUNT	0x00000004
+#define FSPICK_EMPTY_PATH	0x00000008
+
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 632a937ca09c..152fdc95d426 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -436,3 +436,4 @@ COND_SYSCALL(setuid16);
 /* fd-based mount */
 COND_SYSCALL(sys_fsopen);
 COND_SYSCALL(sys_fsmount);
+COND_SYSCALL(sys_fspick);
