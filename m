Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeBFLM0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:12:26 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34890 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeBFLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:12:20 -0500
Date: Tue, 6 Feb 2018 11:57:06 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        Andi Kleen <ak@linux.intel.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH v3 2/3] x86/entry: Clear registers for 64bit
 exceptions/interrupts
Message-ID: <20180206105706.GA7460@light.dominikbrodowski.net>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de>
 <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:51:39AM +0100, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > On Mon, Feb 05, 2018 at 05:18:11PM -0800, Dan Williams wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Clear the 'extra' registers on entering the 64bit kernel for exceptions
> > > and interrupts. The common registers are not cleared since they are
> > > likely clobbered well before they can be exploited in a speculative
> > > execution attack.
> > 
> > Could the clever trick from patch 3/3 (interleave xorq with movq) be
> > used here as well? Something like below (untested)? This includes removing
> > the (seemingly?) unused SAVE_C_REGS_EXCEPT_* macros, which probably needs to
> > become a spearate patch.
> > 
> > Thanks,
> > 	Dominik
> > 
> > 
> > diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> > index 3f48f695d5e6..7bdee6d14f0a 100644
> > --- a/arch/x86/entry/calling.h
> > +++ b/arch/x86/entry/calling.h
> > @@ -101,49 +101,36 @@ For 32-bit we have the following conventions - kernel is built with
> >  	addq	$-(15*8), %rsp
> >  	.endm
> >  
> > -	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
> > -	.if \r11
> > +	.macro SAVE_C_REGS offset=0
> > +	xorq %r11, %r11				/* nospec r11 */
> >  	movq %r11, 6*8+\offset(%rsp)
> > -	.endif
> > -	.if \r8910
> >  	movq %r10, 7*8+\offset(%rsp)
> > +	xorq %r10, %r10				/* nospec r10 */
> >  	movq %r9,  8*8+\offset(%rsp)
> > +	xorq %r9, %r9				/* nospec r9 */
> >  	movq %r8,  9*8+\offset(%rsp)
> > -	.endif
> > -	.if \rax
> > +	xorq %r8, %r8				/* nospec r8 */
> >  	movq %rax, 10*8+\offset(%rsp)
> > -	.endif
> > -	.if \rcx
> >  	movq %rcx, 11*8+\offset(%rsp)
> > -	.endif
> >  	movq %rdx, 12*8+\offset(%rsp)
> >  	movq %rsi, 13*8+\offset(%rsp)
> >  	movq %rdi, 14*8+\offset(%rsp)
> >  	UNWIND_HINT_REGS offset=\offset extra=0
> >  	.endm
> > -	.macro SAVE_C_REGS offset=0
> > -	SAVE_C_REGS_HELPER \offset, 1, 1, 1, 1
> > -	.endm
> > -	.macro SAVE_C_REGS_EXCEPT_RAX_RCX offset=0
> > -	SAVE_C_REGS_HELPER \offset, 0, 0, 1, 1
> > -	.endm
> > -	.macro SAVE_C_REGS_EXCEPT_R891011
> > -	SAVE_C_REGS_HELPER 0, 1, 1, 0, 0
> > -	.endm
> > -	.macro SAVE_C_REGS_EXCEPT_RCX_R891011
> > -	SAVE_C_REGS_HELPER 0, 1, 0, 0, 0
> > -	.endm
> > -	.macro SAVE_C_REGS_EXCEPT_RAX_RCX_R11
> > -	SAVE_C_REGS_HELPER 0, 0, 0, 1, 0
> > -	.endm
> >  
> >  	.macro SAVE_EXTRA_REGS offset=0
> >  	movq %r15, 0*8+\offset(%rsp)
> > +	xorq %r15, %r15				/* nospec r15 */
> >  	movq %r14, 1*8+\offset(%rsp)
> > +	xorq %r14, %r14				/* nospec r14 */
> >  	movq %r13, 2*8+\offset(%rsp)
> > +	xorq %r13, %r13				/* nospec r13 */
> >  	movq %r12, 3*8+\offset(%rsp)
> > +	xorq %r12, %r12				/* nospec r12*/
> >  	movq %rbp, 4*8+\offset(%rsp)
> > +	xorl %ebp, %ebp				/* nospec rbp */
> >  	movq %rbx, 5*8+\offset(%rsp)
> > +	xorl %ebx, %ebx				/* nospec rbx */
> >  	UNWIND_HINT_REGS offset=\offset
> >  	.endm
> >  
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index c752abe89d80..de19a46f40b2 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1218,7 +1218,6 @@ ENTRY(error_entry)
> >  	SAVE_C_REGS 8
> >  	SAVE_EXTRA_REGS 8
> >  	ENCODE_FRAME_POINTER 8
> > -	xorl	%ebx, %ebx
> >  	testb	$3, CS+8(%rsp)
> >  	jz	.Lerror_kernelspace
> >  
> > @@ -1405,15 +1404,25 @@ ENTRY(nmi)
> >  	pushq   %rcx		/* pt_regs->cx */
> >  	pushq   %rax		/* pt_regs->ax */
> >  	pushq   %r8		/* pt_regs->r8 */
> > +	xorq    %r8, %r8	/* nospec   r8 */
> >  	pushq   %r9		/* pt_regs->r9 */
> > +	xorq    %r9, %r9	/* nospec   r9 */
> >  	pushq   %r10		/* pt_regs->r10 */
> > +	xorq    %r10, %r10	/* nospec   r10 */
> >  	pushq   %r11		/* pt_regs->r11 */
> > +	xorq    %r11, %r11	/* nospec   r11*/
> >  	pushq	%rbx		/* pt_regs->rbx */
> > +	xorl    %ebx, %ebx	/* nospec   rbx*/
> >  	pushq	%rbp		/* pt_regs->rbp */
> > +	xorl    %ebp, %ebp	/* nospec   rbp*/
> >  	pushq	%r12		/* pt_regs->r12 */
> > +	xorq    %r12, %r12	/* nospec   r12*/
> >  	pushq	%r13		/* pt_regs->r13 */
> > +	xorq    %r13, %r13	/* nospec   r13*/
> >  	pushq	%r14		/* pt_regs->r14 */
> > +	xorq    %r14, %r14	/* nospec   r14*/
> >  	pushq	%r15		/* pt_regs->r15 */
> > +	xorq    %r15, %r15	/* nospec   r15*/
> >  	UNWIND_HINT_REGS
> >  	ENCODE_FRAME_POINTER
> 
> Makes sense and it's also more readable - could you send this patch on top of 
> tip:x86/pti or tip:master, once I've pushed out the latest version (within the 
> next few hours)?

Will do. Thanks,

	Dominik
