Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeBGL2e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:28:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753794AbeBGL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:28:33 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Cc: Richard Guy Briggs <rgb@redhat.com>, Paul Moore <pmoore@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: [PATCH] audit: deprecate the AUDIT_FILTER_ENTRY filter
Date: Wed,  7 Feb 2018 06:24:36 -0500
Message-Id: <0b3961849e1fdcb10b95dd3ca0dc818e8997a8f5.1518002656.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit entry filter has been long deprecated with userspace support
finally removed in audit-v2.6.7 and plans to remove kernel support have
existed since kernel-v2.6.31.
Remove it.

Passes audit-testsuite.

See: https://github.com/linux-audit/audit-kernel/issues/6
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c | 4 ++--
 kernel/auditsc.c     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index e80459f..9348302 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1530,7 +1530,8 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	context->dummy = !audit_n_rules;
 	if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
 		context->prio = 0;
-		state = audit_filter_syscall(tsk, context, &audit_filter_list[AUDIT_FILTER_ENTRY]);
+		if (auditd_test_task(tsk))
+			return;
 	}
 	if (state == AUDIT_DISABLED)
 		return;
-- 
1.8.3.1
