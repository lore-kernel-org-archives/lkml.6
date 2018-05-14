Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeENOno (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:43:44 -0400
Received: from foss.arm.com ([217.140.101.70]:44042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbeENOnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:43:41 -0400
Date: Mon, 14 May 2018 15:43:36 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/18] arm64: convert native/compat syscall entry to C
Message-ID: <20180514144331.GL7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-11-mark.rutland@arm.com>
 <20180514110729.GF7753@e103592.cambridge.arm.com>
 <20180514115805.bdlcxsw6q3xsbjb7@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514115805.bdlcxsw6q3xsbjb7@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 12:58:05PM +0100, Mark Rutland wrote:
> On Mon, May 14, 2018 at 12:07:30PM +0100, Dave Martin wrote:
> > On Mon, May 14, 2018 at 10:46:32AM +0100, Mark Rutland wrote:
> 
> > > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > > index 5df857e32b48..4706f841e758 100644
> > > --- a/arch/arm64/kernel/syscall.c
> > > +++ b/arch/arm64/kernel/syscall.c
> > > @@ -6,7 +6,9 @@
> > >  #include <linux/ptrace.h>
> > >  
> > >  #include <asm/daifflags.h>
> > > +#include <asm/fpsimd.h>
> > >  #include <asm/thread_info.h>
> > > +#include <asm/unistd.h>
> > >  
> > >  long do_ni_syscall(struct pt_regs *regs);
> > >  
> > > @@ -41,8 +43,8 @@ static inline bool has_syscall_work(unsigned long flags)
> > >  int syscall_trace_enter(struct pt_regs *regs);
> > >  void syscall_trace_exit(struct pt_regs *regs);
> > >  
> > > -asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > > -			       syscall_fn_t syscall_table[])
> > > +static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > > +			   syscall_fn_t syscall_table[])
> > >  {
> > >  	unsigned long flags = current_thread_info()->flags;
> > >  
> > > @@ -79,3 +81,37 @@ asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > >  trace_exit:
> > >  	syscall_trace_exit(regs);
> > >  }
> > > +
> > > +static inline void sve_user_reset(void)
> > 
> > Static function with no caller...
> 
> Ugh, this was intended to be called below in el0_svc_handler().
> 
> > > +{
> > > +	if (!system_supports_sve())
> > > +		return;
> > > +
> > > +	/*
> > > +	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> > > +	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> > > +	 * happens if a context switch or kernel_neon_begin() or context
> > > +	 * modification (sigreturn, ptrace) intervenes.
> > > +	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
> > > +	 */
> > > +	if (test_and_clear_thread_flag(TIF_SVE))
> > > +		sve_user_disable();
> > 
> > sve_user_disable() is already inline, and incorporates the if()
> > internally via sysreg_clear_set().
> > 
> > So, should this just be
> > 
> > 	clear_thread_flag(TIF_SVE);
> > 	sve_user_disable();
> 
> Sure. That does mean we'll unconditionally read cpacr_el1, but I assume
> you're happy with that. I'll note the difference in the commit message.

This is what the code does today, conditioned no system_supports_sve().

I'm assuming that reading CPACR_EL1 is cheap ... or have you come across
counterexamples to that?

> > > +}
> > > +
> > > +extern syscall_fn_t sys_call_table[];
> > > +
> > > +asmlinkage void el0_svc_handler(struct pt_regs *regs)
> > > +{
> > 
> > if (system_supports_sve()) ?
> > 
> > > +	sve_user_disable();
> > 
> > Or should this be replaced by a call to sve_user_reset()?
> > 
> > I suspect the latter, since we do want to be clearing TIF_SVE here too.
> 
> Yes, this was mean to be sve_user_reset().

OK.  Just to be clear, I think there should be a system_supports_sve()
check here (in case that wasn't obvious from my previous reply).

Cheers
---Dave
