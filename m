Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0975C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B60D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfANWBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:01:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58743 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANWBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:01:42 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.41])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0EM0PJ02238615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 14 Jan 2019 14:00:26 -0800
Subject: Re: [PATCH v3 0/6] Static calls
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
 <nycvar.YFH.7.76.1901112035570.6626@cbobk.fhfr.pm>
 <5cbd249a-3b2b-6b3b-fb52-67571617403f@zytor.com>
 <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
Message-ID: <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
Date:   Mon, 14 Jan 2019 14:00:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <207c865e-a92a-1647-b1b0-363010383cc3@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I was already in the middle of composing this message when Andy posted:

> I don't even think this is sufficient.  I think we also need everyone
> who clears the bit to check if all bits are clear and, if so, remove
> the breakpoint.  Otherwise we have a situation where, if you are in
> text_poke_bp() and you take an NMI (or interrupt or MCE or whatever)
> and that interrupt then hits the breakpoint, then you deadlock because
> no one removes the breakpoint.
> 
> If we do this, and if we can guarantee that all CPUs make forward
> progress, then maybe the problem is solved. Can we guarantee something
> like all NMI handlers that might wait in a spinlock or for any other
> reason will periodically check if a sync is needed while they're
> spinning?

So the really, really nasty case is when an asynchronous event on the
*patching* processor gets stuck spinning on a resource which is
unavailable due to another processor spinning on the #BP. We can disable
interrupts, but we can't stop NMIs from coming in (although we could
test in the NMI handler if we are in that condition and return
immediately; I'm not sure we want to do that, and we still have to deal
with #MC and what not.)

The fundamental problem here is that we don't see the #BP on the
patching processor, in which case we could simply complete the patching
from the #BP handler on that processor.

On 1/13/19 6:40 PM, H. Peter Anvin wrote:
> On 1/13/19 6:31 PM, H. Peter Anvin wrote:
>>
>> static cpumask_t text_poke_cpumask;
>>
>> static void text_poke_sync(void)
>> {
>> 	smp_wmb();
>> 	text_poke_cpumask = cpu_online_mask;
>> 	smp_wmb();	/* Should be optional on x86 */
>> 	cpumask_clear_cpu(&text_poke_cpumask, smp_processor_id());
>> 	on_each_cpu_mask(&text_poke_cpumask, text_poke_sync_cpu, NULL, false);
>> 	while (!cpumask_empty(&text_poke_cpumask)) {
>> 		cpu_relax();
>> 		smp_rmb();
>> 	}
>> }
>>
>> static void text_poke_sync_cpu(void *dummy)
>> {
>> 	(void)dummy;
>>
>> 	smp_rmb();
>> 	cpumask_clear_cpu(&poke_bitmask, smp_processor_id());
>> 	/*
>> 	 * We are guaranteed to return with an IRET, either from the
>> 	 * IPI or the #BP handler; this provides serialization.
>> 	 */
>> }
>>
> 
> The invariants here are:
> 
> 1. The patching routine must set each bit in the cpumask after each event
>    that requires synchronization is complete.
> 2. The bit can be (atomically) cleared on the target CPU only, and only in a
>    place that guarantees a synchronizing event (e.g. IRET) before it may
>    reaching the poked instruction.
> 3. At a minimum the IPI handler and #BP handler needs to clear the bit. It
>    *is* also possible to clear it in other places, e.g. the NMI handler, if
>    necessary as long as condition 2 is satisfied.
> 

OK, so with interrupts enabled *on the processor doing the patching* we
still have a problem if it takes an interrupt which in turn takes a #BP.
 Disabling interrupts would not help, because but an NMI and #MC could
still cause problems unless we can guarantee that no path which may be
invoked by NMI/#MC can do text_poke, which seems to be a very aggressive
assumption.

Note: I am assuming preemption is disabled.

The easiest/sanest way to deal with this might be to switch the IDT (or
provide a hook in the generic exception entry code) on the patching
processor, such that if an asynchronous event comes in, we either roll
forward or revert. This is doable because the second sync we currently
do is not actually necessary per the hardware guys.

If we take that #BP during the breakpoint deployment phase -- that is,
before the first sync has completed -- restore the previous value of the
breakpoint byte. Upon return text_poke_bp() will then have to loop back
to the beginning and do it again.

If we take the #BP after that point, we can complete the patch in the
normal manner, by writing the rest of the instruction and then removing
the #BP. text_poke_bp() will complete the synchronization sequence on
return, but if another processor is spinning and sees the breakpoint
having been removed, it is good to go.

Rignt now we do completely unnecessary setup and teardown of the PDT
entries for each phase of the patching. This would have to be removed,
so that the asynchronous event handler will always be able to do the
roll forward/roll back as required.

If this is unpalatable, the solution you touched on is probably also
doable, but I need to think *really* carefully about the sequencing
constraints, because now you also have to worry about events
interrupting a patch in progress but not completed. It would however
have the advantage that an arbitrary interrupt on the patching processor
is unlikely to cause a rollback, and so would be safer to execute with
interrupts enabled without causing a livelock.

Now, you can't just remove the breakpoint; you have to make sure that if
you do, during the first phase text_poke_bp() will loop, and in the
second phase complete the whole patching sequence.

Let me think about the second solution, the one you proposed, and what
it would require to avoid any possible race condition. If it is
practical, then I think it is probably the better option.

	-hpa
