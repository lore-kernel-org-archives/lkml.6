Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeBGPjg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:39:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754184AbeBGPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:39:34 -0500
Date: Wed, 7 Feb 2018 15:39:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/20] arm64: capabilities: Prepare for fine grained
 capabilities
Message-ID: <20180207153929.GS5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-5-suzuki.poulose@arm.com>
 <20180207103754.GU5862@e103592.cambridge.arm.com>
 <970157c2-449d-9cb5-cf63-fb58fddc556a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970157c2-449d-9cb5-cf63-fb58fddc556a@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 03:16:39PM +0000, Suzuki K Poulose wrote:
> On 07/02/18 10:37, Dave Martin wrote:
> >On Wed, Jan 31, 2018 at 06:27:51PM +0000, Suzuki K Poulose wrote:

[...]

> >>As such there is no change in how the capabilities are treated.
> >>
> >>Cc: Dave Martin <dave.martin@arm.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> >A few minor nits in the documentation, otherwise
> >
> >Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> >
> >>---
> >>  arch/arm64/include/asm/cpufeature.h | 90 ++++++++++++++++++++++++++++++++++---
> >>  arch/arm64/kernel/cpu_errata.c      |  8 ++--
> >>  arch/arm64/kernel/cpufeature.c      | 38 ++++++++--------
> >>  3 files changed, 107 insertions(+), 29 deletions(-)
> >>
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>index 7925e40c6ded..05da54f1b4c7 100644
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >>@@ -86,16 +86,89 @@ struct arm64_ftr_reg {
> >>  extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> >>-/* scope of capability check */
> >>-enum {
> >>-	SCOPE_SYSTEM,
> >>-	SCOPE_LOCAL_CPU,
> >>-};
> >>+/*
> >>+ * CPU capabilities:
> >>+ *
> >>+ * We use arm64_cpu_capabilities to represent system features, errata work
> >>+ * arounds (both used internally by kernel and tracked in cpu_hwcaps) and
> >>+ * ELF HWCAPs (which are exposed to user).
> >>+ *
> >>+ * To support systems with heterogeneous CPUs, we need to make sure that we
> >>+ * detect the capabilities correctly on the system and take appropriate
> >>+ * measures to ensure there are not incompatibilities.
> >>+ *
> >>+ * This comment tries to explain how we treat the capabilities.
> >>+ * Each capability has the following list of attributes :
> >>+ *
> >>+ * 1) Scope of Detection : The system detects a given capability by performing
> >>+ *    some checks at runtime. This could be, e.g, checking the value of a field
> >>+ *    in CPU ID feature register or checking the cpu model. The capability
> >>+ *    provides a call back ( @matches() ) to perform the check.
> >>+ *    Scope defines how the checks should be performed. There are two cases:
> >>+ *
> >>+ *     a) SCOPE_LOCAL_CPU: check all the CPUs and "detect" if at least one
> >>+ *        matches. This implies, we have to run the check on all the booting
> >>+ *        CPUs, until the system decides that state of the capability is finalised.
> >>+ *        (See section 2 below)
> >>+ *		Or
> >>+ *     b) SCOPE_SYSTEM: check all the CPUs and "detect" if all the CPUs matches.
> >>+ *        This implies, we run the check only once, when the system decides to
> >>+ *        finalise the state of the capability. If the capability relies on a
> >>+ *        field in one of the CPU ID feature registers, we use the sanitised
> >>+ *        value of the register from the CPU feature infrastructure to make
> >>+ *        the decision.
> >>+ *    The process of detection is usually denoted by "update" capability state
> >>+ *    in the code.
> >>+ *
> >>+ * 2) Finalise the state : The kernel should finalise the state of a capability
> >>+ *    at some point during its execution and take necessary actions if any. Usually,
> >>+ *    this is done, after all the boot-time enabled CPUs are brought up by the
> >>+ *    kernel, so that it can make better decision based on the available set
> >>+ *    of CPUs. However, there are some special cases, where the action is taken
> >>+ *    during the early boot by the primary boot CPU. (e.g, running the kernel at
> >>+ *    EL2 with Virtualisation Host Extensions). The kernel usually disallows
> >>+ *    any changes to the state of a capability once it finalises the capability
> >>+ *    and takes any action, as it may be impossible to execute the actions safely.
> >>+ *
> >>+ * 3) Verification: When a CPU is brought online (e.g, by user or by the kernel),
> >>+ *    the kernel should make sure that it is safe to use the CPU, by verifying
> >>+ *    that the CPU is compliant with the state of the capabilities established
> >
> >Nit: can we say "finalised" instead of "established"?
> >
> >There could be doubt about precisely what "established" means.
> >"Finalised" is clearly defined in (2) -- I'm assuming that's the
> >intended meaning here (?)
> 
> You're right. It should be "Finalised".
> 
> >
> >>+ *    already. This happens via :
> >>+ *    secondary_start_kernel()-> check_local_cpu_capabilities()	->
> >>+ *      check_early_cpu_features() && verify_local_cpu_capabilities()
> >
> >Nit: Maybe just say "via secondart_start_kernel()"?  Too much detail
> >about the exact code flow may become wrong in the future when someone
> >refactors the code.
> 
> Sure. We could say secondary_start_kernel-> check_local_cpu_capabilities().

Yes, that seems enough.

> >
> >>+ *
> >>+ *    As explained in (2) above, capabilities could be finalised at different
> >>+ *    points in the execution. Each CPU is verified against the "finalised"
> >>+ *    capabilities and if there is a conflict, the kernel takes an action, based
> >>+ *    on the severity (e.g, a CPU could be prevented from booting or cause a
> >>+ *    kernel panic). The CPU is allowed to "affect" the state of the capability,
> >>+ *    if it has not been finalised already.
> >>+ *
> >>+ * 4) Action: As mentioned in (2), the kernel can take an action for each detected
> >>+ *    capability, on all CPUs on the system. This is always initiated only after
> >
> >Nit: maybe clarify what an action is, e.g.
> >"Appropriate actions include patching in alternatives, turning on an
> >architectural feature or activating errata workarounds."
> 
> See below.
> 
> >
> >Can we can that it is the job of the cpu_enable() method to perform the
> >appropriate action, or is that not universally true?
> >
> 
> It is not completely true. e.g we don't patch in alternatives from "enable" call back.
> They are batched and performed after we have "taken actions" (i.e after
> enable_cpu_capabilites() ). But all CPU control specific changes are performed from
> cpu_enable().
> 
> So we could say:
> 
> "Appropriate actions include turning on an architectural feature or
> changing the CPU control bits (e.g SCTLR or TCR). Patching in
> alternatives for the capabilities are

are -> is ?

> batched and is performed separately"

Ah, OK.  Yes that seems fine.

Happy to keep my Reviewed-by with those edits.

Cheers
---Dave
