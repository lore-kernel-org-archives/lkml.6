Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82551ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CE620892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2hHnv5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CE620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKIHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbeKIHcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:21 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493162145D;
        Thu,  8 Nov 2018 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714094;
        bh=3uQAofjn341EXCo8HgnZPxXRA1/mlBWVNaUladPEY7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2hHnv5QXlXv1GMHwY0pgY7q+EYjWWwzfeawtIWYOsy1bOw7YhMK96ZSdCHJpUfiD
         yXEaGpKHaND9bDJmWwuNr1z55PfkNpZOp1Nt6TfQoMxqaYUqux7pWCTsHBIKOeYPpe
         PpumeB4ltKuePaNH4ACAX+e++j+f/dm41aiDFpwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 037/144] s390/ftrace/jprobes: Fix conflict between jprobes and function graph tracing
Date:   Thu,  8 Nov 2018 13:50:08 -0800
Message-Id: <20181108215057.544813888@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



