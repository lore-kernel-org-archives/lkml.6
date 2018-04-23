Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeDWK3U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:29:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754617AbeDWK3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:29:17 -0400
Date: Mon, 23 Apr 2018 11:29:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        will.deacon@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
Subject: Re: BUG: KASAN: global-out-of-bounds in
 unmap_kernel_at_el0+0x70/0x1a0
Message-ID: <20180423102909.ra2n6tqvwcn7oash@lakrids.cambridge.arm.com>
References: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
 <20180422190639.lyfvgnzapo2mrpu6@salmiak>
 <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14575e7-c862-fb7c-b776-86976e68f4b7@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 07:00:52AM +0200, Jan Kiszka wrote:
> On 2018-04-22 21:06, Mark Rutland wrote:

> > Does the below help?

> > From ade322407e3d6d1f50e558ebd50d2c1c7bd811c2 Mon Sep 17 00:00:00 2001
> > From: Mark Rutland <mark.rutland@arm.com>
> > Date: Sun, 22 Apr 2018 19:58:08 +0100
> > Subject: [PATCH] arm64: add sentinel to kpti_safe_list
> > 
> > We're missing a sentinel entry in kpti_safe_list. Thus is_midr_in_range_list()
> > can walk past the end of kpti_safe_list. Depending on the contents of memory,
> > this could erroneously match a CPU's MIDR, cause a data abort, or other bad
> > outcomes.
> > 
> > Add the sentinel entry to avoid this.
> > 
> > Fixes: be5b299830c63ed7 ("arm64: capabilities: Add support for checks based on a list of MIDRs")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reported-by: Jan Kiszka <jan.kiszka@web.de>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/cpufeature.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 536d572e5596..9d1b06d67c53 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -868,6 +868,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >  	static const struct midr_range kpti_safe_list[] = {
> >  		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
> >  		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
> > +		{ /* sentinel */ }
> >  	};
> >  	char const *str = "command line option";
> >  
> > 
> 
> Jep, all fine now!

Cool. Can I take that as a Tested-by?

Mark.
