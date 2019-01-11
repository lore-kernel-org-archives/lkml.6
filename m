Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424C6218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbfAKTYu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:24:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53779 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfAKTYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:24:50 -0500
Received: from [10.171.236.31] ([192.55.54.60])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0BJNWSE781204
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 11 Jan 2019 11:23:33 -0800
Date:   Fri, 11 Jan 2019 11:23:29 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net> <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com> <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com> <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble> <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 0/6] Static calls
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
From:   hpa@zytor.com
Message-ID: <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 11, 2019 11:03:30 AM PST, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, Jan 11, 2019 at 7:15 AM Josh Poimboeuf <jpoimboe@redhat.com>
>wrote:
>>
>> >
>> > Now, in the int3 handler can you take the faulting RIP and search
>for it in
>> > the “static-calls” table, writing the RIP+5 (offset) into R10
>(return
>> > address) and the target into R11. You make the int3 handler to
>divert the
>> > code execution by changing pt_regs->rip to point to a new function
>that does:
>> >
>> >       push R10
>> >       jmp __x86_indirect_thunk_r11
>> >
>> > And then you are done. No?
>>
>> IIUC, that sounds pretty much like what Steven proposed:
>>
>>  
>https://lkml.kernel.org/r/20181129122000.7fb4fb04@gandalf.local.home
>>
>> I liked the idea, BUT, how would it work for callee-saved PV ops?  In
>> that case there's only one clobbered register to work with (rax).
>
>Actually, there's a much simpler model now that I think about it.
>
>The BP fixup just fixes up %rip to to point to "bp_int3_handler".
>
>And that's just a random text address set up by "text_poke_bp()".
>
>So how about the static call rewriting simply do this:
>
> - for each static call:
>
> 1)   create a fixup code stub that does
>
>        push $returnaddressforTHIScall
>        jmp targetforTHIScall
>
> 2) do
>
>        on_each_cpu(do_sync_core, NULL, 1);
>
>     to make sure all CPU's see this generated code
>
>  3) do
>
>        text_poke_bp(addr, newcode, newlen, generatedcode);
>
>Ta-daa! Done.
>
>In fact, it turns out that even the extra "do_sync_core()" in #2 is
>unnecessary, because taking the BP will be serializing on the CPU that
>takes it, so we can skip it.
>
>End result: the text_poke_bp() function will do the two do_sync_core
>IPI's that guarantee that by the time it returns, no other CPU is
>using the generated code any more, so it can be re-used for the next
>static call fixup.
>
>Notice? No odd emulation, no need to adjust the stack in the BP
>handler, just the regular "return to a different IP".
>
>Now, there is a nasty special case with that stub, though.
>
>So nasty thing with the whole "generate a stub for each call" case:
>because it's dynamic and because of the re-use of the stub, you could
>be in the situation where:
>
>  CPU1                  CPU2
>  ----                  ----
>
>  generate a stub
>  on_each_cpu(do_sync_core..)
>  text_poke_bp()
>  ...
>
>  rewrite to BP
>                        trigger the BP
>                        return to the stub
>                        fun the first instruction of the stub
>                        *INTERRUPT causes rescheduling*
>
>  on_each_cpu(do_sync_core..)
>  rewrite to good instruction
>  on_each_cpu(do_sync_core..)
>
>  free or re-generate the stub
>
>                        !! The stub is still in use !!
>
>So that simple "just generate the stub dynamically" isn't so simple
>after all.
>
>But it turns out that that is really simple to handle too. How do we do
>that?
>
>We do that by giving the BP handler *two* code sequences, and we make
>the BP handler pick one depending on whether it is returning to a
>"interrupts disabled" or "interrupts enabled" case.
>
>So the BP handler does this:
>
> - if we're returning with interrupts disabled, pick the simple stub
>
> - if we're returning with interrupts enabled, clkear IF in the return
>%rflags, and pick a *slightly* more complex stub:
>
>        push $returnaddressforTHIScall
>        sti
>        jmp targetforTHIScall
>
>and now the STI shadow will mean that this sequence is uninterruptible.
>
>So we'd not do complex emulation of the call instruction at BP time,
>but we'd do that *trivial* change at BP time.
>
>This seems simple, doesn't need any temporary registers at all, and
>doesn't need any extra stack magic. It literally needs just a trivial
>sequence in poke_int3_handler().
>
>The we'd change the end of poke_int3_handler() to do something like
>this instead:
>
>        void *newip = bp_int3_handler;
>        ..
>        if (new == magic_static_call_bp_int3_handler) {
>                if (regs->flags &X86_FLAGS_IF) {
>                        newip = magic_static_call_bp_int3_handler_sti;
>                        regs->flags &= ~X86_FLAGS_IF;
>        }
>        regs->ip = (unsigned long) newip;
>        return 1;
>
>AAND now we're *really* done.
>
>Does anybody see any issues in this?
>
>              Linus

I still don't see why can't simply spin in the #BP handler until the patch is complete.

We can't have the #BP handler do any additional patching, as previously discussed, but spinning should be perfectly safe. The simplest way to spin it to just IRET; that both serializes and will re-take the exception if the patch is still in progress.

It requires exactly *no* awareness in the #BP handler, allows for the call to be replaced with inline code or a simple NOP if desired (or vice versa, as long as it is a single instruction.)

If I'm missing something, then please educate me or point me to previous discussion; I would greatly appreciate it.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
