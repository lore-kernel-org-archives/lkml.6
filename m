Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032477AbeBNQW6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:22:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032462AbeBNQWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:22:55 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak21 2/4] audit: link denied should not directly generate PATH record
Date: Wed, 14 Feb 2018 11:18:22 -0500
Message-Id: <f48d5d1f1e429e2dee817ae723f9a02a67ed1f3b.1518603831.git.rgb@redhat.com>
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
In-Reply-To: <cover.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit link denied events generate duplicate PATH records which disagree
in different ways from symlink and hardlink denials.
audit_log_link_denied() should not directly generate PATH records.

See: https://github.com/linux-audit/audit-kernel/issues/21
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/audit.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 4c3fd24..683b249 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2259,31 +2259,19 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
 void audit_log_link_denied(const char *operation, const struct path *link)
 {
 	struct audit_buffer *ab;
-	struct audit_names *name;
 
 	if (!audit_enabled || audit_dummy_context())
 		return;
 
-	name = kzalloc(sizeof(*name), GFP_NOFS);
-	if (!name)
-		return;
-
 	/* Generate AUDIT_ANOM_LINK with subject, operation, outcome. */
 	ab = audit_log_start(current->audit_context, GFP_KERNEL,
 			     AUDIT_ANOM_LINK);
 	if (!ab)
-		goto out;
+		return;
 	audit_log_format(ab, "op=%s", operation);
 	audit_log_task_info(ab, current);
 	audit_log_format(ab, " res=0");
 	audit_log_end(ab);
-
-	/* Generate AUDIT_PATH record with object. */
-	name->type = AUDIT_TYPE_NORMAL;
-	audit_copy_inode(name, link->dentry, d_backing_inode(link->dentry));
-	audit_log_name(current->audit_context, name, link, 0, NULL);
-out:
-	kfree(name);
 }
 
 /**
-- 
1.8.3.1
