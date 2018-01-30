Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeA3PQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:16:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbeA3PQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:16:49 -0500
Date: Tue, 30 Jan 2018 15:16:44 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 13/16] arm64: Add support for checking errata based on a
 list of MIDRS
Message-ID: <20180130151644.GG5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-14-suzuki.poulose@arm.com>
 <20180126141610.GU5862@e103592.cambridge.arm.com>
 <0558db28-b1f1-b249-6098-99e1071f613f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0558db28-b1f1-b249-6098-99e1071f613f@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 03:57:44PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 14:16, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:06PM +0000, Suzuki K Poulose wrote:
> >>Add helpers for detecting an errata on list of midr ranges
> >>of affected CPUs.
> >
> >This doesn't describe what the patch does: instead, helpers are being
> >added for checking whether an MIDR falls in one of multiple affected
> >model(s) and or revision(s).
> >
> >Doing this makes sense, but is it really worth it?
> 
> Well, we need th MIDR list helpers anyway for other things:
>   - White list of CPUs where we know KPTI is not needed
>   - Black list of CPUs where DBM shouldn't be enabled.
> 
> So all we do is add a new type which could reduce the number of entries.
> 
> >
> >We might save 100-200 bytes in the kernel image for now, but a common
> >workaround for errata on multiple unrelated cpus is surely a rare case.
> >
> >Only if there are many such lists, or if the lists become large does
> >this start to seem a clear win.
> >
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/include/asm/cpufeature.h |  1 +
> >>  arch/arm64/kernel/cpu_errata.c      | 40 ++++++++++++++++++++++---------------
> >>  2 files changed, 25 insertions(+), 16 deletions(-)
> >>
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>index a3d54c2c411f..70712de687c7 100644
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >
> >[...]
> >
> >>@@ -330,22 +353,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >>  #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> >>  	{
> >>  		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> >>-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> >>-		.enable = enable_psci_bp_hardening,
> >>-	},
> >>-	{
> >>-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> >>-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> >>-		.enable = enable_psci_bp_hardening,
> >>-	},
> >>-	{
> >>-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> >>-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> >>-		.enable = enable_psci_bp_hardening,
> >>-	},
> >>-	{
> >>-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> >>-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> >>+		ERRATA_MIDR_RANGE_LIST(cortex_bp_harden_cpus),
> >
> >Could we just use a macro to generate multiple structs, instead of
> >inventing a new type of struct?
> 
> We could. Somehow, I don't think we are over engineering much here.

There is a flipside to this: I commented elsewhere that not allowing
mutiple match criteria per capability struct complicates verification
for late CPUs and/or makes it more costly.

Your changes here do implement support for multiple match criteria,
albeit only for the specific case of MIDR matching.

It could be worth generalising this in the future, but that's
probably not for this series.

OTOH, if MIDR matching is the only scenario where we have duplicate
cap structs with different match criteria and this patch allows all
those duplicates to be removed, then is there still a need to walk
the whole list in verify_local_cpu_features(), as introduced in
67948af41f2e ("arm64: capabilities: Handle duplicate entries for a
capability")?  Or can that now be simplified?

Cheers
---Dave
