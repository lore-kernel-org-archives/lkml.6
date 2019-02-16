Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189E8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C3F222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfBPEHk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:07:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54755 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfBPEHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:07:40 -0500
Received: from [IPv6:2601:646:8680:2bb1:4d04:7df8:9f95:eec1] ([IPv6:2601:646:8680:2bb1:4d04:7df8:9f95:eec1])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1G477Q71484064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 15 Feb 2019 20:07:09 -0800
Date:   Fri, 15 Feb 2019 20:06:56 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
References: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com> <20190213131720.GU32494@hirez.programming.kicks-ass.net> <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net> <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net> <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net> <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net> <20190214101429.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
From:   hpa@zytor.com
Message-ID: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 14, 2019 2:14:29 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>On Wed, Feb 13, 2019 at 02:49:47PM -0800, Andy Lutomirski wrote:
>
>> Do we need to backport this thing?
>
>Possibly, just to be safe.
>
>> The problem can’t be too widespread or we would have heard of it
>before.
>
>Yes, so far we've been lucky.
>
>---
>Subject: sched/x86: Save [ER]FLAGS on context switch
>From: Peter Zijlstra <peterz@infradead.org>
>Date: Thu Feb 14 10:30:52 CET 2019
>
>Effectively revert commit:
>
>  2c7577a75837 ("sched/x86_64: Don't save flags on context switch")
>
>Specifically because SMAP uses FLAGS.AC which invalidates the claim
>that the kernel has clean flags.
>
>In particular; while preemption from interrupt return is fine (the
>IRET frame on the exception stack contains FLAGS) it breaks any code
>that does synchonous scheduling, including preempt_enable().
>
>This has become a significant issue ever since commit:
>
>5b24a7a2aa20 ("Add 'unsafe' user access functions for batched
>accesses")
>
>provided for means of having 'normal' C code between STAC / CLAC,
>exposing the FLAGS.AC state. So far this hasn't led to trouble,
>however fix it before it comes apart.
>
>Fixes: 5b24a7a2aa20 ("Add 'unsafe' user access functions for batched
>accesses")
>Acked-by: Andy Lutomirski <luto@amacapital.net>
>Reported-by: Julien Thierry <julien.thierry@arm.com>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>---
> arch/x86/entry/entry_32.S        |    2 ++
> arch/x86/entry/entry_64.S        |    2 ++
> arch/x86/include/asm/switch_to.h |    1 +
> 3 files changed, 5 insertions(+)
>
>--- a/arch/x86/entry/entry_32.S
>+++ b/arch/x86/entry/entry_32.S
>@@ -650,6 +650,7 @@ ENTRY(__switch_to_asm)
> 	pushl	%ebx
> 	pushl	%edi
> 	pushl	%esi
>+	pushfl
> 
> 	/* switch stack */
> 	movl	%esp, TASK_threadsp(%eax)
>@@ -672,6 +673,7 @@ ENTRY(__switch_to_asm)
> #endif
> 
> 	/* restore callee-saved registers */
>+	popfl
> 	popl	%esi
> 	popl	%edi
> 	popl	%ebx
>--- a/arch/x86/entry/entry_64.S
>+++ b/arch/x86/entry/entry_64.S
>@@ -291,6 +291,7 @@ ENTRY(__switch_to_asm)
> 	pushq	%r13
> 	pushq	%r14
> 	pushq	%r15
>+	pushfq
> 
> 	/* switch stack */
> 	movq	%rsp, TASK_threadsp(%rdi)
>@@ -313,6 +314,7 @@ ENTRY(__switch_to_asm)
> #endif
> 
> 	/* restore callee-saved registers */
>+	popfq
> 	popq	%r15
> 	popq	%r14
> 	popq	%r13
>--- a/arch/x86/include/asm/switch_to.h
>+++ b/arch/x86/include/asm/switch_to.h
>@@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
>  * order of the fields must match the code in __switch_to_asm().
>  */
> struct inactive_task_frame {
>+	unsigned long flags;
> #ifdef CONFIG_X86_64
> 	unsigned long r15;
> 	unsigned long r14;

This implies we invoke schedule -- a restricted operation (consider may_sleep) during execution of STAC-enabled code, but *not* as an exception or interrupt, since those preserve the flags.

I have serious concerns about this. This is more or less saying that we have left an unlimited gap and have had AC escape.

Does *anyone* see a need to allow this? I got a question at LPC from someone about this, and what they were trying to do once all the layers had been unwound was so far down the wrong track for a root problem that actually has a very simple solution.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
