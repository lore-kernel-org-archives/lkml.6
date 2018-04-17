Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeDQRVY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:21:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbeDQRVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:21:22 -0400
Date: Tue, 17 Apr 2018 19:21:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Message-ID: <20180417172102.GA3633@pd.tnic>
References: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 02:57:07PM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The Intel SDM and AMD APM both state that the auxiliary MCA registers
> should be read if their respective valid bits are set in MCA_STATUS.
> 
> The Processor Programming Reference for AMD Fam17h systems has a new
> recommendation that the auxiliary registers should be saved
> unconditionally. This recommendation can be retroactively applied to
> older AMD systems. However, we only need to apply this to SMCA systems
> to avoid modifying behavior on older systems.

Applying the logic of that recommendation on older systems: wouldn't it
be prudent to save them there too, if it helps debugging an MCE?

> Define a separate function to save all auxiliary registers on SMCA
> systems. Call this function from both the MCE handlers and the AMD LVT
> interrupt handlers so that we don't duplicate code.
> 
> Print all auxiliary registers in EDAC/mce_amd. Don't restrict this to
> SMCA systems in order to save a conditional and keep the format similar
> between SMCA and non-SMCA systems.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

...

> diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> index f7666eef4a87..b00d5fff1848 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> @@ -244,6 +244,47 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  	}
>  }
>  
> +
> +static bool _smca_read_aux(struct mce *m, int bank, bool read_addr)
> +{
> +	if (!mce_flags.smca)
> +		return false;
> +
> +	rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
> +	rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
> +
> +	/*
> +	 * We should already have a value if we're coming from the Threshold LVT
> +	 * interrupt handler. Otherwise, read it now.
> +	 */
> +	if (!m->misc)
> +		rdmsrl(msr_ops.misc(bank), m->misc);
> +
> +	/*
> +	 * Read MCA_ADDR if we don't have it already. We should already have it
> +	 * if we're coming from the interrupt handlers.
> +	 */
> +	if (read_addr)

Why not

	if (!m->addr)

?

And yeah, if it has been read to 0 already, reading it again won't
change anything.

And thinking about it more, you don't really need those if-tests, I'd
say. So what, you'll read one or two MSRs once more. It is not such a
hot path that we can't stomach the perf penalty of reading the MSRs.

> +		rdmsrl(msr_ops.addr(bank), m->addr);
> +
> +	/*
> +	 * Extract [55:<lsb>] where lsb is the least significant
> +	 * *valid* bit of the address bits.
> +	 */
> +	if (m->addr) {

And that test is probably not needed either: if m->addr is 0, the
below would be 0 anyway.

> +		u8 lsb = (m->addr >> 56) & 0x3f;
> +
> +		m->addr &= GENMASK_ULL(55, lsb);
> +	}
> +
> +	return true;
> +}

IOW, those tests are probably ok but getting rid of them would make the
code more readable and I think we can afford that here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
