Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeEMB7w (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 21:59:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752045AbeEMB7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 21:59:49 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak81 RFC V2 5/5] audit: collect audit task parameters
Date: Sat, 12 May 2018 21:58:22 -0400
Message-Id: <90031e185e85e5e327aaafb40882d2e3e52ea4c8.1526173613.git.rgb@redhat.com>
In-Reply-To: <cover.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
In-Reply-To: <cover.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit-related parameters in struct task_struct should ideally be
collected together and accessed through a standard audit API.

Collect the existing loginuid, sessionid and audit_context together in a
new struct audit_task_info called "audit" in struct task_struct.

See: https://github.com/linux-audit/audit-kernel/issues/81

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 MAINTAINERS                |  2 +-
 include/linux/audit.h      | 10 +++++-----
 include/linux/audit_task.h | 31 +++++++++++++++++++++++++++++++
 include/linux/sched.h      |  6 ++----
 init/init_task.c           |  7 +++++--
 kernel/auditsc.c           |  6 +++---
 6 files changed, 47 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/audit_task.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d..8c7992d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2510,7 +2510,7 @@ L:	linux-audit@redhat.com (moderated for non-subscribers)
 W:	https://github.com/linux-audit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 S:	Supported
-F:	include/linux/audit.h
+F:	include/linux/audit*.h
 F:	include/uapi/linux/audit.h
 F:	kernel/audit*
 
diff --git a/include/linux/audit.h b/include/linux/audit.h
index f7973e4..6d599b6 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -237,11 +237,11 @@ extern void __audit_inode_child(struct inode *parent,
 
 static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
 {
-	task->audit_context = ctx;
+	task->audit.ctx = ctx;
 }
 static inline struct audit_context *audit_context(void)
 {
-	return current->audit_context;
+	return current->audit.ctx;
 }
 static inline bool audit_dummy_context(void)
 {
@@ -250,7 +250,7 @@ static inline bool audit_dummy_context(void)
 }
 static inline void audit_free(struct task_struct *task)
 {
-	if (unlikely(task->audit_context))
+	if (unlikely(task->audit.ctx))
 		__audit_free(task);
 }
 static inline void audit_syscall_entry(int major, unsigned long a0,
@@ -330,12 +330,12 @@ extern int auditsc_get_stamp(struct audit_context *ctx,
 
 static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
 {
-	return tsk->loginuid;
+	return tsk->audit.loginuid;
 }
 
 static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
 {
-	return tsk->sessionid;
+	return tsk->audit.sessionid;
 }
 
 extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
diff --git a/include/linux/audit_task.h b/include/linux/audit_task.h
new file mode 100644
index 0000000..d4b3a20
--- /dev/null
+++ b/include/linux/audit_task.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* audit_task.h -- definition of audit_task_info structure
+ *
+ * Copyright 2018 Red Hat Inc., Raleigh, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Written by Richard Guy Briggs <rgb@redhat.com>
+ *
+ */
+
+#ifndef _LINUX_AUDIT_TASK_H_
+#define _LINUX_AUDIT_TASK_H_
+
+struct audit_context;
+struct audit_task_info {
+	kuid_t			loginuid;
+	unsigned int		sessionid;
+	struct audit_context	*ctx;
+};
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f..b58eca0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -27,9 +27,9 @@
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/audit_task.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
-struct audit_context;
 struct backing_dev_info;
 struct bio_list;
 struct blk_plug;
@@ -832,10 +832,8 @@ struct task_struct {
 
 	struct callback_head		*task_works;
 
-	struct audit_context		*audit_context;
 #ifdef CONFIG_AUDITSYSCALL
-	kuid_t				loginuid;
-	unsigned int			sessionid;
+	struct audit_task_info		audit;
 #endif
 	struct seccomp			seccomp;
 
diff --git a/init/init_task.c b/init/init_task.c
index 74f60ba..d33260d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -119,8 +119,11 @@ struct task_struct init_task
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
 #ifdef CONFIG_AUDITSYSCALL
-	.loginuid	= INVALID_UID,
-	.sessionid	= AUDIT_SID_UNSET,
+	.audit		= {
+		.loginuid	= INVALID_UID,
+		.sessionid	= AUDIT_SID_UNSET,
+		.ctx		= NULL,
+	},
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	.perf_event_mutex = __MUTEX_INITIALIZER(init_task.perf_event_mutex),
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d441d68..4c1fd18 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -836,7 +836,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
 						      int return_valid,
 						      long return_code)
 {
-	struct audit_context *context = tsk->audit_context;
+	struct audit_context *context = tsk->audit.ctx;
 
 	if (!context)
 		return NULL;
@@ -2066,8 +2066,8 @@ int audit_set_loginuid(kuid_t loginuid)
 			sessionid = (unsigned int)atomic_inc_return(&session_id);
 	}
 
-	task->sessionid = sessionid;
-	task->loginuid = loginuid;
+	task->audit.sessionid = sessionid;
+	task->audit.loginuid = loginuid;
 out:
 	audit_log_set_loginuid(oldloginuid, loginuid, oldsessionid, sessionid, rc);
 	return rc;
-- 
1.8.3.1
