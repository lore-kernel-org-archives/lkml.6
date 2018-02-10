Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeBJCpy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 21:45:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752054AbeBJCp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 21:45:29 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V2 2/3] audit: bail ASAP on syscall entry
Date: Fri,  9 Feb 2018 21:40:31 -0500
Message-Id: <fc8dc7d245b6962d330eeedea544d7e4fd56e78c.1518230355.git.rgb@redhat.com>
In-Reply-To: <cover.1518230355.git.rgb@redhat.com>
References: <cover.1518230355.git.rgb@redhat.com>
In-Reply-To: <cover.1518230355.git.rgb@redhat.com>
References: <cover.1518230355.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since removing the audit entry filter, test for early return before
setting up any context state.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9348302..bc534bf 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1519,23 +1519,23 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
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
 		if (auditd_test_task(tsk))
 			return;
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
