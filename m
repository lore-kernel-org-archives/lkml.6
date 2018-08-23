Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24BAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A5208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643A5208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeHWL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:57:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbeHWL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:57:32 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB0988B1;
        Thu, 23 Aug 2018 08:28:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 124/217] openrisc: entry: Fix delay slot exception detection
Date:   Thu, 23 Aug 2018 09:53:57 +0200
Message-Id: <20180823075511.107363876@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit ae15a41a641449f536578b0d9ec0e4ade130deb5 ]

Originally in patch e6d20c55a4 ("openrisc: entry: Fix delay slot
detection") I fixed delay slot detection, but only for QEMU.  We missed
that hardware delay slot detection using delay slot exception flag (DSX)
was still broken.  This was because QEMU set the DSX flag in both
pre-exception supervision register (ESR) and supervision register (SR)
register, but on real hardware the DSX flag is only set on the SR
register during exceptions.

Fix this by carrying the DSX flag into the SR register during exception.
We also update the DSX flag read locations to read the value from the SR
register not the pt_regs SR register which represents ESR.  The ESR
should never have the DSX flag set.

In the process I updated/removed a few comments to match the current
state.  Including removing a comment saying that the DSX detection logic
was inefficient and needed to be rewritten.

I have tested this on QEMU with a patch ensuring it matches the hardware
specification.

Link: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg00000.html
Fixes: e6d20c55a4 ("openrisc: entry: Fix delay slot detection")
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/openrisc/kernel/entry.S |    8 +-------
 arch/openrisc/kernel/head.S  |    9 ++++++---
 arch/openrisc/kernel/traps.c |    2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -221,12 +221,6 @@ EXCEPTION_ENTRY(_data_page_fault_handler
 	l.addi  r3,r1,0                    // pt_regs
 	/* r4 set be EXCEPTION_HANDLE */   // effective address of fault
 
-	/*
-	 * __PHX__: TODO
-	 *
-	 * all this can be written much simpler. look at
-	 * DTLB miss handler in the CONFIG_GUARD_PROTECTED_CORE part
-	 */
 #ifdef CONFIG_OPENRISC_NO_SPR_SR_DSX
 	l.lwz   r6,PT_PC(r3)               // address of an offending insn
 	l.lwz   r6,0(r6)                   // instruction that caused pf
@@ -258,7 +252,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler
 
 #else
 
-	l.lwz   r6,PT_SR(r3)               // SR
+	l.mfspr r6,r0,SPR_SR               // SR
 	l.andi  r6,r6,SPR_SR_DSX           // check for delay slot exception
 	l.sfne  r6,r0                      // exception happened in delay slot
 	l.bnf   7f
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -141,8 +141,7 @@
  *	 r4  - EEAR     exception EA
  *	 r10 - current	pointing to current_thread_info struct
  *	 r12 - syscall  0, since we didn't come from syscall
- *	 r13 - temp	it actually contains new SR, not needed anymore
- *	 r31 - handler	address of the handler we'll jump to
+ *	 r30 - handler	address of the handler we'll jump to
  *
  *	 handler has to save remaining registers to the exception
  *	 ksp frame *before* tainting them!
@@ -178,6 +177,7 @@
 	/* r1 is KSP, r30 is __pa(KSP) */			;\
 	tophys  (r30,r1)					;\
 	l.sw    PT_GPR12(r30),r12				;\
+	/* r4 use for tmp before EA */				;\
 	l.mfspr r12,r0,SPR_EPCR_BASE				;\
 	l.sw    PT_PC(r30),r12					;\
 	l.mfspr r12,r0,SPR_ESR_BASE				;\
@@ -197,7 +197,10 @@
 	/* r12 == 1 if we come from syscall */			;\
 	CLEAR_GPR(r12)						;\
 	/* ----- turn on MMU ----- */				;\
-	l.ori	r30,r0,(EXCEPTION_SR)				;\
+	/* Carry DSX into exception SR */			;\
+	l.mfspr r30,r0,SPR_SR					;\
+	l.andi	r30,r30,SPR_SR_DSX				;\
+	l.ori	r30,r30,(EXCEPTION_SR)				;\
 	l.mtspr	r0,r30,SPR_ESR_BASE				;\
 	/* r30:	EA address of handler */			;\
 	LOAD_SYMBOL_2_GPR(r30,handler)				;\
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -358,7 +358,7 @@ static inline int in_delay_slot(struct p
 		return 0;
 	}
 #else
-	return regs->sr & SPR_SR_DSX;
+	return mfspr(SPR_SR) & SPR_SR_DSX;
 #endif
 }
 


