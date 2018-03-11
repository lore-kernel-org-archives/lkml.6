Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeCKLAp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:00:45 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54322 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeCKK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:51 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 28/35] syscalls: do not call sys_symlink{,at}() within the kernel
Date: Sun, 11 Mar 2018 11:55:50 +0100
Message-Id: <20180311105557.20807-29-linux@dominikbrodowski.net>
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
 fs/internal.h            |  2 ++
 fs/namei.c               | 12 +++++++++---
 include/linux/syscalls.h |  8 ++++++++
 init/initramfs.c         |  2 +-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 53846bd4d9d7..a3f04ca2a08b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,6 +58,8 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
+long do_symlinkat(const char __user *oldname, int newdfd,
+		  const char __user *newname);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index dcf506227509..e15da92209d5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4113,8 +4113,8 @@ int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 }
 EXPORT_SYMBOL(vfs_symlink);
 
-SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
-		int, newdfd, const char __user *, newname)
+long do_symlinkat(const char __user *oldname, int newdfd,
+		  const char __user *newname)
 {
 	int error;
 	struct filename *from;
@@ -4144,9 +4144,15 @@ SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
 	return error;
 }
 
+SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
+		int, newdfd, const char __user *, newname)
+{
+	return do_symlinkat(oldname, newdfd, newname);
+}
+
 SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newname)
 {
-	return sys_symlinkat(oldname, AT_FDCWD, newname);
+	return do_symlinkat(oldname, AT_FDCWD, newname);
 }
 
 /**
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e7fb0295dbfc..178d1321a037 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -985,4 +985,12 @@ static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
 	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
+extern long do_symlinkat(const char __user *oldname, int newdfd,
+			 const char __user *newname);
+static inline long ksys_symlink(const char __user *oldname,
+				const char __user *newname)
+{
+	return do_symlinkat(oldname, AT_FDCWD, newname);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index ca538a5f9fa9..cd9571a113b6 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -392,7 +392,7 @@ static int __init do_symlink(void)
 {
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
-	sys_symlink(collected + N_ALIGN(name_len), collected);
+	ksys_symlink(collected + N_ALIGN(name_len), collected);
 	sys_lchown(collected, uid, gid);
 	do_utime(collected, mtime);
 	state = SkipIt;
-- 
2.16.2
