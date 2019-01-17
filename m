Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8210DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2020652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="loJoeuUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAQMXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:23:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40304 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfAQMW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:22:59 -0500
Received: from zn.tnic (p200300EC2BCAA900AC94893E33AB057A.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:ac94:893e:33ab:57a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29BC51EC01B6;
        Thu, 17 Jan 2019 13:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547727778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+ZkFHTk6v7ofETUJgSFmkI6xTooef/U1T/vCg4zc3CE=;
        b=loJoeuUlfiLYwrj0baTMJvOCUapEItqBMbnI7Y7HTrI7cFOtZOrkVRLYpTEc9m88fGI3Cb
        sEwFB+5fC5QSVkZB3J79qSG54753B2xP5OCwndf1xL6/CSUKfm4niqQWIjvL5NfEwWytZ7
        hs8L6PY7FmrkKtjXuIyA9AbiGiZgFGw=
Date:   Thu, 17 Jan 2019 13:22:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190117122253.GC5023@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:40:37PM +0100, Sebastian Andrzej Siewior wrote:
> Actually we do. copy_fpregs_to_sigframe() saves current FPU registers to
> task's stack frame which is userspace memory.

I know we do - I was only pointing at the not optimal choice of words -
"save registers to userspace" and to rather say "save hardware registers
to user buffers" or so.

> I think *parts* of the ->initialized field was wrongly converted while
> lazy-FPU was removed *or* it was forgotten to be removed afterwards. Or
> I don't know but it looks like a leftover.
> 
> At the beginning (while it was added) it was part of the lazy-FPU code.
> So if tasks's FPU register are not active then they are saved in task's
> FPU struct. So in this case (the else path) it does
> 	__copy_to_user(buf_fx, xsave, fpu_user_xstate_size)

So far, so good. Comment above says so too:

 * If the fpu, extended register state is live, save the state directly
 * to the user frame pointed by the aligned pointer 'buf_fx'. Otherwise,
 * copy the thread's fpu state to the user frame starting at 'buf_fx'.

> In the other case (task's FPU struct is not up-to date, the current
> FPU register content is in CPU's registers) it does
> 	copy_fpregs_to_sigframe(buf_fx)

ACK.

> How does using_compacted_format() fit in here?
> The point is that the "compacted" format is never exposed to
> userland so it requires normal xsave. So far so good, right? But how
> does it work in in the '->initialized = 0' case right?  It was
> introduced in commit
>   99aa22d0d8f7 ("x86/fpu/xstate: Copy xstate registers directly to the signal frame when compacted format is in use")
> 
> and it probably does not explain why this works, right?

I think this was imposed by our inability to handle XSAVES compacted
format. And that should be fixed now, AFAICR.

> So *either* fpregs_active() was always true if the task used FPU *once*
> or if it used FPU *recently* and task's FPU register are active (I don't
> remember anymore). Anyway:
> a) we don't get here because caller checks for fpregs_active() before
>    invoking copy_fpstate_to_sigframe()

Ok.

> b) a preemption check resets fpregs_active() after the first check
>    then we do "xsave", xsaves traps because FPU is off/disabled, trap
>    loads task's FPU registers, gets back to "xsave", "xsave" saves
>    CPU's register to the stack frame.
> 
> The b part does not work like that since commit
>   bef8b6da9522 ("x86/fpu: Handle #NM without FPU emulation as an error")
> 
> but then at that point it was "okay" because fpregs_active() would
> return true if the task used FPU registers at least once. If it did not
> use them then it would not invoke that function (the caller checks for
> fpregs_active()).

Right, AFAICT, we were moving to eager FPU at that time and this commit
is part of the lazy FPU removal stuff.

> So I can't tell you why it is okay but I can explain why it is done
> (well, that part I puzzled together).

I hate the fact that we have to puzzle stuff together for the FPU code.
;-\

> The task is running and using FPU registers. Then an evil mind sends a
> signal. The task goes into kernel, prepares itself and is about to
> handle the signal in userland. It saves its FPU registers on the stack
> frame. It zeros its current FPU registers (ready for a fresh start),
> loads the address of the signal handler and returns to user land
> handling the signal.
> 
> Now. The signal handler may use FPU registers and the signal handler
> maybe be preempted so you need to save the FPU registers of the signal
> handler and you can't mix them up with the FPU register's of the task
> (before it started handling the signal).
> 
> So in order to avoid a second FPU struct it saves them on user's stack
> frame. I *think* this (avoiding a second FPU struct) is the primary
> motivation.

Yah, makes sense. Sounds like something we'd do :-)

> A bonus point might be that the signal handler has a third
> argument the `context'. That means you can use can access the task's FPU
> registers from the signal handler. Not sure *why* you want to do so but
> yo can.

For <raisins>.

> I can't imagine a use case and I was looking for a user and expecting it
> to be glibc but I didn't find anything in the glibc that would explain
> it. Intel even defines a few bytes as "user reserved" which are used by
> "struct _fpx_sw_bytes" to add a marker in the signal and recognise it on
> restore.
> The only user that seems to make use of that is `criu' (or it looked
> like it does use it). I would prefer to add a second struct-FPU and use
> that for the signal handler. This would avoid the whole dance here.

That would be interesting from the perspective of making the code
straight-forward and not having to document all that dance somewhere.

> And `criu' could maybe become a proper interface. I don't think as of
> now that it will break something in userland if the signal handler
> suddenly does not have a pointer to the FPU struct.

Well, but allocating a special FPU pointer for the signal handler
context sounds simple and clean, no? Or are we afraid that that would
slowdown signal handling, the whole allocation and assignment and
stuff...?

> Okay. So I was verbose *now*. Depending on what you say (or don't) I
> will try to recycle this into commit message in a few days.

Yeah, much much better. Thanks a lot for the effort!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
