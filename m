Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeA3PGa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:06:30 -0500
Received: from foss.arm.com ([217.140.101.70]:54928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbeA3PG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:06:28 -0500
Date: Tue, 30 Jan 2018 15:06:24 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/16] arm64: capabilities: Group handling of features
 and errata
Message-ID: <20180130150623.GF5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-9-suzuki.poulose@arm.com>
 <20180126114708.GP5862@e103592.cambridge.arm.com>
 <cdd7ab66-9d9e-286d-cb39-c1684bde9c19@arm.com>
 <20180129171410.GB5862@e103592.cambridge.arm.com>
 <b52a705d-67b3-5d46-007e-3eb48d824ec0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52a705d-67b3-5d46-007e-3eb48d824ec0@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 05:22:26PM +0000, Suzuki K Poulose wrote:
> On 29/01/18 17:14, Dave Martin wrote:
> >On Fri, Jan 26, 2018 at 12:31:18PM +0000, Suzuki K Poulose wrote:
> >>On 26/01/18 11:47, Dave Martin wrote:
> >>>On Tue, Jan 23, 2018 at 12:28:01PM +0000, Suzuki K Poulose wrote:
> >>>>So far we have had separate routes for triggering errata and feature
> >>>
> >>>"triggering errata" ? ;)
> >>>
> >>
> >>:-). Should have been "triggering errata and feature capability *checks*.
> >>
> >>>Maybe "[...] for determining whether to activate errata workarounds and
> >>>whether to enable feature capabilities."
> >>>
> >>
> >>
> >>>>capabilities. Also, we never allowed "features" based on local CPU
> >>>>and "errata" based on System wide safe registers. This patch
> >>>>groups the handling of errata and features and also allows them
> >>>>to have all the possible scopes.
> >>>>
> >>>>So, we now run through the arm64_features and arm64_errata:
> >>>
> >>>when?
> >>
> >>with this patch.
> >
> >I mean, when at runtime?
> 
> Sorry, I thought that was evident from the comment below :

Sort of, but you talk about things being done on boot-time enabled CPUs,
rather than saying the check actually happens at boot time.  The
description isn't wrong, but I just ended up a bit unsure about exactly
what was being guaranteed.

My confusion was partly due to my understanding of the code still being
incomplete when I responsed to this patch.


Maybe say "we run through arm64_features and arm64_errata in two phases
during the boot process"

> 
> >
> >>>What about late cpus?
> >>>
> >>
> >>We don't detect any new capabilities on them. They continue to get
> >>verified against the enabled capabilities.

If this patch doesn't intentionally change what happens for late CPUs
after kernel boot, but nonetheless does unifiy the errata/feature
verification code for late CPUs then this may also be worth noting here.

> >>
> >>>>  1) with SCOPE_LOCAL_CPU filter on each boot time enabeld CPUs,
> >>>>     via update_cpu_local_capabilities().
> 
> Here ^^.  Earlier we ran only through the errata list. But now, we
> run through errata and the features, using a type filter of SCOPE_LOCAL_CPU.
> 
> It also said :
> 
>   2) with SCOPE_SYSTEM filter only once after all boot time enabled
>     CPUs are active.
> 
> (2) happens from setup_cpu_features(), just like it was done earlier, but
> with a filter of SCOPE_SYSTEM.
> 
> >>>
> >>>"each [...] enabeld CPUs" -> "each [...] enabled CPU"
> >>>
> >>>Also, changing "boot time" -> "boot-time" helps avoid this being misread
> >>>as "on each boot", which could be taken to mean "each time a CPU comes
> >>>online".  I'm guessing that's not the intended meaning here.
> >>
> 
> >>>
> >>>   }
> >>>>  DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
> >>>>@@ -1422,9 +1435,7 @@ void __init setup_cpu_features(void)
> >>>>  	u32 cwg;
> >>>>  	int cls;
> >>>>-	/* Set the CPU feature capabilies */
> >>>>-	setup_feature_capabilities();
> >>>>-	enable_errata_workarounds();
> >>>>+	setup_system_capabilities();
> >>>>  	mark_const_caps_ready();
> >>>>  	setup_elf_hwcaps(arm64_elf_hwcaps);
> >>>
> >>>I wonder whether we could unify the elf hwcaps handling too.
> >>
> >>I was thinking about it today. The only catch is how do we know
> >>if we have "the capability", as it is spread across multiple bitmasks.
> >>(HWCAP, COMPAT_HWCAP, COMPAT_HWCAP2).
> >
> >An easy-ish solution might be to maintain our own bitmap in the style
> >of cpu_hwcaps, and set bits in parallel with the elf_hwcap etc. bits.
> >Or, add a method that knows how to set/query the appropriate bit.
> >
> >I guess we could do this later.  It's certainly not urgent.
> 
> Yes, I understand.

OK, cool

Cheers
---Dave
