Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBHLGA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:06:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeBHLF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:05:59 -0500
Date: Thu, 8 Feb 2018 11:05:54 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 10/20] arm64: capabilities: Restrict KPTI detection to
 boot-time CPUs
Message-ID: <20180208110550.GV5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-11-suzuki.poulose@arm.com>
 <20180207103845.GA5862@e103592.cambridge.arm.com>
 <ec712e11-baa5-aa2c-1b70-be221ea36f9f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec712e11-baa5-aa2c-1b70-be221ea36f9f@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 06:15:58PM +0000, Suzuki K Poulose wrote:
> On 07/02/18 10:38, Dave Martin wrote:
> >On Wed, Jan 31, 2018 at 06:27:57PM +0000, Suzuki K Poulose wrote:
> >>KPTI is treated as a system wide feature, where we enable the feature
> >>when all the CPUs on the system suffers from the security vulnerability,
> >
> >Should that be "when any CPU"?
> >
> 
> Without this patch, we need all the CPUs to mandate the defense (as this
> is a system feature). This patch changes it. I will change it to :
> 
> "KPTI is treated as a system wide feature and is only "detected" if all
> the CPUs on the system needs the defense. This is not sufficient, as the
> KPTI is turned off on a system with a mix of CPUs, where some CPUs can
> defend and others can't,
> 
> >>unless it is forced via kernel command line. Also, if a late CPU needs
> >>KPTI but KPTI was not enabled at boot time, the CPU is currently allowed
> >>to boot, which is a potential security vulnerability.  This patch ensures
> 
> " This patch ensures that KPTI is turned on if at least one CPU requires the
> defense and any late CPUs are rejected..."
> .

Yes, that makes sense.

[...]

> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index ecc87aa74c64..4a55492784b7 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c

[...]

> >>@@ -1008,7 +1006,10 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >>  	{
> >>  		.desc = "Kernel page table isolation (KPTI)",
> >>  		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
> >>-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> >>+		.type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
> >>+		.sys_reg = SYS_ID_AA64PFR0_EL1,
> >>+		.field_pos = ID_AA64PFR0_CSV3_SHIFT,
> >>+		.min_field_value = 1,
> >>  		.matches = unmap_kernel_at_el0,
> >
> >Minor nit, but:
> >
> >Can we have a comment here to explain that .min_field_value is the
> >minimum value that indicates that KPTI is _not_ required by this cpu?
> >This is the opposite of the usual semantics for this field.
> 
> Sure, will add it.
> 
> >
> >Otherwise, this inversion of meaning is not obvious without digging into
> >unmap_kernel_at_el0() and spotting the ! in !has_cpuid_feature().
> >
> >With that, or if this usage of !has_cpuid_feature() is already well-
> >established so that a comment is deemed unnecessary:
> 
> This is the first time we have used it.

Thought so, but I wasn't ruling out the possibility that I had missed
it!

Cheers
---Dave
