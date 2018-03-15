Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932800AbeCOTGj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:06:39 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36244 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932703AbeCOTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:25 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 35/36] fs: add ksys_close() wrapper; remove in-kernel calls to sys_close()
Date: Thu, 15 Mar 2018 20:05:28 +0100
Message-Id: <20180315190529.20943-36-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the ksys_close() wrapper allows us to get rid of in-kernel calls
to the sys_close() syscall.

The few places which checked the return value did not care about the return
value re-writing in sys_close(), so simply use a wrapper around
__close_fd().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/autofs4/dev-ioctl.c   |  2 +-
 fs/binfmt_misc.c         |  2 +-
 fs/file.c                |  1 +
 fs/open.c                |  1 -
 include/linux/syscalls.h | 12 ++++++++++++
 init/do_mounts.c         |  4 ++--
 init/do_mounts_initrd.c  |  2 +-
 init/do_mounts_md.c      |  8 ++++----
 init/do_mounts_rd.c      |  6 +++---
 init/initramfs.c         |  8 ++++----
 10 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index b7c816f39404..26f6b4f41ce6 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -310,7 +310,7 @@ static int autofs_dev_ioctl_closemount(struct file *fp,
 				       struct autofs_sb_info *sbi,
 				       struct autofs_dev_ioctl *param)
 {
-	return sys_close(param->ioctlfd);
+	return ksys_close(param->ioctlfd);
 }
 
 /*
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a7c5a9861bef..a41b48f82a70 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -241,7 +241,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	return retval;
 error:
 	if (fd_binary > 0)
-		sys_close(fd_binary);
+		ksys_close(fd_binary);
 	bprm->interp_flags = 0;
 	bprm->interp_data = 0;
 	goto ret;
diff --git a/fs/file.c b/fs/file.c
index d304004f0b65..7ffd6e9d103d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -638,6 +638,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 	spin_unlock(&files->file_lock);
 	return -EBADF;
 }
+EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
 void do_close_on_exec(struct files_struct *files)
 {
diff --git a/fs/open.c b/fs/open.c
index b3f3b2cd9f19..710102fc262b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1200,7 +1200,6 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 
 	return retval;
 }
-EXPORT_SYMBOL(sys_close);
 
 /*
  * This routine simulates a hangup on the tty, to arrange that users
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fe9bac39f3c2..4ff0b01ab277 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1062,4 +1062,16 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 			     AT_SYMLINK_NOFOLLOW);
 }
 
+extern int __close_fd(struct files_struct *files, unsigned int fd);
+
+/*
+ * In contrast to sys_close(), this stub does not check whether the syscall
+ * should or should not be restarted, but returns the raw error codes from
+ * __close_fd().
+ */
+static inline int ksys_close(unsigned int fd)
+{
+	return __close_fd(current->files, fd);
+}
+
 #endif
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 89f18985fa90..a28dd42d1f84 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -492,7 +492,7 @@ void __init change_floppy(char *fmt, ...)
 	fd = sys_open("/dev/root", O_RDWR | O_NDELAY, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, FDEJECT, 0);
-		sys_close(fd);
+		ksys_close(fd);
 	}
 	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
 	fd = sys_open("/dev/console", O_RDWR, 0);
@@ -503,7 +503,7 @@ void __init change_floppy(char *fmt, ...)
 		sys_read(fd, &c, 1);
 		termios.c_lflag |= ICANON;
 		sys_ioctl(fd, TCSETSF, (long)&termios);
-		sys_close(fd);
+		ksys_close(fd);
 	}
 }
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d30db6bbf014..50decd9999b7 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -111,7 +111,7 @@ static void __init handle_initrd(void)
 			error = fd;
 		} else {
 			error = sys_ioctl(fd, BLKFLSBUF, 0);
-			sys_close(fd);
+			ksys_close(fd);
 		}
 		printk(!error ? "okay\n" : "failed\n");
 	}
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index 3f733c760a8c..ebd4013d589e 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -191,7 +191,7 @@ static void __init md_setup_drive(void)
 			printk(KERN_WARNING
 			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
 			       minor);
-			sys_close(fd);
+			ksys_close(fd);
 			continue;
 		}
 
@@ -243,11 +243,11 @@ static void __init md_setup_drive(void)
 			 * boot a kernel with devfs compiled in from partitioned md
 			 * array without it
 			 */
-			sys_close(fd);
+			ksys_close(fd);
 			fd = sys_open(name, 0, 0);
 			sys_ioctl(fd, BLKRRPART, 0);
 		}
-		sys_close(fd);
+		ksys_close(fd);
 	}
 }
 
@@ -297,7 +297,7 @@ static void __init autodetect_raid(void)
 	fd = sys_open("/dev/md0", 0, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, RAID_AUTORUN, raid_autopart);
-		sys_close(fd);
+		ksys_close(fd);
 	}
 }
 
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 5b69056f610a..f1aa341862d3 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -257,7 +257,7 @@ int __init rd_load_image(char *from)
 		if (i && (i % devblocks == 0)) {
 			printk("done disk #%d.\n", disk++);
 			rotate = 0;
-			if (sys_close(in_fd)) {
+			if (ksys_close(in_fd)) {
 				printk("Error closing the disk.\n");
 				goto noclose_input;
 			}
@@ -283,9 +283,9 @@ int __init rd_load_image(char *from)
 successful_load:
 	res = 1;
 done:
-	sys_close(in_fd);
+	ksys_close(in_fd);
 noclose_input:
-	sys_close(out_fd);
+	ksys_close(out_fd);
 out:
 	kfree(buf);
 	ksys_unlink("/dev/ram");
diff --git a/init/initramfs.c b/init/initramfs.c
index 0d3b001b0dc5..ce2bcad97cdf 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -373,7 +373,7 @@ static int __init do_copy(void)
 	if (byte_count >= body_len) {
 		if (xwrite(wfd, victim, body_len) != body_len)
 			error("write error");
-		sys_close(wfd);
+		ksys_close(wfd);
 		do_utime(vcollected, mtime);
 		kfree(vcollected);
 		eat(body_len);
@@ -574,7 +574,7 @@ static void __init clean_rootfs(void)
 	buf = kzalloc(BUF_SIZE, GFP_KERNEL);
 	WARN_ON(!buf);
 	if (!buf) {
-		sys_close(fd);
+		ksys_close(fd);
 		return;
 	}
 
@@ -602,7 +602,7 @@ static void __init clean_rootfs(void)
 		num = sys_getdents64(fd, dirp, BUF_SIZE);
 	}
 
-	sys_close(fd);
+	ksys_close(fd);
 	kfree(buf);
 }
 #endif
@@ -639,7 +639,7 @@ static int __init populate_rootfs(void)
 				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
 				       written, initrd_end - initrd_start);
 
-			sys_close(fd);
+			ksys_close(fd);
 			free_initrd();
 		}
 	done:
-- 
2.16.2
