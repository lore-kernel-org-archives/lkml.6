Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B56ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF0208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyUxaw+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDF0208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeGPIiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:38:25 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45592 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeGPIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:38:25 -0400
Received: by mail-lj1-f176.google.com with SMTP id q5-v6so29122273ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pAFCWXF4N35x3BL/W3Hv/kk+YXopwuVf2eL3u2Jx9F0=;
        b=JyUxaw+9D9Pu6DTVPhKfnWjVTlRtjSZeyWN8UtvzNzhdJS2T0zqF94H6NJGEmCfd/g
         CaBsBnCxcp4BdK6W4vn1A3BHT+xzGtVnN06VpdgEYRXo5PB7r/v/RtjyAeINPM0mfYbd
         Uxs0gOJOmp6CovvglVBR0MaqzAj7iDU2wTixZxM+sU8rL/dfuX19CJg/vQrTsFj9hUgp
         Swd+KQyxA6tj6vpuJdyl6098rXSt8C3y6ZH8pdXFsTZuQRwyF+qJz11mDwreJV9jG8KB
         rhujGN4VeHMZ0dc4wX0Pv9ZLQAsoZ6xxE0wnHtVR2jOHCjqiYJK2LjuIJDrnSE6ICkQu
         Benw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pAFCWXF4N35x3BL/W3Hv/kk+YXopwuVf2eL3u2Jx9F0=;
        b=g8IM+WEfNaIV+f1be3xyKBLdCAoPAn+mpzJOeKZB36iCDfl/ezc7RNoHfuo2ebJIcv
         0AZD9/ATMA2nGvkTjit/sc5L5IDYGYJ0KC+hdDbUsXQn3FzggpwtsbpaPXuxr5aPALB/
         99Hr5UhZNVEmwmtIvU8m+6gbjbxCnw8An9bOVM8oiiU1qZ11Did/WuReQvqy1MsM53sH
         T4ZKzEcKIJcOX0dLVcOOYe5GsoqkL1rhZR9eu27IwXbCv4lgWSLZkPA4b8AXymp84Eea
         y4x+okdd4XoaAB7u5xwwqqwbnS312QqIlJieiuKSB8W6ESSQyk1ZCX+buES73WWyzp38
         Guuw==
X-Gm-Message-State: AOUpUlHBlYD5RArACP5uzeg1bsz4opBYnLaANTKboROsIOHsaBTWYTYh
        knQoelH6Vp7YKTx157nFHa7Opw==
X-Google-Smtp-Source: AAOMgpd66ba2XWohvQKz4pm7+XSIWCZyJhOqVDC61Ggc8Y8tS7z5Gs6tYDgxmBKaEdB6vm4XGBpWhw==
X-Received: by 2002:a2e:87da:: with SMTP id v26-v6mr8626061ljj.69.1531728731685;
        Mon, 16 Jul 2018 01:12:11 -0700 (PDT)
Received: from glvvh-laptop.synapse.com ([195.234.74.136])
        by smtp.gmail.com with ESMTPSA id p84-v6sm2974547ljb.19.2018.07.16.01.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 01:12:10 -0700 (PDT)
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH] [RFC] initrd/initramfs: extracted common code to init_rootfs.c file
Date:   Mon, 16 Jul 2018 11:12:03 +0300
Message-Id: <1531728723-11992-1-git-send-email-vvavrychuk@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extracted from initramfs to common place code that sits on top of
iniramfs and initrd and initializes one or another depending on
configuration.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
---
 init/Makefile           |   5 +-
 init/default_rootfs.c   |  52 ++++++++++++++++
 init/do_mounts_initrd.c |   2 -
 init/init_rootfs.c      | 162 ++++++++++++++++++++++++++++++++++++++++++++++++
 init/initramfs.c        | 156 +---------------------------------------------
 init/initramfs.h        |   4 ++
 init/noinitramfs.c      |  52 ----------------
 7 files changed, 222 insertions(+), 211 deletions(-)
 create mode 100644 init/default_rootfs.c
 create mode 100644 init/init_rootfs.c
 create mode 100644 init/initramfs.h
 delete mode 100644 init/noinitramfs.c

diff --git a/init/Makefile b/init/Makefile
index a3e5ce2..d513411 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -7,10 +7,11 @@ ccflags-y := -fno-function-sections -fno-data-sections
 
 obj-y                          := main.o version.o mounts.o
 ifneq ($(CONFIG_BLK_DEV_INITRD),y)
