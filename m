Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D19C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADC020673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADC020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbeG0VPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:15:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389448AbeG0VPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AEE740216FF;
        Fri, 27 Jul 2018 19:51:56 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA593111E415;
        Fri, 27 Jul 2018 19:51:54 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak59 V2 5/6] audit: kill trees before logging syscall exit for exit/free
Date:   Fri, 27 Jul 2018 15:48:16 -0400
Message-Id: <01b59195f8ff3c2ec32a2251200f588bd537dff1.1532709911.git.rgb@redhat.com>
In-Reply-To: <cover.1532709911.git.rgb@redhat.com>
References: <cover.1532709911.git.rgb@redhat.com>
In-Reply-To: <cover.1532709911.git.rgb@redhat.com>
References: <cover.1532709911.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 19:51:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 19:51:56 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EOE record was being issued prior to the pruning of the killed_tree
list.

Move the kill_trees call before the audit_log_exit call in
__audit_free() and __audit_syscall_exit() so that the user library
doesn't leave out any appended pruned trees CONFIG_CHANGE records due to
the EOE flagging the end of the event.

See: https://github.com/linux-audit/audit-kernel/issues/50
See: https://github.com/linux-audit/audit-kernel/issues/59
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 986c5ce..55fd2a3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1482,6 +1482,8 @@ void __audit_free(struct task_struct *tsk)
 	if (!context)
 		return;
 
+	if (!list_empty(&context->killed_trees))
+		audit_kill_trees(context);
 	/* Check for system calls that do not go through the exit
 	 * function (e.g., exit_group), then free context block.
 	 * We use GFP_ATOMIC here because we might be doing this
@@ -1489,8 +1491,6 @@ void __audit_free(struct task_struct *tsk)
 	/* that can happen only if we are called from do_exit() */
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, tsk);
-	if (!list_empty(&context->killed_trees))
-		audit_kill_trees(context);
 
 	audit_free_context(context);
 }
@@ -1570,15 +1570,14 @@ void __audit_syscall_exit(int success, long return_code)
 	if (!context)
 		return;
 
+	if (!list_empty(&context->killed_trees))
+		audit_kill_trees(context);
 	if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
 		audit_log_exit(context, current);
 
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

