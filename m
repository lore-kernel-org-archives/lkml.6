Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EAC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D132086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBBDps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:45:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfBBDps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:45:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FAB3A4056;
        Sat,  2 Feb 2019 03:45:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F98A5DD6F;
        Sat,  2 Feb 2019 03:45:41 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak105 V3] audit: remove audit_context when CONFIG_ AUDIT and not AUDITSYSCALL
Date:   Fri,  1 Feb 2019 22:45:17 -0500
Message-Id: <0c4ada9c89959ce0aa82e35ffa477ce245f2bb8b.1549074196.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 02 Feb 2019 03:45:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove audit_context from struct task_struct and struct audit_buffer
when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.

Also, audit_log_name() (and supporting inode and fcaps functions) should
have been put back in auditsc.c when soft and hard link logging was
normalized since it is only used by syscall auditing.

See github issue https://github.com/linux-audit/audit-kernel/issues/105

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Tested with CONFIG_AUDITSYSCALL automatically set "y" and manually set
"n".  Passes all audit-testsuite with the former and the expected subset
that don't depend on syscall auditing for the latter.

changelog v2:
- guard audit_context by CONFIG_AUDITSYSCALL in task_struct 
- rebase/resolve merge conflicts on upstreamed ghak103 v1.1/1

changelog v3:
- re-instate audit_context in audit_buffer (though not needed)
- rebase/resolve merge conflicts on upstreamed ghak100 v2.2/2

 include/linux/sched.h |   4 +-
 kernel/audit.c        | 157 -------------------------------------------------
 kernel/audit.h        |   9 ---
 kernel/auditsc.c      | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 167 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f9788bb122c5..765119df759a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -885,8 +885,10 @@ struct task_struct {
 
 	struct callback_head		*task_works;
 
-	struct audit_context		*audit_context;
 #ifdef CONFIG_AUDIT
+#ifdef CONFIG_AUDITSYSCALL
+	struct audit_context		*audit_context;
+#endif
 	kuid_t				loginuid;
 	unsigned int			sessionid;
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index b7177a8def2e..c89ea48c70a6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2067,163 +2067,6 @@ void audit_log_key(struct audit_buffer *ab, char *key)
 		audit_log_format(ab, "(null)");
 }
 
