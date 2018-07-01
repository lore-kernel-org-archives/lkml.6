Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A63025171
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A63025171
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965084AbeGAQYs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:24:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965131AbeGAQYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:24:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA9E4AE0;
        Sun,  1 Jul 2018 16:24:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 4.9 017/101] mips: ftrace: fix static function graph tracing
Date:   Sun,  1 Jul 2018 18:21:03 +0200
Message-Id: <20180701160757.823536881@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <mschiffer@universe-factory.net>

commit 6fb8656646f996d1eef42e6d56203c4915cb9e08 upstream.

ftrace_graph_caller was never run after calling ftrace_trace_function,
breaking the function graph tracer. Fix this, bringing it in line with the
x86 implementation.

While we're at it, also streamline the control flow of _mcount a bit to
reduce the number of branches.

This issue was reported before:
https://www.linux-mips.org/archives/linux-mips/2014-11/msg00295.html

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Tested-by: Matt Redfearn <matt.redfearn@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/18929/
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: stable@vger.kernel.org # v3.17+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mcount.S |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -116,10 +116,20 @@ ftrace_stub:
 NESTED(_mcount, PT_SIZE, ra)
 	PTR_LA	t1, ftrace_stub
 	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
-	bne	t1, t2, static_trace
+	beq	t1, t2, fgraph_trace
 	 nop
 
+	MCOUNT_SAVE_REGS
+
+	move	a0, ra		/* arg1: self return address */
+	jalr	t2		/* (1) call *ftrace_trace_function */
+	 move	a1, AT		/* arg2: parent's return address */
+
+	MCOUNT_RESTORE_REGS
+
+fgraph_trace:
 #ifdef	CONFIG_FUNCTION_GRAPH_TRACER
+	PTR_LA	t1, ftrace_stub
 	PTR_L	t3, ftrace_graph_return
 	bne	t1, t3, ftrace_graph_caller
 	 nop
@@ -128,24 +138,11 @@ NESTED(_mcount, PT_SIZE, ra)
 	bne	t1, t3, ftrace_graph_caller
 	 nop
 #endif
-	b	ftrace_stub
-#ifdef CONFIG_32BIT
-	 addiu sp, sp, 8
-#else
-	 nop
-#endif
-
-static_trace:
-	MCOUNT_SAVE_REGS
-
-	move	a0, ra		/* arg1: self return address */
-	jalr	t2		/* (1) call *ftrace_trace_function */
-	 move	a1, AT		/* arg2: parent's return address */
 
-	MCOUNT_RESTORE_REGS
 #ifdef CONFIG_32BIT
 	addiu sp, sp, 8
 #endif
+
 	.globl ftrace_stub
 ftrace_stub:
 	RETURN_BACK


