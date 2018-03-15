Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeCOTGh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:06:37 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36338 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbeCOTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:25 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 34/36] fs: add do_fchownat(), ksys_fchown() helpers and ksys_{,l}chown() wrappers
Date: Thu, 15 Mar 2018 20:05:27 +0100
Message-Id: <20180315190529.20943-35-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the fs-interal do_fchownat() wrapper allows us to get rid of
fs-internal calls to the sys_fchownat() syscall.

Introducing the ksys_fchown() helper and the ksys_{,}chown() wrappers
allows us to avoid the in-kernel calls to the sys_{,l,f}chown() syscalls.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/s390/kernel/compat_linux.c |  6 +++---
 fs/internal.h                   |  2 ++
 fs/open.c                       | 23 +++++++++++++++++------
 include/linux/syscalls.h        | 17 +++++++++++++++++
 init/initramfs.c                |  8 ++++----
 kernel/uid16.c                  |  6 +++---
 6 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 572349852b75..a1fa8051fe63 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -89,18 +89,18 @@
 COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
 		       u16, user, u16, group)
 {
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
+	return ksys_chown(filename, low2highuid(user), low2highgid(group));
 }
 
 COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
 		       filename, u16, user, u16, group)
 {
-	return sys_lchown(filename, low2highuid(user), low2highgid(group));
+	return ksys_lchown(filename, low2highuid(user), low2highgid(group));
 }
 
 COMPAT_SYSCALL_DEFINE3(s390_fchown16, unsigned int, fd, u16, user, u16, group)
 {
-	return sys_fchown(fd, low2highuid(user), low2highgid(group));
+	return ksys_fchown(fd, low2highuid(user), low2highgid(group));
 }
 
 COMPAT_SYSCALL_DEFINE2(s390_setregid16, u16, rgid, u16, egid)
diff --git a/fs/internal.h b/fs/internal.h
index 49e0bf51576c..980d005b21b4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -122,6 +122,8 @@ extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 long do_faccessat(int dfd, const char __user *filename, int mode);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
+		int flag);
 
 extern int open_check_o_direct(struct file *f);
 extern int vfs_open(const struct path *, struct file *, const struct cred *);
diff --git a/fs/open.c b/fs/open.c
index 77a4494f605d..b3f3b2cd9f19 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -645,8 +645,8 @@ static int chown_common(const struct path *path, uid_t user, gid_t group)
 	return error;
 }
 
-SYSCALL_DEFINE5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
-		gid_t, group, int, flag)
+int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
+		int flag)
 {
 	struct path path;
 	int error = -EINVAL;
@@ -677,18 +677,24 @@ SYSCALL_DEFINE5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
 	return error;
 }
 
+SYSCALL_DEFINE5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
+		gid_t, group, int, flag)
+{
+	return do_fchownat(dfd, filename, user, group, flag);
+}
+
 SYSCALL_DEFINE3(chown, const char __user *, filename, uid_t, user, gid_t, group)
 {
-	return sys_fchownat(AT_FDCWD, filename, user, group, 0);
+	return do_fchownat(AT_FDCWD, filename, user, group, 0);
 }
 
 SYSCALL_DEFINE3(lchown, const char __user *, filename, uid_t, user, gid_t, group)
 {
-	return sys_fchownat(AT_FDCWD, filename, user, group,
-			    AT_SYMLINK_NOFOLLOW);
+	return do_fchownat(AT_FDCWD, filename, user, group,
+			   AT_SYMLINK_NOFOLLOW);
 }
 
-SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
+int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
@@ -708,6 +714,11 @@ SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
 	return error;
 }
 
+SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
+{
+	return ksys_fchown(fd, user, group);
+}
+
 int open_check_o_direct(struct file *f)
 {
 	/* NB: we're sure to have correct a_ops only after f_op->open */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1b453770cee8..fe9bac39f3c2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -971,6 +971,7 @@ int ksys_chdir(const char __user *filename);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 int ksys_fchmod(unsigned int fd, umode_t mode);
+int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
@@ -1045,4 +1046,20 @@ static inline long ksys_ftruncate(unsigned int fd, unsigned long length)
 	return do_sys_ftruncate(fd, length, 1);
 }
 
+extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
+		       gid_t group, int flag);
+
+static inline long ksys_chown(const char __user *filename, uid_t user,
+			      gid_t group)
+{
+	return do_fchownat(AT_FDCWD, filename, user, group, 0);
+}
+
+static inline long ksys_lchown(const char __user *filename, uid_t user,
+			       gid_t group)
+{
+	return do_fchownat(AT_FDCWD, filename, user, group,
+			     AT_SYMLINK_NOFOLLOW);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 237a975738ba..0d3b001b0dc5 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -343,7 +343,7 @@ static int __init do_name(void)
 			wfd = sys_open(collected, openflags, mode);
 
 			if (wfd >= 0) {
-				sys_fchown(wfd, uid, gid);
+				ksys_fchown(wfd, uid, gid);
 				ksys_fchmod(wfd, mode);
 				if (body_len)
 					ksys_ftruncate(wfd, body_len);
@@ -353,14 +353,14 @@ static int __init do_name(void)
 		}
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
-		sys_chown(collected, uid, gid);
+		ksys_chown(collected, uid, gid);
 		ksys_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
-			sys_chown(collected, uid, gid);
+			ksys_chown(collected, uid, gid);
 			ksys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
@@ -393,7 +393,7 @@ static int __init do_symlink(void)
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	ksys_symlink(collected + N_ALIGN(name_len), collected);
-	sys_lchown(collected, uid, gid);
+	ksys_lchown(collected, uid, gid);
 	do_utime(collected, mtime);
 	state = SkipIt;
 	next_state = Reset;
diff --git a/kernel/uid16.c b/kernel/uid16.c
index ef1da2a5f9bd..ea3cf87ff000 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -20,17 +20,17 @@
 
 SYSCALL_DEFINE3(chown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
 {
-	return sys_chown(filename, low2highuid(user), low2highgid(group));
+	return ksys_chown(filename, low2highuid(user), low2highgid(group));
 }
 
 SYSCALL_DEFINE3(lchown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
 {
-	return sys_lchown(filename, low2highuid(user), low2highgid(group));
+	return ksys_lchown(filename, low2highuid(user), low2highgid(group));
 }
 
 SYSCALL_DEFINE3(fchown16, unsigned int, fd, old_uid_t, user, old_gid_t, group)
 {
-	return sys_fchown(fd, low2highuid(user), low2highgid(group));
+	return ksys_fchown(fd, low2highuid(user), low2highgid(group));
 }
 
 SYSCALL_DEFINE2(setregid16, old_gid_t, rgid, old_gid_t, egid)
-- 
2.16.2
