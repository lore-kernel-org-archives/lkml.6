Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeCNO1b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:27:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:27:30 -0400
Date: Wed, 14 Mar 2018 15:27:27 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: jason.vas.dias@gmail.com
cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: Re: [PATCH v4.16-rc5 1/3] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <1521001222-10712-2-git-send-email-jason.vas.dias@gmail.com>
Message-ID: <alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de>
References: <1521001222-10712-1-git-send-email-jason.vas.dias@gmail.com> <1521001222-10712-2-git-send-email-jason.vas.dias@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Wed, 14 Mar 2018, jason.vas.dias@gmail.com wrote:

this subject line is not really what it should be.

[PATCH v4.16-rc5 1/3] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW

Documentation clearly says:

  The canonical patch subject line is::

      Subject: [PATCH 001/123] subsystem: summary phrase

  The ``summary phrase`` in the email's Subject should concisely describe
  the patch which that email contains.  The ``summary phrase`` should not
  be a filename.  Do not use the same ``summary phrase`` for every patch in
  a whole patch series (where a ``patch series`` is an ordered sequence of
  multiple, related patches).

Aside of that the text body of the patch lacks:

   1) A description of the patch

   2) Your Signed-off-by. Again: checkpatch.pl complains for a reason.

Is it really that hard to comply with the established and documented
proceedures?

> diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
> index f19856d..fbc7371 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -182,6 +182,18 @@ notrace static u64 vread_tsc(void)
>  	return last;
>  }
>  
> +notrace static u64 vread_tsc_raw(void)
> +{
> +	u64 tsc
> +	  , last = gtod->raw_cycle_last;

This is hardly kernel coding style.

> +
> +	tsc	      = rdtsc_ordered();

and these spaces are pointless.

> +	if (likely(tsc >= last))
> +		return tsc;
> +	asm volatile ("");
> +	return last;
> +}

As I explained to you before: This function is not required because
gtod->cycle_last and gtod->raw_cycle_last are the same value. 

>  notrace static inline u64 vgetsns(int *mode)
>  {
>  	u64 v;
> @@ -203,6 +215,27 @@ notrace static inline u64 vgetsns(int *mode)
>  	return v * gtod->mult;
>  }
>  
> +notrace static inline u64 vgetsns_raw(int *mode)
> +{
> +	u64 v;
> +	cycles_t cycles;
> +
> +	if (gtod->vclock_mode == VCLOCK_TSC)
> +		cycles = vread_tsc_raw();
> +#ifdef CONFIG_PARAVIRT_CLOCK
> +	else if (gtod->vclock_mode == VCLOCK_PVCLOCK)
> +		cycles = vread_pvclock(mode);
> +#endif
> +#ifdef CONFIG_HYPERV_TSCPAGE
> +	else if (gtod->vclock_mode == VCLOCK_HVCLOCK)
> +		cycles = vread_hvclock(mode);
> +#endif
> +	else
> +		return 0;
> +	v = (cycles - gtod->raw_cycle_last) & gtod->raw_mask;

gtod->raw_mask is the same as gtod->mask for obvious reasons. So the whole
thing can be simplified by extending vgetns() with a mult argument, which
is handed in from the call sites.

>  
> +	vdata->raw_cycle_last	= tk->tkr_raw.cycle_last;
> +	vdata->raw_mask		= tk->tkr_raw.mask;
> +	vdata->raw_mult		= tk->tkr_raw.mult;
> +	vdata->raw_shift	= tk->tkr_raw.shift;

Only the raw_mult/shift value needs to be stored.

Thanks,

	tglx
