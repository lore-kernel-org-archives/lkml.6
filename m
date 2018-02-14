Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeBNHjQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 02:39:16 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34122 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754489AbeBNHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 02:39:15 -0500
X-Google-Smtp-Source: AH8x2253IjK/oFMmNtU3TMAhAKPcb+/VBCjFLfsg2EVxAxTv5ue9TjTdms/Y4Q5aW96Hr3KXr7G6hA==
Date: Wed, 14 Feb 2018 08:39:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: Fix CR3 restore order in paranoid_exit()
Message-ID: <20180214073910.boevmg65upbk3vqb@gmail.com>
References: <2b8ce3a31bcdfffa434269f4abf5d46816b75773.1518575248.git.jpoimboe@redhat.com>
 <9f6d258e-8191-9b57-4839-aa7c84e4c829@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6d258e-8191-9b57-4839-aa7c84e4c829@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 02/13/2018 06:27 PM, Josh Poimboeuf wrote:
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1167,10 +1167,10 @@ ENTRY(paranoid_exit)
> >  	UNWIND_HINT_REGS
> >  	DISABLE_INTERRUPTS(CLBR_ANY)
> >  	TRACE_IRQS_OFF_DEBUG
> > +	RESTORE_CR3	scratch_reg=%r15 save_reg=%r14
> >  	testl	%ebx, %ebx			/* swapgs needed? */
> >  	jnz	.Lparanoid_exit_no_swapgs
> >  	TRACE_IRQS_IRETQ
> > -	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
> >  	SWAPGS_UNSAFE_STACK
> >  	jmp	.Lparanoid_exit_restore
> >  .Lparanoid_exit_no_swapgs:
> 
> TRACE_IRQS_* call non-entry functions that are not mapped by the user
> CR3.  How can this possibly work?  What am I missing?

How about something like the patch below? (Totally untested)

Thanks,

	Ingo
---
 arch/x86/entry/entry_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cd216c9431e1..8971bd64d515 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1175,6 +1175,7 @@ ENTRY(paranoid_exit)
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
+	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
 END(paranoid_exit)
