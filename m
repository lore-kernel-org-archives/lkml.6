Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032693AbeBOCwM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:52:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032660AbeBOCwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:52:07 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V3 1/2] audit: deprecate the AUDIT_FILTER_ENTRY filter
Date: Wed, 14 Feb 2018 21:47:43 -0500
Message-Id: <cb76d12aecaa60dc9137655098ec1716bf43088a.1518662391.git.rgb@redhat.com>
In-Reply-To: <cover.1518662391.git.rgb@redhat.com>
References: <cover.1518662391.git.rgb@redhat.com>
In-Reply-To: <cover.1518662391.git.rgb@redhat.com>
References: <cover.1518662391.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit entry filter has been long deprecated with userspace support
finally removed in audit-v2.6.7 and plans to remove kernel support have
existed since kernel-v2.6.31.
Remove it.

Since removing the audit entry filter, test for early return before
setting up any context state.

Passes audit-testsuite.

See: https://github.com/linux-audit/audit-kernel/issues/6
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c |  4 ++--
 kernel/auditsc.c     | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4a1758a..1bbf5de 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -258,8 +258,8 @@ static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *
 		goto exit_err;
 #ifdef CONFIG_AUDITSYSCALL
 	case AUDIT_FILTER_ENTRY:
-		if (rule->action == AUDIT_ALWAYS)
-			goto exit_err;
+		pr_err("AUDIT_FILTER_ENTRY is deprecated\n");
+		goto exit_err;
 	case AUDIT_FILTER_EXIT:
 	case AUDIT_FILTER_TASK:
 #endif
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f..bc534bf 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1519,22 +1519,23 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	if (!audit_enabled)
 		return;
 
-	context->arch	    = syscall_get_arch();
-	context->major      = major;
-	context->argv[0]    = a1;
-	context->argv[1]    = a2;
-	context->argv[2]    = a3;
-	context->argv[3]    = a4;
-
 	state = context->state;
+	if (state == AUDIT_DISABLED)
+		return;
+
 	context->dummy = !audit_n_rules;
 	if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
 		context->prio = 0;
-		state = audit_filter_syscall(tsk, context, &audit_filter_list[AUDIT_FILTER_ENTRY]);
+		if (auditd_test_task(tsk))
+			return;
 	}
-	if (state == AUDIT_DISABLED)
-		return;
 
+	context->arch	    = syscall_get_arch();
+	context->major      = major;
+	context->argv[0]    = a1;
+	context->argv[1]    = a2;
+	context->argv[2]    = a3;
+	context->argv[3]    = a4;
 	context->serial     = 0;
 	context->ctime = current_kernel_time64();
 	context->in_syscall = 1;
-- 
1.8.3.1
