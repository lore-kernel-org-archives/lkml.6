Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeCOTIA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:08:00 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36184 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 15/36] fs: add ksys_umount() helper; remove in-kernel call to sys_umount()
Date: Thu, 15 Mar 2018 20:05:08 +0100
Message-Id: <20180315190529.20943-16-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the sys_umount()
syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/namespace.c           | 9 +++++++--
 include/linux/syscalls.h | 1 +
 init/do_mounts_initrd.c  | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 642b8b229944..e398f32d7541 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1680,7 +1680,7 @@ static inline bool may_mandlock(void)
  * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
  */
 
-SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
+int ksys_umount(char __user *name, int flags)
 {
 	struct path path;
 	struct mount *mnt;
@@ -1720,6 +1720,11 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
 	return retval;
 }
 
+SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
+{
+	return ksys_umount(name, flags);
+}
+
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
@@ -1727,7 +1732,7 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
  */
 SYSCALL_DEFINE1(oldumount, char __user *, name)
 {
-	return sys_umount(name, 0);
+	return ksys_umount(name, 0);
 }
 
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 69899ffa03e9..929dfc6c2906 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -950,5 +950,6 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 
 int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 	       unsigned long flags, void __user *data);
+int ksys_umount(char __user *name, int flags);
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 7868a6039fb4..1c4da8353332 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -105,7 +105,7 @@ static void __init handle_initrd(void)
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
-		sys_umount("/old", MNT_DETACH);
+		ksys_umount("/old", MNT_DETACH);
 		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");
 		if (fd < 0) {
 			error = fd;
-- 
2.16.2
