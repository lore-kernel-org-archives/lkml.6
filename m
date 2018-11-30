Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13C120863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13C120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLAJfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeLAJfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:35:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 990333002509;
        Fri, 30 Nov 2018 22:24:51 +0000 (UTC)
Received: from treble (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6328B19C7D;
        Fri, 30 Nov 2018 22:24:49 +0000 (UTC)
Date:   Fri, 30 Nov 2018 16:24:47 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20181130222447.u5yxnsvxg7zqibie@treble>
References: <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home>
 <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <20181129141648.6ef944a9@gandalf.local.home>
 <20181129192211.ndzj2ltzx5t6x2qe@treble>
 <eb15f2dd-92f3-423d-e22f-3d1528fb7b6e@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb15f2dd-92f3-423d-e22f-3d1528fb7b6e@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 30 Nov 2018 22:24:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:16:34PM +0100, Rasmus Villemoes wrote:
> On 29/11/2018 20.22, Josh Poimboeuf wrote:
> > On Thu, Nov 29, 2018 at 02:16:48PM -0500, Steven Rostedt wrote:
> >>> and honestly, the way "static_call()" works now, can you guarantee
> >>> that the call-site doesn't end up doing that, and calling the
> >>> trampoline function for two different static calls from one indirect
> >>> call?
> >>>
> >>> See what I'm talking about? Saying "callers are wrapped in macros"
> >>> doesn't actually protect you from the compiler doing things like that.
> >>>
> >>> In contrast, if the call was wrapped in an inline asm, we'd *know* the
> >>> compiler couldn't turn a "call wrapper(%rip)" into anything else.
> >>
> >> But then we need to implement all numbers of parameters.
> > 
> > I actually have an old unfinished patch which (ab)used C macros to
> > detect the number of parameters and then setup the asm constraints
> > accordingly.  At the time, the goal was to optimize the BUG code.
> > 
> > I had wanted to avoid this kind of approach for static calls, because
> > "ugh", but now it's starting to look much more appealing.
> > 
> > Behold:
> > 
> > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > index aa6b2023d8f8..d63e9240da77 100644
> > --- a/arch/x86/include/asm/bug.h
> > +++ b/arch/x86/include/asm/bug.h
> > @@ -32,10 +32,59 @@
> >  
> >  #ifdef CONFIG_DEBUG_BUGVERBOSE
> >  
> > -#define _BUG_FLAGS(ins, flags)						\
> > +#define __BUG_ARGS_0(ins, ...) \
> > +({\
> > +	asm volatile("1:\t" ins "\n"); \
> > +})
> > +#define __BUG_ARGS_1(ins, ...) \
> > +({\
> > +	asm volatile("1:\t" ins "\n" \
> > +		     : : "D" (ARG1(__VA_ARGS__))); \
> > +})
> > +#define __BUG_ARGS_2(ins, ...) \
> > +({\
> > +	asm volatile("1:\t" ins "\n" \
> > +		     : : "D" (ARG1(__VA_ARGS__)), \
> > +			 "S" (ARG2(__VA_ARGS__))); \
> > +})
> > +#define __BUG_ARGS_3(ins, ...) \
> > +({\
> > +	asm volatile("1:\t" ins "\n" \
> > +		     : : "D" (ARG1(__VA_ARGS__)), \
> > +			 "S" (ARG2(__VA_ARGS__)), \
> > +			 "d" (ARG3(__VA_ARGS__))); \
> > +})
> 
> wouldn't you need to tie all these to (unused) outputs as well as adding
> the remaining caller-saved registers to the clobber list? Maybe not for
> the WARN machinery(?), but at least for stuff that should look like a
> normal call to gcc? Then there's %rax which is either a clobber or an
> output, and if there's not to be a separate static_call_void(), one
> would need to do some __builtin_choose_expr(__same_type(void, f(...)), ...).

Yes, this is a crappy unfinished patch.  It should be ignored, and
perhaps even mercilessly mocked :-)

paravirt_types.h already does something similar today, and it's at least
more correct than this.

What I was trying to show was that you can use macros to count
arguments, like this:

  _BUG_ARGS(ins, NUM_ARGS(__VA_ARGS__), __VA_ARGS__);

which can make a macro look and act like a function call.  Though as
Steven pointed out, the concept falls apart after 6 arguments.

-- 
Josh
