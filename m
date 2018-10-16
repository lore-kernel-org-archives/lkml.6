Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D29C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C97F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir5x4ung"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C97F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbeJQBNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbeJQBNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C1620866;
        Tue, 16 Oct 2018 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710508;
        bh=pg2jarIqg17KtXqUeyWeToPPa2bPGi0nVCHN4ygCZI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir5x4ungX25tR0AkoE74d367egFNM3Iav04y5sNfpWi9sMTaFL6XfEyu5UUVD5aM1
         Mh/IB5anXO8NYcDBny6Kg5S4kQni1jE6qYt7Ighqs/4jMxA80pGDz79nvzSNm00P2H
         BI3OGVg9hkb4qW5oHlsXDRpkFWxFHI4dHVvlK7ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 102/109] ARM: spectre-v1: fix syscall entry
Date:   Tue, 16 Oct 2018 19:06:10 +0200
Message-Id: <20181016170530.539960618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 10573ae547c85b2c61417ff1a106cffbfceada35 upstream.

Prevent speculation at the syscall table decoding by clamping the index
used to zero on invalid system call numbers, and using the csdb
speculative barrier.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/entry-common.S |   18 +++++++-----------
 arch/arm/kernel/entry-header.S |   25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -241,9 +241,7 @@ local_restart:
 	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
 	bne	__sys_trace
 
-	cmp	scno, #NR_syscalls		@ check upper syscall limit
-	badr	lr, ret_fast_syscall		@ return address
-	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
+	invoke_syscall tbl, scno, r10, ret_fast_syscall
 
 	add	r1, sp, #S_OFF
 2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
@@ -277,14 +275,8 @@ __sys_trace:
 	mov	r1, scno
 	add	r0, sp, #S_OFF
 	bl	syscall_trace_enter
-
-	badr	lr, __sys_trace_return		@ return address
-	mov	scno, r0			@ syscall number (possibly new)
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	cmp	scno, #NR_syscalls		@ check upper syscall limit
-	ldmccia	r1, {r0 - r6}			@ have to reload r0 - r6
-	stmccia	sp, {r4, r5}			@ and update the stack args
-	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
+	mov	scno, r0
+	invoke_syscall tbl, scno, r10, __sys_trace_return, reload=1
 	cmp	scno, #-1			@ skip the syscall?
 	bne	2b
 	add	sp, sp, #S_OFF			@ restore stack
@@ -362,6 +354,10 @@ sys_syscall:
 		bic	scno, r0, #__NR_OABI_SYSCALL_BASE
 		cmp	scno, #__NR_syscall - __NR_SYSCALL_BASE
 		cmpne	scno, #NR_syscalls	@ check range
+#ifdef CONFIG_CPU_SPECTRE
+		movhs	scno, #0
+		csdb
+#endif
 		stmloia	sp, {r5, r6}		@ shuffle args
 		movlo	r0, r1
 		movlo	r1, r2
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -378,6 +378,31 @@
 #endif
 	.endm
 
+	.macro	invoke_syscall, table, nr, tmp, ret, reload=0
+#ifdef CONFIG_CPU_SPECTRE
+	mov	\tmp, \nr
+	cmp	\tmp, #NR_syscalls		@ check upper syscall limit
+	movcs	\tmp, #0
+	csdb
+	badr	lr, \ret			@ return address
+	.if	\reload
+	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
+	ldmccia	r1, {r0 - r6}			@ reload r0-r6
+	stmccia	sp, {r4, r5}			@ update stack arguments
+	.endif
+	ldrcc	pc, [\table, \tmp, lsl #2]	@ call sys_* routine
+#else
+	cmp	\nr, #NR_syscalls		@ check upper syscall limit
+	badr	lr, \ret			@ return address
+	.if	\reload
+	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
+	ldmccia	r1, {r0 - r6}			@ reload r0-r6
+	stmccia	sp, {r4, r5}			@ update stack arguments
+	.endif
+	ldrcc	pc, [\table, \nr, lsl #2]	@ call sys_* routine
+#endif
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.


