Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935488AbeBLN3c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:29:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933917AbeBLN3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:29:31 -0500
Subject: Re: [tip:x86/pti] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS
 macro
To: hpa@zytor.com, torvalds@linux-foundation.org, luto@kernel.org,
        mingo@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, brgerst@gmail.com, peterz@infradead.org,
        tglx@linutronix.de, jpoimboe@redhat.com,
        linux-tip-commits@vger.kernel.org
References: <20180211104949.12992-5-linux@dominikbrodowski.net>
 <tip-7b7b09f110f06f3c006e9b3f4590f7d9ba91345b@git.kernel.org>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <22559e63-5b78-21a7-27cd-a985957d5879@redhat.com>
Date: Mon, 12 Feb 2018 14:29:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <tip-7b7b09f110f06f3c006e9b3f4590f7d9ba91345b@git.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 11:17 AM, tip-bot for Dominik Brodowski wrote:
> Commit-ID:  7b7b09f110f06f3c006e9b3f4590f7d9ba91345b
> Gitweb:     https://git.kernel.org/tip/7b7b09f110f06f3c006e9b3f4590f7d9ba91345b
> Author:     Dominik Brodowski <linux@dominikbrodowski.net>
> AuthorDate: Sun, 11 Feb 2018 11:49:45 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 12 Feb 2018 08:06:36 +0100
> 
> x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
> 
> Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
> SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
> This macro uses PUSH instead of MOV and should therefore be faster, at
> least on newer CPUs.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: dan.j.williams@intel.com
> Link: http://lkml.kernel.org/r/20180211104949.12992-5-linux@dominikbrodowski.net
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>   arch/x86/entry/calling.h  | 36 ++++++++++++++++++++++++++++++++++++
>   arch/x86/entry/entry_64.S |  6 ++----
>   2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index a05cbb8..57b1b87 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -137,6 +137,42 @@ For 32-bit we have the following conventions - kernel is built with
>   	UNWIND_HINT_REGS offset=\offset
>   	.endm
>   
> +	.macro PUSH_AND_CLEAR_REGS
> +	/*
> +	 * Push registers and sanitize registers of values that a
> +	 * speculation attack might otherwise want to exploit. The
> +	 * lower registers are likely clobbered well before they
> +	 * could be put to use in a speculative execution gadget.
> +	 * Interleave XOR with PUSH for better uop scheduling:
> +	 */
> +	pushq   %rdi		/* pt_regs->di */
> +	pushq   %rsi		/* pt_regs->si */
> +	pushq   %rdx		/* pt_regs->dx */
> +	pushq   %rcx		/* pt_regs->cx */
> +	pushq   %rax		/* pt_regs->ax */
> +	pushq   %r8		/* pt_regs->r8 */
> +	xorq    %r8, %r8	/* nospec   r8 */

xorq's are slower than xorl's on Silvermont/Knights Landing.
I propose using xorl instead.

> +	pushq   %r9		/* pt_regs->r9 */
> +	xorq    %r9, %r9	/* nospec   r9 */
> +	pushq   %r10		/* pt_regs->r10 */
> +	xorq    %r10, %r10	/* nospec   r10 */
> +	pushq   %r11		/* pt_regs->r11 */
> +	xorq    %r11, %r11	/* nospec   r11*/
> +	pushq	%rbx		/* pt_regs->rbx */
> +	xorl    %ebx, %ebx	/* nospec   rbx*/
> +	pushq	%rbp		/* pt_regs->rbp */
> +	xorl    %ebp, %ebp	/* nospec   rbp*/
> +	pushq	%r12		/* pt_regs->r12 */
> +	xorq    %r12, %r12	/* nospec   r12*/
> +	pushq	%r13		/* pt_regs->r13 */
> +	xorq    %r13, %r13	/* nospec   r13*/
> +	pushq	%r14		/* pt_regs->r14 */
> +	xorq    %r14, %r14	/* nospec   r14*/
> +	pushq	%r15		/* pt_regs->r15 */
> +	xorq    %r15, %r15	/* nospec   r15*/
