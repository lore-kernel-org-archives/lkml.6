Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961CEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfAPWkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:40:47 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbfAPWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:40:47 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gjtrS-0001Uo-5r; Wed, 16 Jan 2019 23:40:38 +0100
Date:   Wed, 16 Jan 2019 23:40:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116193603.GK15409@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-16 20:36:03 [+0100], Borislav Petkov wrote:
> On Wed, Jan 09, 2019 at 12:47:27PM +0100, Sebastian Andrzej Siewior wrote:
> > Since ->initialized is always true for user tasks and kernel threads
> > don't get this far,
> 
> Yeah, this is commit message is too laconic. Don'g get this far "where"?

To reach copy_fpregs_to_sigframe(). A kernel thread never invokes
copy_fpregs_to_sigframe(). Which means only user threads invoke
copy_fpregs_to_sigframe() and they have ->initialized set to one.

> > we always save the registers directly to userspace.
> 
> We don't save registers to userspace - please write stuff out.

Actually we do. copy_fpregs_to_sigframe() saves current FPU registers to
task's stack frame which is userspace memory.

> So from looking at what you're removing I can barely rhyme up what
> you're doing but this needs a lot more explanation why it is OK to
> remove the else case. Hell, why was the thing added in the first place
> if ->initialized is always true?

I think *parts* of the ->initialized field was wrongly converted while
lazy-FPU was removed *or* it was forgotten to be removed afterwards. Or
I don't know but it looks like a leftover.

At the beginning (while it was added) it was part of the lazy-FPU code.
So if tasks's FPU register are not active then they are saved in task's
FPU struct. So in this case (the else path) it does
	__copy_to_user(buf_fx, xsave, fpu_user_xstate_size)

In the other case (task's FPU struct is not up-to date, the current
FPU register content is in CPU's registers) it does
	copy_fpregs_to_sigframe(buf_fx)
	
which copies CPU's registers. In both cases it copies them (the FPU
registers) to the task's stack frame (the same location). Easy so far?

How does using_compacted_format() fit in here?
The point is that the "compacted" format is never exposed to
userland so it requires normal xsave. So far so good, right? But how
does it work in in the '->initialized = 0' case right?  It was
introduced in commit
  99aa22d0d8f7 ("x86/fpu/xstate: Copy xstate registers directly to the signal frame when compacted format is in use")

and it probably does not explain why this works, right?
So *either* fpregs_active() was always true if the task used FPU *once*
or if it used FPU *recently* and task's FPU register are active (I don't
remember anymore). Anyway:
a) we don't get here because caller checks for fpregs_active() before
   invoking copy_fpstate_to_sigframe()
b) a preemption check resets fpregs_active() after the first check
   then we do "xsave", xsaves traps because FPU is off/disabled, trap
   loads task's FPU registers, gets back to "xsave", "xsave" saves
   CPU's register to the stack frame.

The b part does not work like that since commit
  bef8b6da9522 ("x86/fpu: Handle #NM without FPU emulation as an error")

but then at that point it was "okay" because fpregs_active() would
return true if the task used FPU registers at least once. If it did not
use them then it would not invoke that function (the caller checks for
fpregs_active()).

> And why is it ok to save registers directly to the user task's buffers?
So I can't tell you why it is okay but I can explain why it is done
(well, that part I puzzled together).
The task is running and using FPU registers. Then an evil mind sends a
signal. The task goes into kernel, prepares itself and is about to
handle the signal in userland. It saves its FPU registers on the stack
frame. It zeros its current FPU registers (ready for a fresh start),
loads the address of the signal handler and returns to user land
handling the signal.

Now. The signal handler may use FPU registers and the signal handler
maybe be preempted so you need to save the FPU registers of the signal
handler and you can't mix them up with the FPU register's of the task
(before it started handling the signal).

So in order to avoid a second FPU struct it saves them on user's stack
frame. I *think* this (avoiding a second FPU struct) is the primary
motivation. A bonus point might be that the signal handler has a third
argument the `context'. That means you can use can access the task's FPU
registers from the signal handler. Not sure *why* you want to do so but
yo can.
I can't imagine a use case and I was looking for a user and expecting it
to be glibc but I didn't find anything in the glibc that would explain
it. Intel even defines a few bytes as "user reserved" which are used by
"struct _fpx_sw_bytes" to add a marker in the signal and recognise it on
restore.
The only user that seems to make use of that is `criu' (or it looked
like it does use it). I would prefer to add a second struct-FPU and use
that for the signal handler. This would avoid the whole dance here. And
`criu' could maybe become a proper interface. I don't think as of now
that it will break something in userland if the signal handler suddenly
does not have a pointer to the FPU struct.

> So please be more verbose even at the risk of explaning the obvious.
> This is the FPU code, remember? :)

Okay. So I was verbose *now*. Depending on what you say (or don't) I
will try to recycle this into commit message in a few days.

> Thx.

Sebastian
