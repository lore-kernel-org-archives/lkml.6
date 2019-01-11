Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09F7214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfAKAAm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:00:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:35752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729416AbfAKAAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:00:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88094AD7F;
        Fri, 11 Jan 2019 00:00:40 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org, Torsten Duwe <duwe@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Kosina <jkosina@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
Date:   Fri, 11 Jan 2019 01:00:38 +0100
In-Reply-To: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com> (Joe Lawrence's
        message of "Thu, 10 Jan 2019 16:14:00 -0500")
Message-ID: <87bm4ocbbt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Joe Lawrence <joe.lawrence@redhat.com> writes:

> tl;dr: On ppc64le, what is top-most stack frame for scheduled tasks
>        about?

If I'm reading the code in _switch() correctly, the first frame is
completely uninitialized except for the pointer back to the caller's
stack frame.

For completeness: _switch() saves the return address, i.e. the link
register into its parent's stack frame, as is mandated by the ABI and
consistent with your findings below: it's always the second stack frame
where the return address into __switch_to() is kept.

<snip>

>
>
> Example 1 (RHEL-7)
> ==================
>
> crash> struct task_struct.thread c00000022fd015c0 | grep ksp
>     ksp = 0xc0000000288af9c0
>
> crash> rd 0xc0000000288af9c0 -e 0xc0000000288b0000
>
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>
> sp[0]:
>
> c0000000288af9c0:  c0000000288afb90 0000000000dd0000   ...(............
> c0000000288af9d0:  c000000000002a94 c000000001c60a00   .*..............
>
>         crash> sym c000000000002a94
>         c000000000002a94 (T) hardware_interrupt_common+0x114

So that c000000000002a94 certainly wasn't stored by _switch(). I think
what might have happened is that the switching frame aliased with some
prior interrupt frame as setup by hardware_interrupt_common().

The interrupt and switching frames seem to share a common layout as far
as the lower STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) bytes are
concerned.

That address into hardware_interrupt_common() could have been written by
the do_IRQ() called from there.


> c0000000288af9e0:  c000000001c60a80 0000000000000000   ................
> c0000000288af9f0:  c0000000288afbc0 0000000000dd0000   ...(............
> c0000000288afa00:  c0000000014322e0 c000000001c60a00   ."C.............
> c0000000288afa10:  c0000002303ae380 c0000002303ae380   ..:0......:0....
> c0000000288afa20:  7265677368657265 0000000000002200   erehsger."......
>
>         Uh-oh...
>
>         /* Mark stacktraces with exception frames as unreliable. */
>         stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER


Aliasing of the switching stack frame with some prior interrupt stack
frame would explain why that STACK_FRAME_REGS_MARKER is still found on
the stack, i.e. it's a leftover.

For testing, could you try whether clearing the word at STACK_FRAME_MARKER
from _switch() helps?

I.e. something like (completely untested):

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 435927f549c4..b747d0647ec4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -596,6 +596,10 @@ _GLOBAL(_switch)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
 	std	r0,_NIP(r1)	/* Return to switch caller */
+
+	li	r23,0
+	std	r23,96(r1)	/* 96 == STACK_FRAME_MARKER * sizeof(long) */
+
 	mfcr	r23
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */


<snap>

>
> save_stack_trace_tsk_reliable
> =============================
>
> arch/powerpc/kernel/stacktrace.c :: save_stack_trace_tsk_reliable() does
> take into account the first stackframe, but only to verify that the link
> register is indeed pointing at kernel code address.

It's actually the other way around:

	if (!firstframe && !__kernel_text_address(ip))
		return 1;


So the address gets sanitized only if it's _not_ coming from the first
frame.


Thanks,

Nicolai

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
