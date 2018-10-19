Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E1FECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCB221470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCB221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeJSNTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:19:35 -0400
Received: from mo-csw-fb1515.securemx.jp ([210.130.202.171]:38874 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeJSNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:19:35 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 09:19:32 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id w9J5B7LF028526; Fri, 19 Oct 2018 14:11:07 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id w9J5B09w014660; Fri, 19 Oct 2018 14:11:00 +0900
X-Iguazu-Qid: 34tMdZTBnGzYUw5QSS
X-Iguazu-QSIG: v=1; s=0; t=1539925859; q=34tMdZTBnGzYUw5QSS; m=mNHdMtWE9UCI95Em2dXz6v8lvLISrYen9z9I0TZdg6E=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1511) id w9J5AwOA009389;
        Fri, 19 Oct 2018 14:10:58 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w9J5ArRF029608;
        Fri, 19 Oct 2018 14:10:58 +0900 (JST)
From:   Shinya Takumi <shinya1.takumi@toshiba.co.jp>
To:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shinya Takumi <shinya1.takumi@toshiba.co.jp>
Subject: [RFC v4 1/2] WhiteEgret: Add WhiteEgret core functions.
Date:   Fri, 19 Oct 2018 14:09:09 +0900
X-TSB-HOP: ON
Message-Id: <1539925749-16796-1-git-send-email-shinya1.takumi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC provides implementation of WhiteEgret.

Signed-off-by: Shinya Takumi <shinya1.takumi@toshiba.co.jp>
---
 security/Kconfig                   |   1 +
 security/Makefile                  |   2 +
 security/whiteegret/Kconfig        |  82 +++++++
 security/whiteegret/Makefile       |   2 +
 security/whiteegret/init.c         | 148 ++++++++++++
 security/whiteegret/main.c         | 466 +++++++++++++++++++++++++++++++++++++
 security/whiteegret/request.c      |  98 ++++++++
 security/whiteegret/request.h      |  47 ++++
 security/whiteegret/we.h           |  72 ++++++
 security/whiteegret/we_fs.c        | 269 +++++++++++++++++++++
 security/whiteegret/we_fs.h        |  23 ++
 security/whiteegret/we_fs_common.h |  60 +++++
 12 files changed, 1270 insertions(+)
 create mode 100644 security/whiteegret/Kconfig
 create mode 100644 security/whiteegret/Makefile
 create mode 100644 security/whiteegret/init.c
 create mode 100644 security/whiteegret/main.c
 create mode 100644 security/whiteegret/request.c
 create mode 100644 security/whiteegret/request.h
 create mode 100644 security/whiteegret/we.h
 create mode 100644 security/whiteegret/we_fs.c
 create mode 100644 security/whiteegret/we_fs.h
 create mode 100644 security/whiteegret/we_fs_common.h

diff --git a/security/Kconfig b/security/Kconfig
index d9aa521..d656e20 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -236,6 +236,7 @@ source security/tomoyo/Kconfig
 source security/apparmor/Kconfig
 source security/loadpin/Kconfig
 source security/yama/Kconfig
+source security/whiteegret/Kconfig
 
 source security/integrity/Kconfig
 
diff --git a/security/Makefile b/security/Makefile
index 4d2d378..2da669c 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -10,6 +10,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
 subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
