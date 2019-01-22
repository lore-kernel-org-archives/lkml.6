Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979EAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ABD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfAVWHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:07:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfAVWHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:07:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5532C04BD2F;
        Tue, 22 Jan 2019 22:07:13 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0550A5D9C5;
        Tue, 22 Jan 2019 22:07:07 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak104 V1] audit: move loginuid and sessionid from CONFIG_ AUDITSYSCALL to AUDIT
Date:   Tue, 22 Jan 2019 17:06:39 -0500
Message-Id: <77df427bbfd22e0d901a9a0b2674e8d617b0c8c0.1548192726.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 22 Jan 2019 22:07:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loginuid and sessionid (and audit_log_session_info) should be part of
CONFIG_AUDIT scope and not CONFIG_AUDITSYSCALL since it is used in
CONFIG_CHANGE, ANOM_LINK, FEATURE_CHANGE (and INTEGRITY_RULE), none of
which are otherwise dependent on AUDITSYSCALL.

Please see github issue
https://github.com/linux-audit/audit-kernel/issues/104

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/proc/base.c        |  6 ++--
 include/linux/audit.h | 42 +++++++++++++------------
 include/linux/sched.h |  2 +-
 init/init_task.c      |  2 +-
 kernel/audit.c        | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c      | 84 --------------------------------------------------
 6 files changed, 113 insertions(+), 108 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 633a63462573..a23651ce6960 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1210,7 +1210,7 @@ static ssize_t oom_score_adj_write(struct file *file, const char __user *buf,
 	.llseek		= default_llseek,
 };
 
-#ifdef CONFIG_AUDITSYSCALL
+#ifdef CONFIG_AUDIT
 #define TMPBUFLEN 11
 static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
 				  size_t count, loff_t *ppos)
