Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3924C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8635A20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHmclqAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8635A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeK3Dza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:55:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbeK3Dza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dTEjWIQbOULmijBN7xN0uINojAPuCrL3hnMR4RX64S4=; b=hHmclqAIvHhlUApStuY98SqGS
        BXiyBS06dkFXxP3q06sqqs1njW5Wgh+xWXPwgB6RAvcpsFXuylhNUb87B3P+XYWDa5TtafBL+2Rtf
        AnxiBgAhRjXGnO7a1IuY4G4oG0aE88GM4fYywY56cMaE+QpBCVVRedHZpu83nUUu2nQ2usGt4mje6
        QU8UfOp+RDON+9qRyCaPrVu4g1j92ygYsDOyWD7+z+58cW/qYNUQ8VxyG78PZUFL4SBZmjGW6LOql
        8SaizDow63IQm0vTSbULQCe4QUeMn+FB/vIGk25r0QZ22gdiOUvs9sa+SuAKAvqLYMUd+S1npWTMU
        7G0G1iXZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSPV6-0008Iq-QE; Thu, 29 Nov 2018 16:49:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31B082029FD58; Thu, 29 Nov 2018 17:49:14 +0100 (CET)
Date:   Thu, 29 Nov 2018 17:49:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129164914.GA9027@hirez.programming.kicks-ass.net>
References: <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net>
 <20181129163342.tp5wlfcyiazwwyoh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129163342.tp5wlfcyiazwwyoh@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:33:42AM -0600, Josh Poimboeuf wrote:
> > can't we 'fix' that again? The alternative is moving that IRET-frame and
> > fixing everything up, which is going to be fragile, ugly and such
> > things more.

> This seems to work...

That's almost too easy... nice!

> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index ce25d84023c0..184523447d35 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -876,7 +876,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
>   * @paranoid == 2 is special: the stub will never switch stacks.  This is for
>   * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
>   */
> -.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
> +.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 create_gap=0
>  ENTRY(\sym)
>  	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
>  
> @@ -891,6 +891,12 @@ ENTRY(\sym)
>  	pushq	$-1				/* ORIG_RAX: no syscall to restart */
>  	.endif
>  
> +	.if \create_gap == 1
> +	.rept 6
> +	pushq 5*8(%rsp)
> +	.endr
> +	.endif
> +
>  	.if \paranoid == 1
>  	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
>  	jnz	.Lfrom_usermode_switch_stack_\@
> @@ -1126,7 +1132,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
>  #endif /* CONFIG_HYPERV */
>  
>  idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
> -idtentry int3			do_int3			has_error_code=0
> +idtentry int3			do_int3			has_error_code=0	create_gap=1
>  idtentry stack_segment		do_stack_segment	has_error_code=1
>  
>  #ifdef CONFIG_XEN_PV
