Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935803AbeCAIBH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:01:07 -0500
Received: from mfo1500.tsb.2iij.net ([210.149.48.175]:53333 "EHLO
        mfo.tsb.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934962AbeCAIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:01:03 -0500
X-MXL-Hash: 5a97ae1f27e4400a-4f9d8bcedf12bc050529ab28ceda8fd7fec5d5d0
Content-Transfer-Encoding: 7bit
From: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
To: jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
Subject: [RFC v2 2/2] WhiteEgret: Add an example of user application.
Date: Thu,  1 Mar 2018 16:38:56 +0900
Message-Id: <20180301073856.2601-1-masanobu2.koike@toshiba.co.jp>
X-Mailer: git-send-email 2.14.1
X-MAIL-FROM: <masanobu2.koike@toshiba.co.jp>
X-SOURCE-IP: [172.27.153.190]
X-Spam: exempt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user application is required to use WhiteEgret.
This RFC provides a sample user application program.

Usage
  sample-we-user <exe>

This sample user application always returns "not permit"
for the executable specified by the argument <exe>,
otherwise always returns "permit". Set the absolute path
of an executable to be blocked for <exe>.

Example
  sample-we-user /bin/df

Then every executions of /bin/df are blocked.
The other commands can be issued normally.

How to build
To build this sample user application, set option
CONFIG_SAMPLE_WHITEEGRET=y.

Remark
This sample user application does not use a whitelist.
It simply returns "not permit" only when WhiteEgret sends
the absolute path of argv[1] to the application.
The reason why this sample user application adopts
blacklist-like approach is to avoid a host to become
uncontrollable. Namely, if this sample provides a sample
whitelist and it misses indispensable executable components
for a host, the host cannot run or stop normally.
Because indispensable executable components depend on
each environment, we decide not to provide a whitelisting-type
sample user application.

Signed-off-by: Masanobu Koike <masanobu2.koike@toshiba.co.jp>
---
 samples/Kconfig              |  6 ++++
 samples/Makefile             |  2 +-
 samples/whiteegret/Makefile  | 14 ++++++++
 samples/whiteegret/checkwl.c | 57 +++++++++++++++++++++++++++++
 samples/whiteegret/checkwl.h | 26 ++++++++++++++
 samples/whiteegret/main.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 samples/whiteegret/Makefile
 create mode 100644 samples/whiteegret/checkwl.c
 create mode 100644 samples/whiteegret/checkwl.h
 create mode 100644 samples/whiteegret/main.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c332a3b9de05..be6b03a70f23 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -117,4 +117,10 @@ config SAMPLE_STATX
 	help
 	  Build example userspace program to use the new extended-stat syscall.
 
+config SAMPLE_WHITEEGRET
+	bool "Build WhiteEgret sample user application"
+	depends on SECURITY_WHITEEGRET
+	help
+	  Build sample userspace application for WhiteEgret LSM module.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index db54e766ddb1..00bcba542e46 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
-			   vfio-mdev/ statx/
+			   vfio-mdev/ statx/ whiteegret/
diff --git a/samples/whiteegret/Makefile b/samples/whiteegret/Makefile
new file mode 100644
index 000000000000..77a01643c45d
--- /dev/null
+++ b/samples/whiteegret/Makefile
@@ -0,0 +1,14 @@
+# kbuild trick to avoid linker error. Can be omitted if a module is built.
+obj- := dummy.o
+
+# List of programs to build
+hostprogs-$(CONFIG_SAMPLE_WHITEEGRET) := sample-we-user
+
+sample-we-user-objs := main.o checkwl.o
+
+HOSTCFLAGS += -Wall
+HOSTCFLAGS += -I/usr/local/include
+HOSTCFLAGS += -I$(srctree)/security/whiteegret
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
diff --git a/samples/whiteegret/checkwl.c b/samples/whiteegret/checkwl.c
new file mode 100644
index 000000000000..f19eb1054208
--- /dev/null
+++ b/samples/whiteegret/checkwl.c
@@ -0,0 +1,57 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include "checkwl.h"
+
+/*
+ * The function check_whitelist() returns -EACCES
+ * only when path to be examined equals to @a not_permit_exe.
+ */
+char not_permit_exe[NOTPERMITEXENAMELENGTH];
+
+/**
+ * check_whitelist - Examine whether the executable input to this function
+ *                   is included in whitelist or not.
+ *
+ * @result: Result of the examination.
+ *            0       if the executble is included in whitelist
+ *            -EACCES otherwise ("not included")
+ *
+ * Returns 0 for success, -1 otherwise.
+ */
+int check_whitelist(int *result, struct we_req_user *user)
+{
+	char *path;
+
+	if (result == NULL)
+		return -1;
+
+	*result = 0;
+
+	if (user == NULL)
+		return -1;
+
+	path = user->path;
+
+	/*
+	 * Referring a whitelist is expected at this location.
+	 * However, this sample uses not whitelist but blacklist
+	 * because of avoiding a host to become uncontrollable.
+	 * (not_permit_exe is a blacklist containing only one item.)
+	 */
+	if (strncmp(not_permit_exe, path, NOTPERMITEXENAMELENGTH) == 0)
+		*result = -EACCES;
+
+	return 0;
+}
diff --git a/samples/whiteegret/checkwl.h b/samples/whiteegret/checkwl.h
new file mode 100644
index 000000000000..732959bbcf16
--- /dev/null
+++ b/samples/whiteegret/checkwl.h
@@ -0,0 +1,26 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#ifndef _CHECKWL_H
+#define _CHECKWL_H
+
+#include <sys/types.h>
+#include "we_fs_common.h"
+
+/* byte length of absolute path of file not to permit execution */
+#define NOTPERMITEXENAMELENGTH 1024
+
+extern char not_permit_exe[NOTPERMITEXENAMELENGTH];
+
+int check_whitelist(int *result, struct we_req_user *user);
+
+#endif
diff --git a/samples/whiteegret/main.c b/samples/whiteegret/main.c
new file mode 100644
index 000000000000..949d188885de
--- /dev/null
+++ b/samples/whiteegret/main.c
@@ -0,0 +1,86 @@
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Sample program of user's whitelisting application
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include "checkwl.h"
+
+#include <stdlib.h>
+#include "we_fs_common.h"
+
+#define MAXWAITFROMKER 10
+
+static void sigint_catch(int sig)
+{
+}
+
+static void print_usage(void)
+{
+	fprintf(stderr, "Usage: sample-we-user [file_name]\n");
+	fprintf(stderr, "file_name: absolute path of executable");
+	fprintf(stderr, "not to permit execution.\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	struct we_req_user *user;
+	struct we_ack ack;
+	char buf[1024];
+	int ret;
+
+	if (argc < 2) {
+		print_usage();
+		return -1;
+	}
+
+	snprintf(not_permit_exe, NOTPERMITEXENAMELENGTH, "%s", argv[1]);
+
+	signal(SIGINT, sigint_catch);
+
+	if (daemon(0, 0) < 0) {
+		perror("daemon");
+		exit(EXIT_FAILURE);
+	}
+
+	fd = open(WE_DEV_PATH, O_RDWR, 0);
+	if (fd < 0) {
+		perror(WE_DEV_PATH);
+		exit(EXIT_FAILURE);
+	}
+	user = (struct we_req_user *)((void *)buf);
+
+	while (1) {
+		ret = read(fd, (char *)user, 1024);
+		if (ret < 0) {
+			perror("read");
+			continue;
+		}
+
+		ack.pid = user->pid;
+		check_whitelist(&ack.permit, user);
+
+		ret = write(fd, (char *)&ack, sizeof(ack));
+	}
+
+	close(fd);
+
+	return 0;
+}
-- 
2.14.1
