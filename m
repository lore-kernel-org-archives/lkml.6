Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72737ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4B921567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4B921567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbeIUWY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390357AbeIUWY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:24:28 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABF3C310E981;
        Fri, 21 Sep 2018 16:34:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25B6130912F4;
        Fri, 21 Sep 2018 16:34:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 34/34] vfs: Add a sample program for the new mount API [ver
 #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:34:46 +0100
Message-ID: <153754768644.17872.4707695831889551662.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 21 Sep 2018 16:34:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sample program to demonstrate fsopen/fsmount/move_mount to mount
something.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/Kconfig            |   10 +-
 samples/Makefile           |    2 
 samples/statx/Makefile     |    7 -
 samples/statx/test-statx.c |  258 --------------------------------------------
 samples/vfs/Makefile       |   10 ++
 samples/vfs/test-fsmount.c |  118 ++++++++++++++++++++
 samples/vfs/test-statx.c   |  258 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 393 insertions(+), 270 deletions(-)
 delete mode 100644 samples/statx/Makefile
 delete mode 100644 samples/statx/test-statx.c
 create mode 100644 samples/vfs/Makefile
 create mode 100644 samples/vfs/test-fsmount.c
 create mode 100644 samples/vfs/test-statx.c

diff --git a/samples/Kconfig b/samples/Kconfig
index bd133efc1a56..8df1c012820f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -146,10 +146,12 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 	  Specifically it does *not* include any legacy vga stuff.
 	  Device looks a lot like "qemu -device secondary-vga".
 
-config SAMPLE_STATX
-	bool "Build example extended-stat using code"
-	depends on BROKEN
+config SAMPLE_VFS
+	bool "Build example programs that use new VFS system calls"
+	depends on X86
 	help
-	  Build example userspace program to use the new extended-stat syscall.
+	  Build example userspace programs that use new VFS system calls such
+	  as mount API and statx().  Note that this is restricted to the x86
+	  arch whilst it accesses system calls that aren't yet in all arches.
 
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index bd601c038b86..c5a6175c2d3f 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/
+			   vfio-mdev/ vfs/ qmi/
diff --git a/samples/statx/Makefile b/samples/statx/Makefile
deleted file mode 100644
index 59df7c25a9d1..000000000000
--- a/samples/statx/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# List of programs to build
-hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx
-
-# Tell kbuild to always build the programs
-always := $(hostprogs-y)
-
-HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/statx/test-statx.c b/samples/statx/test-statx.c
deleted file mode 100644
index d4d77b09412c..000000000000
--- a/samples/statx/test-statx.c
+++ /dev/null
@@ -1,258 +0,0 @@
-/* Test the statx() system call.
- *
- * Note that the output of this program is intended to look like the output of
- * /bin/stat where possible.
- *
- * Copyright (C) 2015 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
- */
-
-#define _GNU_SOURCE
-#define _ATFILE_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <ctype.h>
-#include <errno.h>
-#include <time.h>
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <sys/stat.h>
-
-#define AT_STATX_SYNC_TYPE	0x6000
-#define AT_STATX_SYNC_AS_STAT	0x0000
-#define AT_STATX_FORCE_SYNC	0x2000
-#define AT_STATX_DONT_SYNC	0x4000
-
-static __attribute__((unused))
-ssize_t statx(int dfd, const char *filename, unsigned flags,
-	      unsigned int mask, struct statx *buffer)
-{
-	return syscall(__NR_statx, dfd, filename, flags, mask, buffer);
-}
-
-static void print_time(const char *field, struct statx_timestamp *ts)
-{
-	struct tm tm;
-	time_t tim;
-	char buffer[100];
-	int len;
-
-	tim = ts->tv_sec;
-	if (!localtime_r(&tim, &tm)) {
-		perror("localtime_r");
-		exit(1);
-	}
-	len = strftime(buffer, 100, "%F %T", &tm);
-	if (len == 0) {
-		perror("strftime");
-		exit(1);
-	}
-	printf("%s", field);
-	fwrite(buffer, 1, len, stdout);
-	printf(".%09u", ts->tv_nsec);
-	len = strftime(buffer, 100, "%z", &tm);
-	if (len == 0) {
-		perror("strftime2");
-		exit(1);
-	}
-	fwrite(buffer, 1, len, stdout);
-	printf("\n");
-}
-
-static void dump_statx(struct statx *stx)
-{
-	char buffer[256], ft = '?';
-
-	printf("results=%x\n", stx->stx_mask);
-
-	printf(" ");
-	if (stx->stx_mask & STATX_SIZE)
-		printf(" Size: %-15llu", (unsigned long long)stx->stx_size);
-	if (stx->stx_mask & STATX_BLOCKS)
-		printf(" Blocks: %-10llu", (unsigned long long)stx->stx_blocks);
-	printf(" IO Block: %-6llu", (unsigned long long)stx->stx_blksize);
-	if (stx->stx_mask & STATX_TYPE) {
-		switch (stx->stx_mode & S_IFMT) {
-		case S_IFIFO:	printf("  FIFO\n");			ft = 'p'; break;
-		case S_IFCHR:	printf("  character special file\n");	ft = 'c'; break;
-		case S_IFDIR:	printf("  directory\n");		ft = 'd'; break;
-		case S_IFBLK:	printf("  block special file\n");	ft = 'b'; break;
-		case S_IFREG:	printf("  regular file\n");		ft = '-'; break;
-		case S_IFLNK:	printf("  symbolic link\n");		ft = 'l'; break;
-		case S_IFSOCK:	printf("  socket\n");			ft = 's'; break;
-		default:
-			printf(" unknown type (%o)\n", stx->stx_mode & S_IFMT);
-			break;
-		}
-	} else {
-		printf(" no type\n");
-	}
-
-	sprintf(buffer, "%02x:%02x", stx->stx_dev_major, stx->stx_dev_minor);
-	printf("Device: %-15s", buffer);
-	if (stx->stx_mask & STATX_INO)
-		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
-	if (stx->stx_mask & STATX_NLINK)
-		printf(" Links: %-5u", stx->stx_nlink);
-	if (stx->stx_mask & STATX_TYPE) {
-		switch (stx->stx_mode & S_IFMT) {
-		case S_IFBLK:
-		case S_IFCHR:
-			printf(" Device type: %u,%u",
-			       stx->stx_rdev_major, stx->stx_rdev_minor);
-			break;
-		}
-	}
-	printf("\n");
-
-	if (stx->stx_mask & STATX_MODE)
-		printf("Access: (%04o/%c%c%c%c%c%c%c%c%c%c)  ",
-		       stx->stx_mode & 07777,
-		       ft,
-		       stx->stx_mode & S_IRUSR ? 'r' : '-',
-		       stx->stx_mode & S_IWUSR ? 'w' : '-',
-		       stx->stx_mode & S_IXUSR ? 'x' : '-',
-		       stx->stx_mode & S_IRGRP ? 'r' : '-',
-		       stx->stx_mode & S_IWGRP ? 'w' : '-',
-		       stx->stx_mode & S_IXGRP ? 'x' : '-',
-		       stx->stx_mode & S_IROTH ? 'r' : '-',
-		       stx->stx_mode & S_IWOTH ? 'w' : '-',
-		       stx->stx_mode & S_IXOTH ? 'x' : '-');
-	if (stx->stx_mask & STATX_UID)
-		printf("Uid: %5d   ", stx->stx_uid);
-	if (stx->stx_mask & STATX_GID)
-		printf("Gid: %5d\n", stx->stx_gid);
-
-	if (stx->stx_mask & STATX_ATIME)
-		print_time("Access: ", &stx->stx_atime);
-	if (stx->stx_mask & STATX_MTIME)
-		print_time("Modify: ", &stx->stx_mtime);
-	if (stx->stx_mask & STATX_CTIME)
-		print_time("Change: ", &stx->stx_ctime);
-	if (stx->stx_mask & STATX_BTIME)
-		print_time(" Birth: ", &stx->stx_btime);
-
-	if (stx->stx_attributes_mask) {
-		unsigned char bits, mbits;
-		int loop, byte;
-
-		static char attr_representation[64 + 1] =
-			/* STATX_ATTR_ flags: */
-			"????????"	/* 63-56 */
-			"????????"	/* 55-48 */
-			"????????"	/* 47-40 */
-			"????????"	/* 39-32 */
-			"????????"	/* 31-24	0x00000000-ff000000 */
-			"????????"	/* 23-16	0x00000000-00ff0000 */
-			"???me???"	/* 15- 8	0x00000000-0000ff00 */
-			"?dai?c??"	/*  7- 0	0x00000000-000000ff */
-			;
-
-		printf("Attributes: %016llx (", stx->stx_attributes);
-		for (byte = 64 - 8; byte >= 0; byte -= 8) {
-			bits = stx->stx_attributes >> byte;
-			mbits = stx->stx_attributes_mask >> byte;
-			for (loop = 7; loop >= 0; loop--) {
-				int bit = byte + loop;
-
-				if (!(mbits & 0x80))
-					putchar('.');	/* Not supported */
-				else if (bits & 0x80)
-					putchar(attr_representation[63 - bit]);
-				else
-					putchar('-');	/* Not set */
-				bits <<= 1;
-				mbits <<= 1;
-			}
-			if (byte)
-				putchar(' ');
-		}
-		printf(")\n");
-	}
-}
-
-static void dump_hex(unsigned long long *data, int from, int to)
-{
-	unsigned offset, print_offset = 1, col = 0;
-
-	from /= 8;
-	to = (to + 7) / 8;
-
-	for (offset = from; offset < to; offset++) {
-		if (print_offset) {
-			printf("%04x: ", offset * 8);
-			print_offset = 0;
-		}
-		printf("%016llx", data[offset]);
-		col++;
-		if ((col & 3) == 0) {
-			printf("\n");
-			print_offset = 1;
-		} else {
-			printf(" ");
-		}
-	}
-
-	if (!print_offset)
-		printf("\n");
-}
-
-int main(int argc, char **argv)
-{
-	struct statx stx;
-	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
-
-	unsigned int mask = STATX_ALL;
-
-	for (argv++; *argv; argv++) {
-		if (strcmp(*argv, "-F") == 0) {
-			atflag &= ~AT_STATX_SYNC_TYPE;
-			atflag |= AT_STATX_FORCE_SYNC;
-			continue;
-		}
-		if (strcmp(*argv, "-D") == 0) {
-			atflag &= ~AT_STATX_SYNC_TYPE;
-			atflag |= AT_STATX_DONT_SYNC;
-			continue;
-		}
-		if (strcmp(*argv, "-L") == 0) {
-			atflag &= ~AT_SYMLINK_NOFOLLOW;
-			continue;
-		}
-		if (strcmp(*argv, "-O") == 0) {
-			mask &= ~STATX_BASIC_STATS;
-			continue;
-		}
-		if (strcmp(*argv, "-A") == 0) {
-			atflag |= AT_NO_AUTOMOUNT;
-			continue;
-		}
-		if (strcmp(*argv, "-R") == 0) {
-			raw = 1;
-			continue;
-		}
-
-		memset(&stx, 0xbf, sizeof(stx));
-		ret = statx(AT_FDCWD, *argv, atflag, mask, &stx);
-		printf("statx(%s) = %d\n", *argv, ret);
-		if (ret < 0) {
-			perror(*argv);
-			exit(1);
-		}
-
-		if (raw)
-			dump_hex((unsigned long long *)&stx, 0, sizeof(stx));
-
-		dump_statx(&stx);
-	}
-	return 0;
-}
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
new file mode 100644
index 000000000000..4ac9690fb3c4
--- /dev/null
+++ b/samples/vfs/Makefile
@@ -0,0 +1,10 @@
+# List of programs to build
+hostprogs-$(CONFIG_SAMPLE_VFS) := \
+	test-fsmount \
+	test-statx
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
+HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/test-fsmount.c b/samples/vfs/test-fsmount.c
new file mode 100644
index 000000000000..74124025ade0
--- /dev/null
+++ b/samples/vfs/test-fsmount.c
@@ -0,0 +1,118 @@
+/* fd-based mount test.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <linux/fs.h>
+#include <linux/unistd.h>
+
+#define E(x) do { if ((x) == -1) { perror(#x); exit(1); } } while(0)
+
+static void check_messages(int fd)
+{
+	char buf[4096];
+	int err, n;
+
+	err = errno;
+
+	for (;;) {
+		n = read(fd, buf, sizeof(buf));
+		if (n < 0)
+			break;
+		n -= 2;
+
+		switch (buf[0]) {
+		case 'e':
+			fprintf(stderr, "Error: %*.*s\n", n, n, buf + 2);
+			break;
+		case 'w':
+			fprintf(stderr, "Warning: %*.*s\n", n, n, buf + 2);
+			break;
+		case 'i':
+			fprintf(stderr, "Info: %*.*s\n", n, n, buf + 2);
+			break;
+		}
+	}
+
+	errno = err;
+}
+
+static __attribute__((noreturn))
+void mount_error(int fd, const char *s)
+{
+	check_messages(fd);
+	fprintf(stderr, "%s: %m\n", s);
+	exit(1);
+}
+
+static inline int fsopen(const char *fs_name, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fs_name, flags);
+}
+
+static inline int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
+{
+	return syscall(__NR_fsmount, fsfd, flags, ms_flags);
+}
+
+static inline int fsconfig(int fsfd, unsigned int cmd,
+			   const char *key, const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
+}
+
+static inline int move_mount(int from_dfd, const char *from_pathname,
+			     int to_dfd, const char *to_pathname,
+			     unsigned int flags)
+{
+	return syscall(__NR_move_mount,
+		       from_dfd, from_pathname,
+		       to_dfd, to_pathname, flags);
+}
+
+#define E_fsconfig(fd, cmd, key, val, aux)				\
+	do {								\
+		if (fsconfig(fd, cmd, key, val, aux) == -1)		\
+			mount_error(fd, key ?: "create");		\
+	} while (0)
+
+int main(int argc, char *argv[])
+{
+	int fsfd, mfd;
+
+	/* Mount a publically available AFS filesystem */
+	fsfd = fsopen("afs", 0);
+	if (fsfd == -1) {
+		perror("fsopen");
+		exit(1);
+	}
+
+	E_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "#grand.central.org:root.cell.", 0);
+	E_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+
+	mfd = fsmount(fsfd, 0, MS_RDONLY);
+	if (mfd < 0)
+		mount_error(fsfd, "fsmount");
+	E(close(fsfd));
+
+	if (move_mount(mfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH) < 0) {
+		perror("move_mount");
+		exit(1);
+	}
+
+	E(close(mfd));
+	exit(0);
+}
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
new file mode 100644
index 000000000000..d4d77b09412c
--- /dev/null
+++ b/samples/vfs/test-statx.c
@@ -0,0 +1,258 @@
+/* Test the statx() system call.
+ *
+ * Note that the output of this program is intended to look like the output of
+ * /bin/stat where possible.
+ *
+ * Copyright (C) 2015 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <linux/stat.h>
+#include <linux/fcntl.h>
+#include <sys/stat.h>
+
+#define AT_STATX_SYNC_TYPE	0x6000
+#define AT_STATX_SYNC_AS_STAT	0x0000
+#define AT_STATX_FORCE_SYNC	0x2000
+#define AT_STATX_DONT_SYNC	0x4000
+
+static __attribute__((unused))
+ssize_t statx(int dfd, const char *filename, unsigned flags,
+	      unsigned int mask, struct statx *buffer)
+{
+	return syscall(__NR_statx, dfd, filename, flags, mask, buffer);
+}
+
+static void print_time(const char *field, struct statx_timestamp *ts)
+{
+	struct tm tm;
+	time_t tim;
+	char buffer[100];
+	int len;
+
+	tim = ts->tv_sec;
+	if (!localtime_r(&tim, &tm)) {
+		perror("localtime_r");
+		exit(1);
+	}
+	len = strftime(buffer, 100, "%F %T", &tm);
+	if (len == 0) {
+		perror("strftime");
+		exit(1);
+	}
+	printf("%s", field);
+	fwrite(buffer, 1, len, stdout);
+	printf(".%09u", ts->tv_nsec);
+	len = strftime(buffer, 100, "%z", &tm);
+	if (len == 0) {
+		perror("strftime2");
+		exit(1);
+	}
+	fwrite(buffer, 1, len, stdout);
+	printf("\n");
+}
+
+static void dump_statx(struct statx *stx)
+{
+	char buffer[256], ft = '?';
+
+	printf("results=%x\n", stx->stx_mask);
+
+	printf(" ");
+	if (stx->stx_mask & STATX_SIZE)
+		printf(" Size: %-15llu", (unsigned long long)stx->stx_size);
+	if (stx->stx_mask & STATX_BLOCKS)
+		printf(" Blocks: %-10llu", (unsigned long long)stx->stx_blocks);
+	printf(" IO Block: %-6llu", (unsigned long long)stx->stx_blksize);
+	if (stx->stx_mask & STATX_TYPE) {
+		switch (stx->stx_mode & S_IFMT) {
+		case S_IFIFO:	printf("  FIFO\n");			ft = 'p'; break;
+		case S_IFCHR:	printf("  character special file\n");	ft = 'c'; break;
+		case S_IFDIR:	printf("  directory\n");		ft = 'd'; break;
+		case S_IFBLK:	printf("  block special file\n");	ft = 'b'; break;
+		case S_IFREG:	printf("  regular file\n");		ft = '-'; break;
+		case S_IFLNK:	printf("  symbolic link\n");		ft = 'l'; break;
+		case S_IFSOCK:	printf("  socket\n");			ft = 's'; break;
+		default:
+			printf(" unknown type (%o)\n", stx->stx_mode & S_IFMT);
+			break;
+		}
+	} else {
+		printf(" no type\n");
+	}
+
+	sprintf(buffer, "%02x:%02x", stx->stx_dev_major, stx->stx_dev_minor);
+	printf("Device: %-15s", buffer);
+	if (stx->stx_mask & STATX_INO)
+		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
+	if (stx->stx_mask & STATX_NLINK)
+		printf(" Links: %-5u", stx->stx_nlink);
+	if (stx->stx_mask & STATX_TYPE) {
+		switch (stx->stx_mode & S_IFMT) {
+		case S_IFBLK:
+		case S_IFCHR:
+			printf(" Device type: %u,%u",
+			       stx->stx_rdev_major, stx->stx_rdev_minor);
+			break;
+		}
+	}
+	printf("\n");
+
+	if (stx->stx_mask & STATX_MODE)
+		printf("Access: (%04o/%c%c%c%c%c%c%c%c%c%c)  ",
+		       stx->stx_mode & 07777,
+		       ft,
+		       stx->stx_mode & S_IRUSR ? 'r' : '-',
+		       stx->stx_mode & S_IWUSR ? 'w' : '-',
+		       stx->stx_mode & S_IXUSR ? 'x' : '-',
+		       stx->stx_mode & S_IRGRP ? 'r' : '-',
+		       stx->stx_mode & S_IWGRP ? 'w' : '-',
+		       stx->stx_mode & S_IXGRP ? 'x' : '-',
+		       stx->stx_mode & S_IROTH ? 'r' : '-',
+		       stx->stx_mode & S_IWOTH ? 'w' : '-',
+		       stx->stx_mode & S_IXOTH ? 'x' : '-');
+	if (stx->stx_mask & STATX_UID)
+		printf("Uid: %5d   ", stx->stx_uid);
+	if (stx->stx_mask & STATX_GID)
+		printf("Gid: %5d\n", stx->stx_gid);
+
+	if (stx->stx_mask & STATX_ATIME)
+		print_time("Access: ", &stx->stx_atime);
+	if (stx->stx_mask & STATX_MTIME)
+		print_time("Modify: ", &stx->stx_mtime);
+	if (stx->stx_mask & STATX_CTIME)
+		print_time("Change: ", &stx->stx_ctime);
+	if (stx->stx_mask & STATX_BTIME)
+		print_time(" Birth: ", &stx->stx_btime);
+
+	if (stx->stx_attributes_mask) {
+		unsigned char bits, mbits;
+		int loop, byte;
+
+		static char attr_representation[64 + 1] =
+			/* STATX_ATTR_ flags: */
+			"????????"	/* 63-56 */
+			"????????"	/* 55-48 */
+			"????????"	/* 47-40 */
+			"????????"	/* 39-32 */
+			"????????"	/* 31-24	0x00000000-ff000000 */
+			"????????"	/* 23-16	0x00000000-00ff0000 */
+			"???me???"	/* 15- 8	0x00000000-0000ff00 */
+			"?dai?c??"	/*  7- 0	0x00000000-000000ff */
+			;
+
+		printf("Attributes: %016llx (", stx->stx_attributes);
+		for (byte = 64 - 8; byte >= 0; byte -= 8) {
+			bits = stx->stx_attributes >> byte;
+			mbits = stx->stx_attributes_mask >> byte;
+			for (loop = 7; loop >= 0; loop--) {
+				int bit = byte + loop;
+
+				if (!(mbits & 0x80))
+					putchar('.');	/* Not supported */
+				else if (bits & 0x80)
+					putchar(attr_representation[63 - bit]);
+				else
+					putchar('-');	/* Not set */
+				bits <<= 1;
+				mbits <<= 1;
+			}
+			if (byte)
+				putchar(' ');
+		}
+		printf(")\n");
+	}
+}
+
+static void dump_hex(unsigned long long *data, int from, int to)
+{
+	unsigned offset, print_offset = 1, col = 0;
+
+	from /= 8;
+	to = (to + 7) / 8;
+
+	for (offset = from; offset < to; offset++) {
+		if (print_offset) {
+			printf("%04x: ", offset * 8);
+			print_offset = 0;
+		}
+		printf("%016llx", data[offset]);
+		col++;
+		if ((col & 3) == 0) {
+			printf("\n");
+			print_offset = 1;
+		} else {
+			printf(" ");
+		}
+	}
+
+	if (!print_offset)
+		printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct statx stx;
+	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
+
+	unsigned int mask = STATX_ALL;
+
+	for (argv++; *argv; argv++) {
+		if (strcmp(*argv, "-F") == 0) {
+			atflag &= ~AT_STATX_SYNC_TYPE;
+			atflag |= AT_STATX_FORCE_SYNC;
+			continue;
+		}
+		if (strcmp(*argv, "-D") == 0) {
+			atflag &= ~AT_STATX_SYNC_TYPE;
+			atflag |= AT_STATX_DONT_SYNC;
+			continue;
+		}
+		if (strcmp(*argv, "-L") == 0) {
+			atflag &= ~AT_SYMLINK_NOFOLLOW;
+			continue;
+		}
+		if (strcmp(*argv, "-O") == 0) {
+			mask &= ~STATX_BASIC_STATS;
+			continue;
+		}
+		if (strcmp(*argv, "-A") == 0) {
+			atflag |= AT_NO_AUTOMOUNT;
+			continue;
+		}
+		if (strcmp(*argv, "-R") == 0) {
+			raw = 1;
+			continue;
+		}
+
+		memset(&stx, 0xbf, sizeof(stx));
+		ret = statx(AT_FDCWD, *argv, atflag, mask, &stx);
+		printf("statx(%s) = %d\n", *argv, ret);
+		if (ret < 0) {
+			perror(*argv);
+			exit(1);
+		}
+
+		if (raw)
+			dump_hex((unsigned long long *)&stx, 0, sizeof(stx));
+
+		dump_statx(&stx);
+	}
+	return 0;
+}

