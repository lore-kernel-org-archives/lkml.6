Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F123EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC90208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC90208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936091AbeFNUXo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:23:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755486AbeFNUXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:23:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B7FD738E9;
        Thu, 14 Jun 2018 20:23:19 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0586D11166FE;
        Thu, 14 Jun 2018 20:23:17 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <aviro@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak59 V1 5/6] audit: move EOE record after kill_trees for exit/free
Date:   Thu, 14 Jun 2018 16:21:15 -0400
Message-Id: <65299efddc04e19e6ad4b06fbde0bb3db2643cb5.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
In-Reply-To: <cover.1529003588.git.rgb@redhat.com>
References: <cover.1529003588.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 20:23:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 20:23:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EOE record was being issued prior to the pruning of the killed_tree
list.

Move the EOE record creation out of audit_log_exit() and into its
callers __audit_free() and __audit_syscall_exit() so that
audit_kill_trees() can be called prior to the EOE record creation and
any purged trees CONFIG_CHANGE records included in the syscall record
event.

See: https://github.com/linux-audit/audit-kernel/issues/50
See: https://github.com/linux-audit/audit-kernel/issues/59
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2590c9e..d56aead 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1460,10 +1460,6 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
 
 	audit_log_proctitle(tsk, context);
 
-	/* Send end of event record to help user space know we are finished */
-	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
-	if (ab)
-		audit_log_end(ab);
 	if (call_panic)
 		audit_panic("error converting sid to string");
 }
@@ -1491,6 +1487,14 @@ void __audit_free(struct task_struct *tsk)
 		audit_log_exit(context, tsk);
 	if (!list_empty(&context->killed_trees))
 		audit_kill_trees(context);
+	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
+		struct audit_buffer *ab;
+
+		/* Send end of event record to help user space know we are finished */
+		ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
+		if (ab)
+			audit_log_end(ab);
+	}
 
 	audit_free_context(context);
 }
@@ -1572,13 +1576,19 @@ void __audit_syscall_exit(int success, long return_code)
 
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, current);
+	if (!list_empty(&context->killed_trees))
+		audit_kill_trees(context);
+	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
+		struct audit_buffer *ab;
 
+		/* Send end of event record to help user space know we are finished */
+		ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
+		if (ab)
+			audit_log_end(ab);
+	}
 	context->in_syscall = 0;
 	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
 
-	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(context);
-
 	audit_free_names(context);
 	unroll_tree_refs(context, NULL, 0);
 	audit_free_aux(context);
-- 
1.8.3.1

