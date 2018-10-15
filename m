Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B314F20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B314F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeJOWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbeJOWIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:08:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 501FAA82C;
        Mon, 15 Oct 2018 14:23:01 +0000 (UTC)
Received: from treble (ovpn-125-6.rdu2.redhat.com [10.10.125.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF3CB1057075;
        Mon, 15 Oct 2018 14:22:58 +0000 (UTC)
Date:   Mon, 15 Oct 2018 09:22:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, nick.desaulniers@gmail.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Message-ID: <20181015142252.6p2zgkznj26jzdwl@treble>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015051705.GA20687@flashbox>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 15 Oct 2018 14:23:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 10:17:05PM -0700, Nathan Chancellor wrote:
> On Sun, Oct 14, 2018 at 08:43:18PM -0700, Andy Lutomirski wrote:
> > On Sun, Oct 14, 2018 at 5:37 PM Nick Desaulniers
> > <nick.desaulniers@gmail.com> wrote:
> > >
> > > Fixes the objtool warning:
> > > arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> > > instruction
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/204
> > > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > ---
> > >  arch/x86/mm/fault.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index 47bebfe6efa7..057d2178fa19 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> > >                  * and then double-fault, though, because we're likely to
> > >                  * break the console driver and lose most of the stack dump.
> > >                  */
> > > -               asm volatile ("movq %[stack], %%rsp\n\t"
> > > +               asm volatile (UNWIND_HINT_SAVE
> > > +                             "movq %[stack], %%rsp\n\t"
> > >                               "call handle_stack_overflow\n\t"
> > > -                             "1: jmp 1b"
> > > +                             "1: jmp 1b\n\t"
> > > +                             UNWIND_HINT_RESTORE
> > >                               : ASM_CALL_CONSTRAINT
> > >                               : "D" ("kernel stack overflow (page fault)"),
> > >                                 "S" (regs), "d" (address),
> > 
> > NAK.  Just below this snippet is unreachable();
> > 
> > Can you reply with objtool -dr output on a problematic fault.o?  Josh,
> > it *looks* like annotate_unreachable() should be doing the right
> > thing, but something is clearly busted.
> > 
> > Also, shouldn't compiler-clang.h contain a reasonable definition of
> > unreachable()?
> > 
> > --Andy
> 
> Hi Andy,
> 
> Did you mean 'objdump -dr'? If so, here you go (rather long, sorry if I
> should have pasted it here instead):
> https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5503e

As Andy said, I think compiler-clang.h needs an unreachable()
definition.  Without that, I'm guessing you're getting this:

  #ifndef unreachable
  # define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
  #endif

which converts "unreachable" to "reachable".  That used to be needed for
pre-4.5 versions of GCC when we supported them, but it's the wrong
behavior for this piece of code (and I should remove all those old GCC
hacks soon...)

-- 
Josh
