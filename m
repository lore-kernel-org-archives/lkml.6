Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65BFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8647F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8647F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbeGRJtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:49:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57681 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbeGRJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:49:12 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffiVG-0002rG-68; Wed, 18 Jul 2018 11:12:10 +0200
Date:   Wed, 18 Jul 2018 11:12:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180718091209.u76gzacanj5avhdl@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716151737.GO9486@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-16 16:17:39 [+0100], Dave Martin wrote:
> On Fri, Jul 13, 2018 at 07:49:38PM +0200, Sebastian Andrzej Siewior wrote:
> > In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> > code disables BH and expects that it is not preemptible. On -RT the
> > task remains preemptible but remains the same CPU. This may corrupt the
> > content of the SIMD registers if the task is preempted during
> > saving/restoring those registers.
> > Add a locallock around this process. This avoids that the any function
> > within the locallock block is invoked more than once on the same CPU.
> 
> The overall shape of this looks reasonable -- I have some comments and
> concerns though, below.
> 
> I'm to blame for much of the current shape of this code, so please Cc
> me on reposts.
> 
> > The kernel_neon_begin() can't be kept preemptible. If the task-switch notices
> > TIF_FOREIGN_FPSTATE then it would restore task's SIMD state and we lose the
> > state of registers used for in-kernel-work. We would require additional storage
> 
> Are you trying to say that a kernel_neon_begin()...kernel_neon_end()
> critical section can't be preemptible?

yes. I try to describe the current status.

> Whether kernel_neon_begin() itself is preemptible is more of an
> implementation detail.
>
> > for the in-kernel copy of the registers. But then the NEON-crypto checks for
> > the need-resched flag so it shouldn't that bad.
> 
> This sounds like an (understandably) confused description of how the
> existing code is intended to work, rather than what the patch does.

