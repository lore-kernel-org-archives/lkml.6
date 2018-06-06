Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94E1E601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933628AbeFFRBN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:01:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752390AbeFFRBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:01:09 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak90 (was ghak32) V3 04/10] audit: add support for non-syscall auxiliary records
Date: Wed,  6 Jun 2018 12:58:31 -0400
Message-Id: <dcd3d6e27c4beb8aec11805faeb4de7013132bd7.1528304204.git.rgb@redhat.com>
In-Reply-To: <cover.1528304203.git.rgb@redhat.com>
References: <cover.1528304203.git.rgb@redhat.com>
In-Reply-To: <cover.1528304203.git.rgb@redhat.com>
References: <cover.1528304203.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standalone audit records have the timestamp and serial number generated
on the fly and as such are unique, making them standalone.  This new
function audit_alloc_local() generates a local audit context that will
be used only for a standalone record and its auxiliary record(s).  The
context is discarded immediately after the local associated records are
produced.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 include/linux/audit.h |  8 ++++++++
 kernel/auditsc.c      | 25 +++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index ab50985..f549121 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -232,7 +232,9 @@ struct audit_task_info {
 extern struct audit_task_info init_struct_audit;
 extern void __init audit_task_init(void);
 extern int  audit_alloc(struct task_struct *task);
+extern struct audit_context *audit_alloc_local(void);
 extern void audit_free(struct task_struct *task);
+extern void audit_free_context(struct audit_context *context);
 extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
@@ -493,6 +495,12 @@ static inline int audit_alloc(struct task_struct *task)
 {
 	return 0;
 }
+static inline struct audit_context *audit_alloc_local(void)
+{
+	return NULL;
+}
+static inline void audit_free_context(struct audit_context *context)
+{ }
 static inline void audit_free(struct task_struct *task)
 { }
 static inline void audit_syscall_entry(int major, unsigned long a0,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cface9d..81c9765 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -916,8 +916,11 @@ static inline void audit_free_aux(struct audit_context *context)
 static inline struct audit_context *audit_alloc_context(enum audit_state state)
 {
 	struct audit_context *context;
+	gfp_t gfpflags;
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
+	/* We can be called in atomic context via audit_tg() */
+	gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
+	context = kzalloc(sizeof(*context), gfpflags);
 	if (!context)
 		return NULL;
 	context->state = state;
@@ -993,8 +996,26 @@ struct audit_task_info init_struct_audit = {
 	.ctx = NULL,
 };
 
-static inline void audit_free_context(struct audit_context *context)
+struct audit_context *audit_alloc_local(void)
 {
+	struct audit_context *context;
+
+	if (!audit_ever_enabled)
+		return NULL; /* Return if not auditing. */
+
+	context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
+	if (!context)
+		return NULL;
+	context->serial = audit_serial();
+	context->ctime = current_kernel_time64();
+	context->in_syscall = 1;
+	return context;
+}
+
+void audit_free_context(struct audit_context *context)
+{
+	if (!context)
+		return;
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
 	free_tree_refs(context);
-- 
1.8.3.1
