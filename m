Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeEPVfI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:35:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:38863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeEPVfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:35:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,407,1520924400";
   d="scan'208";a="51456673"
Date: Wed, 16 May 2018 14:35:31 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Alan Cox <alan@linux.intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/15] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
Message-ID: <20180516213529.GA46255@romley-ivt3.sc.intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
 <1526323945-211107-4-git-send-email-fenghua.yu@intel.com>
 <03909bf6-2dc5-f5e4-d6bc-a4ebaf20709d@intel.com>
 <20180515172115.GB244301@romley-ivt3.sc.intel.com>
 <9a64587d-7b04-7445-9434-4e39ff66ceb9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a64587d-7b04-7445-9434-4e39ff66ceb9@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 09:44:59AM -0700, Dave Hansen wrote:
> On 05/15/2018 10:21 AM, Fenghua Yu wrote:
> > On Tue, May 15, 2018 at 08:51:24AM -0700, Dave Hansen wrote:
> >> On 05/14/2018 11:52 AM, Fenghua Yu wrote:
> >>> +#define	delay_ms	1
> >>
> >> That seems like a dangerously-generic name that should not be a #define
> >> anyway.
> > 
> > Sure. I will change it to
> > #define split_lock_delay_ms	1
> 
> Why not:
> 
> static unsigned int reenable_split_lock_delay_ms = 1;
> 
> ?
Sure.

> 
> >>> +/* Will the faulting instruction be re-executed? */
> >>> +static bool re_execute(struct pt_regs *regs)
> >>> +{
> >>> +	/*
> >>> +	 * The only reason for generating #AC from kernel is because of
> >>> +	 * split lock. The kernel faulting instruction will be re-executed.
> >>> +	 */
> >>> +	if (!user_mode(regs))
> >>> +		return true;
> >>> +
> >>> +	return false;
> >>> +}
> >>
> >> This helper with a single user is a bit unnecessary.  Just open-code
> >> this and move the comments into the caller.
> > 
> > In this patch, this helper is only used for checking kernel mode.
> > Then in patch #11, this helper will add checking user mode code.
> > It would be better to have a helper defined and called.
> 
> Then introduce the helper later, or call this out in a comment or the
> patch description, please.

Ok. I will call this out in the patch description.

> 
> >>> +/*
> >>> + * #AC handler for kernel split lock is called by generic #AC handler.
> >>> + *
> >>> + * Disable #AC for split lock on this CPU so that the faulting instruction
> >>> + * gets executed. The #AC for split lock is re-enabled later.
> >>> + */
> >>> +bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
> >>> +{
> >>> +	unsigned long delay = msecs_to_jiffies(delay_ms);
> >>> +	unsigned long address = read_cr2(); /* Get the faulting address */
> >>> +	int this_cpu = smp_processor_id();
> >>
> >> How does this end up working?  This seems to depend on this handler not
> >> getting preempted.
> > 
> > Maybe change the handler to:
> > 
> > this_cpu = task_cpu(current);
> > Then disable split lock on this_cpu.
> > Re-enable split lock on this_cpu (already in this way).
> > 
> > Does this sound better?
> 
> Actually, as I look at it, interrupts *are* still disabled here, so you
> are OK.  But, you can do a local_irq_enable() once you get all of the
> per-cpu state settled and go to start handling the fault if you are
> going to do anything that takes an appreciable amount of time.

Ok.

> 
> >>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> >>> index 03f3d7695dac..c07b817bbbe9 100644
> >>> --- a/arch/x86/kernel/traps.c
> >>> +++ b/arch/x86/kernel/traps.c
> >>> @@ -61,6 +61,7 @@
> >>>  #include <asm/mpx.h>
> >>>  #include <asm/vm86.h>
> >>>  #include <asm/umip.h>
> >>> +#include <asm/cpu.h>
> >>>  
> >>>  #ifdef CONFIG_X86_64
> >>>  #include <asm/x86_init.h>
> >>> @@ -286,10 +287,21 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
> >>>  			  unsigned long trapnr, int signr)
> >>>  {
> >>>  	siginfo_t info;
> >>> +	int ret;
> >>>  
> >>>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> >>>  
> >>>  	/*
> >>> +	 * #AC exception could be handled by split lock handler.
> >>> +	 * If the handler can't handle the exception, go to generic #AC handler.
> >>> +	 */
> >>> +	if (trapnr == X86_TRAP_AC) {
> >>> +		ret = do_split_lock_exception(regs, error_code);
> >>> +		if (ret)
> >>> +			return;
> >>> +	}
> >>
> >> Why are you hooking into do_error_trap()?  Shouldn't you just be
> >> installing do_split_lock_exception() as *the* #AC handler and put it in
> >> the IDT?
> > 
> > Split lock is not the only reason that causes #AC. #AC can be caused
> > by user turning on AC bit in EFLAGS, which is just cache line misalignment
> > and is different from split lock.
> > 
> > So split lock is sharing the handler with another #AC case and can't
> > be installed seperately from previous #AC handler, right?
> 
> There are lots of exceptions that use do_error_trap().  I'm suggesting
> that you make an IDT entry for X86_TRAP_AC that does not use
> do_error_trap() since you need something different in there now.
> 
> See:
> 
> > #define DO_ERROR(trapnr, signr, str, name)                              \
> > dotraplinkage void do_##name(struct pt_regs *regs, long error_code)     \
> > {                                                                       \
> >         do_error_trap(regs, error_code, str, trapnr, signr);            \
> > }
> > 
> > DO_ERROR(X86_TRAP_DE,     SIGFPE,  "divide error",              divide_error)
> > DO_ERROR(X86_TRAP_OF,     SIGSEGV, "overflow",                  overflow)
> > DO_ERROR(X86_TRAP_UD,     SIGILL,  "invalid opcode",            invalid_op)
> > DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_segment_overrun)
> > DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",               invalid_TSS)
> > DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",       segment_not_present)
> > DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",             stack_segment)
> > DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",           alignment_check)
> 
> Look at do_general_protection(), for instance.

Sure. I will define the #AC separately.

Thanks.

-Fenghua
