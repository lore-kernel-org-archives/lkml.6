Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeEORUu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:20:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:47138 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeEORUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:20:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="42019076"
Date: Tue, 15 May 2018 10:21:15 -0700
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
Message-ID: <20180515172115.GB244301@romley-ivt3.sc.intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
 <1526323945-211107-4-git-send-email-fenghua.yu@intel.com>
 <03909bf6-2dc5-f5e4-d6bc-a4ebaf20709d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03909bf6-2dc5-f5e4-d6bc-a4ebaf20709d@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:51:24AM -0700, Dave Hansen wrote:
> On 05/14/2018 11:52 AM, Fenghua Yu wrote:
> > +#define	delay_ms	1
> 
> That seems like a dangerously-generic name that should not be a #define
> anyway.

Sure. I will change it to
#define split_lock_delay_ms	1

> 
> > +static void delayed_reenable_split_lock(struct work_struct *w)
> > +{
> > +	if (split_lock_ac == ENABLE_SPLIT_LOCK_AC)
> > +		_setup_split_lock(ENABLE_SPLIT_LOCK_AC);
> > +}
> 
> This seems like it might get confusing.  We have the split lock ac
> *mode* (what the kernel is doing overall) and also the *status* (what
> mode the CPU is in at the moment).
> 
> The naming here doesn't really split up those two concepts very well.

To check the status and re-enable split lock is complex because the
MSR is shared among threads in one core and locking could be complex.

I will re-think about this code...

> 
> > +/* Will the faulting instruction be re-executed? */
> > +static bool re_execute(struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * The only reason for generating #AC from kernel is because of
> > +	 * split lock. The kernel faulting instruction will be re-executed.
> > +	 */
> > +	if (!user_mode(regs))
> > +		return true;
> > +
> > +	return false;
> > +}
> 
> This helper with a single user is a bit unnecessary.  Just open-code
> this and move the comments into the caller.

In this patch, this helper is only used for checking kernel mode.
Then in patch #11, this helper will add checking user mode code.
It would be better to have a helper defined and called.

> 
> > +/*
> > + * #AC handler for kernel split lock is called by generic #AC handler.
> > + *
> > + * Disable #AC for split lock on this CPU so that the faulting instruction
> > + * gets executed. The #AC for split lock is re-enabled later.
> > + */
> > +bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
> > +{
> > +	unsigned long delay = msecs_to_jiffies(delay_ms);
> > +	unsigned long address = read_cr2(); /* Get the faulting address */
> > +	int this_cpu = smp_processor_id();
> 
> How does this end up working?  This seems to depend on this handler not
> getting preempted.

Maybe change the handler to:

this_cpu = task_cpu(current);
Then disable split lock on this_cpu.
Re-enable split lock on this_cpu (already in this way).

Does this sound better?

> 
> > +	if (!re_execute(regs))
> > +		return false;
> > +
> > +	pr_info_ratelimited("Alignment check for split lock at %lx\n", address);
> 
> This is a potential KASLR bypass, I believe.  We shouldn't be printing
> raw kernel addresses.
> 
> We have some nice printk's for page faults that give you kernel symbols.
>  Could you copy one of those?

Sure. Will do that.

> 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 03f3d7695dac..c07b817bbbe9 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -61,6 +61,7 @@
> >  #include <asm/mpx.h>
> >  #include <asm/vm86.h>
> >  #include <asm/umip.h>
> > +#include <asm/cpu.h>
> >  
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -286,10 +287,21 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
> >  			  unsigned long trapnr, int signr)
> >  {
> >  	siginfo_t info;
> > +	int ret;
> >  
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> >  
> >  	/*
> > +	 * #AC exception could be handled by split lock handler.
> > +	 * If the handler can't handle the exception, go to generic #AC handler.
> > +	 */
> > +	if (trapnr == X86_TRAP_AC) {
> > +		ret = do_split_lock_exception(regs, error_code);
> > +		if (ret)
> > +			return;
> > +	}
> 
> Why are you hooking into do_error_trap()?  Shouldn't you just be
> installing do_split_lock_exception() as *the* #AC handler and put it in
> the IDT?
> 

Split lock is not the only reason that causes #AC. #AC can be caused
by user turning on AC bit in EFLAGS, which is just cache line misalignment
and is different from split lock.

So split lock is sharing the handler with another #AC case and can't
be installed seperately from previous #AC handler, right?

Thanks.

-Fenghua