-obj-y                          += noinitramfs.o
+obj-y                          += default_rootfs.o
 else
-obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
+obj-$(CONFIG_BLK_DEV_INITRD)   += init_rootfs.o
 endif
+obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 
 obj-y                          += init_task.o
diff --git a/init/default_rootfs.c b/init/default_rootfs.c
new file mode 100644
index 0000000..f4bad84
--- /dev/null
+++ b/init/default_rootfs.c
@@ -0,0 +1,52 @@
+/*
+ * init/noinitramfs.c
+ *
+ * Copyright (C) 2006, NXP Semiconductors, All Rights Reserved
+ * Author: Jean-Paul Saman <jean-paul.saman@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/kdev_t.h>
+#include <linux/syscalls.h>
+
+/*
+ * Create a simple rootfs that is similar to the default initramfs
+ */
+static int __init default_rootfs(void)
+{
+	int err;
+
+	err = ksys_mkdir((const char __user __force *) "/dev", 0755);
+	if (err < 0)
+		goto out;
+
+	err = ksys_mknod((const char __user __force *) "/dev/console",
+			S_IFCHR | S_IRUSR | S_IWUSR,
+			new_encode_dev(MKDEV(5, 1)));
+	if (err < 0)
+		goto out;
+
+	err = ksys_mkdir((const char __user __force *) "/root", 0700);
+	if (err < 0)
+		goto out;
+
+	return 0;
+
+out:
+	printk(KERN_WARNING "Failed to create a rootfs\n");
+	return err;
+}
+rootfs_initcall(default_rootfs);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 5a91aef..05b958f 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -21,8 +21,6 @@
 
 #include "do_mounts.h"
 
-unsigned long initrd_start, initrd_end;
-int initrd_below_start_ok;
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
diff --git a/init/init_rootfs.c b/init/init_rootfs.c
new file mode 100644
index 0000000..bd70072
--- /dev/null
+++ b/init/init_rootfs.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/file.h>
+#include "initramfs.h"
+
+/* externally loaded initrd or initramfs location */
+unsigned long initrd_start, initrd_end;
+int initrd_below_start_ok;
+
+static int __initdata do_retain_initrd;
+
+static int __init retain_initrd_param(char *str)
+{
+	if (*str)
+		return 0;
+	do_retain_initrd = 1;
+	return 1;
+}
+__setup("retain_initrd", retain_initrd_param);
+
+extern char __initramfs_start[];
+extern unsigned long __initramfs_size;
+#include <linux/initrd.h>
+#include <linux/kexec.h>
+
+static void __init free_initrd(void)
+{
+#ifdef CONFIG_KEXEC_CORE
+	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
+	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
+#endif
+	if (do_retain_initrd)
+		goto skip;
+
+#ifdef CONFIG_KEXEC_CORE
+	/*
+	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * free only memory that is not part of crashkernel region.
+	 */
+	if (initrd_start < crashk_end && initrd_end > crashk_start) {
+		/*
+		 * Initialize initrd memory region since the kexec boot does
+		 * not do.
+		 */
+		memset((void *)initrd_start, 0, initrd_end - initrd_start);
+		if (initrd_start < crashk_start)
+			free_initrd_mem(initrd_start, crashk_start);
+		if (initrd_end > crashk_end)
+			free_initrd_mem(crashk_end, initrd_end);
+	} else
+#endif
+		free_initrd_mem(initrd_start, initrd_end);
+skip:
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
+#ifdef CONFIG_BLK_DEV_RAM
+#define BUF_SIZE 1024
+static void __init clean_rootfs(void)
+{
+	int fd;
+	void *buf;
+	struct linux_dirent64 *dirp;
+	int num;
+
+	fd = ksys_open("/", O_RDONLY, 0);
+	WARN_ON(fd < 0);
+	if (fd < 0)
+		return;
+	buf = kzalloc(BUF_SIZE, GFP_KERNEL);
+	WARN_ON(!buf);
+	if (!buf) {
+		ksys_close(fd);
+		return;
+	}
+
+	dirp = buf;
+	num = ksys_getdents64(fd, dirp, BUF_SIZE);
+	while (num > 0) {
+		while (num > 0) {
+			struct kstat st;
+			int ret;
+
+			ret = vfs_lstat(dirp->d_name, &st);
+			WARN_ON_ONCE(ret);
+			if (!ret) {
+				if (S_ISDIR(st.mode))
+					ksys_rmdir(dirp->d_name);
+				else
+					ksys_unlink(dirp->d_name);
+			}
+
+			num -= dirp->d_reclen;
+			dirp = (void *)dirp + dirp->d_reclen;
+		}
+		dirp = buf;
+		memset(buf, 0, BUF_SIZE);
+		num = ksys_getdents64(fd, dirp, BUF_SIZE);
+	}
+
+	ksys_close(fd);
+	kfree(buf);
+}
+#endif
+
+static int __init populate_rootfs(void)
+{
+	/* Load the built in initramfs */
+	char *err = initramfs_unpack_to_rootfs(__initramfs_start, __initramfs_size);
+	if (err)
+		panic("%s", err); /* Failed to decompress INTERNAL initramfs */
+	/* If available load the bootloader supplied initrd */
+	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
+#ifdef CONFIG_BLK_DEV_RAM
+		int fd;
+		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
+		err = initramfs_unpack_to_rootfs((char *)initrd_start,
+			initrd_end - initrd_start);
+		if (!err) {
+			free_initrd();
+			goto done;
+		} else {
+			clean_rootfs();
+			initramfs_unpack_to_rootfs(__initramfs_start, __initramfs_size);
+		}
+		printk(KERN_INFO "rootfs image is not initramfs (%s)"
+				"; looks like an initrd\n", err);
+		fd = ksys_open("/initrd.image",
+			      O_WRONLY|O_CREAT, 0700);
+		if (fd >= 0) {
+			ssize_t written = xwrite(fd, (char *)initrd_start,
+						initrd_end - initrd_start);
+
+			if (written != initrd_end - initrd_start)
+				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
+				       written, initrd_end - initrd_start);
+
+			ksys_close(fd);
+			free_initrd();
+		}
+	done:
+		/* empty statement */;
+#else
+		printk(KERN_INFO "Unpacking initramfs...\n");
+		err = initramfs_unpack_to_rootfs((char *)initrd_start,
+			initrd_end - initrd_start);
+		if (err)
+			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+		free_initrd();
+#endif
+	}
+	flush_delayed_fput();
+	/*
+	 * Try loading default modules from initramfs.  This gives
+	 * us a chance to load before device_initcalls.
+	 */
+	load_default_modules();
+
+	return 0;
+}
+rootfs_initcall(populate_rootfs);
diff --git a/init/initramfs.c b/init/initramfs.c
index 13643c4..eea6eb1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -448,7 +448,7 @@ static unsigned long my_inptr; /* index of next byte to be processed in inbuf */
 
 #include <linux/decompress/generic.h>
 
