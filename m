Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeCOTMY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:12:24 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36142 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeCOTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:21 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 17/36] fs: add ksys_chroot() helper; remove-in kernel calls to sys_chroot()
Date: Thu, 15 Mar 2018 20:05:10 +0100
Message-Id: <20180315190529.20943-18-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the sys_chroot()
syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  | 2 +-
 fs/open.c                | 7 ++++++-
 include/linux/syscalls.h | 1 +
 init/do_mounts.c         | 2 +-
 init/do_mounts_initrd.c  | 4 ++--
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 4afb04686c8e..5743f04014ca 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -387,7 +387,7 @@ static int devtmpfsd(void *p)
 	if (*err)
 		goto out;
 	sys_chdir("/.."); /* will traverse into overmounted root */
-	sys_chroot(".");
+	ksys_chroot(".");
 	complete(&setup_done);
 	while (1) {
 		spin_lock(&req_lock);
diff --git a/fs/open.c b/fs/open.c
index 7ea118471dce..7a475e8a2e41 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -479,7 +479,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	return error;
 }
 
-SYSCALL_DEFINE1(chroot, const char __user *, filename)
+int ksys_chroot(const char __user *filename)
 {
 	struct path path;
 	int error;
@@ -512,6 +512,11 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	return error;
 }
 
+SYSCALL_DEFINE1(chroot, const char __user *, filename)
+{
+	return ksys_chroot(filename);
+}
+
 static int chmod_common(const struct path *path, umode_t mode)
 {
 	struct inode *inode = path->dentry->d_inode;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 73f1889e73a5..13c7bc43b6ef 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -952,5 +952,6 @@ int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 	       unsigned long flags, void __user *data);
 int ksys_umount(char __user *name, int flags);
 int ksys_dup(unsigned int fildes);
+int ksys_chroot(const char __user *filename);
 
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index eb768de43d84..2f06f7827b0c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -600,7 +600,7 @@ void __init prepare_namespace(void)
 out:
 	devtmpfs_mount("dev");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
-	sys_chroot(".");
+	ksys_chroot(".");
 }
 
 static bool is_tmpfs;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index e8573e1776f6..71293265ac4b 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -44,7 +44,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
 	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
-	sys_chroot(".");
+	ksys_chroot(".");
 	sys_setsid();
 	return 0;
 }
@@ -83,7 +83,7 @@ static void __init handle_initrd(void)
 	/* move initrd to rootfs' /old */
 	ksys_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
-	sys_chroot("..");
+	ksys_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
 		sys_chdir("/old");
-- 
2.16.2
