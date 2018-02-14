Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032173AbeBNQLx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:11:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030349AbeBNQLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:11:49 -0500
Date: Wed, 14 Feb 2018 10:11:48 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: Fix CR3 restore order in paranoid_exit()
Message-ID: <20180214161148.c4uxsmbwycsbcfh4@treble>
References: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
 <9f6d258e-8191-9b57-4839-aa7c84e4c829@intel.com>
 <20180214073910.boevmg65upbk3vqb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214073910.boevmg65upbk3vqb@gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 08:39:11AM +0100, Ingo Molnar wrote:
> 
> * Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > On 02/13/2018 06:27 PM, Josh Poimboeuf wrote:
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -1167,10 +1167,10 @@ ENTRY(paranoid_exit)
> > >  	UNWIND_HINT_REGS
> > >  	DISABLE_INTERRUPTS(CLBR_ANY)
> > >  	TRACE_IRQS_OFF_DEBUG
> > > +	RESTORE_CR3	scratch_reg=%r15 save_reg=%r14
> > >  	testl	%ebx, %ebx			/* swapgs needed? */
> > >  	jnz	.Lparanoid_exit_no_swapgs
> > >  	TRACE_IRQS_IRETQ
> > > -	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
> > >  	SWAPGS_UNSAFE_STACK
> > >  	jmp	.Lparanoid_exit_restore
> > >  .Lparanoid_exit_no_swapgs:
> > 
> > TRACE_IRQS_* call non-entry functions that are not mapped by the user
> > CR3.  How can this possibly work?  What am I missing?
> 
> How about something like the patch below? (Totally untested)
> 
> Thanks,
> 
> 	Ingo
> ---
>  arch/x86/entry/entry_64.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index cd216c9431e1..8971bd64d515 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1175,6 +1175,7 @@ ENTRY(paranoid_exit)
>  	jmp	.Lparanoid_exit_restore
>  .Lparanoid_exit_no_swapgs:
>  	TRACE_IRQS_IRETQ_DEBUG
> +	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
>  .Lparanoid_exit_restore:
>  	jmp restore_regs_and_return_to_kernel
>  END(paranoid_exit)

Dave was right, my patch was obviously bogus.  I couldn't figure out a
real reproducer, so I made an artificial one (see below) and can confirm
that your patch fixes it.

I would resubmit the patch, but now you're the author, so I'm not sure
how that works with the SOB.

Feel free to add my

  Reported-and-tested-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks!

-------------

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 68c95a09b48d..c181eb23109b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -325,6 +325,8 @@ syscall_return_via_sysret:
 	 */
 	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
 
+	int3
+
 	popq	%rdi
 	popq	%rsp
 	USERGS_SYSRET64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3d9b2308e7fa..74fabcdf6c36 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -605,6 +605,8 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 		goto exit;
 #endif
 
+	goto exit;
+
 	if (notify_die(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
 			SIGTRAP) == NOTIFY_STOP)
 		goto exit;
