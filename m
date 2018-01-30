Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeA3P6J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:58:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbeA3P6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:58:08 -0500
Date: Tue, 30 Jan 2018 15:58:03 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 13/16] arm64: Add support for checking errata based on a
 list of MIDRS
Message-ID: <20180130155802.GJ5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-14-suzuki.poulose@arm.com>
 <20180126141610.GU5862@e103592.cambridge.arm.com>
 <0558db28-b1f1-b249-6098-99e1071f613f@arm.com>
 <20180130151644.GG5862@e103592.cambridge.arm.com>
 <951cb77f-c5f3-56f1-abc7-3cc51248e15d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951cb77f-c5f3-56f1-abc7-3cc51248e15d@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 03:38:44PM +0000, Suzuki K Poulose wrote:
> On 30/01/18 15:16, Dave Martin wrote:
> >On Fri, Jan 26, 2018 at 03:57:44PM +0000, Suzuki K Poulose wrote:
> >>On 26/01/18 14:16, Dave Martin wrote:
> >>>On Tue, Jan 23, 2018 at 12:28:06PM +0000, Suzuki K Poulose wrote:
> >>>>Add helpers for detecting an errata on list of midr ranges
> >>>>of affected CPUs.
> >>>
> >>>This doesn't describe what the patch does: instead, helpers are being
> >>>added for checking whether an MIDR falls in one of multiple affected
> >>>model(s) and or revision(s).
> >>>
> >>>Doing this makes sense, but is it really worth it?
> >>
> >>Well, we need th MIDR list helpers anyway for other things:
> >>   - White list of CPUs where we know KPTI is not needed
> >>   - Black list of CPUs where DBM shouldn't be enabled.
> >>
> >>So all we do is add a new type which could reduce the number of entries.
> >>
> >>>
> >>>We might save 100-200 bytes in the kernel image for now, but a common
> >>>workaround for errata on multiple unrelated cpus is surely a rare case.
> >>>
> >>>Only if there are many such lists, or if the lists become large does
> >>>this start to seem a clear win.
> >>>
> >>>>
> >>>>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>>---
> >>>>  arch/arm64/include/asm/cpufeature.h |  1 +
> >>>>  arch/arm64/kernel/cpu_errata.c      | 40 ++++++++++++++++++++++---------------
> >>>>  2 files changed, 25 insertions(+), 16 deletions(-)
> >>>>
> >>>>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h

[...]

> >>>>-	{
> >>>>-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> >>>>-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> >>>>-		.enable = enable_psci_bp_hardening,
> >>>>-	},
> >>>>-	{
> >>>>-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> >>>>-		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> >>>>+		ERRATA_MIDR_RANGE_LIST(cortex_bp_harden_cpus),
> >>>
> >>>Could we just use a macro to generate multiple structs, instead of
> >>>inventing a new type of struct?
> >>
> >>We could. Somehow, I don't think we are over engineering much here.
> >
> >There is a flipside to this: I commented elsewhere that not allowing
> >mutiple match criteria per capability struct complicates verification
> >for late CPUs and/or makes it more costly.
> >
> >Your changes here do implement support for multiple match criteria,
> >albeit only for the specific case of MIDR matching.
> >
> >It could be worth generalising this in the future, but that's
> >probably not for this series.
> 
> It is not that complex, right now. See below.
> 
> >
> >OTOH, if MIDR matching is the only scenario where we have duplicate
> >cap structs with different match criteria and this patch allows all
> >those duplicates to be removed, then is there still a need to walk
> >the whole list in verify_local_cpu_features(), as introduced in
> >67948af41f2e ("arm64: capabilities: Handle duplicate entries for a
> >capability")?  Or can that now be simplified?
> 
> I have added support for this in my v2. So here is what I have done :
> 
> 1) Continue to use midr_list for capability entries that just matches
> MIDRS and share the same enable() call back.
> 
>  and
> 
> 2) Add support for wrapper entries where a capability is determined
> by two or more entries with different matches()/enable() call backs.
> 
> And that can get rid of the changes introduced in commit 67948af41f2e
> ("arm64: capabilities: Handle duplicate entries for a capability").

OK, cool.  I was presuming that might be too much work to be justified
here, but if not, great.

Cheers
---Dave
