Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeCLGgv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 02:36:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeCLGge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 02:36:34 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V2 4/4] audit: add parent of refused symlink to audit_names
Date: Mon, 12 Mar 2018 02:31:20 -0400
Message-Id: <b8673a31534c6122545a09abcb6db405e0d0ec50.1520835596.git.rgb@redhat.com>
In-Reply-To: <cover.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com>
In-Reply-To: <cover.1520835596.git.rgb@redhat.com>
References: <cover.1520835596.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit link denied events for symlinks were missing the parent PATH
record.  Add it.  Since the full pathname may not be available,
reconstruct it from the path in the nameidata supplied.

See: https://github.com/linux-audit/audit-kernel/issues/21
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c            |  2 +-
 include/linux/audit.h |  3 +++
 kernel/audit.c        | 31 +++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 00f5041..2f39617 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -946,7 +946,7 @@ static inline int may_follow_link(struct nameidata *nd)
 		return -ECHILD;
 
 	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
-	audit_log_link_denied("follow_link", &nd->stack[0].link);
+	audit_log_symlink_denied(&nd->stack[0].link);
 	return -EACCES;
 }
 
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 75d5b03..b5808e9 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -147,6 +147,7 @@ extern void		    audit_log_d_path(struct audit_buffer *ab,
 extern void		    audit_log_key(struct audit_buffer *ab,
 					  char *key);
 extern void		    audit_log_link_denied(const char *operation);
+extern void		    audit_log_symlink_denied(const struct path *link);
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
@@ -195,6 +196,8 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_link_denied(const char *string)
 { }
+static inline void audit_log_symlink_denied(const struct path *link)
+{ }
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index e54deaf..4acf374 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -73,6 +73,7 @@
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/namei.h> /* for LOOKUP_PARENT */
 
 #include "audit.h"
 
@@ -2320,6 +2321,36 @@ void audit_log_link_denied(const char *operation)
 	audit_log_end(ab);
 }
 
+/*
+ * audit_log_symlink_denied - report a symlink restriction denial
+ * @link: the path that triggered the restriction
+ */
+void audit_log_symlink_denied(const struct path *link)
+{
+	char *pathname;
+	struct filename *filename;
+
+	if (audit_dummy_context())
+		return;
+
+	pathname = kmalloc(PATH_MAX + 1, GFP_KERNEL);
+	if (!pathname) {
+		audit_panic("memory allocation error while reporting symlink denied");
+		return;
+	}
+	filename = getname_kernel(d_absolute_path(link, pathname, PATH_MAX + 1));
+	if (IS_ERR(filename)) {
+		audit_panic("error getting pathname while reporting symlink denied");
+		goto out;
+	}
+	audit_inode(filename, link->dentry->d_parent, LOOKUP_PARENT);
+	audit_log_link_denied("follow_link");
+	putname(filename);
+out:
+	kfree(pathname);
+	return;
+}
+
 /**
  * audit_log_end - end one audit record
  * @ab: the audit_buffer
-- 
1.8.3.1
