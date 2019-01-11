Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C18C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444EB21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfAKVW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:22:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfAKVWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:22:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA6BA804FA;
        Fri, 11 Jan 2019 21:22:23 +0000 (UTC)
Received: from treble (ovpn-122-231.rdu2.redhat.com [10.10.122.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE67881636;
        Fri, 11 Jan 2019 21:22:12 +0000 (UTC)
Date:   Fri, 11 Jan 2019 15:22:10 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190111212210.veyfn5vvjswcwacm@treble>
References: <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 11 Jan 2019 21:22:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:46:39PM -0800, Linus Torvalds wrote:
> On Fri, Jan 11, 2019 at 12:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > I was referring to the fact that a single static call key update will
> > usually result in patching multiple call sites.  But you're right, it's
> > only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
> > we may want to batch all the writes like what Daniel has proposed for
> > jump labels, to reduce IPIs.
> 
> Yeah, my suggestion doesn't allow for batching, since it would
> basically generate one trampoline for every rewritten instruction.

As Andy said, I think batching would still be possible, it's just that
we'd have to create multiple trampolines at a time.

Or... we could do a hybrid approach: create a single custom trampoline
which has the call destination patched in, but put the return address in
%rax -- which is always clobbered, even for callee-saved PV ops.  Like:

trampoline:
	push %rax
	call patched-dest

That way the batching could be done with a single trampoline
(particularly if using rcu-sched to avoid the sti hack).

If you don't completely hate that approach then I may try it.

> > Regardless, the trampoline management seems more complex to me.  But
> > it's easier to argue about actual code, so maybe I'll code it up to make
> > it easier to compare solutions.
> 
> I do agree hat the stack games are likely "simpler" in one sense. I
> just abhor playing those kinds of games with the entry code and entry
> stack.
> 
> A small bit of extra complexity in the code that actually does the
> rewriting would be much more palatable to me than the complexity in
> the entry code. I prefer seeing the onus of complexity being on the
> code that introduces the problem, not on a innocent bystander.
> 
> I'd like to say that our entry code actually looks fairly sane these
> days.  I'd _like_ to say that, but I'd be lying through my teeth if I
> did. The macros we use make any normal persons head spin.
> 
> The workaround for the stack corruption was fairly simple, but the
> subtlety behind the *reason* for it was what made my hackles rise
> about that code.
> 
> The x86 entry code is some of the nastiest in the kernel, I feel, with
> all the subtle interactions about odd stack switches, odd CPU bugs
> causing odd TLB switches, NMI interactions etc etc.
> 
> So I am fully cognizant that the workaround to shift the stack in the
> entry code was just a couple of lines, and not very complicated.
> 
> And I agree that I may be a bit oversensitive about that area, but it
> really is one of those places where I go "damn, I think I know some
> low-level x86 stuff better than most, but that code scares *me*".
> 
> Which is why I'd accept a rather bigger complexity hit just about
> anywhere else in the code...

I agree that, to a certain extent, it can make sense to put the "onus of
complexity" on the code that introduces the problem.  But of course it's
not an absolute rule, and should be considered in context with the
relative complexities of the competing solutions.

But I think where I see things differently is that:

a) The entry code is, by far, in the best shape it's ever been [*],
   thanks to Andy's considerable efforts.  I find it to be quite
   readable, but that might be due to many hours of intense study...

   [*] overlooking recent unavoidable meltdown/spectre hacks

b) Adding a gap to the #DB entry stack is (in my mind) a simple
   localized change, which is easily understandable by a reader of the
   entry code -- assuming certain personality characteristics of a
   person whose life decisions have resulted in them reading entry code
   in the first place...

c) Doing so is an order of magnitude simpler than the custom trampoline
   thing (or really any of the other many alternatives we've discussed).
   At least that's my feeling.

-- 
Josh
