Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeCOTJ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:09:28 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36142 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeCOTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:23 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 24/36] fs: add ksys_unlink() wrapper; remove in-kernel calls to sys_unlink()
Date: Thu, 15 Mar 2018 20:05:17 +0100
Message-Id: <20180315190529.20943-25-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this wrapper allows us to avoid the in-kernel calls to the
sys_unlink() syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 11 +++++++++++
 init/do_mounts.h         |  2 +-
 init/do_mounts_initrd.c  |  4 ++--
 init/do_mounts_rd.c      |  2 +-
 init/initramfs.c         |  4 ++--
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8f0f99702e7a..31aea3873de7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -971,4 +971,15 @@ int ksys_chdir(const char __user *filename);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 
+/*
+ * The following kernel syscall equivalents are just wrappers to fs-internal
+ * functions. Therefore, provide stubs to be inlined at the callsites.
+ */
+extern long do_unlinkat(int dfd, struct filename *name);
+
+static inline long ksys_unlink(const char __user *pathname)
+{
+	return do_unlinkat(AT_FDCWD, getname(pathname));
+}
+
 #endif
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 5b05c8f93f47..401f90ee1eeb 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,7 +16,7 @@ extern int root_mountflags;
 
 static inline int create_dev(char *name, dev_t dev)
 {
-	sys_unlink(name);
+	ksys_unlink(name);
 	return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index c19d9070134e..784576b633fd 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -128,11 +128,11 @@ bool __init initrd_load(void)
 		 * mounted in the normal path.
 		 */
 		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			sys_unlink("/initrd.image");
+			ksys_unlink("/initrd.image");
 			handle_initrd();
 			return true;
 		}
 	}
-	sys_unlink("/initrd.image");
+	ksys_unlink("/initrd.image");
 	return false;
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 2d365c398ccc..5b69056f610a 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -288,7 +288,7 @@ int __init rd_load_image(char *from)
 	sys_close(out_fd);
 out:
 	kfree(buf);
-	sys_unlink("/dev/ram");
+	ksys_unlink("/dev/ram");
 	return res;
 }
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 6f972df15bf2..08eb551168a8 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -319,7 +319,7 @@ static void __init clean_path(char *path, umode_t fmode)
 		if (S_ISDIR(st.mode))
 			sys_rmdir(path);
 		else
-			sys_unlink(path);
+			ksys_unlink(path);
 	}
 }
 
@@ -591,7 +591,7 @@ static void __init clean_rootfs(void)
 				if (S_ISDIR(st.mode))
 					sys_rmdir(dirp->d_name);
 				else
-					sys_unlink(dirp->d_name);
+					ksys_unlink(dirp->d_name);
 			}
 
 			num -= dirp->d_reclen;
-- 
2.16.2
