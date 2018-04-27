Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeD0TR0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:17:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33622 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeD0TRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:17:22 -0400
From: Tyler Hicks <tyhicks@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/3] seccomp: Audit attempts to modify the actions_logged sysctl
Date: Fri, 27 Apr 2018 19:16:01 +0000
Message-Id: <1524856562-22566-3-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524856562-22566-1-git-send-email-tyhicks@canonical.com>
References: <1524856562-22566-1-git-send-email-tyhicks@canonical.com>
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

Writing "not-a-real-action" emits:

 type=CONFIG_CHANGE msg=audit(1524600971.363:119): pid=1651 uid=0
 auid=1000 tty=pts8 ses=1 comm="tee" exe="/usr/bin/tee"
 op=seccomp-logging res=1

Writing "kill_process kill_thread errno trace log" emits:

 type=CONFIG_CHANGE msg=audit(1524601023.982:131): pid=1658 uid=0
 auid=1000 tty=pts8 ses=1 comm="tee" exe="/usr/bin/tee"
 op=seccomp-logging actions="kill_process kill_thread errno trace log"
 res=0

Writing the string "log log errno trace kill_process kill_thread", which
is unordered and contains the log action twice, results in the same
value as the previous example for the actions field:

 type=CONFIG_CHANGE msg=audit(1524601204.365:152): pid=1704 uid=0
 auid=1000 tty=pts8 ses=1 comm="tee" exe="/usr/bin/tee"
 op=seccomp-logging actions="kill_process kill_thread errno trace log"
 res=0

No audit records are generated when reading the actions_logged sysctl.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 include/linux/audit.h |  3 +++
 kernel/auditsc.c      | 37 +++++++++++++++++++++++++++++++++++++
 kernel/seccomp.c      | 43 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 75d5b03..b311d7d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -233,6 +233,7 @@ extern void __audit_inode_child(struct inode *parent,
 				const struct dentry *dentry,
 				const unsigned char type);
 extern void __audit_seccomp(unsigned long syscall, long signr, int code);
+extern void audit_seccomp_actions_logged(const char *names, int res);
 extern void __audit_ptrace(struct task_struct *t);
 
 static inline bool audit_dummy_context(void)
@@ -502,6 +503,8 @@ static inline void __audit_seccomp(unsigned long syscall, long signr, int code)
 { }
 static inline void audit_seccomp(unsigned long syscall, long signr, int code)
 { }
+static inline void audit_seccomp_actions_logged(const char *names, int res)
+{ }
 static inline int auditsc_get_stamp(struct audit_context *ctx,
 			      struct timespec64 *t, unsigned int *serial)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4e0a4ac..3496238 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2478,6 +2478,43 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 	audit_log_end(ab);
 }
 
+void audit_seccomp_actions_logged(const char *names, int res)
+{
+	struct tty_struct *tty;
+	const struct cred *cred;
+	struct audit_buffer *ab;
+	char comm[sizeof(current->comm)];
+
+	if (!audit_enabled)
+		return;
+
+	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	if (unlikely(!ab))
+		return;
+
+	cred = current_cred();
+	tty = audit_get_tty(current);
+	audit_log_format(ab, "pid=%d uid=%u auid=%u tty=%s ses=%u",
+			 task_tgid_nr(current),
+			 from_kuid(&init_user_ns, cred->uid),
+			 from_kuid(&init_user_ns,
+			 audit_get_loginuid(current)),
+			 tty ? tty_name(tty) : "(none)",
+			 audit_get_sessionid(current));
+	audit_put_tty(tty);
+	audit_log_task_context(ab);
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	audit_log_d_path_exe(ab, current->mm);
+	audit_log_format(ab, " op=seccomp-logging");
+
+	if (names)
+		audit_log_format(ab, " actions=\"%s\"", names);
+
+	audit_log_format(ab, " res=%d", res);
+	audit_log_end(ab);
+}
+
 struct list_head *audit_killed_trees(void)
 {
 	struct audit_context *ctx = current->audit_context;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f4afe67..e28ddcc 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1218,11 +1218,10 @@ static int read_actions_logged(struct ctl_table *ro_table, void __user *buffer,
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
@@ -1237,24 +1236,50 @@ static int write_actions_logged(struct ctl_table *ro_table, void __user *buffer,
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
 
+static void audit_actions_logged(u32 actions_logged, int ret)
+{
+	char names[sizeof(seccomp_actions_avail)];
+
+	if (!audit_enabled)
+		return;
+
+	if (ret)
+		return audit_seccomp_actions_logged(NULL, 1);
+
+	memset(names, 0, sizeof(names));
+	if (!seccomp_names_from_actions_logged(names, sizeof(names),
+					       actions_logged))
+		return audit_seccomp_actions_logged(NULL, 0);
+
+	return audit_seccomp_actions_logged(names, 0);
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
+
+		ret = write_actions_logged(ro_table, buffer, lenp, ppos,
+					   &actions_logged);
+		audit_actions_logged(actions_logged, ret);
+	} else
+		ret = read_actions_logged(ro_table, buffer, lenp, ppos);
+
+	return ret;
 }
 
 static struct ctl_path seccomp_sysctl_path[] = {
-- 
2.7.4
