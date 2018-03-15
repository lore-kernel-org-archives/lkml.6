Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeCOTHS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:07:18 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36332 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932693AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 19/36] kernel: add ksys_unshare() helper; remove in-kernel calls to sys_unshare()
Date: Thu, 15 Mar 2018 20:05:12 +0100
Message-Id: <20180315190529.20943-20-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_unshare() syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/base/devtmpfs.c  | 2 +-
 include/linux/syscalls.h | 1 +
 init/do_mounts_initrd.c  | 2 +-
 kernel/fork.c            | 7 ++++++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 5743f04014ca..d6f37537275c 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -380,7 +380,7 @@ static int devtmpfsd(void *p)
 {
 	char options[] = "mode=0755";
 	int *err = p;
-	*err = sys_unshare(CLONE_NEWNS);
+	*err = ksys_unshare(CLONE_NEWNS);
 	if (*err)
 		goto out;
 	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6aa44b6a0a2..2c0fabc7d19d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -954,5 +954,6 @@ int ksys_umount(char __user *name, int flags);
 int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
+int ksys_unshare(unsigned long unshare_flags);
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 71293265ac4b..414284dadc64 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -36,7 +36,7 @@ __setup("noinitrd", no_initrd);
 
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
-	sys_unshare(CLONE_FS | CLONE_FILES);
+	ksys_unshare(CLONE_FS | CLONE_FILES);
 	/* stdin/stdout/stderr for /linuxrc */
 	sys_open("/dev/console", O_RDWR, 0);
 	ksys_dup(0);
diff --git a/kernel/fork.c b/kernel/fork.c
index b1e031aac9db..f71b67dc156d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2354,7 +2354,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
  * constructed. Here we are modifying the current, active,
  * task_struct.
  */
-SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
+int ksys_unshare(unsigned long unshare_flags)
 {
 	struct fs_struct *fs, *new_fs = NULL;
 	struct files_struct *fd, *new_fd = NULL;
@@ -2470,6 +2470,11 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
 	return err;
 }
 
+SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
+{
+	return ksys_unshare(unshare_flags);
+}
+
 /*
  *	Helper to unshare the files of the current task.
  *	We don't want to expose copy_files internals to
-- 
2.16.2
