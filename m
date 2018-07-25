Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F7CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39D020883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39D020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGYDhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:37:32 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:44290 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbeGYDhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:37:32 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A4063608350672B43A95;
        Wed, 25 Jul 2018 10:28:06 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6P2RwRb059532;
        Wed, 25 Jul 2018 10:27:58 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072510280235-1661324 ;
          Wed, 25 Jul 2018 10:28:02 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     paul@paul-moore.com
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH v2] audit: fix potential null dereference 'context->module.name'
Date:   Wed, 25 Jul 2018 10:26:19 +0800
Message-Id: <1532485579-34431-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-25 10:28:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-25 10:27:50,
        Serialize complete at 2018-07-25 10:27:50
X-MAIL: mse01.zte.com.cn w6P2RwRb059532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'context->module.name' may be null pointer when
kmalloc return null, so it's better to check it before using
to avoid null dereference.
Another one more thing this patch does is using kstrdup instead
of (kmalloc + strcpy), and signal a lost record via audit_log_lost.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
v2: use kstrdup instead of kmalloc + strcpy, and signal a lost
record. Thanks to Eric and Paul.

 kernel/auditsc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f..713386a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1272,8 +1272,12 @@ static void show_special(struct audit_context *context, int *call_panic)
 		break;
 	case AUDIT_KERN_MODULE:
 		audit_log_format(ab, "name=");
-		audit_log_untrustedstring(ab, context->module.name);
-		kfree(context->module.name);
+		if (context->module.name) {
+			audit_log_untrustedstring(ab, context->module.name);
+			kfree(context->module.name);
+		} else
+			audit_log_format(ab, "(null)");
+
 		break;
 	}
 	audit_log_end(ab);
@@ -2408,8 +2412,9 @@ void __audit_log_kern_module(char *name)
 {
 	struct audit_context *context = current->audit_context;
 
-	context->module.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
-	strcpy(context->module.name, name);
+	context->module.name = kstrdup(name, GFP_KERNEL);
+	if (!context->module.name)
+		audit_log_lost("out of memory in __audit_log_kern_module");
 	context->type = AUDIT_KERN_MODULE;
 }
 
-- 
1.8.3.1

