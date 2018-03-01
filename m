Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967794AbeCALkp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:40:45 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967540AbeCALkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:40:43 -0500
Date: Thu, 1 Mar 2018 12:40:19 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Rajvi Jingar <rajvi.jingar@intel.com>
cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, christopher.s.hall@intel.com
Subject: Re: [PATCH] x86/tsc: Always Running Timer (ART) nanoseconds
 clocksource
In-Reply-To: <1519818885-5480-1-git-send-email-rajvi.jingar@intel.com>
Message-ID: <alpine.DEB.2.21.1803011022330.1396@nanos.tec.linutronix.de>
References: <1519818885-5480-1-git-send-email-rajvi.jingar@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Rajvi Jingar wrote:

Subject: x86/tsc: Always Running Timer (ART) nanoseconds clocksource

Please don't use clocksource here. That's misleading because clocksources
are related to the time keeping infrastructure. What the patch provides is a
conversion/correlation function for ART.

> Some clock distribution mechanisms (e.g. PCIe-PTM) require time to be
> distributed in units of nanoseconds. In order to cross-timestamp local
> device time across domains the local device timestamp needs to be
> correlated with TSC.
> 
> On systems that support ART, a CPUID leaf (0x15) returns parameter
> Nominal Core Crystal Clock Frequency such that:
> 
> ART_value (in ticks) = (cryst_freq * ART.ns) / 1e9
> 
> Add a special case for Goldmont-based platform (which returns cryst_freq 0)
> to manually set the frequency to 19.2MHz.
> 
> Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>

This SOB chain is wrong. Christopher is not transporting your patch. If he
was involved in development then please use the:

Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>

format.

> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -108,6 +108,7 @@
>  #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
>  #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
>  #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
> +#define X86_FEATURE_ART_NS		( 3*32+29) /* Always running timer (ART) in nanoseconds */

What's the point of this feature flag? You are not using it in the
conversion function for sanity checking the invocation.

Also the naming is bogus as it suggests that the ART value is actually in
nano seconds which is not true at all.

What it allows is to do a translation from nanosecond based ART values
- where ever they come from - to TSC.

>  static u32 art_to_tsc_numerator;
>  static u32 art_to_tsc_denominator;
> +static u32 art_to_tsc_hz;

I really do not understand your attempt to connect this to TSC. It's just
wrong. From your changelog:

       ART_value (in ticks) = (cryst_freq * ART.ns) / 1e9

Where is TSC in that formula? Also what is ART.ns? This does not make any
sense at all.

>From the SDM:

     The invariant TSC is based on the invariant timekeeping hardware
     (called Always Running Timer or ART), that runs at the core crystal
     clock frequency.

So ART_TICKS is simply the value read from the ART register in a device and
the unit of this value is the core crystal clock frequency.

Now what you want to achieve is the conversion of ART_TICKS to
nanoseconds. That is:

	ART_NS = ART_TICKS * CORE_CRYSTAL_FREQ / 1e9

>  	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
> -	      &art_to_tsc_numerator, unused, unused+1);
> +	      &art_to_tsc_numerator, &art_to_tsc_hz, &unused);

That means that the variable you want here is:

     core_crystal_freq

and not some misleading randomly chosen one. Again from the SDM:

ECX Bits 31 - 00: An unsigned integer which is the nominal frequency of the
    	      	  core crystal clock in Hz.

>  	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
>  		return;
> @@ -1001,6 +1002,15 @@ static void __init detect_art(void)
>  
>  	/* Make this sticky over multiple CPU init calls */
>  	setup_force_cpu_cap(X86_FEATURE_ART);
> +
> +	if (art_to_tsc_hz == 0) {
> +		if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
> +			art_to_tsc_hz = 19200000;
> +		else
> +			return;

Please make this a switch case right away. Given the track record of Intels
bogus frequency information in CPUID this will grow before this patch is
merged.

	  switch (boot_cpu_data.x86_model) {
	  case INTEL_FAM6_ATOM_GOLDMONT:
	  	/* Add a comment explaining why goldmont is special */
	  	art_to_tsc_hz = 19200000;
		break;
	  default: return;
	  }

> +	}
> +
> +	setup_force_cpu_cap(X86_FEATURE_ART_NS);

This still makes no sense. Can you please elaborate what this feature is for?

> @@ -1179,6 +1189,27 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
>  }
>  EXPORT_SYMBOL(convert_art_to_tsc);
>  
> +#define ART_NS_QUANTITY	1000000000

What on earth does this constant mean? It's simply NSEC_PER_SEC, i.e. 1e9,
if I did not miscount the trailing zeros. There is absolutely no point to
invent obscure new constants if there are meaningful and correct ones
available already.

> +/*
> + * Convert ART ns to TSC given numerator/denominator found in detect_art()

Please use proper kernel doc to document the function.

> + */
> +struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)

How do you get a ART value in nanoseconds in the first place? You are
mumbling something unspecific in your changelog:

    Some clock distribution mechanisms (e.g. PCIe-PTM) require time to be
    distributed in units of nanoseconds.

Of course you completely fail to explain how that is supposed to work. The
original explanation for ART was that ART is distributed to PCIe as is and
the time stamps taken in devices are in ART frequency. That's how PTP uses
it, right?

Now you say, that PCIe-PTM provides ART values in nanosecond units. I
assume that's done in hardware and uses the same conversion formula:

	ART_NS = ART_TICKS * CORE_CRYSTAL_FREQ / 1e9

That brings up the obvious question how PCIe-PTM knows about
CORE_CRYSTAL_FREQ on Goldmont if the CPUID does not. What a mess.

All this information wants to be in the changelog and not left to the
reader/reviewer to be figured out with crystalballs.

So for full correlation to TSC you need to go back to the original core
crystal ticks and then do the conversion to TSC. The way you are doing this
is:

    	ART_TICKS = ART_NS * 1e9 / CORE_CRYSTAL_FREQ;

and then:

        TSC = art_tsc_offset + ART_TICKS * art_tsc_nominator / art_tsc_denominator

Sorry, but that is just mindless hackery. The complete conversion function
is:

       TSC = art_tsc_offset + (ART_TICKS * 1e9 * art_tsc_nominator) /
       	     		      (CORE_CRYSTAL_FREQ * art_tsc_denominator)

The relevant values are already known at init time. So you can simply
compute the compound values.

	art_ns_tsc_nominator = 1e9 * art_tsc_nominator;
	art_ns_tsc_denominator = CORE_CRYSTAL_FREQ * art_tsc_denominator;

and the computation boils down to:

	res = div64_u64_rem(art_ns, art_ns_tsc_denominator, &rem);
	res *= art_ns_to_tsc_numerator;

	rem *= art_ns_to_tsc_numerator;
	res += div64_u64(rem, art_ns_tsc_denominator);
	res += art_tsc_offset;

instead of a completely uncomprehensible mess which is also prone to lose
precision.

Hmm?

Thanks,

	tglx
