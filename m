Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC920840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDC920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeKJJIP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:08:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbeKJJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:08:14 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gLG9S-0006KO-09; Sat, 10 Nov 2018 00:25:22 +0100
Date:   Sat, 10 Nov 2018 00:25:21 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 02/23] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20181109232521.l2ll2n3coxygkxv4@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-3-bigeasy@linutronix.de>
 <20181108145721.GC7543@zn.tnic>
 <20181109173521.2m6iijp5wkncgi77@linutronix.de>
 <20181109185202.GF21243@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181109185202.GF21243@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-09 19:52:02 [+0100], Borislav Petkov wrote:
> On Fri, Nov 09, 2018 at 06:35:21PM +0100, Sebastian Andrzej Siewior wrote:
> > fpu__drop() stets ->initialized to 0. As a result the context switch
> 
> "... the context switch path landing in switch_fpu_prepare()... " is what you
> mean, right?
I mean both. switch_fpu_prepare() while the task is leaving and then
switch_fpu_finish() while the task is coming back. But yes.

> > will not save current FPU registers and so _not_ write to fpu->state.
> > This also means that CPU's FPU register will be random (inherited from
> > the last context)
> 
> You mean, the FPU regs will have random values, yes.
correct. Same like for kernel threads.

> > after the context switch. This is also true for usage
> > in softirq via kernel_fpu_begin().
> 
> So far so good.
> 
> Except maybe because I'm dense about FPU, I still am missing something.
> 
> You have this path:
> 
> __fpu__restore_sig
> |-> fpu__clear
>  |-> fpu__drop
> 
> and that happens on the sigreturn() path.
> 
> Now, the context switch happens ... when exactly?
> 
> After the sigreturn is done?

Is fpu__clear() correct here? If so, a context switch after setting
->initialized has been set to 1 wouldn't matter because in the end the
register state is restored from init_fpstate and not from task's FPU
struct.

> 
> It must be because then you'd get that ->state corruption after
> ->initialized has been cleared.
> 
> Right?

I might got your question wrong. If you quote the code and try again and
I do so, too :)

> <snip a bunch of stuff, we'll get back to it later>
> 
> > So. The fix would be:
> > @@ -344,10 +344,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
> >                         sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
> >                 }
> >  
> > +               local_bh_disable();
> >                 fpu->initialized = 1;
> > -               preempt_disable();
> >                 fpu__restore(fpu);
> > -               preempt_enable();
> > +               local_bh_enable();
> >  
> >                 return err;
> >         } else {
> > 
> > local_bh_disable() due to possible kernel_fpu_begin() usage in softirq.
> > How much do we care here about a theoretical race on 32bit anyway? I
> > don't think someone complained :) I would have to rebase my queue…
> > otherwise…
> 
> Funny, you should mention that.
> 
> But this very much rings a bell about a very elusive bug we had on
> 32-bit at the time. See attached mbox (yeah, the web archives were crap
> and couldn't find the links so I'm sending you the whole thread).
> 
> And at the time Ingo said that there's something still missing about
> *why* it would happen.
> 
> And I think it is this context switch happening right after the
> sigreturn - *AFAICT* - which would cause this.
> 
> I could very well be off but this smells very similar to your thing.

So checking out v4.5-rc3-15-g58122bf1d856a and __fpu__restore_sig() is
something like this:

|	fpu__drop(fpu);
…
|	fpu->fpstate_active = 1;
X
|	if (use_eager_fpu()) {
|		preempt_disable();
|		fpu__restore(fpu);
|		preempt_enable();
|	}

fpu__drop() sets fpstate_active & fpregs_active to 0[¹]. A context switch
at X would _not_ save current FPU registers and overwrite what was
prepared because fpregs_active should still be zero.
Now on the switch back to the task, fpstate_active was set which means
fpu.preload might be true. If so it would load the FPU registers and set
fpregs_active to 1. Later fpu__restore() would try the same and
fpregs_activate() would trigger the warning because fpregs_active was
already set to 1.

> Hmmm.
So I just came up with a possible hard to trigger case and a robot
triggered it already a while back. Well, CONFIG_PREEMPT=y is also there
so it matches this part of the story. But you connected the dots. 

[¹] side note: in my early research it took a while to notice that
    fpstate_active and fpregs_active were two different things. My brain
    used fp.*_active for matching. It also helped my confusion that
    those were renamed and removed…

Sebastian
