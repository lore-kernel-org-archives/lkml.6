Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeENLlQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:41:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeENLlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:41:14 -0400
Date: Mon, 14 May 2018 12:41:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/18] arm64: convert raw syscall invocation to C
Message-ID: <20180514114104.oubxdf526hf2m6t5@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-9-mark.rutland@arm.com>
 <20180514110717.GE7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514110717.GE7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 12:07:18PM +0100, Dave Martin wrote:
> On Mon, May 14, 2018 at 10:46:30AM +0100, Mark Rutland wrote:
> > As a first step towards invoking syscalls with a pt_regs argument,
> > convert the raw syscall invocation logic to C. We end up with a bit more
> > register shuffling, but the unified invocation logic means we can unify
> > the tracing paths, too.
> > 
> > This only converts the invocation of the syscall. The rest of the
> > syscall triage and tracing is left in assembly for now, and will be
> > converted in subsequent patches.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/Makefile  |  3 ++-
> >  arch/arm64/kernel/entry.S   | 36 ++++++++++--------------------------
> >  arch/arm64/kernel/syscall.c | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 41 insertions(+), 27 deletions(-)
> >  create mode 100644 arch/arm64/kernel/syscall.c
> > 
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index bf825f38d206..c22e8ace5ea3 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -18,7 +18,8 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
> >  			   hyp-stub.o psci.o cpu_ops.o insn.o	\
> >  			   return_address.o cpuinfo.o cpu_errata.o		\
> >  			   cpufeature.o alternative.o cacheinfo.o		\
> > -			   smp.o smp_spin_table.o topology.o smccc-call.o
> > +			   smp.o smp_spin_table.o topology.o smccc-call.o	\
> > +			   syscall.o
> >  
> >  extra-$(CONFIG_EFI)			:= efi-entry.o
> >  
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 08ea3cbfb08f..d6e057500eaf 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -873,7 +873,6 @@ ENDPROC(el0_error)
> >   */
> >  ret_fast_syscall:
> >  	disable_daif
> > -	str	x0, [sp, #S_X0]			// returned x0
> >  	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
> >  	and	x2, x1, #_TIF_SYSCALL_WORK
> >  	cbnz	x2, ret_fast_syscall_trace
> > @@ -946,15 +945,11 @@ el0_svc_naked:					// compat entry point
> >  
> >  	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
> >  	b.ne	__sys_trace
> > -	cmp     wscno, wsc_nr			// check upper syscall limit
> > -	b.hs	ni_sys
> > -	mask_nospec64 xscno, xsc_nr, x19	// enforce bounds for syscall number
> > -	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
> > -	blr	x16				// call sys_* routine
> > -	b	ret_fast_syscall
> > -ni_sys:
> >  	mov	x0, sp
> > -	bl	do_ni_syscall
> > +	mov	w1, wscno
> > +	mov	w2, wsc_nr
> > +	mov	x3, stbl
> > +	bl	invoke_syscall
> >  	b	ret_fast_syscall
> >  ENDPROC(el0_svc)
> >  
> > @@ -971,29 +966,18 @@ __sys_trace:
> >  	bl	syscall_trace_enter
> >  	cmp	w0, #NO_SYSCALL			// skip the syscall?
> >  	b.eq	__sys_trace_return_skipped
> > -	mov	wscno, w0			// syscall number (possibly new)
> > -	mov	x1, sp				// pointer to regs
> > -	cmp	wscno, wsc_nr			// check upper syscall limit
> > -	b.hs	__ni_sys_trace
> > -	ldp	x0, x1, [sp]			// restore the syscall args
> > -	ldp	x2, x3, [sp, #S_X2]
> > -	ldp	x4, x5, [sp, #S_X4]
> > -	ldp	x6, x7, [sp, #S_X6]
> > -	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
> > -	blr	x16				// call sys_* routine
> >  
> > -__sys_trace_return:
> > -	str	x0, [sp, #S_X0]			// save returned x0
> > +	mov	x0, sp
> > +	mov	w1, wscno
> > +	mov w2, wsc_nr
> > +	mov	x3, stbl
> > +	bl	invoke_syscall
> > +
> >  __sys_trace_return_skipped:
> >  	mov	x0, sp
> >  	bl	syscall_trace_exit
> >  	b	ret_to_user
> >  
> > -__ni_sys_trace:
> > -	mov	x0, sp
> > -	bl	do_ni_syscall
> > -	b	__sys_trace_return
> > -
> 
> Can you explain why ni_syscall is special here, 

This is for out-of-range syscall numbers, instances of ni_syscall in the
syscall table are handled by the regular path. When the syscall number
is out-of-range, we can't index the syscall table, and have to call
ni_sys directly.

The c invoke_syscall() wrapper handles that case internally so that we
don't have to open-code it everywhere.

> why __sys_trace_return existed, 

The __sys_trace_return label existed so that the special __ni_sys_trace
path could return into a common tracing return path.

> and why its disappearance doesn't break anything?

Now that invoke_syscall() handles out-of-range syscall numbers, and we
can remove the __ni_sys_trace path, nothing branches to
__sys_trace_return.

Only the label has been removed, not the usual return path.

> Not saying there's a bug, just that I'm a little confuse -- I see no
> real reason for ni_syscall being special, and this may be a good
> opportunity to decruft it.  (See also comments below.)

Hopefully the above clarifies things?

I've updated the commit message with a description.

[...]

> > +asmlinkage void invoke_syscall(struct pt_regs *regs, int scno, int sc_nr,
> > +			       syscall_fn_t syscall_table[])
> > +{
> > +	if (scno < sc_nr) {
> 
> What if (int)scno < 0?  Should those args both by unsigned ints?

Yes, they should -- I've fixed that up locally.

That is a *very* good point, thanks!

> "sc_nr" sounds too much like "syscall number" to me.  Might
> "syscall_table_size" might be clearer?  Similarly, we could have
> "stbl_size" or similar in the asm.  This is purely cosmetic,
> though.

I'd tried to stick to the naming used in assembly to keep the conversion
clearer for those familiar with the asm.

I agree the names aren't great.

> > +		syscall_fn_t syscall_fn;
> > +		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
> > +		__invoke_syscall(regs, syscall_fn);
> > +	} else {
> > +		regs->regs[0] = do_ni_syscall(regs);
> 
> Can we make __invoke_syscall() the universal syscall wrapper, and give
> do_ni_syscall() the same interface as any other syscall body?

Not at this point in time, since the prototype (in core code) differs.

I agree that would be nicer, but there are a number of complications;
more details below.

> Then you could factor this as
> 
> static syscall_fn_t syscall_fn(syscall_fn_t const syscall_table[],
> 				(unsigned) int scno, (unsigned) int sc_nr)
> {
> 	if (sc_no >= sc_nr)
> 		return sys_ni_syscall;
> 
> 	return syscall_table[array_index_nospec(scno, sc_nr)];
> }
> 
> ...
> 	__invoke_syscall(regs, syscall_fn(syscall_table, scno, sc_nr);
> 
> 
> 
> This is cosmetic too, of course.
> 
> do_ni_syscall() should be given a pt_regs-based wrapper like all the
> rest.

I agree it would be nicer if it had a wrapper that took a pt_regs, even
if it does nothing with it.

We can't use SYSCALL_DEFINE0() due to the fault injection muck, we'd
need a ksys_ni_syscall() for our traps.c logic, and adding this
uniformly would involve some arch-specific rework for x86, too, so I
decided it was not worth the effort.

Thanks,
Mark.
