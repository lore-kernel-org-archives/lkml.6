Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeCOTJd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:09:33 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36258 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbeCOTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:23 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 29/36] fs: add do_mknodat() helper and ksys_mknod() wrapper; remove in-kernel calls to syscall
Date: Thu, 15 Mar 2018 20:05:22 +0100
Message-Id: <20180315190529.20943-30-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the fs-internal do_mknodat() helper allows us to get rid of
fs-internal calls to the sys_mknodat() syscall.

Introducing the ksys_mknod() wrapper allows us to avoid the in-kernel
calls to sys_mknod() syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            |  2 ++
 fs/namei.c               | 12 +++++++++---
 include/linux/syscalls.h |  9 +++++++++
 init/do_mounts.h         |  2 +-
 init/initramfs.c         |  2 +-
 init/noinitramfs.c       |  2 +-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index a3f04ca2a08b..4f0b67054c54 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,6 +55,8 @@ extern void __init chrdev_init(void);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
+long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+		unsigned int dev);
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
diff --git a/fs/namei.c b/fs/namei.c
index e15da92209d5..8459a18cdd18 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3728,8 +3728,8 @@ static int may_mknod(umode_t mode)
 	}
 }
 
-SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
-		unsigned, dev)
+long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+		unsigned int dev)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -3772,9 +3772,15 @@ SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
 	return error;
 }
 
+SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
+		unsigned int, dev)
+{
+	return do_mknodat(dfd, filename, mode, dev);
+}
+
 SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
 {
-	return sys_mknodat(AT_FDCWD, filename, mode, dev);
+	return do_mknodat(AT_FDCWD, filename, mode, dev);
 }
 
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 882c7fad2b68..a003ffedff52 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,4 +1005,13 @@ static inline long ksys_symlink(const char __user *oldname,
 	return do_symlinkat(oldname, AT_FDCWD, newname);
 }
 
+extern long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+		       unsigned int dev);
+
+static inline long ksys_mknod(const char __user *filename, umode_t mode,
+			      unsigned int dev)
+{
+	return do_mknodat(AT_FDCWD, filename, mode, dev);
+}
+
 #endif
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 401f90ee1eeb..0bb0806de4ce 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -17,7 +17,7 @@ extern int root_mountflags;
 static inline int create_dev(char *name, dev_t dev)
 {
 	ksys_unlink(name);
-	return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
+	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
 static inline u32 bstat(char *name)
diff --git a/init/initramfs.c b/init/initramfs.c
index cd9571a113b6..2972ed0ab399 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -359,7 +359,7 @@ static int __init do_name(void)
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-			sys_mknod(collected, mode, rdev);
+			ksys_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
 			sys_chmod(collected, mode);
 			do_utime(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index a08a9d937e60..f4bad8436c93 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -33,7 +33,7 @@ static int __init default_rootfs(void)
 	if (err < 0)
 		goto out;
 
-	err = sys_mknod((const char __user __force *) "/dev/console",
+	err = ksys_mknod((const char __user __force *) "/dev/console",
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			new_encode_dev(MKDEV(5, 1)));
 	if (err < 0)
-- 
2.16.2
