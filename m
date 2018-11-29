Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED7B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED7B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeK3GeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeK3GeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:34:12 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D7B820868;
        Thu, 29 Nov 2018 19:27:40 +0000 (UTC)
Date:   Thu, 29 Nov 2018 14:27:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129142739.7a48c078@gandalf.local.home>
In-Reply-To: <20181129192211.ndzj2ltzx5t6x2qe@treble>
References: <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
        <20181129121307.12393c57@gandalf.local.home>
        <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
        <20181129124404.2fe55dd0@gandalf.local.home>
        <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
        <20181129125857.75c55b96@gandalf.local.home>
        <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
        <20181129134725.6d86ade6@gandalf.local.home>
        <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
        <20181129141648.6ef944a9@gandalf.local.home>
        <20181129192211.ndzj2ltzx5t6x2qe@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 13:22:11 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Nov 29, 2018 at 02:16:48PM -0500, Steven Rostedt wrote:
> > > and honestly, the way "static_call()" works now, can you guarantee
> > > that the call-site doesn't end up doing that, and calling the
> > > trampoline function for two different static calls from one indirect
> > > call?
> > > 
> > > See what I'm talking about? Saying "callers are wrapped in macros"
> > > doesn't actually protect you from the compiler doing things like that.
> > > 
> > > In contrast, if the call was wrapped in an inline asm, we'd *know* the
> > > compiler couldn't turn a "call wrapper(%rip)" into anything else.  
> > 
> > But then we need to implement all numbers of parameters.  
> 
> I actually have an old unfinished patch which (ab)used C macros to
> detect the number of parameters and then setup the asm constraints
> accordingly.  At the time, the goal was to optimize the BUG code.
> 
> I had wanted to avoid this kind of approach for static calls, because
> "ugh", but now it's starting to look much more appealing.
> 
> Behold:
> 
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index aa6b2023d8f8..d63e9240da77 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -32,10 +32,59 @@
>  
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  
> -#define _BUG_FLAGS(ins, flags)						\
> +#define __BUG_ARGS_0(ins, ...) \
> +({\
> +	asm volatile("1:\t" ins "\n"); \
> +})
> +#define __BUG_ARGS_1(ins, ...) \
> +({\
> +	asm volatile("1:\t" ins "\n" \
> +		     : : "D" (ARG1(__VA_ARGS__))); \
> +})
> +#define __BUG_ARGS_2(ins, ...) \
> +({\
> +	asm volatile("1:\t" ins "\n" \
> +		     : : "D" (ARG1(__VA_ARGS__)), \
> +			 "S" (ARG2(__VA_ARGS__))); \
> +})
> +#define __BUG_ARGS_3(ins, ...) \
> +({\
> +	asm volatile("1:\t" ins "\n" \
> +		     : : "D" (ARG1(__VA_ARGS__)), \
> +			 "S" (ARG2(__VA_ARGS__)), \
> +			 "d" (ARG3(__VA_ARGS__))); \
> +})
> +#define __BUG_ARGS_4(ins, ...) \
> +({\
> +	asm volatile("1:\t" ins "\n" \
> +		     : : "D" (ARG1(__VA_ARGS__)), \
> +			 "S" (ARG2(__VA_ARGS__)), \
> +			 "d" (ARG3(__VA_ARGS__)), \
> +			 "c" (ARG4(__VA_ARGS__))); \
> +})
> +#define __BUG_ARGS_5(ins, ...) \
> +({\
> +	register u64 __r8 asm("r8") = (u64)ARG5(__VA_ARGS__); \
> +	asm volatile("1:\t" ins "\n" \
> +		     : : "D" (ARG1(__VA_ARGS__)), \
> +			 "S" (ARG2(__VA_ARGS__)), \
> +			 "d" (ARG3(__VA_ARGS__)), \
> +			 "c" (ARG4(__VA_ARGS__)), \
> +			 "r" (__r8)); \
> +})
> +#define __BUG_ARGS_6 foo
> +#define __BUG_ARGS_7 foo
> +#define __BUG_ARGS_8 foo
> +#define __BUG_ARGS_9 foo
> +


There exist tracepoints with 13 arguments.

-- Steve