-static char * __init unpack_to_rootfs(char *buf, unsigned long len)
+char * __init initramfs_unpack_to_rootfs(char *buf, unsigned long len)
 {
 	long written;
 	decompress_fn decompress;
@@ -509,157 +509,3 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	kfree(header_buf);
 	return message;
 }
-
-static int __initdata do_retain_initrd;
-
-static int __init retain_initrd_param(char *str)
-{
-	if (*str)
-		return 0;
-	do_retain_initrd = 1;
-	return 1;
-}
-__setup("retain_initrd", retain_initrd_param);
-
-extern char __initramfs_start[];
-extern unsigned long __initramfs_size;
-#include <linux/initrd.h>
-#include <linux/kexec.h>
-
-static void __init free_initrd(void)
-{
-#ifdef CONFIG_KEXEC_CORE
-	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
-	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
-#endif
-	if (do_retain_initrd)
-		goto skip;
-
-#ifdef CONFIG_KEXEC_CORE
-	/*
-	 * If the initrd region is overlapped with crashkernel reserved region,
-	 * free only memory that is not part of crashkernel region.
-	 */
-	if (initrd_start < crashk_end && initrd_end > crashk_start) {
-		/*
-		 * Initialize initrd memory region since the kexec boot does
-		 * not do.
-		 */
-		memset((void *)initrd_start, 0, initrd_end - initrd_start);
-		if (initrd_start < crashk_start)
-			free_initrd_mem(initrd_start, crashk_start);
-		if (initrd_end > crashk_end)
-			free_initrd_mem(crashk_end, initrd_end);
-	} else
-#endif
-		free_initrd_mem(initrd_start, initrd_end);
-skip:
-	initrd_start = 0;
-	initrd_end = 0;
-}
-
-#ifdef CONFIG_BLK_DEV_RAM
-#define BUF_SIZE 1024
-static void __init clean_rootfs(void)
-{
-	int fd;
-	void *buf;
-	struct linux_dirent64 *dirp;
-	int num;
-
-	fd = ksys_open("/", O_RDONLY, 0);
-	WARN_ON(fd < 0);
-	if (fd < 0)
-		return;
-	buf = kzalloc(BUF_SIZE, GFP_KERNEL);
-	WARN_ON(!buf);
-	if (!buf) {
-		ksys_close(fd);
-		return;
-	}
-
-	dirp = buf;
-	num = ksys_getdents64(fd, dirp, BUF_SIZE);
-	while (num > 0) {
-		while (num > 0) {
-			struct kstat st;
-			int ret;
-
-			ret = vfs_lstat(dirp->d_name, &st);
-			WARN_ON_ONCE(ret);
-			if (!ret) {
-				if (S_ISDIR(st.mode))
-					ksys_rmdir(dirp->d_name);
-				else
-					ksys_unlink(dirp->d_name);
-			}
-
-			num -= dirp->d_reclen;
-			dirp = (void *)dirp + dirp->d_reclen;
-		}
-		dirp = buf;
-		memset(buf, 0, BUF_SIZE);
-		num = ksys_getdents64(fd, dirp, BUF_SIZE);
-	}
-
-	ksys_close(fd);
-	kfree(buf);
-}
-#endif
-
-static int __init populate_rootfs(void)
-{
-	/* Load the built in initramfs */
-	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
-	if (err)
-		panic("%s", err); /* Failed to decompress INTERNAL initramfs */
-	/* If available load the bootloader supplied initrd */
-	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
-#ifdef CONFIG_BLK_DEV_RAM
-		int fd;
-		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (!err) {
-			free_initrd();
-			goto done;
-		} else {
-			clean_rootfs();
-			unpack_to_rootfs(__initramfs_start, __initramfs_size);
-		}
-		printk(KERN_INFO "rootfs image is not initramfs (%s)"
-				"; looks like an initrd\n", err);
-		fd = ksys_open("/initrd.image",
-			      O_WRONLY|O_CREAT, 0700);
-		if (fd >= 0) {
-			ssize_t written = xwrite(fd, (char *)initrd_start,
-						initrd_end - initrd_start);
-
-			if (written != initrd_end - initrd_start)
-				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-				       written, initrd_end - initrd_start);
-
-			ksys_close(fd);
-			free_initrd();
-		}
-	done:
-		/* empty statement */;
-#else
-		printk(KERN_INFO "Unpacking initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (err)
-			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-		free_initrd();
-#endif
-	}
-	flush_delayed_fput();
-	/*
-	 * Try loading default modules from initramfs.  This gives
-	 * us a chance to load before device_initcalls.
-	 */
-	load_default_modules();
-
-	return 0;
-}
-rootfs_initcall(populate_rootfs);
diff --git a/init/initramfs.h b/init/initramfs.h
new file mode 100644
index 0000000..3ecad6f
--- /dev/null
+++ b/init/initramfs.h
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+
+char * __init initramfs_unpack_to_rootfs(char *buf, unsigned long len);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
deleted file mode 100644
index f4bad84..0000000
--- a/init/noinitramfs.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * init/noinitramfs.c
- *
- * Copyright (C) 2006, NXP Semiconductors, All Rights Reserved
- * Author: Jean-Paul Saman <jean-paul.saman@nxp.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-#include <linux/init.h>
-#include <linux/stat.h>
-#include <linux/kdev_t.h>
-#include <linux/syscalls.h>
-
-/*
- * Create a simple rootfs that is similar to the default initramfs
- */
-static int __init default_rootfs(void)
-{
-	int err;
-
-	err = ksys_mkdir((const char __user __force *) "/dev", 0755);
-	if (err < 0)
-		goto out;
-
-	err = ksys_mknod((const char __user __force *) "/dev/console",
-			S_IFCHR | S_IRUSR | S_IWUSR,
-			new_encode_dev(MKDEV(5, 1)));
-	if (err < 0)
-		goto out;
-
-	err = ksys_mkdir((const char __user __force *) "/root", 0700);
-	if (err < 0)
-		goto out;
-
-	return 0;
-
-out:
-	printk(KERN_WARNING "Failed to create a rootfs\n");
-	return err;
-}
-rootfs_initcall(default_rootfs);
-- 
2.7.4

