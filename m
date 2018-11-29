Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B24C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111BC21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111BC21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeK3Hbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:31:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeK3Hbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:31:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A95FD30C1214;
        Thu, 29 Nov 2018 20:24:57 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB9D161520;
        Thu, 29 Nov 2018 20:24:54 +0000 (UTC)
Date:   Thu, 29 Nov 2018 14:24:52 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129202452.56f4j2wdct6qbaqo@treble>
References: <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home>
 <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 29 Nov 2018 20:24:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:27:00AM -0800, Andy Lutomirski wrote:
> On Thu, Nov 29, 2018 at 11:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Nov 29, 2018 at 10:58 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > In contrast, if the call was wrapped in an inline asm, we'd *know* the
> > > compiler couldn't turn a "call wrapper(%rip)" into anything else.
> >
> > Actually, I think I have a better model - if the caller is done with inline asm.
> >
> > What you can do then is basically add a single-byte prefix to the
> > "call" instruction that does nothing (say, cs override), and then
> > replace *that* with a 'int3' instruction.
> >
> > Boom. Done.
> >
> > Now, the "int3" handler can just update the instruction in-place, but
> > leave the "int3" in place, and then return to the next instruction
> > byte (which is just the normal branch instruction without the prefix
> > byte).
> >
> > The cross-CPU case continues to work, because the 'int3' remains in
> > place until after the IPI.
> 
> Hmm, cute.  But then the calls are in inline asm, which results in
> giant turds like we have for the pvop vcalls.  And, if they start
> being used more generally, we potentially have ABI issues where the
> calling convention isn't quite what the asm expects, and we explode.
> 
> I propose a different solution:
> 
> As in this patch set, we have a direct and an indirect version.  The
> indirect version remains exactly the same as in this patch set.  The
> direct version just only does the patching when all seems well: the
> call instruction needs to be 0xe8, and we only do it when the thing
> doesn't cross a cache line.  Does that work?  In the rare case where
> the compiler generates something other than 0xe8 or crosses a cache
> line, then the thing just remains as a call to the out of line jmp
> trampoline.  Does that seem reasonable?  It's a very minor change to
> the patch set.

Maybe that would be ok.  If my math is right, we would use the
out-of-line version almost 5% of the time due to cache misalignment of
the address.

> Alternatively, we could actually emulate call instructions like this:
> 
> void __noreturn jump_to_kernel_pt_regs(struct pt_regs *regs, ...)
> {
>   struct pt_regs ptregs_copy = *regs;
>   barrier();
>   *(unsigned long *)(regs->sp - 8) = whatever;  /* may clobber old
> regs, but so what? */
>   asm volatile ("jmp return_to_alternate_ptregs");
> }
> 
> where return_to_alternate_ptregs points rsp to the ptregs and goes
> through the normal return path.  It's ugly, but we could have a test
> case for it, and it should work fine.

Is that really any better than my patch to create a gap in the stack
(modified for kernel space #BP only)?

-- 
Josh
