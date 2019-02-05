Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3ACC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977620818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfBESDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:03:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfBESDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:03:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gr54L-0003q2-7K; Tue, 05 Feb 2019 19:03:37 +0100
Date:   Tue, 5 Feb 2019 19:03:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 07/22] x86/fpu: Remove fpu->initialized
Message-ID: <20190205180336.smegi6rz7waprfaf@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-8-bigeasy@linutronix.de>
 <20190124133449.GC11554@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124133449.GC11554@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-24 14:34:49 [+0100], Borislav Petkov wrote:
> > set it back to one) or don't return to userland.
> > 
> > The context switch code (switch_fpu_prepare() + switch_fpu_finish())
> > can't unconditionally save/restore registers for kernel threads. I have
> > no idea what will happen if we restore a zero FPU context for the kernel
> > thread (since it never was initialized).
> 
> Yeah, avoid those "author is wondering" statements.

So I am no longer unsure about certain thing. Understood.

> > Also it has been agreed that
> > for PKRU we don't want a random state (inherited from the previous task)
> > but a deterministic one.
> 
> Rewrite that to state what the PKRU state is going to be.
I dropped that part. It was part for this patch in an earlier version
but it was moved.

> > For kernel_fpu_begin() (+end) the situation is similar: The kernel test
> > bot told me, that EFI with runtime services uses this before
> > alternatives_patched is true. Which means that this function is used too
> > early and it wasn't the case before.
> > 
> > For those two cases current->mm is used to determine between user &
> > kernel thread.
> 
> Now that we start looking at ->mm, I think we should document this
> somewhere prominently, maybe
> 
>   arch/x86/include/asm/fpu/internal.h
> 
> or so along with all the logic this patchset changes wrt FPU handling.
> Then we wouldn't have to wonder in the future why stuff is being done
> the way it is done.

Well, nothing changes in regard to the logic. Earlier we had a variable
which helped us to distinguish between user & kernel thread. Now we have
a different one. 
I'm going to add a comment to switch_fpu_prepare() about ->mm since you
insist but I would like to avoid it.

> Like the FPU saving on the user stack frame or why this was needed:
> 
> -	/* Update the thread's fxstate to save the fsave header. */
> -	if (ia32_fxstate)
> -		copy_fxregs_to_kernel(fpu);
> 
> Some sort of a high-level invariants written down would save us a lot of
> head scratching in the future.

We have a comment, it is just not helping.

> > diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
> > index 069c04be15076..bd65f6ba950f8 100644
> > --- a/arch/x86/include/asm/trace/fpu.h
> > +++ b/arch/x86/include/asm/trace/fpu.h
> > @@ -13,22 +13,19 @@ DECLARE_EVENT_CLASS(x86_fpu,
> >  
> >  	TP_STRUCT__entry(
> >  		__field(struct fpu *, fpu)
> > -		__field(bool, initialized)
> >  		__field(u64, xfeatures)
> >  		__field(u64, xcomp_bv)
> >  		),
> 
> Yikes, can you do that?
> 
> rostedt has been preaching that adding members at the end of tracepoints
> is ok but not changing them in the middle as that breaks ABI.
> 
> Might wanna ping him about it first.

Steven said on IRC that it can be removed.

> > diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> > index e43296854e379..3a4668c9d24f1 100644
> > --- a/arch/x86/kernel/fpu/core.c
> > +++ b/arch/x86/kernel/fpu/core.c
> > @@ -147,10 +147,9 @@ void fpu__save(struct fpu *fpu)
> >  
> >  	preempt_disable();
> >  	trace_x86_fpu_before_save(fpu);
> > -	if (fpu->initialized) {
> > -		if (!copy_fpregs_to_fpstate(fpu)) {
> > -			copy_kernel_to_fpregs(&fpu->state);
> > -		}
> > +
> > +	if (!copy_fpregs_to_fpstate(fpu)) {
> > +		copy_kernel_to_fpregs(&fpu->state);
> >  	}
> 
> WARNING: braces {} are not necessary for single statement blocks
> #217: FILE: arch/x86/kernel/fpu/core.c:151:
> +       if (!copy_fpregs_to_fpstate(fpu)) {
> +               copy_kernel_to_fpregs(&fpu->state);
>         }
removed.

> 
> ...
> 
> > diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> > index 7888a41a03cdb..77d9eb43ccac8 100644
> > --- a/arch/x86/kernel/process_32.c
> > +++ b/arch/x86/kernel/process_32.c
> > @@ -288,10 +288,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> >  	if (prev->gs | next->gs)
> >  		lazy_load_gs(next->gs);
> >  
> > -	switch_fpu_finish(next_fpu, cpu);
> > -
> >  	this_cpu_write(current_task, next_p);
> >  
> > +	switch_fpu_finish(next_fpu, cpu);
> > +
> >  	/* Load the Intel cache allocation PQR MSR. */
> >  	resctrl_sched_in();
> >  
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index e1983b3a16c43..ffea7c557963a 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -566,14 +566,14 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> >  
> >  	x86_fsgsbase_load(prev, next);
> >  
> > -	switch_fpu_finish(next_fpu, cpu);
> > -
> >  	/*
> >  	 * Switch the PDA and FPU contexts.
> >  	 */
> >  	this_cpu_write(current_task, next_p);
> >  	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
> >  
> > +	switch_fpu_finish(next_fpu, cpu);
> > +
> >  	/* Reload sp0. */
> >  	update_task_stack(next_p);
> >  
> 
> Those moves need at least a comment in the commit message or a separate
> patch.

This needs to be part of this patch. I add a note to the commit message.

Sebastian
