Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbeCOTHQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:07:16 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36226 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932689AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 16/36] fs: add ksys_dup{,3}() helper; remove in-kernel calls to sys_dup{,3}()
Date: Thu, 15 Mar 2018 20:05:09 +0100
Message-Id: <20180315190529.20943-17-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using ksys_dup() and ksys_dup3() as helper functions allows us to
avoid the in-kernel calls to the sys_dup() and sys_dup3() syscalls.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/file.c                | 16 +++++++++++++---
 include/linux/syscalls.h |  1 +
 init/do_mounts_initrd.c  |  4 ++--
 init/main.c              |  4 ++--
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 42f0db4bd0fb..d304004f0b65 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -870,7 +870,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	return err;
 }
 
-SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
+static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
 	struct file *file;
@@ -904,6 +904,11 @@ SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
 	return err;
 }
 
+SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
+{
+	return ksys_dup3(oldfd, newfd, flags);
+}
+
 SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 {
 	if (unlikely(newfd == oldfd)) { /* corner case */
@@ -916,10 +921,10 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 		rcu_read_unlock();
 		return retval;
 	}
-	return sys_dup3(oldfd, newfd, 0);
+	return ksys_dup3(oldfd, newfd, 0);
 }
 
-SYSCALL_DEFINE1(dup, unsigned int, fildes)
+int ksys_dup(unsigned int fildes)
 {
 	int ret = -EBADF;
 	struct file *file = fget_raw(fildes);
@@ -934,6 +939,11 @@ SYSCALL_DEFINE1(dup, unsigned int, fildes)
 	return ret;
 }
 
+SYSCALL_DEFINE1(dup, unsigned int, fildes)
+{
+	return ksys_dup(fildes);
+}
+
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
 	int err;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 929dfc6c2906..73f1889e73a5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -951,5 +951,6 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 	       unsigned long flags, void __user *data);
 int ksys_umount(char __user *name, int flags);
+int ksys_dup(unsigned int fildes);
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 1c4da8353332..e8573e1776f6 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -39,8 +39,8 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	sys_unshare(CLONE_FS | CLONE_FILES);
 	/* stdin/stdout/stderr for /linuxrc */
 	sys_open("/dev/console", O_RDWR, 0);
-	sys_dup(0);
-	sys_dup(0);
+	ksys_dup(0);
+	ksys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..b8649d1466e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1077,8 +1077,8 @@ static noinline void __init kernel_init_freeable(void)
 	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
 
-	(void) sys_dup(0);
-	(void) sys_dup(0);
+	(void) ksys_dup(0);
+	(void) ksys_dup(0);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
-- 
2.16.2
