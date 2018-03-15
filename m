Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeCOTM4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:12:56 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36086 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeCOTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:20 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 26/36] fs: add ksys_rmdir() wrapper; remove in-kernel calls to sys_rmdir()
Date: Thu, 15 Mar 2018 20:05:19 +0100
Message-Id: <20180315190529.20943-27-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this wrapper allows us to avoid the in-kernel calls to the
sys_rmdir() syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/internal.h            | 1 +
 fs/namei.c               | 2 +-
 include/linux/syscalls.h | 7 +++++++
 init/initramfs.c         | 4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index df262f41a0ef..0eda35fa1743 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -55,6 +55,7 @@ extern void __init chrdev_init(void);
 extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
+long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 524e829ffc7d..8545151f74e9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3872,7 +3872,7 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(vfs_rmdir);
 
-static long do_rmdir(int dfd, const char __user *pathname)
+long do_rmdir(int dfd, const char __user *pathname)
 {
 	int error = 0;
 	struct filename *name;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 31aea3873de7..48fa98840b4e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -982,4 +982,11 @@ static inline long ksys_unlink(const char __user *pathname)
 	return do_unlinkat(AT_FDCWD, getname(pathname));
 }
 
+extern long do_rmdir(int dfd, const char __user *pathname);
+
+static inline long ksys_rmdir(const char __user *pathname)
+{
+	return do_rmdir(AT_FDCWD, pathname);
+}
+
 #endif
diff --git a/init/initramfs.c b/init/initramfs.c
index 08eb551168a8..73bbb227f868 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -317,7 +317,7 @@ static void __init clean_path(char *path, umode_t fmode)
 
 	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
-			sys_rmdir(path);
+			ksys_rmdir(path);
 		else
 			ksys_unlink(path);
 	}
@@ -589,7 +589,7 @@ static void __init clean_rootfs(void)
 			WARN_ON_ONCE(ret);
 			if (!ret) {
 				if (S_ISDIR(st.mode))
-					sys_rmdir(dirp->d_name);
+					ksys_rmdir(dirp->d_name);
 				else
 					ksys_unlink(dirp->d_name);
 			}
-- 
2.16.2