+subdir-$(CONFIG_SECURITY_WHITEEGRET)	+= whiteegret
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -26,6 +27,7 @@ obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
+obj-$(CONFIG_SECURITY_WHITEEGRET)	+= whiteegret/
 
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
diff --git a/security/whiteegret/Kconfig b/security/whiteegret/Kconfig
new file mode 100644
index 0000000..e55acc4
--- /dev/null
+++ b/security/whiteegret/Kconfig
@@ -0,0 +1,82 @@
+config SECURITY_WHITEEGRET
+	bool "WhiteEgret support"
+	depends on SECURITY
+	select SECURITYFS
+	default n
+	help
+	  This enables the WhiteEgret security module.
+	  WhiteEgret provides a whitelisting execution control capability,
+	  which helps stop the execution of unauthorized software
+	  such as malware.
+	  You will also need a user application and an execution whitelist.
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_WHITEEGRET_INTERPRETER
+	bool "WhiteEgret hook file read and create/exit task for interpreter"
+	depends on SECURITY_WHITEEGRET
+	default n
+	help
+	  This add LSM fook points for controlling interpreter.
+	  Target hook points are file read and create/exit task functions.
+	  You selecte details hook points for enabling config depend on
+	  SECURITY_WHITEEGRET_INTERPRETER.
+
+config SECURITY_WHITEEGRET_HOOK_FILE_READ
+	bool "WhiteEgret hook file read"
+	depends on SECURITY_WHITEEGRET_INTERPRETER
+	default n
+	help
+	  This enables hooking file read. The Kernel notify hooking infomation
+	  to WhiteEgret's user application. This applocation can receive
+	  hooking infomation and contorolling execution of hook function.
+
+config SECURITY_WHITEEGRET_HOOK_READ_OPEN
+	bool "WhiteEgret hook open for file read"
+	depends on SECURITY_WHITEEGRET_INTERPRETER
+	default y
+	help
+	  This enables hooking file open LSM for reading. The Kernel notify
+	  hooking infomation to WhiteEgret user application. This applocation
+	  can receive hooking infomation and contorolling execution of
+	  hook function.
+
+config SECURITY_WHITEEGRET_CHECK_LIVING_TASK
+	bool "WhiteEgret hook creating and exiting task"
+	depends on SECURITY_WHITEEGRET_INTERPRETER
+	default y
+	help
+	  This enables hooking create/exit task LSM. The Kernel notify
+	  hooking infomation to WhiteEgret user application. This applocation
+	  can receive hooking infomation and contorolling execution of
+	  hook function.
+
+config SECURITY_WHITEEGRET_HOOK_WRITE
+	bool "WhiteEgret hook write"
+	depends on SECURITY_WHITEEGRET
+	select SECURITY_PATH
+	default n
+	help
+	  This add LSM fook points for monitoring to write to executable file.
+	  You selecte hook points to write file for enabling config depend on
+	  SECURITY_WHITEEGRET_HOOK_WRITE.
+	  rename function is hooked by enable SECURITY_WHITEEGRET_HOOK_WRITE.
+
+config SECURITY_WHITEEGRET_HOOK_FILE_WRITE
+	bool "WhiteEgret hook file write"
+	depends on SECURITY_WHITEEGRET_HOOK_WRITE
+	default n
+	help
+	  This enables hooking file open LSM for writing. The Kernel notify
+	  hooking infomation to WhiteEgret user application. This applocation
+	  can receive hooking infomation and contorolling execution of
+	  hook function.
+
+config SECURITY_WHITEEGRET_HOOK_WRITE_OPEN
+	bool "WhiteEgret hook open for write"
+	depends on SECURITY_WHITEEGRET_HOOK_WRITE
+	default y
+	help
+	  This enables hooking file write. The Kernel notify hooking
+	  infomation to WhiteEgret user application. This applocation
+	  can receive hooking infomation and contorolling execution of
+	  hook function.
diff --git a/security/whiteegret/Makefile b/security/whiteegret/Makefile
new file mode 100644
index 0000000..16bd3af
--- /dev/null
+++ b/security/whiteegret/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SECURITY_WHITEEGRET) += whiteegret.o
+whiteegret-y := init.o main.o request.o we_fs.o
diff --git a/security/whiteegret/init.c b/security/whiteegret/init.c
new file mode 100644
index 0000000..b78f581
--- /dev/null
+++ b/security/whiteegret/init.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#define pr_fmt(fmt) "WhiteEgret: " fmt
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+#include "we.h"
+
+#include <linux/lsm_hooks.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("WhiteEgret Linux Security Module");
+
+static int we_security_bprm_check(struct linux_binprm *bprm)
+{
+	if (!bprm)
+		return 0;
+
+	if (we_security_bprm_check_main(bprm) == -EACCES)
+		return -EACCES;
+
+	return 0;
+}
+
+static int we_security_mmap_check(struct file *file, unsigned long reqprot,
+		unsigned long prot, unsigned long flags)
+{
+	if (!file)
+		return 0;
+
+	if (we_security_mmap_check_main(file, reqprot, flags) == -EACCES)
+		return -EACCES;
+
+	return 0;
+}
+
+#if defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_READ) || \
+	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_WRITE)
+static int we_security_access_check(struct file *file, int mask)
+{
+	if (!file)
+		return 0;
+	return we_security_access_check_main(file, mask);
+}
+#endif
+
+#if defined(CONFIG_SECURITY_WHITEEGRET_HOOK_READ_OPEN) || \
+	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE_OPEN)
+static int we_security_open_check(struct file *file)
+{
+	if (!file)
+		return 0;
+	return we_security_open_check_main(file);
+}
+#endif
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE
+static int we_security_rename_check(struct path *old_dir,
+				    struct dentry *old_dentry,
+				    struct path *new_dir,
+				    struct dentry *new_dentry)
+{
+	struct path new_path;
+
+	if (!new_dir)
+		return 0;
+
+	new_path.mnt = new_dir->mnt;
+	new_path.dentry = new_dentry;
+	return we_security_rename_check_main(&new_path);
+}
+#endif
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK
+static int we_task_alloc_check(struct task_struct *task,
+			       unsigned long clone_flag)
+{
+	if (!task)
+		return 0;
+
+	return we_security_task_alloc_check_main(task, clone_flag);
+}
+
+static void we_task_free_check(struct task_struct *task)
+{
+	if (!task)
+		return;
+
+	we_security_task_free_check_main(task);
+}
+#endif
+
+static struct security_hook_list we_hooks[] = {
+	LSM_HOOK_INIT(bprm_check_security, we_security_bprm_check),
+	LSM_HOOK_INIT(mmap_file, we_security_mmap_check),
+#if defined(CONFIG_SECURITY_WHITEEGRET_HOOK_READ_OPEN) || \
+	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE_OPEN)
+	LSM_HOOK_INIT(file_open, we_security_open_check),
+#endif
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE
+	LSM_HOOK_INIT(path_rename, we_security_rename_check),
+#endif
+#if defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_READ) || \
+	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_WRITE)
+	LSM_HOOK_INIT(file_permission, we_security_access_check),
+#endif
+#ifdef CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK
+	LSM_HOOK_INIT(task_alloc, we_task_alloc_check),
+	LSM_HOOK_INIT(task_free, we_task_free_check),
+#endif
+};
+
+static int __init we_init(void)
+{
+	int rc;
+
+	security_add_hooks(we_hooks, ARRAY_SIZE(we_hooks), "whiteegret");
+
+	rc = we_specific_init();
+	if (rc) {
+		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
+		return rc;
+	}
+
+	pr_warn("WhiteEgret (LSM) initialized.\n");
+
+	return 0;
+}
+
+static void __exit we_exit(void)
+{
+	we_specific_exit();
+
+	pr_warn("WhiteEgret (LSM) exited.\n");
+}
+
+module_init(we_init);
+module_exit(we_exit);
diff --git a/security/whiteegret/main.c b/security/whiteegret/main.c
new file mode 100644
index 0000000..cc531d0
--- /dev/null
+++ b/security/whiteegret/main.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#define pr_fmt(fmt) "WhiteEgret: " fmt
+
+#include <linux/binfmts.h>
+#include <linux/fs.h>
+#include <linux/mman.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include "we.h"
+#include "request.h"
+#include "we_fs.h"
+
+#include <linux/sched/signal.h>
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK
+/*
+ * This structure is registered exit process then task_free.
+ */
+struct we_obj_info_stack {
+	struct we_obj_info_stack *next;
+	struct we_obj_info we_obj_info;
+};
+static struct we_obj_info_stack *root_we_obj_info;
+static DEFINE_RWLOCK(root_we_obj_info_lock);
+#endif
+
+static int send_receive_we_obj_info(
+		struct we_obj_info *we_obj_info, int *checkresult);
+
+/**
+ * we_specific_init - Initialize fs.
+ *
+ * Returns 0.
+ */
+int we_specific_init(void)
+{
+	int rc = 0;
+
+	rc = we_fs_init();
+	if (rc < 0) {
+		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
+		return rc;
+	}
+	we_req_q_head_init();
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK
+	root_we_obj_info = NULL;
+#endif
+
+	return 0;
+}
+
+/**
+ * we_specific_exit - Nothing to do in the implementation.
+ *
+ * Returns 0.
+ */
+int we_specific_exit(void)
+{
+	return 0;
+}
+
+static inline void set_we_obj_from_task_info(struct we_obj_info *we_obj_info,
+					     struct task_struct *tsk)
+{
+	we_obj_info->req_user.pid = tsk->pid;
+	we_obj_info->req_user.tgid = tsk->tgid;
+	we_obj_info->req_user.ppid = task_ppid_nr(tsk);
+}
+
+static inline void set_we_obj_from_path_info(struct we_obj_info *we_obj_info,
+					     struct inode *inode,
+					     char *pathname)
+{
+	we_obj_info->fpath_kernel = pathname;
+	we_obj_info->req_user.info.ino = inode->i_ino;
+	we_obj_info->req_user.info.dmajor = MAJOR(inode->i_sb->s_dev);
+	we_obj_info->req_user.info.dminor = MINOR(inode->i_sb->s_dev);
+	we_obj_info->req_user.info.pathsize = strlen(pathname);
+}
+
+static int we_get_path(struct path *path,
+		       char **ret_pathname, char **ret_pathnamebuf)
+{
+	char *pathname = NULL, *pathnamebuf = NULL;
+	int pathsize = PAGE_SIZE;
+	int rc = 0;
+
+	if (!path || !path->dentry)
+		goto failure;
+
+	pathnamebuf = kmalloc(pathsize, GFP_KERNEL);
+	if (unlikely(!pathnamebuf)) {
+		rc = -ENOMEM;
+		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
+		goto failure;
+	}
+	if (path->dentry->d_op && path->dentry->d_op->d_dname)
+		pathname = path->dentry->d_op->d_dname
+			(path->dentry, pathnamebuf, pathsize - 1);
+	else
+		pathname = d_absolute_path(path, pathnamebuf,
+					   pathsize - 1);
+	if (IS_ERR(pathname)) {
+		rc = -ENOMEM;
+		pr_err("error %d and %ld at %d in %s\n",
+		       rc, PTR_ERR(pathname), __LINE__, __FILE__);
+		goto failure;
+	}
+ failure:
+	*ret_pathname = pathname;
+	*ret_pathnamebuf = pathnamebuf;
+	return rc;
+}
+
+/**
+ * we_check_main - Common function for security_bprm_check and mmap_file.
+ *
+ * @file: Pointer to struct file.
+ * @cmd: command infomation.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_check_main(struct path *path, int cmd)
+{
+	struct inode *inode;
+	struct we_obj_info we_obj_info;
+	char *pathnamebuf = NULL;
+	char *pathname;
+	int rc = 0;
+	int checkresult;
+
+	if (unlikely(!path) || unlikely(!path->dentry) ||
+	    unlikely(!path->dentry->d_inode))
+		goto failure;
+
+	rc = we_get_path(path, &pathname, &pathnamebuf);
+	if (rc != 0)
+		goto failure;
+
+	inode = path->dentry->d_inode;
+	set_we_obj_from_path_info(&we_obj_info, inode, pathname);
+	set_we_obj_from_task_info(&we_obj_info, current);
+	we_obj_info.req_user.cmd = cmd;
+
+	rc = send_receive_we_obj_info(&we_obj_info, &checkresult);
+	if (rc < 0)
+		goto failure;
+
+	rc = checkresult;
+
+	if (rc == -EACCES)
+		pr_warn("block %s, ino=%ld, devno=0x%x.\n",
+			pathname, we_obj_info.req_user.info.ino,
+			MKDEV(we_obj_info.req_user.info.dmajor,
+			      we_obj_info.req_user.info.dminor));
+	else
+		pr_info("permit %s, ino=%ld, devno=0x%x.\n",
+			pathname, we_obj_info.req_user.info.ino,
+			MKDEV(we_obj_info.req_user.info.dmajor,
+			      we_obj_info.req_user.info.dminor));
+
+failure:
+	kfree(pathnamebuf);
+	if ((rc != 0) && (rc != -EACCES))
+		pr_warn("Checking white list does not work.\n");
+
+	return rc;
+}
+
+/**
+ * send_receive_we_obj_info - Send message and wait.
+ *
+ * @we_obj_info: Pointer to struct we_obj_info.
+ * @result: Pointer to result of matching to white list.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+static int send_receive_we_obj_info(struct we_obj_info *we_obj_info,
+				    int *checkresult)
+{
+	int i;
+	int rc;
+	struct we_req_q req;
+	int is_signal;
+
+	we_req_q_init(&req, we_obj_info);
+
+	rc = we_req_q_push(&req);
+	if (rc < 0) {
+		pr_err("error %d at %d in %s\n", rc,
+		       __LINE__, __FILE__);
+		goto failure;
+	}
+
+	is_signal = 0;
+	for (i = 0; i < MAXCOMRETRY; i++) {
+		rc = send_we_obj_info(&req);
+
+		if (signal_pending(current)) {
+			is_signal = 1;
+			clear_tsk_thread_flag(current, TIF_SIGPENDING);
+		}
+
+		if (likely(req.finish_flag == START_EXEC))
+			break;
+	}
+
+	we_req_q_pop(&req);
+
+	if (is_signal)
+		set_tsk_thread_flag(current, TIF_SIGPENDING);
+
+	if (unlikely(i >= MAXCOMRETRY) && req.finish_flag != START_EXEC) {
+		pr_err("error %d at %d in %s\n", rc, __LINE__, __FILE__);
+		rc = -EINVAL;
+	}
+
+	*checkresult = req.permit;
+
+failure:
+	return rc;
+}
+
+/**
+ * we_security_bprm_check_main - Target for security_bprm_check.
+ *
+ * @bprm: Pointer to struct linux_binprm.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_security_bprm_check_main(struct linux_binprm *bprm)
+{
+	if (unlikely(!from_task) || unlikely(!bprm->file))
+		return 0;
+
+	return we_check_main(&bprm->file->f_path, CONTROL_EXEC);
+}
+
+/**
+ * we_security_mmap_check_main - Target for mmap_file.
+ *
+ * @file: Pointer to struct file to map.
+ * @reqprot: Protection requested by the application.
+ * @flags: Operational flags.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_security_mmap_check_main(struct file *file,
+				unsigned long reqprot, unsigned long flags)
+{
+	int ret = 0;
+
+	if (unlikely(!from_task))
+		return 0;
+
+	if ((flags & MAP_EXECUTABLE))
+		return 0;
+
+	if (reqprot & PROT_EXEC) {
+		ret = we_check_main(&file->f_path, CONTROL_EXEC);
+		if (ret != 0)
+			goto END;
+	}
+
+ END:
+	return ret;
+}
+
+#if defined(CONFIG_SECURITY_WHITEEGRET_HOOK_READ_OPEN) || \
+	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE_OPEN)
+/**
+ * we_security_open_check_main - Target for open_file.
+ *
+ * @file: Pointer to struct file to open.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_security_open_check_main(struct file *file)
+{
+	int ret = 0;
+
+	if (unlikely(!from_task) || from_task == current)
+		goto END;
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_READ_OPEN
+	if (!(file->f_flags & O_WRONLY)) {
+		ret = we_check_main(&file->f_path, CONTROL_READ);
+		if (ret != 0)
+			goto END;
+	}
+#endif
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE_OPEN
+	if (file->f_flags & (O_ACCMODE))
+		ret = we_check_main(&file->f_path, CONTROL_WRITE);
+#endif
+
+ END:
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_WRITE
+/**
+ * we_security_rename_check_main - Target for path_rename.
+ *
+ * @new_path: Pointer to struct path of destination file.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_security_rename_check_main(struct path *new_path)
+{
+	int ret = 0;
+
+	if (unlikely(!from_task))
+		goto END;
+	if (unlikely(!new_path->dentry))
+		goto END;
+	/*
+	 * Notifying information is rename destination file,
+	 * not include information of rename source file.
+	 */
+	ret = we_check_main(new_path, CONTROL_WRITE);
+ END:
+	return ret;
+}
+#endif
+
+#if defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_READ) || \
+	defined(CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_WRITE)
+/**
+ * we_security_access_check_main - Target for file_permission.
+ *
+ * @file: Pointer to struct file to access.
+ * @mask: Access infomation.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_security_access_check_main(struct file *file, int mask)
+{
+	int ret = 0;
+
+	if (unlikely(!from_task) || from_task == current)
+		goto END;
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_READ
+	if (mask & MAY_READ) {
+		ret = we_check_main(&file->f_path, CONTROL_READ);
+		if (ret != 0)
+			goto END;
+	}
+#endif
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_HOOK_FILE_WIRTE
+	if (mask & MAY_WRITE)
+		ret = we_check_main(&file->f_path, CONTROL_WRITE);
+#endif
+
+ END:
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_SECURITY_WHITEEGRET_CHECK_LIVING_TASK
+/**
+ * we_security_task_alloc_check_main - Target for task_alloc.
+ *
+ * @task: Pointer to struct task creating now.
+ * @clone_flags: infomation of creating task.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int we_security_task_alloc_check_main(struct task_struct *task,
+				      unsigned long clone_flags)
+{
+	int checkresult = 0, rc = 0;
+	struct we_obj_info_stack *node;
+
+	if (unlikely(!from_task))
+		return 0;
+
+	/*
+	 * This location notifies exiting task to
+	 * the WhiteEgret User Application.
+	 */
+	while (1) {
+		write_lock(&root_we_obj_info_lock);
+		if (root_we_obj_info) {
+			node = root_we_obj_info;
+			root_we_obj_info = root_we_obj_info->next;
+			write_unlock(&root_we_obj_info_lock);
+			if (likely(from_task))
+				rc = send_receive_we_obj_info
+					(&node->we_obj_info, &checkresult);
+			kfree(node);
+		} else {
+			write_unlock(&root_we_obj_info_lock);
+			break;
+		}
+	}
+
+	/*
+	 * This location notify fork to the WhiteEgret User Application.
+	 * Notifying infomation is exit process infomation, not include
+	 * file information.
+	 */
+	if (!(clone_flags & CLONE_THREAD)) {
+		struct we_obj_info info = {};
+
+		set_we_obj_from_task_info(&info, current);
+		info.req_user.cmd = CONTROL_FORK;
+		rc = send_receive_we_obj_info(&info, &checkresult);
+	}
+	return 0;
+}
+
+/**
+ * we_security_task_free_check_main - Target for task_free.
+ *
+ * @task: Pointer to struct task destroying now.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+void we_security_task_free_check_main(struct task_struct *task)
+{
+	struct we_obj_info_stack *node;
+
+	if (unlikely(!from_task) || from_task == task)
+		return;
+
+	if (get_nr_threads(task) > 1)
+		return;
+
+	node = kzalloc(sizeof(*node), GFP_ATOMIC);
+	if (!node)
+		return;
+
+	set_we_obj_from_task_info(&node->we_obj_info, task);
+	node->we_obj_info.req_user.cmd = CONTROL_EXIT;
+
+	/*
+	 * This location records exiting task.
+	 * The kernel prints warning when communicating to
+	 * the WhiteEgret User Application, threfore
+	 * we_security_task_alloc_check_main() notify exiting task to
+	 * the WhiteEgret User Application before notification of crating task.
+	 * Notifying infomation is exit process infomation, not include
+	 * file information.
+	 */
+	write_lock(&root_we_obj_info_lock);
+	node->next = root_we_obj_info;
+	root_we_obj_info = node;
+	write_unlock(&root_we_obj_info_lock);
+}
+#endif
diff --git a/security/whiteegret/request.c b/security/whiteegret/request.c
new file mode 100644
index 0000000..8d230cb
--- /dev/null
+++ b/security/whiteegret/request.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#include "request.h"
+#include "we.h"
+
+struct we_req_q_head we_q_head;
+
+/**
+ * we_req_q_head_init - Initialize the global variable we_q_head.
+ *
+ * Returns 0.
+ */
+int we_req_q_head_init(void)
+{
+	rwlock_init(&(we_q_head.lock));
+	INIT_LIST_HEAD(&(we_q_head.head));
+	init_waitqueue_head(&(we_q_head.waitq));
+
+	return 0;
+}
+
+/**
+ * we_req_q_push - Add queue to tail of the list.
+ *
+ * @queue: Pointer to we_req_q to be added to the list.
+ *
+ * Returns 0.
+ */
+int we_req_q_push(struct we_req_q *queue)
+{
+	write_lock(&(we_q_head.lock));
+	list_add_tail(&(queue->queue), &we_q_head.head);
+	write_unlock(&(we_q_head.lock));
+
+	return 0;
+}
+
+/**
+ * we_req_q_init - Initialize queue.
+ *
+ * @req: Pointer to we_req_q to be initialized.
+ * @info: Pointer to we_obj_info.
+ *
+ * Returns 0.
+ */
+int we_req_q_init(struct we_req_q *req, struct we_obj_info *info)
+{
+	req->finish_flag = STOP_EXEC;
+	req->we_obj_info = info;
+	req->permit = -EACCES;
+	init_waitqueue_head(&req->waitq);
+
+	return 0;
+}
+
+/**
+ * we_req_q_pop - Delete queue in the list.
+ *
+ * Returns 0.
+ */
+int we_req_q_pop(struct we_req_q *queue)
+{
+	write_lock(&(we_q_head.lock));
+	list_del(&queue->queue);
+	write_unlock(&(we_q_head.lock));
+
+	return 0;
+}
+
+/**
+ * we_req_q_cleanup - Cleaning up queues.
+ *
+ * Returns 0.
+ */
+int we_req_q_cleanup(void)
+{
+	struct list_head *p;
+	struct we_req_q *req;
+
+	write_lock(&(we_q_head.lock));
+	list_for_each(p, &we_q_head.head) {
+		req = list_entry(p, struct we_req_q, queue);
+		req->finish_flag = START_EXEC;
+		req->permit = -EINVAL;
+	}
+	write_unlock(&(we_q_head.lock));
+
+	return 0;
+}
diff --git a/security/whiteegret/request.h b/security/whiteegret/request.h
new file mode 100644
index 0000000..c205c4c
--- /dev/null
+++ b/security/whiteegret/request.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#ifndef _REQUEST_H
+#define _REQUEST_H
+
+#include <linux/wait.h>
+#include <linux/list.h>
+
+struct we_obj_info;
+
+struct we_req_q_head {
+	struct list_head head;
+	rwlock_t lock;
+	wait_queue_head_t waitq;
+};
+
+
+#define STOP_EXEC  0
+#define START_EXEC 1
+
+extern struct we_req_q_head we_q_head;
+
+struct we_req_q {
+	struct list_head queue;
+	int finish_flag;
+	struct we_obj_info *we_obj_info;
+	int permit;
+	wait_queue_head_t waitq;
+};
+
+int we_req_q_pop(struct we_req_q *queue);
+int we_req_q_cleanup(void);
+
+int we_req_q_head_init(void);
+int we_req_q_init(struct we_req_q *req, struct we_obj_info *info);
+int we_req_q_push(struct we_req_q *queue);
+
+#endif  /* _REQUEST_H */
diff --git a/security/whiteegret/we.h b/security/whiteegret/we.h
new file mode 100644
index 0000000..e8f067c
--- /dev/null
+++ b/security/whiteegret/we.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#ifndef _WE_H
+#define _WE_H
+
+#include "we_fs_common.h"
+
+/*
+ * Initial size in byte of memory allocation to store the path
+ * of an object file
+ */
+#define EXPECTPATHSIZE 1023
+
+/*
+ * Default size in byte to expand block that stores the path
+ * of an object file when the memory block is too small
+ * to store the path
+ */
+#define ADDEDEXPECTPATHSIZE 1023
+
+/* Maximum length in byte of path of object file */
+#define MAXPATHSIZE 8184
+
+/* Maximum length in byte of name of executable file */
+#define SHORTNAMELENGTH 256
+
+/*
+ * Maximum number of retry for sending the same message
+ * to user whitelisting application
+ */
+#define MAXCOMRETRY 10
+
+/* Timeout value in millisecond to aquire the semaphore */
+#define WERESULTTIMEOUT 1000
+
+/*
+ * Structure for an object to be tested whether it is contained
+ * in the whitelist or not
+ */
+struct we_obj_info {
+	char *fpath_kernel;
+	struct we_req_user req_user;
+};
+
+struct path;
+struct linux_binprm;
+struct file;
+struct task_struct;
+
+int we_security_bprm_check_main(struct linux_binprm *bprm);
+int we_security_mmap_check_main(struct file *file,
+				unsigned long reqprot, unsigned long flags);
+int we_security_open_check_main(struct file *file);
+int we_security_rename_check_main(struct path *new_path);
+int we_security_access_check_main(struct file *file, int mask);
+int we_security_task_alloc_check_main(struct task_struct *task,
+				      unsigned long clone_flags);
+void we_security_task_free_check_main(struct task_struct *task);
+
+int we_specific_init(void);
+int we_specific_exit(void);
+
+#endif  /* _WE_H */
diff --git a/security/whiteegret/we_fs.c b/security/whiteegret/we_fs.c
new file mode 100644
index 0000000..57f77aa
--- /dev/null
+++ b/security/whiteegret/we_fs.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#define pr_fmt(fmt) "WhiteEgret: " fmt
+
+#include <linux/security.h>
+#include <linux/fs.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include "we_fs.h"
+#include "we.h"
+
+struct task_struct *from_task;
+static DEFINE_RWLOCK(from_task_lock);
+
+static int check_we_pathsize(struct we_req_q *we_req, int size)
+{
+	if (size - sizeof(*we_req)
+	    > we_req->we_obj_info->req_user.info.pathsize)
+		return 0;
+	else
+		return -1;
+}
+
+static int set_we_req_info(struct we_req_user *user,
+		struct we_obj_info *info)
+{
+	unsigned long ret;
+
+	ret = copy_to_user(user, &info->req_user, sizeof(*user));
+	if (ret != 0)
+		return -EFAULT;
+	if (info->req_user.info.pathsize) {
+		ret = copy_to_user(user->info.path, info->fpath_kernel,
+				   info->req_user.info.pathsize + 1);
+		if (ret != 0)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int set_we_ack(struct we_ack *to, struct we_ack *from)
+{
+	unsigned long ret;
+
+	ret = copy_from_user(to, from, sizeof(*to));
+	if (ret != 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static struct we_req_user *get_alive_we_req(void *buf, int size)
+{
+	int pathsize;
+	struct list_head *p;
+	struct we_req_q *req;
+	struct we_req_user *user = NULL;
+
+	write_lock(&we_q_head.lock);
+	list_for_each(p, &we_q_head.head) {
+		req = list_entry(p, struct we_req_q, queue);
+		if (req->finish_flag == STOP_EXEC) {
+			if (unlikely(check_we_pathsize(req, size)))
+				goto SIZE_ERROR;
+			user = (struct we_req_user *)buf;
+			set_we_req_info(user, req->we_obj_info);
+			break;
+		}
+	}
+	write_unlock(&we_q_head.lock);
+
+	return user;
+SIZE_ERROR:
+	pathsize = req->we_obj_info->req_user.info.pathsize;
+	req->permit = -EACCES;
+	req->finish_flag = START_EXEC;
+	write_unlock(&we_q_head.lock);
+	pr_err("Path length of exec is too long (%d).\n", pathsize);
+	return NULL;
+}
+
+static ssize_t send_ack(struct we_ack *ack)
+{
+	struct list_head *p;
+	struct we_req_q *req = NULL, *temp;
+
+	write_lock(&we_q_head.lock);
+	list_for_each(p, &we_q_head.head) {
+		temp = list_entry(p, struct we_req_q, queue);
+		if ((temp->we_obj_info->req_user.tgid == ack->tgid)
+				&& (temp->finish_flag != START_EXEC)) {
+			req = temp;
+			req->permit = ack->permit;
+			req->finish_flag = START_EXEC;
+			wake_up_interruptible_sync(&req->waitq);
+			break;
+		}
+	}
+	write_unlock(&we_q_head.lock);
+
+	if (unlikely(!req)) {
+		pr_warn("%s: can not find we_req. pid(%d)\n",
+			__func__, ack->tgid);
+		return -EACCES;
+	}
+	return sizeof(*ack);
+}
+
+static ssize_t we_driver_read(struct file *file, char *buf,
+		size_t size, loff_t *off)
+{
+	int ret;
+	struct we_req_user *user;
+
+	while (1) {
+		ret = wait_event_interruptible(we_q_head.waitq,
+				(user = get_alive_we_req(buf, size)));
+		if (unlikely(ret < 0)) {
+			pr_info("%s: signal (%d)", __func__, ret);
+			return 0;
+		}
+		if (likely(user))
+			break;
+	}
+
+	return 1;
+}
+
+static ssize_t we_driver_write(struct file *file, const char *buf,
+		size_t size, loff_t *off)
+{
+	int rc;
+	ssize_t ret;
+	struct we_ack ack;
+
+	rc = set_we_ack(&ack, (struct we_ack *)((void *)buf));
+	if (rc < 0)
+		return (ssize_t)rc;
+	ret = send_ack(&ack);
+
+	return ret;
+}
+
+static long we_driver_ioctl(struct file *file,
+		unsigned int arg0, unsigned long arg1)
+{
+	int ret;
+
+	switch (arg0) {
+		/* ask the kernel if it has more than one request */
+	case WE_IOCTL_CHECK_HAS_REQUEST:
+		ret = 0;
+		if (!list_empty(&we_q_head.head)) {
+			struct list_head *p;
+			struct we_req_q *temp;
+
+			read_lock(&we_q_head.lock);
+			list_for_each(p, &we_q_head.head) {
+				temp = list_entry(p, struct we_req_q, queue);
+				if (temp->finish_flag != START_EXEC) {
+					ret = 1;
+					break;
+				}
+			}
+			read_unlock(&we_q_head.lock);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int we_driver_release(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+
+	write_lock(&from_task_lock);
+	if (!from_task) {
+		pr_warn("WhiteEgret has not started.\n");
+		ret =  -EACCES;
+		goto END;
+	}
+	if (from_task != current) {
+		pr_warn("This task is not registered to WhiteEgret.\n");
+		ret = -EACCES;
+		goto END;
+	}
+	from_task = NULL;
+	we_req_q_cleanup();
+END:
+	write_unlock(&from_task_lock);
+	return ret;
+}
+
+static int we_driver_open(struct inode *inode, struct file *filp)
+{
+	write_lock(&from_task_lock);
+	if (from_task) {
+		write_unlock(&(from_task_lock));
+		pr_warn("WhiteEgret has already started.\n");
+		return -EACCES;
+	}
+
+	from_task = current;
+	write_unlock(&from_task_lock);
+
+	return 0;
+}
+
+static const struct file_operations we_driver_fops = {
+	.owner = THIS_MODULE,
+	.read = we_driver_read,
+	.write = we_driver_write,
+	.unlocked_ioctl = we_driver_ioctl,
+	.open =  we_driver_open,
+	.release = we_driver_release,
+};
+
+int we_fs_init(void)
+{
+	struct dentry *we_dir;
+	struct dentry *wecom;
+
+	we_dir = securityfs_create_dir(WE_FS_DIR_NAME, NULL);
+	if (IS_ERR(we_dir))
+		return PTR_ERR(we_dir);
+
+	wecom = securityfs_create_file(WE_DEV_NAME, 0600, we_dir,
+				       NULL, &we_driver_fops);
+	if (IS_ERR(wecom)) {
+		securityfs_remove(we_dir);
+		return PTR_ERR(wecom);
+	}
+
+	return 0;
+}
+
+/**
+ * send_we_obj_info - Wait response from user's whitelisting application.
+ *
+ * @req: Pointer to struct we_req_q.
+ *
+ * Returns 0 if succeeded, < 0 otherwise.
+ */
+int send_we_obj_info(struct we_req_q *req)
+{
+	/* If there exists queue waiting for this request req done,
+	 * then wake it up.
+	 */
+	if (waitqueue_active(&(we_q_head.waitq)))
+		wake_up(&(we_q_head.waitq));
+
+	return wait_event_interruptible_timeout(req->waitq,
+			(req->finish_flag == START_EXEC),
+			WERESULTTIMEOUT);
+}
diff --git a/security/whiteegret/we_fs.h b/security/whiteegret/we_fs.h
new file mode 100644
index 0000000..ffb7775
--- /dev/null
+++ b/security/whiteegret/we_fs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#ifndef _WE_FS_H
+#define _WE_FS_H
+
+#include "request.h"
+#include "we_fs_common.h"
+
+extern struct task_struct *from_task;
+
+int we_fs_init(void);
+int send_we_obj_info(struct we_req_q *req);
+
+#endif  /* _WE_FS_H */
diff --git a/security/whiteegret/we_fs_common.h b/security/whiteegret/we_fs_common.h
new file mode 100644
index 0000000..ba5804b
--- /dev/null
+++ b/security/whiteegret/we_fs_common.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * WhiteEgret Linux Security Module
+ *
+ * Copyright (C) 2017-2018 Toshiba Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation, version 2.
+ */
+
+#ifndef _WE_FS_COMMON_H
+#define _WE_FS_COMMON_H
+
+#define WE_FS_DIR_NAME "whiteegret"
+#define WE_DEV_NAME "wecom"
+#define WE_DEV_PATH "/sys/kernel/security/"WE_FS_DIR_NAME"/"WE_DEV_NAME
+
+/* Control nothing*/
+#define CONTROL_NONE	0x00
+/* Control execution of executables */
+#define CONTROL_EXEC	0x01
+/* Control read of files */
+#define CONTROL_READ	0x02
+/* Check exit task */
+#define CONTROL_EXIT	0x04
+/* Check open for write */
+#define CONTROL_WRITE	0x08
+/* Check clone task */
+#define CONTROL_FORK	0x10
+
+/* permit LSM function */
+#define WE_EXEC_OK	0
+
+/* ioctl request number */
+/* ask the kernel if it has more than one request */
+#define WE_IOCTL_CHECK_HAS_REQUEST 1000
+
+struct target_info {
+	unsigned long ino; /* inode number */
+	unsigned int dmajor; /* major version of device number */
+	unsigned int dminor; /* minor version of device number */
+	int pathsize;
+	char path[0];
+};
+
+struct we_req_user {
+	int cmd;
+	pid_t pid;
+	pid_t ppid;
+	pid_t tgid;
+	struct target_info info;
+};
+
+struct we_ack {
+	int permit;
+	pid_t tgid;
+};
+
+#endif  /* _WE_FS_COMMON_H */
-- 
2.7.4

