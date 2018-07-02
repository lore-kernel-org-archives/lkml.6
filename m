Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4790C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786FF24DDD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786FF24DDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754621AbeGBKsC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:48:02 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:39712 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeGBKsB (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Mon, 2 Jul 2018 06:48:01 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 02 Jul 2018 04:48:00 -0600
Message-Id: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Mon, 02 Jul 2018 04:47:57 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/entry/64: add two more instruction suffixes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sadly, other than claimed in a368d7fd2a ("x86/entry/64: Add instruction
suffix"), there are two more instances which want to be adjusted. As
said there, omitting suffixes from instructions in AT&T mode is bad
practice when operand size cannot be determined by the assembler from
register operands, and is likely going to be warned about by upstream
gas in the future (mine does already). Add the other missing suffixes
here as well.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/entry/entry_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 4.18-rc3/arch/x86/entry/entry_64.S
+++ 4.18-rc3-x86_64-entry-insn-suffix/arch/x86/entry/entry_64.S
@@ -92,7 +92,7 @@ END(native_usergs_sysret64)
 .endm
 
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -701,7 +701,7 @@ retint_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Interrupts are off */
 	/* Check if we need preemption */
-	bt	$9, EFLAGS(%rsp)		/* were interrupts off? */
+	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
 	jnc	1f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f




