Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031245AbeCSUGL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:06:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:20922 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965845AbeCSUFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:05:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="184188148"
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on
 paranoid_entry
To: "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <fa579920-fe34-80fb-4244-5b840b99e72c@linux.intel.com>
Date: Mon, 19 Mar 2018 13:05:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 10:49 AM, Chang S. Bae wrote:
> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
> GS base is not the kernel's.

Do you mean "SWAPGS is needed..."?

> FSGSBASE instructions allow user to write any value on GS base;
> even negative. Sign check on the current GS base is not
> sufficient. Fortunately, reading GS base is fast. Kernel GS
> base is also known from the offset table with the CPU number.
> 
> GS-compatible RDPID macro is included.

This description could use some work.  I think you're trying to say
that, currently, userspace can't modify GS base and the kernel's
conventions are that a negative GS base means it is a kernel value and a
positive GS base means it is a user vale.  But, with your new patches,
userspace can put arbitrary data in there, breaking the exising assumption.

Correct?

This also needs to explain a bit of the theory about how we go finding
the kernel GS base value.

Also, this is expected to improve paranoid_entry speed, right?  The
rdmsr goes away so this should be faster.  Should that be mentioned?

>  /*
> - * Save all registers in pt_regs, and switch gs if needed.
> - * Use slow, but surefire "are we in kernel?" check.
> - * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
> + * Save all registers in pt_regs.
> + *
> + * SWAPGS needs when it comes from user space.

The grammar here needs some work.

	"SWAPGS is needed when entering from userspace".

>  To check where-it-from,
> + * read GS base from RDMSR/MSR_GS_BASE and check if negative or not.
> + * This works without FSGSBASE.
> + * When FSGSBASE enabled, arbitrary GS base can be put by a user-level
> + * task, which means negative value is possible. Direct comparison
> + * between the current and kernel GS bases determines the necessity of
> + * SWAPGS; do if and only if unmatched.
> + *
> + * Return: ebx=0: need SWAPGS on exit, ebx=1: otherwise
>   */

I don't think this really belongs in a comment above the function.  I'd
just explain overall that we are trying to determine if we interrupted
userspace or not.

>  ENTRY(paranoid_entry)
>  	UNWIND_HINT_FUNC
>  	cld
>  	PUSH_AND_CLEAR_REGS save_ret=1
>  	ENCODE_FRAME_POINTER 8
> -	movl	$1, %ebx
> -	movl	$MSR_GS_BASE, %ecx
> -	rdmsr
> -	testl	%edx, %edx
> -	js	1f				/* negative -> in kernel */
> -	SWAPGS
> -	xorl	%ebx, %ebx
>  
> -1:
> +	/*
> +	 * As long as this PTI macro doesn't depend on kernel GS base,
> +	 * we can do it early. This is because READ_KERNEL_GSBASE
> +	 * references data in kernel space.
> +	 */
>  	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14

We used to depend on some per-cpu data in here, but we no longer do.  So
I think this is OK.

> +	movl	$1, %ebx

I know it wasn't commented before, but please add a comment about what
this is doing.

> +	/*
> +	 * Read current GS base with RDGSBASE. Kernel GS base is found
> +	 * by CPU number and its offset value.
> +	 */
> +	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	\
> +		"RDGSBASE %rdx", X86_FEATURE_FSGSBASE

I'd rather this be:

	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	"nop",\
		X86_FEATURE_FSGSBASE
	
	RDGSBASE	   %rdx
	READ_KERNEL_GSBASE %rax
	/* See if the kernel GS_BASE value is in GS base register */
	cmpq	%rdx, %rax
	...

It's a lot more readable than what you have.

...
> +	jne	.Lparanoid_entry_swapgs
> +	ret
> +
> +.Lparanoid_entry_no_fsgsbase:
> +	/*
> +	 * A (slow) RDMSR is surefire without FSGSBASE.

I'd say:

	FSGSBASE is not in use, so depend on the kernel-enforced
	convention that a negative GS base indicates a kernel value.

> +	 * The READ_MSR_GSBASE macro scratches %ecx, %eax, and %edx.

"clobbers" is the normal terminology for this, not "scratches".

> +	READ_MSR_GSBASE save_reg=%edx
> +	testl	%edx, %edx	/* negative -> in kernel */
> +	jns	.Lparanoid_entry_swapgs
> +	ret
> +
> +.Lparanoid_entry_swapgs:
> +	SWAPGS
> +	xorl	%ebx, %ebx
>  	ret
>  END(paranoid_entry)

^^ Please comment the xorl, especially now that it's farther away from
the comment explaining what it is for.

> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> index 8936b7f..76d3457 100644
> --- a/arch/x86/include/asm/fsgsbase.h
> +++ b/arch/x86/include/asm/fsgsbase.h
> @@ -140,6 +140,55 @@ void  write_shadow_gsbase(unsigned long gsbase);
>  	MODRM 0xd0 wrgsbase_opd 1
>  .endm
>  
> +#if CONFIG_SMP
> +
> +.macro READ_KERNEL_GSBASE_RDPID reg:req

This needs some explanation.  Maybe:

/*
 * Fetch the per-cpu GSBASE value for this processor and
 * put it in @reg.  We normally use %GS for accessing per-cpu
 * data, but we are setting up %GS here and obviously can not
 * use %GS itself to access per-cpu data.
 */

> +	RDPID	\reg
> +
> +	/*
> +	 * processor id is written during vDSO (virtual dynamic shared object)
> +	 * initialization. 12 bits for the CPU and 8 bits for the node.
> +	 */
> +	andq	$0xFFF, \reg

This begs the question: when do we initialize the VDSO?  Is that before
or after the first paranoid_entry interrupt?  Also, why the magic
number?  Shouldn't this come out of a macro somewhere rather than having
to hard-code and spell out the convention?

> +	/*
> +	 * Kernel GS base is looked up from the __per_cpu_offset list with
> +	 * the CPU number (processor id).
> +	 */
> +	movq	__per_cpu_offset(, \reg, 8), \reg
> +.endm
> +
> +.macro READ_KERNEL_GSBASE_CPU_SEG_LIMIT reg:req
> +	/* CPU number is found from the limit of PER_CPU entry in GDT */
> +	movq	$__PER_CPU_SEG, \reg
> +	lsl	\reg, \reg
> +
> +	/* Same as READ_KERNEL_GSBASE_RDPID */
> +	andq	$0xFFF, \reg
> +	movq	__per_cpu_offset(, \reg, 8), \reg
> +.endm
> +
> +.macro READ_KERNEL_GSBASE reg:req
> +	ALTERNATIVE "READ_KERNEL_GSBASE_CPU_SEG_LIMIT \reg", \
> +		"READ_KERNEL_GSBASE_RDPID \reg", X86_FEATURE_RDPID
> +.endm

Can I suggest a different indentation?

	ALTERNATIVE \
		"READ_KERNEL_GSBASE_CPU_SEG_LIMIT \reg", \
		"READ_KERNEL_GSBASE_RDPID \reg",
		X86_FEATURE_RDPID