What I am trying to say is that kernel_neon_begin() invokes
preempt_disable(). Usually we try to avoid the preempt_disable()
sections because this forbids scheduling of the task (and a task with a
higher priority couldn't be scheduled). Sometimes the preempt_disable()
section is replaced with alternatives / locking of the resource but in
this case there is no alternative because we would lose the in-kernel
registers.

> Can we say something along the lines of:
> 
> "kernel_neon_begin() ... kernel_neon_end() are intended to delimit a
> critical section where the executing context has exclusive access to
> the cpu's FPSIMD/SVE registers.  This means that we must not allow
> preemption by another context or migration to another cpu during this
> region [...]"
> 
> (Not trying to be pedantic here: this -rt patch should help to clarify
> the intended semantics of the code here beyond what is currently
> explicit.  What I truly intended is less clear than I'd like... even to
> me.)

I can update that part.

> > The preempt_disable() avoids the context switch while the kernel uses the SIMD
> > registers. Unfortunately we have to balance out the migrate_disable() counter
> > because local_lock_bh() is invoked in different context compared to its unlock
> > counterpart.
> > 
> > __efi_fpsimd_begin() should not use kernel_fpu_begin() due to its
> 
> Confused -- is this a typo for "kernel_neon_begin()"?

Yes.

> > preempt_disable() context and instead save the registers always in its
> > extra spot on RT.
> 
> I'm not sure this works.  Some EFI runtime service calls are interruptible,
> so we arrange here to stash off the state as normal if an EFI call is
> made from an interruptible context; otherwise we stash in a dedicated
> percpu side buffer and restore eagerly in __efi_fpsimd_end().
> 
> If we now unconditionally use the side-buffer with
> IS_ENABLED(CONFIG_PREEMPT_RT_BASE), I think a nested EFI call will save
> state over the outer context's saved state, leading to corruption of the
> vector registers.

Okay. So this is news to me. I assumed that once we are "in" EFI the CPU
is gone/occupied and only visible to interrupts/whatever is once it
leaves EFI. The call is also within a local_irq_disable() section. But
your "interruptible" would mean that there is a backdoor.

> TBH, I think EFI calls need to be non-preemptible and non-migratable.
> I doubt anything else will conform to the EFI spec.
> 
> IIRC EFI runtime services are not specified to be in any way real-time,
> but I don't think there's a lot we can do about that.

I have no idea what this EFI thing can do. Based on the callbacks I saw
is that you can use them to change time. It would bad if the whole
process takes say 50us (it may need to talk to i2c/spi after all) and in
that time 

> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > 
> > This seems to make work (crypto chacha20-neon + cyclictest). I have no
> > EFI so I have no clue if saving SIMD while calling to EFI works.
> > 
> >  arch/arm64/kernel/fpsimd.c |   47 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 28 insertions(+), 19 deletions(-)
> > 
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/signal.h>
> >  #include <linux/slab.h>
> >  #include <linux/sysctl.h>
> > +#include <linux/locallock.h>
> >  
> >  #include <asm/fpsimd.h>
> >  #include <asm/cputype.h>
> > @@ -235,7 +236,7 @@ static void sve_user_enable(void)
> >   *    whether TIF_SVE is clear or set, since these are not vector length
> >   *    dependent.
> >   */
> > -
> > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> 
> Does this really disable IRQs, and if so, why?

On RT it is a per-CPU sleeping spin_lock. On !RT it depends on the
calling. A local_lock() would be turned into preempt_disable() and
local_lock_irqsave() would be turned local_irq_save().
Here I used local_lock_bh() so the local_bh_disable() remains.

> If so, this creates an IRQ blackout around task_fpsimd_save(), which is
> something we explicitly tried to avoid in the original design.  It can
> be costly.
> 
> Also, this belongs alongside the declaration for fpsimd_last_state,
> since that's (part of) what the lock protects.
> 
> >  /*
> >   * Update current's FPSIMD/SVE registers from thread_struct.
> >   *
> > @@ -594,7 +595,7 @@ int sve_set_vector_length(struct task_st
> >  	 * non-SVE thread.
> >  	 */
> >  	if (task == current) {
> > -		local_bh_disable();
> > +		local_lock_bh(fpsimd_lock);
> >  
> >  		task_fpsimd_save();
> >  		set_thread_flag(TIF_FOREIGN_FPSTATE);
> > @@ -605,7 +606,7 @@ int sve_set_vector_length(struct task_st
> >  		sve_to_fpsimd(task);
> >  
> >  	if (task == current)
> > -		local_bh_enable();
> > +		local_unlock_bh(fpsimd_lock);
> >  
> >  	/*
> >  	 * Force reallocation of task SVE state to the correct size
> > @@ -837,7 +838,7 @@ asmlinkage void do_sve_acc(unsigned int
> >  
> >  	sve_alloc(current);
> >  
> > -	local_bh_disable();
> > +	local_lock_bh(fpsimd_lock);
> >  
> >  	task_fpsimd_save();
> >  	fpsimd_to_sve(current);
> > @@ -849,7 +850,7 @@ asmlinkage void do_sve_acc(unsigned int
> >  	if (test_and_set_thread_flag(TIF_SVE))
> >  		WARN_ON(1); /* SVE access shouldn't have trapped */
> >  
> > -	local_bh_enable();
> > +	local_unlock_bh(fpsimd_lock);
> >  }
> >  
> >  /*
> > @@ -925,7 +926,7 @@ void fpsimd_flush_thread(void)
> >  	if (!system_supports_fpsimd())
> >  		return;
> >  
> > -	local_bh_disable();
> > +	local_lock_bh(fpsimd_lock);
> >  
> >  	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
> >  	fpsimd_flush_task_state(current);
> > @@ -967,7 +968,7 @@ void fpsimd_flush_thread(void)
> >  
> >  	set_thread_flag(TIF_FOREIGN_FPSTATE);
> >  
> > -	local_bh_enable();
> > +	local_unlock_bh(fpsimd_lock);
> >  }
> >  
> >  /*
> > @@ -979,9 +980,9 @@ void fpsimd_preserve_current_state(void)
> >  	if (!system_supports_fpsimd())
> >  		return;
> >  
> > -	local_bh_disable();
> > +	local_lock_bh(fpsimd_lock);
> >  	task_fpsimd_save();
> > -	local_bh_enable();
> > +	local_unlock_bh(fpsimd_lock);
> >  }
> >  
> >  /*
> > @@ -1021,14 +1022,14 @@ void fpsimd_restore_current_state(void)
> >  	if (!system_supports_fpsimd())
> >  		return;
> >  
> > -	local_bh_disable();
> > +	local_lock_bh(fpsimd_lock);
> >  
> >  	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >  		task_fpsimd_load();
> >  		fpsimd_bind_to_cpu();
> >  	}
> >  
> > -	local_bh_enable();
> > +	local_unlock_bh(fpsimd_lock);
> >  }
> >  
> >  /*
> > @@ -1041,7 +1042,7 @@ void fpsimd_update_current_state(struct
> >  	if (!system_supports_fpsimd())
> >  		return;
> >  
> > -	local_bh_disable();
> > +	local_lock_bh(fpsimd_lock);
> >  
> >  	current->thread.fpsimd_state.user_fpsimd = *state;
> >  	if (system_supports_sve() && test_thread_flag(TIF_SVE))
> > @@ -1052,7 +1053,7 @@ void fpsimd_update_current_state(struct
> >  	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
> >  		fpsimd_bind_to_cpu();
> >  
> > -	local_bh_enable();
> > +	local_unlock_bh(fpsimd_lock);
> >  }
> >  
> >  /*
> > @@ -1115,7 +1116,7 @@ void kernel_neon_begin(void)
> >  
> >  	BUG_ON(!may_use_simd());
> >  
> > -	local_bh_disable();
> > +	local_lock_bh(fpsimd_lock);
> >  
> >  	__this_cpu_write(kernel_neon_busy, true);
> >  
> > @@ -1129,8 +1130,14 @@ void kernel_neon_begin(void)
> >  	fpsimd_flush_cpu_state();
> >  
> >  	preempt_disable();
> > -
> > -	local_bh_enable();
> > +	/*
> > +	 * ballance atomic vs !atomic context of migrate_disable().
> > +	 * local_lock_bh = get_local_var() + spin_lock_bh (2x migrate_disable)
> > +	 */
> > +	migrate_disable();
> > +	migrate_disable();
> > +	migrate_disable();
> > +	local_unlock_bh(fpsimd_lock);
> 
> This looks fragile.
> 
> Do we really need to do it 3 times?

Unfortunately yes.

> Showing my ignorance here, but I'd naively expect that the migrate-
> disableness changes as follows:
> 
> 	/* 0 */
> 	local_lock_bh(); /* +3 */
> 
> 	...
> 
> 	preempt_disable(); /* +3 */
> 
> 	migrate_disable(); /* +4 */
> 	migrate_disable(); /* +5 */
> 	migrate_disable(); /* +6 */
> 
> 	local_unlock_bh(); /* +3 */
> 
> 
> If so, I don't understand why it's not OK to call migrate_disable()
> just once, leaving the count at +1  (?)
> 
> I'm making assumptions about the relationship between preempt_disable()
> and migrate_disable() here.

Exactly. So local_lock_bh() does +3 which I try to explain why it is 3.
Now migrate_disable() has two counters: One for atomic context (irq or
preemption disabled) and on for non-atomic context. The difference is
that in atomic context migrate_disable() does nothing and in !atomic
context it does other things which can't be done in atomic context
anyway (I can explain this in full detail but you may lose interest so I
keep it short). To update your example:

	/* ATOMIC COUNTER | non-ATOMIC COUNTER  | change */
			 /* 0 | 0 | - */
	local_lock_bh(); /* 0 | 3 | N+3 */
 
 	...
 
	preempt_disable(); /* atomic context */
 
	migrate_disable(); /* 1 | 3 | A+1 */
	migrate_disable(); /* 2 | 3 | A+1 */
	migrate_disable(); /* 3 | 3 | A+1 */
 
	local_unlock_bh(); /* 0 | 3 | A-3 */

/* later */
	preempt_enable();  /* non-atomic context */
	migrate_enable();  /* 0 | 2 | N-1 */
	migrate_enable();  /* 0 | 1 | N-1 */
	migrate_enable();  /* 0 | 0 | N-1 */

> >  }
> >  EXPORT_SYMBOL(kernel_neon_begin);
> >  
> > @@ -1154,6 +1161,10 @@ void kernel_neon_end(void)
> >  	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
> >  
> >  	preempt_enable();
> > +	/* balance migrate_disable(). See kernel_neon_begin() */
> > +	migrate_enable();
> > +	migrate_enable();
> > +	migrate_enable();
> >  }
> >  EXPORT_SYMBOL(kernel_neon_end);
> >  
> > @@ -1185,9 +1196,7 @@ void __efi_fpsimd_begin(void)
> >  	if (!system_supports_fpsimd())
> >  		return;
> >  
> > -	WARN_ON(preemptible());
> > -
> > -	if (may_use_simd()) {
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {
> 
> I suspect this is wrong -- see comments on the commit message.
> 
> >  		kernel_neon_begin();
> >  	} else {
> 
> [...]
> 
> Cheers
> ---Dave
