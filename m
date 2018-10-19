Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3745ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7EC205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7EC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeJSN3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:29:44 -0400
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:39048 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeJSN3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:29:44 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id w9J5BIhM028535; Fri, 19 Oct 2018 14:11:18 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id w9J5BA7s032320; Fri, 19 Oct 2018 14:11:10 +0900
X-Iguazu-Qid: 34tKVYwxduQHUbNp8j
X-Iguazu-QSIG: v=1; s=0; t=1539925870; q=34tKVYwxduQHUbNp8j; m=mGx++BgMT98NmRr8jL/4ZkgLAtS3PryfLLDYsjawpDA=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1511) id w9J5B94o009730;
        Fri, 19 Oct 2018 14:11:09 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w9J5B6eG029791;
        Fri, 19 Oct 2018 14:11:09 +0900 (JST)
From:   Shinya Takumi <shinya1.takumi@toshiba.co.jp>
To:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shinya Takumi <shinya1.takumi@toshiba.co.jp>
Subject: [RFC v4 2/2] WhiteEgret: Add an example of user application.
Date:   Fri, 19 Oct 2018 14:11:04 +0900
X-TSB-HOP: ON
Message-Id: <1539925864-16849-1-git-send-email-shinya1.takumi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user application is required to use WhiteEgret.
This RFC provides a sample user application program.

Usage
  sample-we-user <exe> <interpreter exe> <script>

This sample user application always returns "not permit"
for the executable specified by the argument <exe>,
otherwise always returns "permit". Set the absolute path
of an executable to be blocked for <exe>.

If the process of <interpreter exe> opening <script>, WhiteEgret
denies the execution request of the script. If the process opens
the other file, WhiteEgret allows the execution request.

Example
  sample-we-user /bin/df /bin/perl /tmp/test.pl

Then every executions of /bin/df are blocked.
The other commands can be issued normally.

If the process family of /bin/perl requests to open
/tmp/test.pl, WhiteEgret denies the request. If the
process family requests to open other file, it is
permitted.

How to build
To build this sample user application, please set option
CONFIG_SAMPLE_WHITEEGRET=y. To enable to control for script
execution, also set SECURITY_WHITEEGRET_INTERPRETER=y,
CONFIG_SECURITY_WHITEEGRET_HOOK_READ_OPEN=y and
CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK=y.

Remark
This sample user application does not use a whitelist.
The reason why this sample user application adopts
blacklist-like approach is to avoid a host to become
uncontrollable. Namely, if this sample provides a sample
whitelist and it misses indispensable executable components
for a host, the host cannot run or stop normally.
Because indispensable executable components depend on
each environment, we decide not to provide a whitelisting-type
sample user application.

Signed-off-by: Shinya Takumi <shinya1.takumi@toshiba.co.jp>
---
 samples/Kconfig              |   6 ++
 samples/Makefile             |   2 +-
 samples/whiteegret/Makefile  |  14 +++
 samples/whiteegret/checkwl.c | 215 +++++++++++++++++++++++++++++++++++++++++++
 samples/whiteegret/checkwl.h |  33 +++++++
 samples/whiteegret/main.c    | 119 ++++++++++++++++++++++++
 6 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 samples/whiteegret/Makefile
 create mode 100644 samples/whiteegret/checkwl.c
 create mode 100644 samples/whiteegret/checkwl.h
 create mode 100644 samples/whiteegret/main.c

diff --git a/samples/Kconfig b/samples/Kconfig
index ad1ec701..03a89c0 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -153,4 +153,10 @@ config SAMPLE_STATX
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
index bd601c0..d0c53d3 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_SAMPLES)	+= kobject/ kprobes/ trace_events/ livepatch/ \
 			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 			   configfs/ connector/ v4l/ trace_printk/ \
