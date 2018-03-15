Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932934AbeCOTJa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:09:30 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36084 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbeCOTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:23 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 31/36] fs: add ksys_fchmod() and do_fchmodat() helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall
Date: Thu, 15 Mar 2018 20:05:24 +0100
Message-Id: <20180315190529.20943-32-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the fs-internal do_fchmodat() helper allows us to get rid of
fs-internal calls to the sys_fchmodat() syscall.

Introducing the ksys_fchmod() helper and the ksys_chmod() wrapper allows
us to avoid the in-kernel calls to the sys_fchmod() and sys_chmod()
syscalls.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            |  2 ++
 fs/open.c                | 17 ++++++++++++++---
 include/linux/syscalls.h |  8 ++++++++
 init/initramfs.c         |  6 +++---
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 91e6fc93fcb5..2474bf460f96 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -119,6 +119,8 @@ extern struct file *do_filp_open(int dfd, struct filename *pathname,
 extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 		const char *, const struct open_flags *);
 
+int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+
 extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *, const struct cred *);
 extern struct file *filp_clone_open(struct file *);
diff --git a/fs/open.c b/fs/open.c
index a19b8277c439..6037f2bf418c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -551,7 +551,7 @@ static int chmod_common(const struct path *path, umode_t mode)
 	return error;
 }
 
-SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
+int ksys_fchmod(unsigned int fd, umode_t mode)
 {
 	struct fd f = fdget(fd);
 	int err = -EBADF;
@@ -564,7 +564,12 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return err;
 }
 
-SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode)
+SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
+{
+	return ksys_fchmod(fd, mode);
+}
+
+int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 {
 	struct path path;
 	int error;
@@ -582,9 +587,15 @@ SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode
 	return error;
 }
 
+SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
+		umode_t, mode)
+{
+	return do_fchmodat(dfd, filename, mode);
+}
+
 SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 {
-	return sys_fchmodat(AT_FDCWD, filename, mode);
+	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
 static int chown_common(const struct path *path, uid_t user, gid_t group)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index eb8745869833..f2b4858464e2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -970,6 +970,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 int ksys_chdir(const char __user *filename);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
+int ksys_fchmod(unsigned int fd, umode_t mode);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
@@ -1023,4 +1024,11 @@ static inline long ksys_link(const char __user *oldname,
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
+extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+
+static inline int ksys_chmod(const char __user *filename, umode_t mode)
+{
+	return do_fchmodat(AT_FDCWD, filename, mode);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 5855ab632b4e..16c3c23076e2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -344,7 +344,7 @@ static int __init do_name(void)
 
 			if (wfd >= 0) {
 				sys_fchown(wfd, uid, gid);
-				sys_fchmod(wfd, mode);
+				ksys_fchmod(wfd, mode);
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
@@ -354,14 +354,14 @@ static int __init do_name(void)
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
 		sys_chown(collected, uid, gid);
-		sys_chmod(collected, mode);
+		ksys_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
-			sys_chmod(collected, mode);
+			ksys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
 	}
-- 
2.16.2