@@ -3002,7 +3002,7 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 	ONE("oom_score",  S_IRUGO, proc_oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
 	REG("oom_score_adj", S_IRUGO|S_IWUSR, proc_oom_score_adj_operations),
-#ifdef CONFIG_AUDITSYSCALL
+#ifdef CONFIG_AUDIT
 	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
 #endif
@@ -3390,7 +3390,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 	ONE("oom_score", S_IRUGO, proc_oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
 	REG("oom_score_adj", S_IRUGO|S_IWUSR, proc_oom_score_adj_operations),
-#ifdef CONFIG_AUDITSYSCALL
+#ifdef CONFIG_AUDIT
 	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
 	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
 #endif
diff --git a/include/linux/audit.h b/include/linux/audit.h
index a625c29a2ea2..ecb5d317d6a2 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -159,6 +159,18 @@ extern void		    audit_log_key(struct audit_buffer *ab,
 extern int audit_rule_change(int type, int seq, void *data, size_t datasz);
 extern int audit_list_rules_send(struct sk_buff *request_skb, int seq);
 
+extern int audit_set_loginuid(kuid_t loginuid);
+
+static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
+{
+	return tsk->loginuid;
+}
+
+static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
+{
+	return tsk->sessionid;
+}
+
 extern u32 audit_enabled;
 #else /* CONFIG_AUDIT */
 static inline __printf(4, 5)
@@ -201,6 +213,17 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 }
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
+
+static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
+{
+	return INVALID_UID;
+}
+
+static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
+{
+	return AUDIT_SID_UNSET;
+}
+
 #define audit_enabled AUDIT_OFF
 #endif /* CONFIG_AUDIT */
 
@@ -323,17 +346,6 @@ static inline void audit_ptrace(struct task_struct *t)
 extern unsigned int audit_serial(void);
 extern int auditsc_get_stamp(struct audit_context *ctx,
 			      struct timespec64 *t, unsigned int *serial);
-extern int audit_set_loginuid(kuid_t loginuid);
-
-static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
-{
-	return tsk->loginuid;
-}
-
-static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
-{
-	return tsk->sessionid;
-}
 
 extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
 extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
@@ -519,14 +531,6 @@ static inline int auditsc_get_stamp(struct audit_context *ctx,
 {
 	return 0;
 }
-static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
-{
-	return INVALID_UID;
-}
-static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
-{
-	return AUDIT_SID_UNSET;
-}
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 { }
 static inline void audit_ipc_set_perm(unsigned long qbytes, uid_t uid,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89541d248893..f9788bb122c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -886,7 +886,7 @@ struct task_struct {
 	struct callback_head		*task_works;
 
 	struct audit_context		*audit_context;
-#ifdef CONFIG_AUDITSYSCALL
+#ifdef CONFIG_AUDIT
 	kuid_t				loginuid;
 	unsigned int			sessionid;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index 5aebe3be4d7c..39c3109acc1a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -121,7 +121,7 @@ struct task_struct init_task
 	.thread_pid	= &init_struct_pid,
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
-#ifdef CONFIG_AUDITSYSCALL
+#ifdef CONFIG_AUDIT
 	.loginuid	= INVALID_UID,
 	.sessionid	= AUDIT_SID_UNSET,
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index ca55ccb46b76..dc375857c59b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2334,6 +2334,91 @@ void audit_log_link_denied(const char *operation)
 	audit_log_end(ab);
 }
 
+/* global counter which is incremented every time something logs in */
+static atomic_t session_id = ATOMIC_INIT(0);
+
+static int audit_set_loginuid_perm(kuid_t loginuid)
+{
+	/* if we are unset, we don't need privs */
+	if (!audit_loginuid_set(current))
+		return 0;
+	/* if AUDIT_FEATURE_LOGINUID_IMMUTABLE means never ever allow a change*/
+	if (is_audit_feature_set(AUDIT_FEATURE_LOGINUID_IMMUTABLE))
+		return -EPERM;
+	/* it is set, you need permission */
+	if (!capable(CAP_AUDIT_CONTROL))
+		return -EPERM;
+	/* reject if this is not an unset and we don't allow that */
+	if (is_audit_feature_set(AUDIT_FEATURE_ONLY_UNSET_LOGINUID)
+				 && uid_valid(loginuid))
+		return -EPERM;
+	return 0;
+}
+
+static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
+				   unsigned int oldsessionid,
+				   unsigned int sessionid, int rc)
+{
+	struct audit_buffer *ab;
+	uid_t uid, oldloginuid, loginuid;
+	struct tty_struct *tty;
+
+	if (!audit_enabled)
+		return;
+
+	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
+	if (!ab)
+		return;
+
+	uid = from_kuid(&init_user_ns, task_uid(current));
+	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
+	loginuid = from_kuid(&init_user_ns, kloginuid),
+	tty = audit_get_tty();
+
+	audit_log_format(ab, "pid=%d uid=%u", task_tgid_nr(current), uid);
+	audit_log_task_context(ab);
+	audit_log_format(ab, " old-auid=%u auid=%u tty=%s old-ses=%u ses=%u res=%d",
+			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
+			 oldsessionid, sessionid, !rc);
+	audit_put_tty(tty);
+	audit_log_end(ab);
+}
+
+/**
+ * audit_set_loginuid - set current task's loginuid
+ * @loginuid: loginuid value
+ *
+ * Returns 0.
+ *
+ * Called (set) from fs/proc/base.c::proc_loginuid_write().
+ */
+int audit_set_loginuid(kuid_t loginuid)
+{
+	unsigned int oldsessionid, sessionid = AUDIT_SID_UNSET;
+	kuid_t oldloginuid;
+	int rc;
+
+	oldloginuid = audit_get_loginuid(current);
+	oldsessionid = audit_get_sessionid(current);
+
+	rc = audit_set_loginuid_perm(loginuid);
+	if (rc)
+		goto out;
+
+	/* are we setting or clearing? */
+	if (uid_valid(loginuid)) {
+		sessionid = (unsigned int)atomic_inc_return(&session_id);
+		if (unlikely(sessionid == AUDIT_SID_UNSET))
+			sessionid = (unsigned int)atomic_inc_return(&session_id);
+	}
+
+	current->sessionid = sessionid;
+	current->loginuid = loginuid;
+out:
+	audit_log_set_loginuid(oldloginuid, loginuid, oldsessionid, sessionid, rc);
+	return rc;
+}
+
 /**
  * audit_log_end - end one audit record
  * @ab: the audit_buffer
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b585ceb2f7a2..572d247957fb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1983,90 +1983,6 @@ int auditsc_get_stamp(struct audit_context *ctx,
 	return 1;
 }
 
-/* global counter which is incremented every time something logs in */
-static atomic_t session_id = ATOMIC_INIT(0);
-
-static int audit_set_loginuid_perm(kuid_t loginuid)
-{
-	/* if we are unset, we don't need privs */
-	if (!audit_loginuid_set(current))
-		return 0;
-	/* if AUDIT_FEATURE_LOGINUID_IMMUTABLE means never ever allow a change*/
-	if (is_audit_feature_set(AUDIT_FEATURE_LOGINUID_IMMUTABLE))
-		return -EPERM;
-	/* it is set, you need permission */
-	if (!capable(CAP_AUDIT_CONTROL))
-		return -EPERM;
-	/* reject if this is not an unset and we don't allow that */
-	if (is_audit_feature_set(AUDIT_FEATURE_ONLY_UNSET_LOGINUID) && uid_valid(loginuid))
-		return -EPERM;
-	return 0;
-}
-
-static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
-				   unsigned int oldsessionid, unsigned int sessionid,
-				   int rc)
-{
-	struct audit_buffer *ab;
-	uid_t uid, oldloginuid, loginuid;
-	struct tty_struct *tty;
-
-	if (!audit_enabled)
-		return;
-
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
-	if (!ab)
-		return;
-
-	uid = from_kuid(&init_user_ns, task_uid(current));
-	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
-	loginuid = from_kuid(&init_user_ns, kloginuid),
-	tty = audit_get_tty();
-
-	audit_log_format(ab, "pid=%d uid=%u", task_tgid_nr(current), uid);
-	audit_log_task_context(ab);
-	audit_log_format(ab, " old-auid=%u auid=%u tty=%s old-ses=%u ses=%u res=%d",
-			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
-			 oldsessionid, sessionid, !rc);
-	audit_put_tty(tty);
-	audit_log_end(ab);
-}
-
-/**
- * audit_set_loginuid - set current task's audit_context loginuid
- * @loginuid: loginuid value
- *
- * Returns 0.
- *
- * Called (set) from fs/proc/base.c::proc_loginuid_write().
- */
-int audit_set_loginuid(kuid_t loginuid)
-{
-	unsigned int oldsessionid, sessionid = AUDIT_SID_UNSET;
-	kuid_t oldloginuid;
-	int rc;
-
-	oldloginuid = audit_get_loginuid(current);
-	oldsessionid = audit_get_sessionid(current);
-
-	rc = audit_set_loginuid_perm(loginuid);
-	if (rc)
-		goto out;
-
-	/* are we setting or clearing? */
-	if (uid_valid(loginuid)) {
-		sessionid = (unsigned int)atomic_inc_return(&session_id);
-		if (unlikely(sessionid == AUDIT_SID_UNSET))
-			sessionid = (unsigned int)atomic_inc_return(&session_id);
-	}
-
-	current->sessionid = sessionid;
-	current->loginuid = loginuid;
-out:
-	audit_log_set_loginuid(oldloginuid, loginuid, oldsessionid, sessionid, rc);
-	return rc;
-}
-
 /**
  * __audit_mq_open - record audit data for a POSIX MQ open
  * @oflag: open flag
-- 
1.8.3.1