-			   vfio-mdev/ statx/ qmi/
+			   vfio-mdev/ statx/ qmi/ whiteegret/
diff --git a/samples/whiteegret/Makefile b/samples/whiteegret/Makefile
new file mode 100644
index 0000000..77a0164
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
index 0000000..806f2f0
--- /dev/null
+++ b/samples/whiteegret/checkwl.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include <stdlib.h>
+#include "checkwl.h"
+
+/*
+ * The function check_whitelist_exec() set -EACCES to result
+ * only when path to be examined equals to @a not_permit_exe.
+ */
+char not_permit_exe[NOTPERMITEXENAMELENGTH];
+
+/*
+ * The function check_whitelist_exec() store monitoring interpreter
+ * only when path to be examined equals to @a monitor_interpreter.
+ */
+char monitor_interpreter[NOTPERMITEXENAMELENGTH];
+
+/*
+ * The function check_whitelist_terp() set -EACCES to result
+ * only when path to be examined equals to @a not_permit_script.
+ */
+char not_permit_script[NOTPERMITEXENAMELENGTH];
+
+/*
+ * The struct records interpreter process tgid.
+ * This tgid recorded in @a root_terp_proc.
+ */
+struct terp_proc {
+	struct terp_proc *next;
+	pid_t tgid;
+};
+static struct terp_proc *root_terp_proc;
+
+void init_terp_proc(void)
+{
+	root_terp_proc = NULL;
+}
+
+static void register_terp_proc(pid_t tgid)
+{
+	struct terp_proc *proc;
+
+	proc = calloc(1, sizeof(*proc));
+	if (!proc)
+		return;
+
+	proc->tgid = tgid;
+	proc->next = root_terp_proc;
+	root_terp_proc = proc;
+}
+
+static void unregister_terp_proc(pid_t tgid)
+{
+	struct terp_proc *now, *back;
+
+	if (!root_terp_proc)
+		return;
+
+	if (root_terp_proc->tgid == tgid) {
+		root_terp_proc = root_terp_proc->next;
+		return;
+	}
+	for (back = root_terp_proc, now = back->next; now != NULL;
+	     back = now, now = now->next) {
+		if (now->tgid == tgid) {
+			back->next = now->next;
+			free(now);
+			break;
+		}
+	}
+}
+
+static struct terp_proc *get_terp_proc(pid_t tgid)
+{
+	struct terp_proc *now;
+
+	for (now = root_terp_proc; now != NULL; now = now->next) {
+		if (now->tgid == tgid)
+			return now;
+	}
+	return NULL;
+}
+
+/**
+ * check_whitelist_exec - Examine whether the executable input to this function
+ *			  is included in whitelist or not.
+ *
+ * @result: Result of the examination.
+ *	    0       if the executble is included in whitelist
+ *	    -EACCES otherwise ("not included")
+ *
+ * Returns 0 for success, -1 otherwise.
+ */
+int check_whitelist_exec(int *result, struct we_req_user *user)
+{
+	char *path;
+
+	if (result == NULL)
+		return -1;
+
+	*result = WE_EXEC_OK;
+
+	if (user == NULL)
+		return -1;
+
+	path = user->info.path;
+
+	/*
+	 * Referring a whitelist is expected at this location.
+	 * However, this sample uses not whitelist but blacklist
+	 * because of avoiding a host to become uncontrollable.
+	 * (not_permit_exe is a blacklist containing only one item.)
+	 */
+	if (strncmp(not_permit_exe, path, NOTPERMITEXENAMELENGTH) == 0)
+		*result = -EACCES;
+	/*
+	 * Referring a list is monitered a interpreter at this location.
+	 * This location registers a tgid of monitering interpreter.
+	 * Monitering interpreter is limited reading script.
+	 */
+	else if (strncmp(monitor_interpreter, path,
+			 NOTPERMITEXENAMELENGTH) == 0)
+		register_terp_proc(user->tgid);
+	return 0;
+}
+
+/**
+ * check_whitelist_terp - Examine whether the script input to this function
+ *			  is included in whitelist or not, if the process
+ *			  input to this function is registered in
+ *			  @root_terp_proc.
+ *
+ * @result: Result of the examination.
+ *	    0       if the script is included in whitelist,
+ *		    or not registered process
+ *	    -EACCES otherwise ("not included")
+ *
+ * Returns 0 for success, -1 otherwise.
+ */
+int check_whitelist_terp(int *result, struct we_req_user *user)
+{
+	if (result == NULL)
+		return -1;
+
+	*result = WE_EXEC_OK;
+
+	/*
+	 * if process reading a file is registered, referring a whitelist
+	 * is expected at this location.
+	 * However, this sample uses not whitelist but blacklist
+	 * because of avoiding a host to become uncontrollable.
+	 * (not_permit_script is a blacklist containing only one item.)
+	 */
+	if (get_terp_proc(user->tgid)) {
+		if (strncmp(not_permit_script, user->info.path,
+			    NOTPERMITEXENAMELENGTH) == 0)
+			*result = -EACCES;
+	}
+	return 0;
+}
+
+/**
+ * check_fork_terp - Register the child process to @root_terp_proc,
+ *		     if the parent process already has registerd to
+ *		     @root_terp_proc.
+ *
+ * Returns Allways 0.
+ */
+int check_fork_terp(int *result, struct we_req_user *user)
+{
+	if (result == NULL)
+		return -1;
+
+	*result = WE_EXEC_OK;
+	/*
+	 * A child process of a interpreter has possibilities interpreter.
+	 * This location registers a tgid of child process case of
+	 * interpreter.
+	 */
+	if (get_terp_proc(user->ppid))
+		register_terp_proc(user->tgid);
+	return 0;
+}
+
+/**
+ * check_exit_terp - Unregister the process form @root_terp_proc,
+ *		     case of matching @root_terp_proc.
+ *
+ * @result: Allways 0.
+ */
+int check_exit_terp(int *result, struct we_req_user *user)
+{
+	if (result == NULL)
+		return -1;
+
+	*result = WE_EXEC_OK;
+	/*
+	 * This location unregisters exit process with interpreter.
+	 */
+	unregister_terp_proc(user->tgid);
+	return 0;
+}
diff --git a/samples/whiteegret/checkwl.h b/samples/whiteegret/checkwl.h
new file mode 100644
index 0000000..14e1509
--- /dev/null
+++ b/samples/whiteegret/checkwl.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+extern char monitor_interpreter[NOTPERMITEXENAMELENGTH];
+extern char not_permit_script[NOTPERMITEXENAMELENGTH];
+
+void init_terp_proc(void);
+int check_whitelist_exec(int *result, struct we_req_user *user);
+int check_whitelist_terp(int *result, struct we_req_user *user);
+int check_fork_terp(int *result, struct we_req_user *user);
+int check_exit_terp(int *result, struct we_req_user *user);
+
+#endif
diff --git a/samples/whiteegret/main.c b/samples/whiteegret/main.c
new file mode 100644
index 0000000..20880df
--- /dev/null
+++ b/samples/whiteegret/main.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
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
+	fprintf(stderr, "Usage: sample-we-user <executable file name> ");
+	fprintf(stderr,	"<interpreter file name> <script file name>\n");
+	fprintf(stderr, "executable file name: absolute path of executable ");
+	fprintf(stderr,	"not to permit execution.\n");
+	fprintf(stderr, "interpreter file name: absolute path of");
+	fprintf(stderr, "interpreter monitoring script read.\n");
+	fprintf(stderr, "script file name: absolute path of script file");
+	fprintf(stderr, "not to permit reading(execution).\n");
+	fprintf(stderr, "If you want to use controling script file, ");
+	fprintf(stderr, "you enable WhiteEgret Kernel option ");
+	fprintf(stderr, "CONFIG_SECURITY_WHITEEGRET_INTERPRETER.\n");
+}
+
+static int check_whitelist(int *result, struct we_req_user *user)
+{
+	int ret;
+
+	switch (user->cmd) {
+	case CONTROL_EXEC:
+		ret = check_whitelist_exec(result, user);
+		break;
+	case CONTROL_READ:
+		ret = check_whitelist_terp(result, user);
+		break;
+	case CONTROL_FORK:
+		ret = check_fork_terp(result, user);
+		break;
+	case CONTROL_EXIT:
+		ret = check_exit_terp(result, user);
+		break;
+	}
+	return ret;
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
+	if (argc < 4) {
+		print_usage();
+		return -1;
+	}
+
+	init_terp_proc();
+	snprintf(not_permit_exe, NOTPERMITEXENAMELENGTH, "%s", argv[1]);
+	snprintf(monitor_interpreter, NOTPERMITEXENAMELENGTH, "%s", argv[2]);
+	snprintf(not_permit_script, NOTPERMITEXENAMELENGTH, "%s", argv[3]);
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
+		ack.tgid = user->tgid;
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
2.7.4

