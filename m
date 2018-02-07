Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeBGMeZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:34:25 -0500
Received: from foss.arm.com ([217.140.101.70]:50282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753767AbeBGMeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:34:24 -0500
Date: Wed, 7 Feb 2018 12:34:20 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, Marc Zyngier <Marc.Zyngier@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: Relax constraints on ID feature bits
Message-ID: <20180207123419.GP5862@e103592.cambridge.arm.com>
References: <20180201103838.14702-1-suzuki.poulose@arm.com>
 <20180207104048.GL5862@e103592.cambridge.arm.com>
 <88c4ae47-60d3-3980-7271-6f4795360563@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c4ae47-60d3-3980-7271-6f4795360563@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 11:41:17AM +0000, Suzuki K Poulose wrote:
> On 07/02/18 10:40, Dave Martin wrote:
> >On Thu, Feb 01, 2018 at 10:38:37AM +0000, Suzuki K Poulose wrote:
> >>We treat most of the feature bits in the ID registers as STRICT,
> >>implying that all CPUs should match it the boot CPU state. However,
> >>for most of the features, we can handle if there are any mismatches
> >>by using the safe value. e.g, HWCAPs and other features used by the
> >>kernel. Relax the constraint on the feature bits whose mismatch can
> >>be handled by the kernel.
> >>
> >>For VHE, if there is a mismatch we don't care if the kernel is
> >>not using it. If the kernel is indeed running in EL2 mode, then
> >>the mismatches results in a panic. Similarly for ASID bits we
> >>take care of conflicts.
> >>
> >>For other features like, PAN, UAO we only enable it only if we
> >>have it on all the CPUs. For IESB, we set the SCTLR bit unconditionally
> >>anyways.
> >
> >Do the remaining STRICT+LOWER_SAFE / NONSTRICT+EXACT cases still
> >make sense?
> 
> Thats a good point. I did take a look at them. Most of them were not
> really used by the kernel and some of them needed some additional checks
> to make sure the "STRICT" is enforced via other checks. (e.g IDAA64MMFR1:VMID).
> 
> Here is the remaining list :
> 
> IDAA64PFR0_EL1
>   - GIC - System register GIC itnerface. I think this can be made non-strict,
> 	  since we can now enforce it via capabilities (with the GIC_CPUIF
> 	  being a Boot CPU feature). So, we need to wait until that series
> 	  is merged.
> 
>   - EL2 - This is a bit complex. This is STRICT only if all the other CPUs were
>  	  booted in EL2 and KVM is enabled. But then we need to add an extra
> 	  check for hotplugged CPUs.
> 
> IDAA64MMFR0_EL1
>   - BIGENDEL - Again, the system uses sanitised value, so LOWER_SAFE makes sense.
> 	  But there are no checks for hotplugged CPUs, if the SETEND emulation
> 	  is enabled.
> 
> ID_AA64MMFR1_EL
>   - LOR - Limited Ordering regions, Not supported by the kernel. So we can
> 	  make this non-strict.
>   - HPD - Hierarchical permission disables. Currently unused by the kernel.
> 	  So, can be switched to non-strict
>   - VMID - VMIDbits width. This is currently STRICT+LOWER_SAFE. The KVM uses
> 	  sanitised value of the feature, so this can be NONSTRICT+LOWER_SAFE.
> 	  However, we need to ensure a hotplugged CPU complies to the sanitised
> 	  width (which may have been used by KVM)
> 	
> 
> To summarise, I can add LOR/HPD changes. But the others requires a bit more
> work and can be done as a separate series.
> 
> >I've wondered in the past whether there is redundancy between the strict
> >and type fields, but when adding entries I just copy-pasted similar ones
> >rather than fully understanding what was going on...
> 
> I agree. These were defined before we started using the system wide safe
> values and enforcing the capabilities on late/secondary CPUs. Now that
> we have an infrastructure which makes sure that conflicts are handled,
> we could relax the definitions a bit.

OK, I this sounds reasonable and I think it all falls under "potential
future cleanups".

A few nits below.

[...]

> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c

[...]

> >>-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
> >>+	/* We handle differing ASID widths by explicit checks to make sure the system is safe */

Where is this checked?  Because of the risk of breaking this
relationship during maintenance, perhaps we should have a comment in
both places.

> >>+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
> >>  	/*
> >>  	 * Differing PARange is fine as long as all peripherals and memory are mapped
> >>  	 * within the minimum PARange of all CPUs
> >>@@ -179,20 +180,23 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
> >>  };
> >>  static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
> >>-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
> >>+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
> >>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
> >>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_HPD_SHIFT, 4, 0),
> >>-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
> >>+	/* When CONFIG_ARM64_VHE is enabled, we ensure that there is no conflict */

Similarly to _ASID, where/how?

> >>+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
> >>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VMIDBITS_SHIFT, 4, 0),
> >>-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_HADBS_SHIFT, 4, 0),
> >>+	/* We can run a mix of CPUs with and without the support for HW management of AF/DBM bits */
> >>+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_HADBS_SHIFT, 4, 0),
> >>  	ARM64_FTR_END,
> >>  };
> >>  static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
> >>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
> >>-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
> >>+	/* While IESB is good to have, it is not fatal if we miss this on some CPUs */

Maybe this deserves slightly more explanation.  We could say that
lacking implicit IESB on exception boundary on a subset of CPUs is no
worse than lacking it on all of them.

Cheers
---Dave
