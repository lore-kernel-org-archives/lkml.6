Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeCOTNB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:13:01 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36076 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbeCOTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:20 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 27/36] fs: add do_mkdirat() helper and ksys_mkdir() wrapper; remove in-kernel calls to syscall
Date: Thu, 15 Mar 2018 20:05:20 +0100
Message-Id: <20180315190529.20943-28-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the fs-internal do_mkdirat() helper allows us to get rid of
fs-internal calls to the sys_mkdirat() syscall.

Introducing the ksys_mkdir() wrapper allows us to avoid the in-kernel
calls to the sys_mkdir() syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            | 1 +
 fs/namei.c               | 9 +++++++--
 include/linux/syscalls.h | 7 +++++++
 init/do_mounts_initrd.c  | 2 +-
 init/initramfs.c         | 2 +-
 init/noinitramfs.c       | 4 ++--
 6 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 0eda35fa1743..53846bd4d9d7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,6 +55,7 @@ extern void __init chrdev_init(void);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
+long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
 
diff --git a/fs/namei.c b/fs/namei.c
index 8545151f74e9..dcf506227509 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3803,7 +3803,7 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
+long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -3828,9 +3828,14 @@ SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
 	return error;
 }
 
+SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
+{
+	return do_mkdirat(dfd, pathname, mode);
+}
+
 SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 {
-	return sys_mkdirat(AT_FDCWD, pathname, mode);
+	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 48fa98840b4e..2abd968bbdfd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -989,4 +989,11 @@ static inline long ksys_rmdir(const char __user *pathname)
 	return do_rmdir(AT_FDCWD, pathname);
 }
 
+extern long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
+
+static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
+{
+	return do_mkdirat(AT_FDCWD, pathname, mode);
+}
+
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 784576b633fd..d30db6bbf014 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -60,7 +60,7 @@ static void __init handle_initrd(void)
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
-	sys_mkdir("/old", 0700);
+	ksys_mkdir("/old", 0700);
 	ksys_chdir("/old");
 
 	/* try loading default modules from initrd */
diff --git a/init/initramfs.c b/init/initramfs.c
index 73bbb227f868..ca538a5f9fa9 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -352,7 +352,7 @@ static int __init do_name(void)
 			}
 		}
 	} else if (S_ISDIR(mode)) {
-		sys_mkdir(collected, mode);
+		ksys_mkdir(collected, mode);
 		sys_chown(collected, uid, gid);
 		sys_chmod(collected, mode);
 		dir_add(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index 267739d85179..a08a9d937e60 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -29,7 +29,7 @@ static int __init default_rootfs(void)
 {
 	int err;
 
-	err = sys_mkdir((const char __user __force *) "/dev", 0755);
+	err = ksys_mkdir((const char __user __force *) "/dev", 0755);
 	if (err < 0)
 		goto out;
 
@@ -39,7 +39,7 @@ static int __init default_rootfs(void)
 	if (err < 0)
 		goto out;
 
-	err = sys_mkdir((const char __user __force *) "/root", 0700);
+	err = ksys_mkdir((const char __user __force *) "/root", 0700);
 	if (err < 0)
 		goto out;
 
-- 
2.16.2
