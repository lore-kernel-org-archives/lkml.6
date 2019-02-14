Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3613A222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="De5h/YYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438233AbfBNKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:14:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBNKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rr1CmuW1hkLZDfhshg5B72VqHAqywFTqsRCuxFY1VTE=; b=De5h/YYduj9mtYBgWubZ0DSab/
        9QPad4/JryplqAo7hzERgMzuivGmNxN6qa7oAIHou48QRRQjxsKmvClU+3VgXmen1Mp9Sav8SnXS5
        vBpORbDmuH4TtNBPLUE1c+4Mmm6jwFTPmiOLTzB/Yi1WqtlLB6z3C6UKxfJtuj0hCsKUsZwvOHQ+Q
        GXxWdbq1WIbyJyxX2Lza7kVsEUEH7wn4WbsdM3sE4tzTjdPn4uqWotbclhWy8YMFbdHCrofPFGdHk
        6QHmgkbcOwXXMyRiGD4sxK0WENajU9iSdFid1+ckxj4EEqyitVMRL3fF9lmNmrfrMdaIiBkrG20DM
        nv5ksn1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guE2K-0007WI-00; Thu, 14 Feb 2019 10:14:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D036D20298375; Thu, 14 Feb 2019 11:14:29 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:14:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Subject: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
References: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:49:47PM -0800, Andy Lutomirski wrote:

> Do we need to backport this thing?

Possibly, just to be safe.

> The problem can’t be too widespread or we would have heard of it before.

Yes, so far we've been lucky.

---
Subject: sched/x86: Save [ER]FLAGS on context switch
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Feb 14 10:30:52 CET 2019

Effectively revert commit:

  2c7577a75837 ("sched/x86_64: Don't save flags on context switch")

Specifically because SMAP uses FLAGS.AC which invalidates the claim
that the kernel has clean flags.

In particular; while preemption from interrupt return is fine (the
IRET frame on the exception stack contains FLAGS) it breaks any code
that does synchonous scheduling, including preempt_enable().

This has become a significant issue ever since commit:

  5b24a7a2aa20 ("Add 'unsafe' user access functions for batched accesses")

provided for means of having 'normal' C code between STAC / CLAC,
exposing the FLAGS.AC state. So far this hasn't led to trouble,
however fix it before it comes apart.

Fixes: 5b24a7a2aa20 ("Add 'unsafe' user access functions for batched accesses")
Acked-by: Andy Lutomirski <luto@amacapital.net>
Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S        |    2 ++
 arch/x86/entry/entry_64.S        |    2 ++
 arch/x86/include/asm/switch_to.h |    1 +
 3 files changed, 5 insertions(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -650,6 +650,7 @@ ENTRY(__switch_to_asm)
 	pushl	%ebx
 	pushl	%edi
 	pushl	%esi
+	pushfl
 
 	/* switch stack */
 	movl	%esp, TASK_threadsp(%eax)
@@ -672,6 +673,7 @@ ENTRY(__switch_to_asm)
 #endif
 
 	/* restore callee-saved registers */
+	popfl
 	popl	%esi
 	popl	%edi
 	popl	%ebx
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -291,6 +291,7 @@ ENTRY(__switch_to_asm)
 	pushq	%r13
 	pushq	%r14
 	pushq	%r15
+	pushfq
 
 	/* switch stack */
 	movq	%rsp, TASK_threadsp(%rdi)
@@ -313,6 +314,7 @@ ENTRY(__switch_to_asm)
 #endif
 
 	/* restore callee-saved registers */
+	popfq
 	popq	%r15
 	popq	%r14
 	popq	%r13
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
  * order of the fields must match the code in __switch_to_asm().
  */
 struct inactive_task_frame {
+	unsigned long flags;
 #ifdef CONFIG_X86_64
 	unsigned long r15;
 	unsigned long r14;
