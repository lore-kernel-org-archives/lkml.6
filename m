Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeCKLAk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:00:40 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54446 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeCKK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:51 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 32/35] syscalls: do not call sys_{f,}access{,at}() within the kernel
Date: Sun, 11 Mar 2018 11:55:54 +0100
Message-Id: <20180311105557.20807-33-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            | 1 +
 fs/open.c                | 9 +++++++--
 include/linux/syscalls.h | 6 ++++++
 init/main.c              | 3 ++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 2474bf460f96..26f4f05b52ef 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -119,6 +119,7 @@ extern struct file *do_filp_open(int dfd, struct filename *pathname,
 extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 		const char *, const struct open_flags *);
 
+long do_faccessat(int dfd, const char __user *filename, int mode);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 
 extern int open_check_o_direct(struct file *f);
diff --git a/fs/open.c b/fs/open.c
index 6037f2bf418c..0fc8188be31a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -350,7 +350,7 @@ SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
  */
-SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
+long do_faccessat(int dfd, const char __user *filename, int mode)
 {
 	const struct cred *old_cred;
 	struct cred *override_cred;
@@ -426,9 +426,14 @@ SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 	return res;
 }
 
+SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
+{
+	return do_faccessat(dfd, filename, mode);
+}
+
 SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 {
-	return sys_faccessat(AT_FDCWD, filename, mode);
+	return do_faccessat(AT_FDCWD, filename, mode);
 }
 
 int ksys_chdir(const char __user *filename)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 87feef73c077..ac4ba9439e52 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1016,4 +1016,10 @@ static inline int ksys_chmod(const char __user *filename, umode_t mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
+extern long do_faccessat(int dfd, const char __user *filename, int mode);
+static inline long ksys_access(const char __user *filename, int mode)
+{
+	return do_faccessat(AT_FDCWD, filename, mode);
+}
+
 #endif
diff --git a/init/main.c b/init/main.c
index b8649d1466e1..d0ded4322c6b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1087,7 +1087,8 @@ static noinline void __init kernel_init_freeable(void)
 	if (!ramdisk_execute_command)
 		ramdisk_execute_command = "/init";
 
-	if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
+	if (ksys_access((const char __user *)
+			ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.16.2
