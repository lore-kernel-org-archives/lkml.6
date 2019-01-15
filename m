Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E2DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568EF2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfAOFCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:02:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36567 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfAOFCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:02:53 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.82])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0F51dHn2370717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 14 Jan 2019 21:01:40 -0800
Subject: Re: [PATCH v3 0/6] Static calls
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
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
 <9f60be8c-47fb-195b-fdb4-4098f1df3dc2@zytor.com>
 <8ca16cca-101d-1d1b-b3da-c9727665fec8@zytor.com>
 <CALCETrVGoVbToA7Dw_mo_gojvFnS=vB=UJxQgDi_R00skSX8pg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <dd57daf3-4762-07c3-e0be-2cbb605802e4@zytor.com>
Date:   Mon, 14 Jan 2019 21:01:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVGoVbToA7Dw_mo_gojvFnS=vB=UJxQgDi_R00skSX8pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 7:05 PM, Andy Lutomirski wrote:
> On Mon, Jan 14, 2019 at 2:55 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> I think this sequence ought to work (keep in mind we are already under a
>> mutex, so the global data is safe even if we are preempted):
> 
> I'm trying to wrap my head around this.  The states are:
> 
> 0: normal operation
> 1: writing 0xcc, can be canceled
> 2: writing final instruction.  The 0xcc was definitely synced to all CPUs.
> 3: patch is definitely installed but maybe not sync_cored.
> 

4: breakpoint has been canceled; need to redo patching.

>>
>>         set up page table entries
>>         invlpg
>>         set up bp patching global data
>>
>>         cpu = get_cpu()
>>
> So we're assuming that the state is
> 
>>         bp_old_value = atomic_read(bp_write_addr)
>>
>>         do {
> 
> So we're assuming that the state is 0 here.  A WARN_ON_ONCE to check
> that would be nice.

The state here can be 0 or 4.

>>                 atomic_write(&bp_poke_state, 1)
>>
>>                 atomic_write(bp_write_addr, 0xcc)
>>
>>                 mask <- online_cpu_mask - self
>>                 send IPIs
>>                 wait for mask = 0
>>
>>         } while (cmpxchg(&bp_poke_state, 1, 2) != 1);
>>
>>         patch sites, remove breakpoints after patching each one
> 
> Not sure what you mean by patch *sites*.  As written, this only
> supports one patch site at a time, since there's only one
> bp_write_addr, and fixing that may be complicated.  Not fixing it
> might also be a scalability problem.

Fixing it isn't all that complicated; we just need to have a list of
patch locations (which we need anyway!) and walk (or search) it instead
of checking just one; I omitted that detail for simplicity.

>>         atomic_write(&bp_poke_state, 3);
>>
>>         mask <- online_cpu_mask - self
>>         send IPIs
>>         wait for mask = 0
>>
>>         atomic_write(&bp_poke_state, 0);
>>
>>         tear down patching global data
>>         tear down page table entries
>>
>>
>>
>> The #BP handler would then look like:
>>
>>         state = cmpxchg(&bp_poke_state, 1, 4);
>>         switch (state) {
>>                 case 1:
>>                 case 4:
> 
> What is state 4?
> 
>>                         invlpg
>>                         cmpxchg(bp_write_addr, 0xcc, bp_old_value)

I'm 85% sure that the cmpxchg here is actually unnecessary, an
atomic_write() is sufficient.

>>                         break;
>>                 case 2:
>>                         invlpg
>>                         complete patch sequence
>>                         remove breakpoint
>>                         break;
> 
> ISTM you might as well change state to 3 here, but it's arguably unnecessary.

If and only if you have only one patch location you could, but again,
unnecessary.

>>                 case 3:
>>                         /* If we are here, the #BP will go away on its own */
>>                         break;
>>                 case 0:
>>                         /* No patching in progress!!! */
>>                         return 0;
>>         }
>>
>>         clear bit in mask
>>         return 1;
>>
>> The IPI handler:
>>
>>         clear bit in mask
>>         sync_core       /* Needed if multiple IPI events are chained */
> 
> I really like that this doesn't require fixups -- text_poke_bp() just
> works.  But I'm nervous about livelocks or maybe just extreme slowness
> under nasty loads.  Suppose some perf NMI code does a static call or
> uses a static call.  Now there's a situation where, under high
> frequency perf sampling, the patch process might almost always hit the
> breakpoint while in state 1.  It'll get reversed and done again, and
> we get stuck.  It would be neat if we could get the same "no
> deadlocks" property while significantly reducing the chance of a
> rollback.

This could be as simple as spinning for a limited time waiting for
states 0 or 3 if we are not the patching CPU. It is also not necessary
to wait for the mask to become zero for the first sync if we find
ourselves suddenly in state 4.

This wouldn't reduce the livelock probability to zero, but it ought to
reduce it enough that if we really are under such heavy event load we
may end up getting stuck in any number of ways...

> This is why I proposed something where we try to guarantee forward
> progress by making sure that any NMI code that might spin and wait for
> other CPUs is guaranteed to eventually sync_core(), clear its bit, and
> possibly finish a patch.  But this is a bit gross.

Yes, this gets really grotty and who knows how many code paths it would
touch.

	-hpa


