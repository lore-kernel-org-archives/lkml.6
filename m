Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeCOTH5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:07:57 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36186 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 14/36] fs: add ksys_mount() helper; remove in-kernel calls to sys_mount()
Date: Thu, 15 Mar 2018 20:05:07 +0100
Message-Id: <20180315190529.20943-15-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the sys_mount()
syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  |  5 +++--
 fs/namespace.c           | 10 ++++++++--
 include/linux/syscalls.h |  3 +++
 init/do_mounts.c         |  4 ++--
 init/do_mounts_initrd.c  |  6 +++---
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 50025d7959cb..4afb04686c8e 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -356,7 +356,8 @@ int devtmpfs_mount(const char *mntdir)
 	if (!thread)
 		return 0;
 
-	err = sys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT, NULL);
+	err = ksys_mount("devtmpfs", (char *)mntdir, "devtmpfs", MS_SILENT,
+			 NULL);
 	if (err)
 		printk(KERN_INFO "devtmpfs: error mounting %i\n", err);
 	else
@@ -382,7 +383,7 @@ static int devtmpfsd(void *p)
 	*err = sys_unshare(CLONE_NEWNS);
 	if (*err)
 		goto out;
-	*err = sys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
+	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
 	if (*err)
 		goto out;
 	sys_chdir("/.."); /* will traverse into overmounted root */
diff --git a/fs/namespace.c b/fs/namespace.c
index 9d1374ab6e06..642b8b229944 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3032,8 +3032,8 @@ struct dentry *mount_subtree(struct vfsmount *mnt, const char *name)
 }
 EXPORT_SYMBOL(mount_subtree);
 
-SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
-		char __user *, type, unsigned long, flags, void __user *, data)
+int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
+	       unsigned long flags, void __user *data)
 {
 	int ret;
 	char *kernel_type;
@@ -3066,6 +3066,12 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ret;
 }
 
+SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
+		char __user *, type, unsigned long, flags, void __user *, data)
+{
+	return ksys_mount(dev_name, dir_name, type, flags, data);
+}
+
 /*
  * Return true if path is reachable from root
  *
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a63e21e7a3af..69899ffa03e9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -948,4 +948,7 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
  * the ksys_xyzyyz() functions prototyped below.
  */
 
+int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
+	       unsigned long flags, void __user *data);
+
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6dafd5f..eb768de43d84 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -363,7 +363,7 @@ static void __init get_fs_names(char *page)
 static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 {
 	struct super_block *s;
-	int err = sys_mount(name, "/root", fs, flags, data);
+	int err = ksys_mount(name, "/root", fs, flags, data);
 	if (err)
 		return err;
 
@@ -599,7 +599,7 @@ void __init prepare_namespace(void)
 	mount_root();
 out:
 	devtmpfs_mount("dev");
-	sys_mount(".", "/", NULL, MS_MOVE, NULL);
+	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 53d4f0f326e7..7868a6039fb4 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -43,7 +43,7 @@ static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 	sys_dup(0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
-	sys_mount(".", "/", NULL, MS_MOVE, NULL);
+	ksys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
 	sys_setsid();
 	return 0;
@@ -81,7 +81,7 @@ static void __init handle_initrd(void)
 	current->flags &= ~PF_FREEZER_SKIP;
 
 	/* move initrd to rootfs' /old */
-	sys_mount("..", ".", NULL, MS_MOVE, NULL);
+	ksys_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
 	sys_chroot("..");
 
@@ -95,7 +95,7 @@ static void __init handle_initrd(void)
 	mount_root();
 
 	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = sys_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
+	error = ksys_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
 	if (!error)
 		printk("okay\n");
 	else {
-- 
2.16.2
