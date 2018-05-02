Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEBPyl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:54:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54892 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEBPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:54:35 -0400
From: Tyler Hicks <tyhicks@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 4/4] seccomp: Don't special case audited processes when logging
Date: Wed,  2 May 2018 15:53:20 +0000
Message-Id: <1525276400-7161-5-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seccomp logging for "handled" actions such as RET_TRAP, RET_TRACE, or
RET_ERRNO can be very noisy for processes that are being audited. This
patch modifies the seccomp logging behavior to treat processes that are
being inspected via the audit subsystem the same as processes that
aren't under inspection. Handled actions will no longer be logged just
because the process is being inspected. Since v4.14, applications have
the ability to request logging of handled actions by using the
SECCOMP_FILTER_FLAG_LOG flag when loading seccomp filters.

With this patch, the logic for deciding if an action will be logged is:

  if action == RET_ALLOW:
    do not log
  else if action not in actions_logged:
    do not log
  else if action == RET_KILL:
    log
  else if action == RET_LOG:
    log
  else if filter-requests-logging:
    log
  else:
    do not log

Reported-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 Documentation/userspace-api/seccomp_filter.rst |  7 -------
 include/linux/audit.h                          | 10 +---------
 kernel/auditsc.c                               | 14 +++++++++++++-
 kernel/seccomp.c                               | 15 +++++----------
 4 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index 099c412..82a468b 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -207,13 +207,6 @@ directory. Here's a description of each file in that directory:
 	to the file do not need to be in ordered form but reads from the file
 	will be ordered in the same way as the actions_avail sysctl.
 
-	It is important to note that the value of ``actions_logged`` does not
-	prevent certain actions from being logged when the audit subsystem is
-	configured to audit a task. If the action is not found in
-	``actions_logged`` list, the final decision on whether to audit the
-	action for that task is ultimately left up to the audit subsystem to
-	decide for all seccomp return values other than ``SECCOMP_RET_ALLOW``.
-
 	The ``allow`` string is not accepted in the ``actions_logged`` sysctl
 	as it is not possible to log ``SECCOMP_RET_ALLOW`` actions. Attempting
 	to write ``allow`` to the sysctl will result in an EINVAL being
diff --git a/include/linux/audit.h b/include/linux/audit.h
index d4e35e7..b639cf1 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -232,7 +232,7 @@ extern void __audit_file(const struct file *);
 extern void __audit_inode_child(struct inode *parent,
 				const struct dentry *dentry,
 				const unsigned char type);
-extern void __audit_seccomp(unsigned long syscall, long signr, int code);
+extern void audit_seccomp(unsigned long syscall, long signr, int code);
 extern void audit_seccomp_actions_logged(const char *names,
 					 const char *old_names, int res);
 extern void __audit_ptrace(struct task_struct *t);
@@ -304,12 +304,6 @@ static inline void audit_inode_child(struct inode *parent,
 }
 void audit_core_dumps(long signr);
 
-static inline void audit_seccomp(unsigned long syscall, long signr, int code)
-{
-	if (audit_enabled && unlikely(!audit_dummy_context()))
-		__audit_seccomp(syscall, signr, code);
-}
-
 static inline void audit_ptrace(struct task_struct *t)
 {
 	if (unlikely(!audit_dummy_context()))
@@ -500,8 +494,6 @@ static inline void audit_inode_child(struct inode *parent,
 { }
 static inline void audit_core_dumps(long signr)
 { }
-static inline void __audit_seccomp(unsigned long syscall, long signr, int code)
-{ }
 static inline void audit_seccomp(unsigned long syscall, long signr, int code)
 { }
 static inline void audit_seccomp_actions_logged(const char *names,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 5a0b770..1512832 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2464,7 +2464,19 @@ void audit_core_dumps(long signr)
 	audit_log_end(ab);
 }
 
-void __audit_seccomp(unsigned long syscall, long signr, int code)
+/**
+ * audit_seccomp - record information about a seccomp action
+ * @syscall: syscall number
+ * @signr: signal value
+ * @code: the seccomp action
+ *
+ * Record the information associated with a seccomp action. Event filtering for
+ * seccomp actions that are not to be logged is done in seccomp_log().
+ * Therefore, this function forces auditing independent of the audit_enabled
+ * and dummy context state because seccomp actions should be logged even when
+ * audit is not in use.
+ */
+void audit_seccomp(unsigned long syscall, long signr, int code)
 {
 	struct audit_buffer *ab;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index da78835..9029d9d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -584,18 +584,13 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
 	}
 
 	/*
-	 * Force an audit message to be emitted when the action is RET_KILL_*,
-	 * RET_LOG, or the FILTER_FLAG_LOG bit was set and the action is
-	 * allowed to be logged by the admin.
+	 * Emit an audit message when the action is RET_KILL_*, RET_LOG, or the
+	 * FILTER_FLAG_LOG bit was set. The admin has the ability to silence
+	 * any action from being logged by removing the action name from the
+	 * seccomp_actions_logged sysctl.
 	 */
 	if (log)
-		return __audit_seccomp(syscall, signr, action);
-
-	/*
-	 * Let the audit subsystem decide if the action should be audited based
-	 * on whether the current task itself is being audited.
-	 */
-	return audit_seccomp(syscall, signr, action);
+		audit_seccomp(syscall, signr, action);
 }
 
 /*
-- 
2.7.4
