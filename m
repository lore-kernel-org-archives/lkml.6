Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeENPBf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:01:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752766AbeENPBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:01:34 -0400
Date: Mon, 14 May 2018 16:01:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/18] arm64: convert native/compat syscall entry to C
Message-ID: <20180514150128.n65oafuw2ehvecrr@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-11-mark.rutland@arm.com>
 <20180514110729.GF7753@e103592.cambridge.arm.com>
 <20180514115805.bdlcxsw6q3xsbjb7@lakrids.cambridge.arm.com>
 <20180514144331.GL7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514144331.GL7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 03:43:36PM +0100, Dave Martin wrote:
> On Mon, May 14, 2018 at 12:58:05PM +0100, Mark Rutland wrote:
> > On Mon, May 14, 2018 at 12:07:30PM +0100, Dave Martin wrote:
> > > On Mon, May 14, 2018 at 10:46:32AM +0100, Mark Rutland wrote:
> > > > +{
> > > > +	if (!system_supports_sve())
> > > > +		return;
> > > > +
> > > > +	/*
> > > > +	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> > > > +	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> > > > +	 * happens if a context switch or kernel_neon_begin() or context
> > > > +	 * modification (sigreturn, ptrace) intervenes.
> > > > +	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
> > > > +	 */
> > > > +	if (test_and_clear_thread_flag(TIF_SVE))
> > > > +		sve_user_disable();
> > > 
> > > sve_user_disable() is already inline, and incorporates the if()
> > > internally via sysreg_clear_set().
> > > 
> > > So, should this just be
> > > 
> > > 	clear_thread_flag(TIF_SVE);
> > > 	sve_user_disable();
> > 
> > Sure. That does mean we'll unconditionally read cpacr_el1, but I assume
> > you're happy with that. I'll note the difference in the commit message.
> 
> This is what the code does today, conditioned no system_supports_sve().
> 
> I'm assuming that reading CPACR_EL1 is cheap ... or have you come across
> counterexamples to that?

I have no data either way. :)

> > > > +}
> > > > +
> > > > +extern syscall_fn_t sys_call_table[];
> > > > +
> > > > +asmlinkage void el0_svc_handler(struct pt_regs *regs)
> > > > +{
> > > 
> > > if (system_supports_sve()) ?
> > > 
> > > > +	sve_user_disable();
> > > 
> > > Or should this be replaced by a call to sve_user_reset()?
> > > 
> > > I suspect the latter, since we do want to be clearing TIF_SVE here too.
> > 
> > Yes, this was mean to be sve_user_reset().
> 
> OK.  Just to be clear, I think there should be a system_supports_sve()
> check here (in case that wasn't obvious from my previous reply).

I understood that; the check is inside sve_user_reset(), which I had
mean to call here.

With your above comments, I now have the following:

static inline void sve_user_reset(void)
{
	if (!system_supports_sve())
		return;

	/*
	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
	 * happens if a context switch or kernel_neon_begin() or context
	 * modification (sigreturn, ptrace) intervenes.
	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
	 */
	clear_thread_flag(TIF_SVE);
	sve_user_disable();
}

asmlinkage void el0_svc_handler(struct pt_regs *regs)
{
	sve_user_reset();
	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
}

... which I think alleviates that concern?

Thanks,
Mark.
