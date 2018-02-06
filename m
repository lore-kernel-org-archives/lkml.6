Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBFH0T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:26:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33815 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFH0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:26:13 -0500
X-Google-Smtp-Source: AH8x225ZroKbyeqyjYUW/yVspD/k9qnXv+pGIJBlDwWDsIvKD7Nuz+eE9Cy6Te4RPFUWGauAiTkt8g==
Date: Tue, 6 Feb 2018 08:26:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v3 3/3] x86/entry: Clear registers for compat syscalls
Message-ID: <20180206072608.idxe4hhhu6gkeqac@gmail.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> From: Andi Kleen <ak@linux.intel.com>
> 
> At entry userspace may have populated registers with values that could
> be useful in a speculative execution attack. Clear them to minimize the
> kernel's attack surface.
> 
> [djbw: interleave the clearing with setting up the stack ]
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/entry/entry_64_compat.S |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 98d5358e4041..fd65e016e413 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -85,15 +85,25 @@ ENTRY(entry_SYSENTER_compat)
>  	pushq	%rcx			/* pt_regs->cx */
>  	pushq	$-ENOSYS		/* pt_regs->ax */
>  	pushq   $0			/* pt_regs->r8  = 0 */
> +	xorq	%r8, %r8		/* nospec   r8 */
>  	pushq   $0			/* pt_regs->r9  = 0 */
> +	xorq	%r9, %r9		/* nospec   r9 */
>  	pushq   $0			/* pt_regs->r10 = 0 */
> +	xorq	%r10, %r10		/* nospec   r10 */
>  	pushq   $0			/* pt_regs->r11 = 0 */
> +	xorq	%r11, %r11		/* nospec   r11 */
>  	pushq   %rbx                    /* pt_regs->rbx */
> +	xorl	%ebx, %ebx		/* nospec   rbx */
>  	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
> +	xorl	%ebp, %ebp		/* nospec   rbp */
>  	pushq   $0			/* pt_regs->r12 = 0 */
> +	xorq	%r12, %r12		/* nospec   r12 */
>  	pushq   $0			/* pt_regs->r13 = 0 */
> +	xorq	%r13, %r13		/* nospec   r13 */
>  	pushq   $0			/* pt_regs->r14 = 0 */
> +	xorq	%r14, %r14		/* nospec   r14 */
>  	pushq   $0			/* pt_regs->r15 = 0 */
> +	xorq	%r15, %r15		/* nospec   r15 */
>  	cld
>  
>  	/*
> @@ -214,15 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
>  	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
>  	pushq	$-ENOSYS		/* pt_regs->ax */
>  	pushq   $0			/* pt_regs->r8  = 0 */
> +	xorq	%r8, %r8		/* nospec   r8 */
>  	pushq   $0			/* pt_regs->r9  = 0 */
> +	xorq	%r9, %r9		/* nospec   r9 */
>  	pushq   $0			/* pt_regs->r10 = 0 */
> +	xorq	%r10, %r10		/* nospec   r10 */
>  	pushq   $0			/* pt_regs->r11 = 0 */
> +	xorq	%r11, %r11		/* nospec   r11 */
>  	pushq   %rbx                    /* pt_regs->rbx */
> +	xorl	%ebx, %ebx		/* nospec   rbx */
>  	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
> +	xorl	%ebp, %ebp		/* nospec   rbp */
>  	pushq   $0			/* pt_regs->r12 = 0 */
> +	xorq	%r12, %r12		/* nospec   r12 */
>  	pushq   $0			/* pt_regs->r13 = 0 */
> +	xorq	%r13, %r13		/* nospec   r13 */
>  	pushq   $0			/* pt_regs->r14 = 0 */
> +	xorq	%r14, %r14		/* nospec   r14 */
>  	pushq   $0			/* pt_regs->r15 = 0 */
> +	xorq	%r15, %r15		/* nospec   r15 */

I really love it how you've aligned the comment fields vertically - nice!

>  	/*
>  	 * User mode is traced as though IRQs are on, and SYSENTER
> @@ -338,15 +358,25 @@ ENTRY(entry_INT80_compat)
>  	pushq	%rcx			/* pt_regs->cx */
>  	pushq	$-ENOSYS		/* pt_regs->ax */
>  	pushq   $0			/* pt_regs->r8  = 0 */
> +	xorq	%r8, %r8		/* nospec   r8 */
>  	pushq   $0			/* pt_regs->r9  = 0 */
> +	xorq	%r9, %r9		/* nospec   r9 */
>  	pushq   $0			/* pt_regs->r10 = 0 */
> +	xorq	%r10, %r10		/* nospec   r10 */
>  	pushq   $0			/* pt_regs->r11 = 0 */
> +	xorq	%r11, %r11		/* nospec   r11 */
>  	pushq   %rbx                    /* pt_regs->rbx */
> +	xorl	%ebx, %ebx		/* nospec   rbx */
>  	pushq   %rbp                    /* pt_regs->rbp */
> +	xorl	%ebp, %ebp		/* nospec   rbp */
>  	pushq   %r12                    /* pt_regs->r12 */
> +	xorq	%r12, %r12		/* nospec   r12 */
>  	pushq   %r13                    /* pt_regs->r13 */
> +	xorq	%r13, %r13		/* nospec   r13 */
>  	pushq   %r14                    /* pt_regs->r14 */
> +	xorq	%r14, %r14		/* nospec   r14 */
>  	pushq   %r15                    /* pt_regs->r15 */
> +	xorq	%r15, %r15		/* nospec   r15 */
>  	cld

BTW., these last two patches have changed *significantly* from Andi's original 
patches that were submitted originally, so I changed them over to:

  From: Dan Williams <dan.j.williams@intel.com>
  ...
  Originally-From: Andi Kleen <ak@linux.intel.com>
  Signed-off-by: Dan Williams <dan.j.williams@intel.com>

... to better show authorship history.

Please let me know if that's not OK.

Thanks,

	Ingo
