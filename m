Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D1C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F6A218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6A218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHJV6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHJV6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:58:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE918215A4;
        Fri, 10 Aug 2018 19:27:40 +0000 (UTC)
Date:   Fri, 10 Aug 2018 15:27:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: implement ftrace with regs
Message-ID: <20180810152738.695cff07@gandalf.local.home>
In-Reply-To: <20180810160223.D360D68C76@newverein.lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de>
        <20180810160223.D360D68C76@newverein.lst.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 18:02:23 +0200 (CEST)
Torsten Duwe <duwe@lst.de> wrote:

> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -13,6 +13,8 @@
>  #include <asm/assembler.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
>  
>  /*
>   * Gcc with -pg will put the following code in the beginning of each function:
> @@ -123,6 +125,7 @@ skip_ftrace_call:			// }
>  ENDPROC(_mcount)
>  
>  #else /* CONFIG_DYNAMIC_FTRACE */
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  /*
>   * _mcount() is used to build the kernel with -pg option, but all the branch
>   * instructions to _mcount() are replaced to NOP initially at kernel start up,
> @@ -162,6 +165,84 @@ ftrace_graph_call:			// ftrace_graph_cal
>  
>  	mcount_exit
>  ENDPROC(ftrace_caller)
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +ENTRY(_mcount)
> +	mov     x10, lr
> +	mov     lr, x9
> +	ret     x10
> +ENDPROC(_mcount)
> +
> +ENTRY(ftrace_caller)
> +	stp	x29, x9, [sp, #-16]!
> +	sub	sp, sp, #S_FRAME_SIZE
> +
> +	stp	x0, x1, [sp]
> +	stp	x2, x3, [sp, #16]
> +	stp	x4, x5, [sp, #32]
> +	stp	x6, x7, [sp, #48]
> +	stp	x8, x9, [sp, #64]
> +	stp	x10, x11, [sp, #80]
> +	stp	x12, x13, [sp, #96]
> +	stp	x14, x15, [sp, #112]
> +	stp	x16, x17, [sp, #128]
> +	stp	x18, x19, [sp, #144]
> +	stp	x20, x21, [sp, #160]
> +	stp	x22, x23, [sp, #176]
> +	stp	x24, x25, [sp, #192]
> +	stp	x26, x27, [sp, #208]
> +	stp	x28, x29, [sp, #224]

Wait! You are having ftrace_caller *always* perform the regs save? Why?
This is why I have a ftrace_caller and a ftrace_regs_caller, so that
normal function tracing doesn't take the overhead hit of tracing all
functions. And note, the generic code will differentiate per function.
The regs calling is usually only done for a handful of functions, the
normal tracing of all functions doesn't need it.

Or am I missing something?


> +	/* The link Register at callee entry */
> +	str	x9, [sp, #S_LR]
> +	/* The program counter just after the ftrace call site */
> +	str	lr, [sp, #S_PC]
> +	/* The stack pointer as it was on ftrace_caller entry... */
> +	add	x29, sp, #S_FRAME_SIZE+16	/* ...is also our new FP */
> +	str	x29, [sp, #S_SP]
> +
> +	adrp    x0, function_trace_op
> +	ldr     x2, [x0, #:lo12:function_trace_op]
> +	mov	x1, x9		/* saved LR == parent IP */
> +	sub	x0, lr, #8	/* function entry == IP */
> +	mov	x3, sp		/* complete pt_regs are @sp */
> +
> +	.global ftrace_call
> +ftrace_call:
> +
> +	bl	ftrace_stub
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	.global ftrace_graph_call
> +ftrace_graph_call:			// ftrace_graph_caller();
> +	nop				// If enabled, this will be replaced
> +					// "b ftrace_graph_caller"
> +#endif
> +
> +ftrace_regs_return:
> +	ldp	x0, x1, [sp]
> +	ldp	x2, x3, [sp, #16]
> +	ldp	x4, x5, [sp, #32]
> +	ldp	x6, x7, [sp, #48]
> +	ldp	x8, x9, [sp, #64]
> +	ldp	x10, x11, [sp, #80]
> +	ldp	x12, x13, [sp, #96]
> +	ldp	x14, x15, [sp, #112]
> +	ldp	x16, x17, [sp, #128]
> +	ldp	x18, x19, [sp, #144]
> +	ldp	x20, x21, [sp, #160]
> +	ldp	x22, x23, [sp, #176]
> +	ldp	x24, x25, [sp, #192]
> +	ldp	x26, x27, [sp, #208]
> +	ldp	x28, x29, [sp, #224]
> +
> +	ldr	x9, [sp, #S_PC]
> +	ldr	lr, [sp, #S_LR]
> +	add	sp, sp, #S_FRAME_SIZE+16
> +
> +	ret	x9
> +
> +ENDPROC(ftrace_caller)
> +
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  
>  ENTRY(ftrace_stub)
> @@ -197,12 +278,20 @@ ENDPROC(ftrace_stub)
>   * and run return_to_handler() later on its exit.
>   */
>  ENTRY(ftrace_graph_caller)
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  	mcount_get_lr_addr	  x0	//     pointer to function's saved lr
>  	mcount_get_pc		  x1	//     function's pc
>  	mcount_get_parent_fp	  x2	//     parent's fp
>  	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
>  
>  	mcount_exit
> +#else
> +	add	x0, sp, #S_LR	/* address of (LR pointing into caller) */
> +	ldr	x1, [sp, #S_PC]
> +	ldr	x2, [sp, #232]	/* caller's frame pointer */
> +	bl	prepare_ftrace_return
> +	b	ftrace_regs_return
> +#endif
>  ENDPROC(ftrace_graph_caller)
>  
