Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935599AbeEXCB4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 22:01:56 -0400
Received: from ozlabs.org ([203.11.71.1]:34131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935126AbeEXCBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 22:01:54 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/12] powerpc: Implement hw_breakpoint_arch_parse()
In-Reply-To: <1526697950-7091-5-git-send-email-frederic@kernel.org>
References: <1526697950-7091-1-git-send-email-frederic@kernel.org> <1526697950-7091-5-git-send-email-frederic@kernel.org>
Date: Thu, 24 May 2018 12:01:52 +1000
Message-ID: <87fu2hstf3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 348cac9..fba6527 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -139,30 +139,31 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
>  /*
>   * Validate the arch-specific HW Breakpoint register settings
>   */
> -int arch_validate_hwbkpt_settings(struct perf_event *bp)
> +int hw_breakpoint_arch_parse(struct perf_event *bp,
> +			     struct perf_event_attr *attr,
> +			     struct arch_hw_breakpoint *hw)

I think the semantics here are that we are reading from bp/attr and
writing to hw?

If so would some sprinkling of const on the first two parameters help
make that clearer?

>  {
>  	int ret = -EINVAL, length_max;
> -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
>  
>  	if (!bp)
>  		return ret;
>  
> -	info->type = HW_BRK_TYPE_TRANSLATE;
> -	if (bp->attr.bp_type & HW_BREAKPOINT_R)
> -		info->type |= HW_BRK_TYPE_READ;
> -	if (bp->attr.bp_type & HW_BREAKPOINT_W)
> -		info->type |= HW_BRK_TYPE_WRITE;
> -	if (info->type == HW_BRK_TYPE_TRANSLATE)
> +	hw->type = HW_BRK_TYPE_TRANSLATE;
> +	if (attr->bp_type & HW_BREAKPOINT_R)
> +		hw->type |= HW_BRK_TYPE_READ;
> +	if (attr->bp_type & HW_BREAKPOINT_W)
> +		hw->type |= HW_BRK_TYPE_WRITE;
> +	if (hw->type == HW_BRK_TYPE_TRANSLATE)
>  		/* must set alteast read or write */
>  		return ret;
> -	if (!(bp->attr.exclude_user))
> -		info->type |= HW_BRK_TYPE_USER;
> -	if (!(bp->attr.exclude_kernel))
> -		info->type |= HW_BRK_TYPE_KERNEL;
> -	if (!(bp->attr.exclude_hv))
> -		info->type |= HW_BRK_TYPE_HYP;
> -	info->address = bp->attr.bp_addr;
> -	info->len = bp->attr.bp_len;
> +	if (!attr->exclude_user)
> +		hw->type |= HW_BRK_TYPE_USER;
> +	if (!attr->exclude_kernel)
> +		hw->type |= HW_BRK_TYPE_KERNEL;
> +	if (!attr->exclude_hv)
> +		hw->type |= HW_BRK_TYPE_HYP;
> +	hw->address = attr->bp_addr;
> +	hw->len = attr->bp_len;
  
All looks right to me.

>  	/*
>  	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
> @@ -176,12 +177,12 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
>  	if (cpu_has_feature(CPU_FTR_DAWR)) {
>  		length_max = 512 ; /* 64 doublewords */
>  		/* DAWR region can't cross 512 boundary */
> -		if ((bp->attr.bp_addr >> 10) != 
> -		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 10))
> +		if ((attr->bp_addr >> 10) !=
> +		    ((attr->bp_addr + attr->bp_len - 1) >> 10))
>  			return -EINVAL;

This will conflict with my next branch, but it should be easy enough to
resolve.

>  	}
> -	if (info->len >
> -	    (length_max - (info->address & HW_BREAKPOINT_ALIGN)))
> +	if (hw->len >
> +	    (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
>  		return -EINVAL;
>  	return 0;
>  }

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
