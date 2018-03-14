Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeCNFsK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751155AbeCNFsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:48:09 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak21 V3 1/2] audit: remove path param from link denied function
Date: Wed, 14 Mar 2018 01:42:59 -0400
Message-Id: <3a001779ec9c295adc515d9170cde6e3ae8762fb.1521005283.git.rgb@redhat.com>
In-Reply-To: <cover.1521005283.git.rgb@redhat.com>
References: <cover.1521005283.git.rgb@redhat.com>
In-Reply-To: <cover.1521005283.git.rgb@redhat.com>
References: <cover.1521005283.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 45b578fe4c3cade6f4ca1fc934ce199afd857edc
("audit: link denied should not directly generate PATH record")
the need for the struct path *link parameter was removed.
Remove the now useless struct path argument.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c            | 2 +-
 include/linux/audit.h | 6 ++----
 kernel/audit.c        | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9cc91fb..50d2533 100644
--- a/fs/namei.c
+++ b/fs/namei.c
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
