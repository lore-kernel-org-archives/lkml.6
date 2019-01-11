Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EEEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D8520870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfAKHv5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:51:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:33538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfAKHv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:51:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E19BDB0BA;
        Fri, 11 Jan 2019 07:51:54 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicolai Stange <nstange@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
        Torsten Duwe <duwe@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Kosina <jkosina@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
        <87bm4ocbbt.fsf@suse.de> <20190111010808.GA17858@redhat.com>
Date:   Fri, 11 Jan 2019 08:51:54 +0100
In-Reply-To: <20190111010808.GA17858@redhat.com> (Joe Lawrence's message of
        "Thu, 10 Jan 2019 20:08:08 -0500")
Message-ID: <87fttzbpid.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Lawrence <joe.lawrence@redhat.com> writes:

> On Fri, Jan 11, 2019 at 01:00:38AM +0100, Nicolai Stange wrote:
>> Hi Joe,
>> 
>> Joe Lawrence <joe.lawrence@redhat.com> writes:
>> 
>> > tl;dr: On ppc64le, what is top-most stack frame for scheduled tasks
>> >        about?
>> 
>> If I'm reading the code in _switch() correctly, the first frame is
>> completely uninitialized except for the pointer back to the caller's
>> stack frame.
>> 
>> For completeness: _switch() saves the return address, i.e. the link
>> register into its parent's stack frame, as is mandated by the ABI and
>> consistent with your findings below: it's always the second stack frame
>> where the return address into __switch_to() is kept.
>>
>
> Hi Nicolai,
>
> Good, that makes a lot of sense.  I couldn't find any reference
> explaining the contents of frame 0, only unwinding code here and there
> (as in crash-utility) that stepped over it.

FWIW, I learned about general stack frame usage on ppc from part 4 of
the introductionary series starting at [1]: it's a good reading and I
can definitely recommend it.

Summary:
- Callers of other functions always allocate a stack frame and only
  set the pointer to the previous stack frame (that's the
  'stdu r1, -STACK_FRAME_OVERHEAD(r1)' insn).
- Callees save their stuff into the stack frame allocated by the caller
  if needed. Where "if needed" == callee in turn calls another function.

The insignificance of frame 0's contents follows from this ABI: the
caller might not have called any callee yet, the callee might be a leaf
and so on.

Finally, as I understand it, the only purpose of _switch() creating a
standard stack frame at the bottom of scheduled out tasks is that the
higher ones can be found (for e.g. the backtracing): otherwise
there would be a pt_regs at the bottom of the stack. But I might be
wrong here.



>> <snip>
>> 
>> >
>> >
>> > Example 1 (RHEL-7)
>> > ==================
>> >
>> > crash> struct task_struct.thread c00000022fd015c0 | grep ksp
>> >     ksp = 0xc0000000288af9c0
>> >
>> > crash> rd 0xc0000000288af9c0 -e 0xc0000000288b0000
>> >
>> >  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> >
>> > sp[0]:
>> >
>> > c0000000288af9c0:  c0000000288afb90 0000000000dd0000   ...(............
>> > c0000000288af9d0:  c000000000002a94 c000000001c60a00   .*..............
>> >
>> >         crash> sym c000000000002a94
>> >         c000000000002a94 (T) hardware_interrupt_common+0x114
>> 
>> So that c000000000002a94 certainly wasn't stored by _switch(). I think
>> what might have happened is that the switching frame aliased with some
>> prior interrupt frame as setup by hardware_interrupt_common().
>> 
>> The interrupt and switching frames seem to share a common layout as far
>> as the lower STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) bytes are
>> concerned.
>> 
>> That address into hardware_interrupt_common() could have been written by
>> the do_IRQ() called from there.
>> 
>
> That was my initial theory, but then when I saw an ordinary scheduled
> task with a similarly strange frame 0, I thought that _switch() might
> have been doing something clever (or not).  But according your earlier
> explanation, it would line up that these values may be inherited from
> do_IRQ() or the like.
>
>> 
>> > c0000000288af9e0:  c000000001c60a80 0000000000000000   ................
>> > c0000000288af9f0:  c0000000288afbc0 0000000000dd0000   ...(............
>> > c0000000288afa00:  c0000000014322e0 c000000001c60a00   ."C.............
>> > c0000000288afa10:  c0000002303ae380 c0000002303ae380   ..:0......:0....
>> > c0000000288afa20:  7265677368657265 0000000000002200   erehsger."......
>> >
>> >         Uh-oh...
>> >
>> >         /* Mark stacktraces with exception frames as unreliable. */
>> >         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER
>> 
>> 
>> Aliasing of the switching stack frame with some prior interrupt stack
>> frame would explain why that STACK_FRAME_REGS_MARKER is still found on
>> the stack, i.e. it's a leftover.
>> 
>> For testing, could you try whether clearing the word at STACK_FRAME_MARKER
>> from _switch() helps?
>> 
>> I.e. something like (completely untested):
>
> I'll kick off some builds tonight and try to get tests lined up
> tomorrow.  Unfortunately these take a bit of time to run setup, schedule
> and complete, so perhaps by next week.

Ok, that's probably still a good test for confirmation, but the solution
you proposed below is much better.


>> 
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index 435927f549c4..b747d0647ec4 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -596,6 +596,10 @@ _GLOBAL(_switch)
>>  	SAVE_8GPRS(14, r1)
>>  	SAVE_10GPRS(22, r1)
>>  	std	r0,_NIP(r1)	/* Return to switch caller */
>> +
>> +	li	r23,0
>> +	std	r23,96(r1)	/* 96 == STACK_FRAME_MARKER * sizeof(long) */
>> +
>>  	mfcr	r23
>>  	std	r23,_CCR(r1)
>>  	std	r1,KSP(r3)	/* Set old stack pointer */
>> 
>> 
>
> This may be sufficient to avoid the condition, but if the contents of
> frame 0 are truely uninitialized (not to be trusted), should the
> unwinder be even looking at that frame (for STACK_FRAMES_REGS_MARKER),
> aside from the LR and other stack size geometry sanity checks?

That's a very good point: we'll only ever be examining scheduled out tasks
and current (which at that time is running klp_try_complete_transition()).

current won't be in an interrupt/exception when it's walking its own
stack. And scheduled out tasks can't have an exception/interrupt frame
as their frame 0, correct?

Thus, AFAICS, whenever klp_try_complete_transition() finds a
STACK_FRAMES_REGS_MARKER in frame 0, it is known to be garbage, as you
said.

Thanks,

Nicolai

[1] https://www.ibm.com/developerworks/linux/library/l-powasm1/index.html

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
