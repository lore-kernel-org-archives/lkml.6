Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeEBPy7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:54:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54884 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeEBPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:54:33 -0400
From: Tyler Hicks <tyhicks@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/4] seccomp: Audit attempts to modify the actions_logged sysctl
Date: Wed,  2 May 2018 15:53:19 +0000
Message-Id: <1525276400-7161-4-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decision to log a seccomp action will always be subject to the
value of the kernel.seccomp.actions_logged sysctl, even for processes
that are being inspected via the audit subsystem, in an upcoming patch.
Therefore, we need to emit an audit record on attempts at writing to the
actions_logged sysctl when auditing is enabled.

This patch updates the write handler for the actions_logged sysctl to
emit an audit record on attempts to write to the sysctl. Successful
writes to the sysctl will result in a record that includes a normalized
list of logged actions in the "actions" field and a "res" field equal to
0. Unsuccessful writes to the sysctl will result in a record that
doesn't include the "actions" field and has a "res" field equal to 1.

Not all unsuccessful writes to the sysctl are audited. For example, an
audit record will not be emitted if an unprivileged process attempts to
open the sysctl file for reading since that access control check is not
part of the sysctl's write handler.

Below are some example audit records when writing various strings to the
actions_logged sysctl.

Writing "not-a-real-action", when the kernel.seccomp.actions_logged
sysctl previously was "kill_process kill_thread trap errno trace log",
emits this audit record:

 type=CONFIG_CHANGE msg=audit(1525275273.537:130): op=seccomp-logging
 old-actions=kill_process,kill_thread,trap,errno,trace,log res=0

If you then write "kill_process kill_thread errno trace log", this audit
record is emitted:

 type=CONFIG_CHANGE msg=audit(1525275310.208:136): op=seccomp-logging
 actions=kill_process,kill_thread,errno,trace,log
 old-actions=kill_process,kill_thread,trap,errno,trace,log res=1

If you then write the string "log log errno trace kill_process
kill_thread", which is unordered and contains the log action twice,
it results in the same actions value as the previous record:

 type=CONFIG_CHANGE msg=audit(1525275325.613:142): op=seccomp-logging
 actions=kill_process,kill_thread,errno,trace,log
 old-actions=kill_process,kill_thread,errno,trace,log res=1

No audit records are generated when reading the actions_logged sysctl.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 include/linux/audit.h |  5 +++++
 kernel/auditsc.c      | 25 +++++++++++++++++++++++++
 kernel/seccomp.c      | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 75d5b03..d4e35e7 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -233,6 +233,8 @@ extern void __audit_inode_child(struct inode *parent,
 				const struct dentry *dentry,
 				const unsigned char type);
 extern void __audit_seccomp(unsigned long syscall, long signr, int code);
+extern void audit_seccomp_actions_logged(const char *names,
+					 const char *old_names, int res);
 extern void __audit_ptrace(struct task_struct *t);
 
 static inline bool audit_dummy_context(void)
@@ -502,6 +504,9 @@ static inline void __audit_seccomp(unsigned long syscall, long signr, int code)
 { }
 static inline void audit_seccomp(unsigned long syscall, long signr, int code)
 { }
+static inline void audit_seccomp_actions_logged(const char *names,
+						const char *old_names, int res)
+{ }
 static inline int auditsc_get_stamp(struct audit_context *ctx,
 			      struct timespec64 *t, unsigned int *serial)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4e0a4ac..5a0b770 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2478,6 +2478,31 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 	audit_log_end(ab);
 }
 
+void audit_seccomp_actions_logged(const char *names, const char *old_names,
+				  int res)
+{
+	struct audit_buffer *ab;
+
+	if (!audit_enabled)
+		return;
+
+	ab = audit_log_start(current->audit_context, GFP_KERNEL,
+			     AUDIT_CONFIG_CHANGE);
+	if (unlikely(!ab))
+		return;
+
+	audit_log_format(ab, "op=seccomp-logging");
+
+	if (names)
+		audit_log_format(ab, " actions=%s", names);
+
+	if (old_names)
+		audit_log_format(ab, " old-actions=%s", old_names);
+
+	audit_log_format(ab, " res=%d", res);
+	audit_log_end(ab);
+}
+
 struct list_head *audit_killed_trees(void)
 {
 	struct audit_context *ctx = current->audit_context;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b36ac1e..da78835 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1219,11 +1219,10 @@ static int read_actions_logged(struct ctl_table *ro_table, void __user *buffer,
 }
 
 static int write_actions_logged(struct ctl_table *ro_table, void __user *buffer,
-				size_t *lenp, loff_t *ppos)
+				size_t *lenp, loff_t *ppos, u32 *actions_logged)
 {
 	char names[sizeof(seccomp_actions_avail)];
 	struct ctl_table table;
-	u32 actions_logged;
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1238,24 +1237,58 @@ static int write_actions_logged(struct ctl_table *ro_table, void __user *buffer,
 	if (ret)
 		return ret;
 
-	if (!seccomp_actions_logged_from_names(&actions_logged, table.data))
+	if (!seccomp_actions_logged_from_names(actions_logged, table.data))
 		return -EINVAL;
 
-	if (actions_logged & SECCOMP_LOG_ALLOW)
+	if (*actions_logged & SECCOMP_LOG_ALLOW)
 		return -EINVAL;
 
-	seccomp_actions_logged = actions_logged;
+	seccomp_actions_logged = *actions_logged;
 	return 0;
 }
 
+static void audit_actions_logged(u32 actions_logged, u32 old_actions_logged,
+				 int ret)
+{
+	char names[sizeof(seccomp_actions_avail)];
+	char old_names[sizeof(seccomp_actions_avail)];
+	const char *new = names;
+	const char *old = old_names;
+
+	if (!audit_enabled)
+		return;
+
+	memset(names, 0, sizeof(names));
+	memset(old_names, 0, sizeof(old_names));
+
+	if (ret || !seccomp_names_from_actions_logged(names, sizeof(names),
+						      actions_logged, ","))
+		new = NULL;
+
+	if (!seccomp_names_from_actions_logged(old_names, sizeof(old_names),
+					       old_actions_logged, ","))
+		old = NULL;
+
+	return audit_seccomp_actions_logged(new, old, !ret);
+}
+
 static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
 					  void __user *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	if (write)
-		return write_actions_logged(ro_table, buffer, lenp, ppos);
-	else
-		return read_actions_logged(ro_table, buffer, lenp, ppos);
+	int ret;
+
+	if (write) {
+		u32 actions_logged = 0;
+		u32 old_actions_logged = seccomp_actions_logged;
+
+		ret = write_actions_logged(ro_table, buffer, lenp, ppos,
+					   &actions_logged);
+		audit_actions_logged(actions_logged, old_actions_logged, ret);
+	} else
+		ret = read_actions_logged(ro_table, buffer, lenp, ppos);
+
+	return ret;
 }
 
 static struct ctl_path seccomp_sysctl_path[] = {
-- 
2.7.4