-void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
-{
-	int i;
-
-	if (cap_isclear(*cap)) {
-		audit_log_format(ab, " %s=0", prefix);
-		return;
-	}
-	audit_log_format(ab, " %s=", prefix);
-	CAP_FOR_EACH_U32(i)
-		audit_log_format(ab, "%08x", cap->cap[CAP_LAST_U32 - i]);
-}
-
-static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
-{
-	if (name->fcap_ver == -1) {
-		audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
-		return;
-	}
-	audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
-	audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
-	audit_log_format(ab, " cap_fe=%d cap_fver=%x cap_frootid=%d",
-			 name->fcap.fE, name->fcap_ver,
-			 from_kuid(&init_user_ns, name->fcap.rootid));
-}
-
-static inline int audit_copy_fcaps(struct audit_names *name,
-				   const struct dentry *dentry)
-{
-	struct cpu_vfs_cap_data caps;
-	int rc;
-
-	if (!dentry)
-		return 0;
-
-	rc = get_vfs_caps_from_disk(dentry, &caps);
-	if (rc)
-		return rc;
-
-	name->fcap.permitted = caps.permitted;
-	name->fcap.inheritable = caps.inheritable;
-	name->fcap.fE = !!(caps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
-	name->fcap.rootid = caps.rootid;
-	name->fcap_ver = (caps.magic_etc & VFS_CAP_REVISION_MASK) >>
-				VFS_CAP_REVISION_SHIFT;
-
-	return 0;
-}
-
-/* Copy inode data into an audit_names. */
-void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
-		      struct inode *inode, unsigned int flags)
-{
-	name->ino   = inode->i_ino;
-	name->dev   = inode->i_sb->s_dev;
-	name->mode  = inode->i_mode;
-	name->uid   = inode->i_uid;
-	name->gid   = inode->i_gid;
-	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
-	if (flags & AUDIT_INODE_NOEVAL) {
-		name->fcap_ver = -1;
-		return;
-	}
-	audit_copy_fcaps(name, dentry);
-}
-
-/**
- * audit_log_name - produce AUDIT_PATH record from struct audit_names
- * @context: audit_context for the task
- * @n: audit_names structure with reportable details
- * @path: optional path to report instead of audit_names->name
- * @record_num: record number to report when handling a list of names
- * @call_panic: optional pointer to int that will be updated if secid fails
- */
-void audit_log_name(struct audit_context *context, struct audit_names *n,
-		    const struct path *path, int record_num, int *call_panic)
-{
-	struct audit_buffer *ab;
-	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PATH);
-	if (!ab)
-		return;
-
-	audit_log_format(ab, "item=%d", record_num);
-
-	if (path)
-		audit_log_d_path(ab, " name=", path);
-	else if (n->name) {
-		switch (n->name_len) {
-		case AUDIT_NAME_FULL:
-			/* log the full path */
-			audit_log_format(ab, " name=");
-			audit_log_untrustedstring(ab, n->name->name);
-			break;
-		case 0:
-			/* name was specified as a relative path and the
-			 * directory component is the cwd */
-			audit_log_d_path(ab, " name=", &context->pwd);
-			break;
-		default:
-			/* log the name's directory component */
-			audit_log_format(ab, " name=");
-			audit_log_n_untrustedstring(ab, n->name->name,
-						    n->name_len);
-		}
-	} else
-		audit_log_format(ab, " name=(null)");
-
-	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu"
-				 " dev=%02x:%02x mode=%#ho"
-				 " ouid=%u ogid=%u rdev=%02x:%02x",
-				 n->ino,
-				 MAJOR(n->dev),
-				 MINOR(n->dev),
-				 n->mode,
-				 from_kuid(&init_user_ns, n->uid),
-				 from_kgid(&init_user_ns, n->gid),
-				 MAJOR(n->rdev),
-				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		char *ctx = NULL;
-		u32 len;
-		if (security_secid_to_secctx(
-			n->osid, &ctx, &len)) {
-			audit_log_format(ab, " osid=%u", n->osid);
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx);
-			security_release_secctx(ctx, len);
-		}
-	}
-
-	/* log the audit_names record type */
-	switch(n->type) {
-	case AUDIT_TYPE_NORMAL:
-		audit_log_format(ab, " nametype=NORMAL");
-		break;
-	case AUDIT_TYPE_PARENT:
-		audit_log_format(ab, " nametype=PARENT");
-		break;
-	case AUDIT_TYPE_CHILD_DELETE:
-		audit_log_format(ab, " nametype=DELETE");
-		break;
-	case AUDIT_TYPE_CHILD_CREATE:
-		audit_log_format(ab, " nametype=CREATE");
-		break;
-	default:
-		audit_log_format(ab, " nametype=UNKNOWN");
-		break;
-	}
-
-	audit_log_fcaps(ab, n);
-	audit_log_end(ab);
-}
-
 int audit_log_task_context(struct audit_buffer *ab)
 {
 	char *ctx = NULL;
diff --git a/kernel/audit.h b/kernel/audit.h
index 002f0f7ba732..82734f438ddd 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -213,15 +213,6 @@ struct audit_context {
 
 extern void audit_log_session_info(struct audit_buffer *ab);
 
-extern void audit_copy_inode(struct audit_names *name,
-			     const struct dentry *dentry,
-			     struct inode *inode, unsigned int flags);
-extern void audit_log_cap(struct audit_buffer *ab, char *prefix,
-			  kernel_cap_t *cap);
-extern void audit_log_name(struct audit_context *context,
-			   struct audit_names *n, const struct path *path,
-			   int record_num, int *call_panic);
-
 extern int auditd_test_task(struct task_struct *task);
 
 #define AUDIT_INODE_BUCKETS	32
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 68da71001096..d8b477a540e8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1136,6 +1136,32 @@ static void audit_log_execve_info(struct audit_context *context,
 	kfree(buf_head);
 }
 
+void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
+{
+	int i;
+
+	if (cap_isclear(*cap)) {
+		audit_log_format(ab, " %s=0", prefix);
+		return;
+	}
+	audit_log_format(ab, " %s=", prefix);
+	CAP_FOR_EACH_U32(i)
+		audit_log_format(ab, "%08x", cap->cap[CAP_LAST_U32 - i]);
+}
+
+static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
+{
+	if (name->fcap_ver == -1) {
+		audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
+		return;
+	}
+	audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
+	audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
+	audit_log_format(ab, " cap_fe=%d cap_fver=%x cap_frootid=%d",
+			 name->fcap.fE, name->fcap_ver,
+			 from_kuid(&init_user_ns, name->fcap.rootid));
+}
+
 static void show_special(struct audit_context *context, int *call_panic)
 {
 	struct audit_buffer *ab;
@@ -1258,6 +1284,97 @@ static inline int audit_proctitle_rtrim(char *proctitle, int len)
 	return len;
 }
 
+/*
+ * audit_log_name - produce AUDIT_PATH record from struct audit_names
+ * @context: audit_context for the task
+ * @n: audit_names structure with reportable details
+ * @path: optional path to report instead of audit_names->name
+ * @record_num: record number to report when handling a list of names
+ * @call_panic: optional pointer to int that will be updated if secid fails
+ */
+static void audit_log_name(struct audit_context *context, struct audit_names *n,
+		    const struct path *path, int record_num, int *call_panic)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PATH);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "item=%d", record_num);
+
+	if (path)
+		audit_log_d_path(ab, " name=", path);
+	else if (n->name) {
+		switch (n->name_len) {
+		case AUDIT_NAME_FULL:
+			/* log the full path */
+			audit_log_format(ab, " name=");
+			audit_log_untrustedstring(ab, n->name->name);
+			break;
+		case 0:
+			/* name was specified as a relative path and the
+			 * directory component is the cwd
+			 */
+			audit_log_d_path(ab, " name=", &context->pwd);
+			break;
+		default:
+			/* log the name's directory component */
+			audit_log_format(ab, " name=");
+			audit_log_n_untrustedstring(ab, n->name->name,
+						    n->name_len);
+		}
+	} else
+		audit_log_format(ab, " name=(null)");
+
+	if (n->ino != AUDIT_INO_UNSET)
+		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+				 n->ino,
+				 MAJOR(n->dev),
+				 MINOR(n->dev),
+				 n->mode,
+				 from_kuid(&init_user_ns, n->uid),
+				 from_kgid(&init_user_ns, n->gid),
+				 MAJOR(n->rdev),
+				 MINOR(n->rdev));
+	if (n->osid != 0) {
+		char *ctx = NULL;
+		u32 len;
+
+		if (security_secid_to_secctx(
+			n->osid, &ctx, &len)) {
+			audit_log_format(ab, " osid=%u", n->osid);
+			if (call_panic)
+				*call_panic = 2;
+		} else {
+			audit_log_format(ab, " obj=%s", ctx);
+			security_release_secctx(ctx, len);
+		}
+	}
+
+	/* log the audit_names record type */
+	switch (n->type) {
+	case AUDIT_TYPE_NORMAL:
+		audit_log_format(ab, " nametype=NORMAL");
+		break;
+	case AUDIT_TYPE_PARENT:
+		audit_log_format(ab, " nametype=PARENT");
+		break;
+	case AUDIT_TYPE_CHILD_DELETE:
+		audit_log_format(ab, " nametype=DELETE");
+		break;
+	case AUDIT_TYPE_CHILD_CREATE:
+		audit_log_format(ab, " nametype=CREATE");
+		break;
+	default:
+		audit_log_format(ab, " nametype=UNKNOWN");
+		break;
+	}
+
+	audit_log_fcaps(ab, n);
+	audit_log_end(ab);
+}
+
 static void audit_log_proctitle(void)
 {
 	int res;
@@ -1753,6 +1870,47 @@ void __audit_getname(struct filename *name)
 		get_fs_pwd(current->fs, &context->pwd);
 }
 
