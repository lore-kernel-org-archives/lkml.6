Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCUIrt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:47:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeCUIrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:47:43 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V4 1/2] audit: remove path param from link denied function
Date: Wed, 21 Mar 2018 04:42:20 -0400
Message-Id: <20dd27aecaac4a158acecb9dbb5365327f0696ec.1521620371.git.rgb@redhat.com>
In-Reply-To: <cover.1521620371.git.rgb@redhat.com>
References: <cover.1521620371.git.rgb@redhat.com>
In-Reply-To: <cover.1521620371.git.rgb@redhat.com>
References: <cover.1521620371.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 45b578fe4c3cade6f4ca1fc934ce199afd857edc
("audit: link denied should not directly generate PATH record")
the need for the struct path *link parameter was removed.
Remove the now useless struct path argument.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c            | 4 ++--
 include/linux/audit.h | 6 ++----
 kernel/audit.c        | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9cc91fb..e3682bb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -945,7 +945,7 @@ static inline int may_follow_link(struct nameidata *nd)
 	if (nd->flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	audit_log_link_denied("follow_link", &nd->stack[0].link);
+	audit_log_link_denied("follow_link");
 	return -EACCES;
 }
 
@@ -1011,7 +1011,7 @@ static int may_linkat(struct path *link)
 	if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
 		return 0;
 
-	audit_log_link_denied("linkat", link);
+	audit_log_link_denied("linkat");
 	return -EPERM;
 }
 
diff --git a/include/linux/audit.h b/include/linux/audit.h
index af410d9..75d5b03 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -146,8 +146,7 @@ extern void		    audit_log_d_path(struct audit_buffer *ab,
 					     const struct path *path);
 extern void		    audit_log_key(struct audit_buffer *ab,
 					  char *key);
-extern void		    audit_log_link_denied(const char *operation,
-						  const struct path *link);
+extern void		    audit_log_link_denied(const char *operation);
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
@@ -194,8 +193,7 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
 { }
 static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
-static inline void audit_log_link_denied(const char *string,
-					 const struct path *link)
+static inline void audit_log_link_denied(const char *string)
 { }
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
diff --git a/kernel/audit.c b/kernel/audit.c
index 3f2f143..e8bf8d7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2308,9 +2308,8 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
 /**
  * audit_log_link_denied - report a link restriction denial
  * @operation: specific link operation
- * @link: the path that triggered the restriction
  */
-void audit_log_link_denied(const char *operation, const struct path *link)
+void audit_log_link_denied(const char *operation)
 {
 	struct audit_buffer *ab;
 
-- 
1.8.3.1
