Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34995C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C7920862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C7920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbeG0S6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:58:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388701AbeG0S6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A63268577C;
        Fri, 27 Jul 2018 17:35:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E68E12166BA3;
        Fri, 27 Jul 2018 17:35:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 36/38] vfs: Add a sample program for the new mount API [ver
 #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:35:23 +0100
Message-ID: <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:35:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:35:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sample program to demonstrate fsopen/fsmount/move_mount to mount
something.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/Kconfig                  |    6 ++
 samples/Makefile                 |    2 -
 samples/mount_api/Makefile       |    7 ++
 samples/mount_api/test-fsmount.c |  118 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 samples/mount_api/Makefile
 create mode 100644 samples/mount_api/test-fsmount.c

diff --git a/samples/Kconfig b/samples/Kconfig
index bd133efc1a56..daa17e9f3197 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -152,4 +152,10 @@ config SAMPLE_STATX
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
+config SAMPLE_MOUNT_API
+	bool "Build example code using the new mount API"
+	depends on BROKEN
+	help
+	  Build example userspace program(s) that use the new mount API.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index bd601c038b86..31d08cc71a5c 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/
+			   vfio-mdev/ statx/ qmi/ mount_api/
diff --git a/samples/mount_api/Makefile b/samples/mount_api/Makefile
new file mode 100644
index 000000000000..6856df236dbf
--- /dev/null
+++ b/samples/mount_api/Makefile
@@ -0,0 +1,7 @@
+# List of programs to build
+hostprogs-$(CONFIG_SAMPLE_MOUNT_API) := test-fsmount
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
diff --git a/samples/mount_api/test-fsmount.c b/samples/mount_api/test-fsmount.c
new file mode 100644
index 000000000000..3886ceb022b6
--- /dev/null
+++ b/samples/mount_api/test-fsmount.c
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
+	E_fsconfig(fsfd, fsconfig_set_string, "source", "#grand.central.org:root.cell.", 0);
+	E_fsconfig(fsfd, fsconfig_cmd_create, NULL, NULL, 0);
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

