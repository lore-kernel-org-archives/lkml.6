Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C802085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw/jb0iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C802085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbeJYWwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbeJYWwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:04 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A46720868;
        Thu, 25 Oct 2018 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477147;
        bh=tByDmkvUt5YA1pwmKrgoEmDvSdrFHzU5oxj+vejuYhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tw/jb0iqMBZMDWFmKEF+cCHs8Vlv+SeG1YfbRoqCT1jt8wNCyAEiGfsbIv8uvcCxV
         OBC+6K2rP4vtJG0Hhn3JTc2KijW9Vpqpwyy4w4Cga26dbQoc9ixJ/MANi4tdP21KY4
         Zn1mceKEaOtnhjOc3scxRqCMtUKch4INKY8veD3E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 06/98] s390/ftrace/jprobes: Fix conflict between jprobes and function graph tracing
Date:   Thu, 25 Oct 2018 10:17:21 -0400
Message-Id: <20181025141853.214051-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit e64a5470dcd2900ab8f8f83638c00098b10e6300 ]

This fixes the same issue Steven already fixed for x86
in following commit:

  237d28db036e ftrace/jprobes/x86: Fix conflict between jprobes and function graph tracing

It fixes the crash, that happens when function graph tracing
and jprobes are used simultaneously. Please refer to above
commit for details.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/kprobes.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 014d4729b134..ee03d8f0ee60 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -633,6 +633,15 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	stack = (unsigned long) regs->gprs[15];
 
 	memcpy(kcb->jprobes_stack, (void *) stack, MIN_STACK_SIZE(stack));
+
+	/*
+	 * jprobes use jprobe_return() which skips the normal return
+	 * path of the function, and this messes up the accounting of the
+	 * function graph tracer to get messed up.
+	 *
+	 * Pause function graph tracing while performing the jprobe function.
+	 */
+	pause_graph_tracing();
 	return 1;
 }
 
@@ -646,6 +655,9 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	unsigned long stack;
 
+	/* It's OK to start function graph tracing again */
+	unpause_graph_tracing();
+
 	stack = (unsigned long) kcb->jprobe_saved_regs.gprs[15];
 
 	/* Put the regs back */
-- 
2.17.1

