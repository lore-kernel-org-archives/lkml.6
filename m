Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeCOTPH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:15:07 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35786 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeCOTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:19 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 22/36] fs: add ksys_chdir() helper; remove in-kernel calls to sys_chdir()
Date: Thu, 15 Mar 2018 20:05:15 +0100
Message-Id: <20180315190529.20943-23-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the sys_chdir()
syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  | 2 +-
 fs/open.c                | 7 ++++++-
 include/linux/syscalls.h | 1 +
 init/do_mounts.c         | 2 +-
 init/do_mounts_initrd.c  | 8 ++++----
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index d6f37537275c..f7768077e817 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -386,7 +386,7 @@ static int devtmpfsd(void *p)
 	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
 	if (*err)
 		goto out;
-	sys_chdir("/.."); /* will traverse into overmounted root */
+	ksys_chdir("/.."); /* will traverse into overmounted root */
 	ksys_chroot(".");
 	complete(&setup_done);
 	while (1) {
diff --git a/fs/open.c b/fs/open.c
index 7a475e8a2e41..a19b8277c439 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -431,7 +431,7 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 	return sys_faccessat(AT_FDCWD, filename, mode);
 }
 
-SYSCALL_DEFINE1(chdir, const char __user *, filename)
+int ksys_chdir(const char __user *filename)
 {
 	struct path path;
 	int error;
@@ -457,6 +457,11 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	return error;
 }
 
+SYSCALL_DEFINE1(chdir, const char __user *, filename)
+{
+	return ksys_chdir(filename);
+}
+
 SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
 	struct fd f = fdget_raw(fd);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 37b311393bdc..923a4d056137 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -967,5 +967,6 @@ static inline int ksys_fadvise64_64(int fd, loff_t offset, loff_t len,
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			      unsigned long prot, unsigned long flags,
 			      unsigned long fd, unsigned long pgoff);
+int ksys_chdir(const char __user *filename);
 
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2f06f7827b0c..89f18985fa90 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -367,7 +367,7 @@ static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 	if (err)
 		return err;
 
-	sys_chdir("/root");
+	ksys_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
 	ROOT_DEV = s->s_dev;
 	printk(KERN_INFO
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 414284dadc64..c19d9070134e 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -42,7 +42,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	ksys_dup(0);
 	ksys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
-	sys_chdir("/root");
+	ksys_chdir("/root");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	sys_setsid();
@@ -61,7 +61,7 @@ static void __init handle_initrd(void)
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	sys_mkdir("/old", 0700);
-	sys_chdir("/old");
+	ksys_chdir("/old");
 
 	/* try loading default modules from initrd */
 	load_default_modules();
@@ -86,11 +86,11 @@ static void __init handle_initrd(void)
 	ksys_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
-		sys_chdir("/old");
+		ksys_chdir("/old");
 		return;
 	}
 
-	sys_chdir("/");
+	ksys_chdir("/");
 	ROOT_DEV = new_decode_dev(real_root_dev);
 	mount_root();
 
-- 
2.16.2