+static inline int audit_copy_fcaps(struct audit_names *name,
+				   const struct dentry *dentry)
+{
+	struct cpu_vfs_cap_data caps;
+	int rc;
+
+	if (!dentry)
+		return 0;
+
+	rc = get_vfs_caps_from_disk(dentry, &caps);
+	if (rc)
+		return rc;
+
+	name->fcap.permitted = caps.permitted;
+	name->fcap.inheritable = caps.inheritable;
+	name->fcap.fE = !!(caps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
+	name->fcap.rootid = caps.rootid;
+	name->fcap_ver = (caps.magic_etc & VFS_CAP_REVISION_MASK) >>
+				VFS_CAP_REVISION_SHIFT;
+
+	return 0;
+}
+
+/* Copy inode data into an audit_names. */
+void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
+		      struct inode *inode, unsigned int flags)
+{
+	name->ino   = inode->i_ino;
+	name->dev   = inode->i_sb->s_dev;
+	name->mode  = inode->i_mode;
+	name->uid   = inode->i_uid;
+	name->gid   = inode->i_gid;
+	name->rdev  = inode->i_rdev;
+	security_inode_getsecid(inode, &name->osid);
+	if (flags & AUDIT_INODE_NOEVAL) {
+		name->fcap_ver = -1;
+		return;
+	}
+	audit_copy_fcaps(name, dentry);
+}
+
 /**
  * __audit_inode - store the inode and device from a lookup
  * @name: name being audited
-- 
1.8.3.1

