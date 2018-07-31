Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836EAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED172083F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED172083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbeGaVxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:53:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbeGaVxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:53:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7532D4219DA2;
        Tue, 31 Jul 2018 20:11:36 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CFEC2026D7E;
        Tue, 31 Jul 2018 20:11:33 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     luto@kernel.org, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 (was ghak32) V4 05/10] audit: add support for non-syscall auxiliary records
Date:   Tue, 31 Jul 2018 16:07:40 -0400
Message-Id: <2827530000d6b4972d446b0226adab153ff3b5c5.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
In-Reply-To: <cover.1533065887.git.rgb@redhat.com>
References: <cover.1533065887.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 20:11:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 20:11:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standalone audit records have the timestamp and serial number generated
on the fly and as such are unique, making them standalone.  This new
function audit_alloc_local() generates a local audit context that will
be used only for a standalone record and its auxiliary record(s).  The
context is discarded immediately after the local associated records are
produced.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 include/linux/audit.h |  8 ++++++++
 kernel/audit.h        |  1 +
 kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4f514ed..1f340ad 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -234,7 +234,9 @@ struct audit_task_info {
 extern struct audit_task_info init_struct_audit;
 extern void __init audit_task_init(void);
 extern int  audit_alloc(struct task_struct *task);
+extern struct audit_context *audit_alloc_local(gfp_t gfpflags);
 extern void audit_free(struct task_struct *task);
+extern void audit_free_context(struct audit_context *context);
 extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
 				  unsigned long a2, unsigned long a3);
 extern void __audit_syscall_exit(int ret_success, long ret_value);
@@ -495,6 +497,12 @@ static inline int audit_alloc(struct task_struct *task)
 {
 	return 0;
 }
+static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
+{
+	return NULL;
+}
+static inline void audit_free_context(struct audit_context *context)
+{ }
 static inline void audit_free(struct task_struct *task)
 { }
 static inline void audit_syscall_entry(int major, unsigned long a0,
diff --git a/kernel/audit.h b/kernel/audit.h
index 1cf1c35..a6d00a5 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -110,6 +110,7 @@ struct audit_proctitle {
 struct audit_context {
 	int		    dummy;	/* must be the first element */
 	int		    in_syscall;	/* 1 if task is in a syscall */
+	bool		    local;	/* local context needed */
 	enum audit_state    state, current_state;
 	unsigned int	    serial;     /* serial number for record */
 	int		    major;      /* syscall number */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cdb24cf..7627f21 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -913,11 +913,13 @@ static inline void audit_free_aux(struct audit_context *context)
 	}
 }
 
-static inline struct audit_context *audit_alloc_context(enum audit_state state)
+static inline struct audit_context *audit_alloc_context(enum audit_state state,
+							gfp_t gfpflags)
 {
 	struct audit_context *context;
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
+	/* We can be called in atomic context via audit_tg() */
+	context = kzalloc(sizeof(*context), gfpflags);
 	if (!context)
 		return NULL;
 	context->state = state;
@@ -970,7 +972,8 @@ int audit_alloc(struct task_struct *tsk)
 		return 0;
 	}
 
-	if (!(context = audit_alloc_context(state))) {
+	context = audit_alloc_context(state, GFP_KERNEL);
+	if (!(context)) {
 		tsk->audit = NULL;
 		kmem_cache_free(audit_task_cache, info);
 		kfree(key);
@@ -991,8 +994,27 @@ struct audit_task_info init_struct_audit = {
 	.ctx = NULL,
 };
 
-static inline void audit_free_context(struct audit_context *context)
+struct audit_context *audit_alloc_local(gfp_t gfpflags)
 {
+	struct audit_context *context;
+
+	if (!audit_ever_enabled)
+		return NULL; /* Return if not auditing. */
+
+	context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
+	if (!context)
+		return NULL;
+	context->serial = audit_serial();
+	context->ctime = current_kernel_time64();
+	context->local = true;
+	return context;
+}
+EXPORT_SYMBOL(audit_alloc_local);
+
+void audit_free_context(struct audit_context *context)
+{
+	if (!context)
+		return;
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
 	free_tree_refs(context);
@@ -1002,6 +1024,7 @@ static inline void audit_free_context(struct audit_context *context)
 	audit_proctitle_free(context);
 	kfree(context);
 }
+EXPORT_SYMBOL(audit_free_context);
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 kuid_t auid, kuid_t uid, unsigned int sessionid,
@@ -2024,7 +2047,7 @@ void __audit_inode_child(struct inode *parent,
 int auditsc_get_stamp(struct audit_context *ctx,
 		       struct timespec64 *t, unsigned int *serial)
 {
-	if (!ctx->in_syscall)
+	if (!ctx->in_syscall && !ctx->local)
 		return 0;
 	if (!ctx->serial)
 		ctx->serial = audit_serial();
-- 
1.8.3.1

