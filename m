Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1FC20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1FC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeGXHD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:03:29 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:53880 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388161AbeGXHD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:03:29 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D393C640F2208226E32E;
        Tue, 24 Jul 2018 13:58:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6O5wXL7068236;
        Tue, 24 Jul 2018 13:58:33 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072413583685-1465621 ;
          Tue, 24 Jul 2018 13:58:36 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     paul@paul-moore.com
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] audit: fix potential null dereference 'context->module.name'
Date:   Tue, 24 Jul 2018 13:57:14 +0800
Message-Id: <1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-24 13:58:36,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-24 13:58:29,
        Serialize complete at 2018-07-24 13:58:29
X-MAIL: mse01.zte.com.cn w6O5wXL7068236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'context->module.name' may be null pointer when
kmalloc return null, so it's better to check it before using
to avoid null dereference.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/auditsc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f..4830b83 100644
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
@@ -2409,7 +2413,8 @@ void __audit_log_kern_module(char *name)
 	struct audit_context *context = current->audit_context;
 
 	context->module.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
-	strcpy(context->module.name, name);
+	if (context->module.name)
+		strcpy(context->module.name, name);
 	context->type = AUDIT_KERN_MODULE;
 }
 
-- 
1.8.3.1

