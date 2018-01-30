Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeA3PW6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:22:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55164 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752959AbeA3PW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:22:56 -0500
Date: Tue, 30 Jan 2018 15:22:51 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 15/16] arm64: Delay enabling hardware DBM feature
Message-ID: <20180130152251.GH5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-16-suzuki.poulose@arm.com>
 <20180126144119.GV5862@e103592.cambridge.arm.com>
 <447fb2b7-1924-94b2-ff78-c97cd8bcea8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447fb2b7-1924-94b2-ff78-c97cd8bcea8d@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 04:05:24PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 14:41, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:08PM +0000, Suzuki K Poulose wrote:
> >>We enable hardware DBM bit in a capable CPU, very early in the
> >>boot via __cpu_setup. This doesn't give us a flexibility of
> >>optionally disable the feature, as the clearing the bit
> >>is a bit costly as the TLB can cache the settings. Instead,
> >>we delay enabling the feature until the CPU is brought up
> >>into the kernel. We use the feature capability mechanism
> >>to handle it.
> >>
> >>The hardware DBM is a non-conflicting feature. i.e, the kernel
> >>can safely run with a mix of CPUs with some using the feature
> >>and the others don't. So, it is safe for a late CPU to have
> >>this capability and enable it, even if the active CPUs don't.
> >>
> >>To get this handled properly by the infrastructure, we
> >>unconditionally set the capability and only enable it
> >>on CPUs which really have the feature. Adds a new type
> >>of feature to the capability infrastructure which
> >>ignores the conflict in a late CPU.
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/include/asm/cpucaps.h    |  3 ++-
> >>  arch/arm64/include/asm/cpufeature.h |  8 +++++++
> >>  arch/arm64/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++++++++++++++
> >>  arch/arm64/mm/proc.S                |  5 +----
> >>  4 files changed, 53 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> >>index bb263820de13..8df80cc828ac 100644
> >>--- a/arch/arm64/include/asm/cpucaps.h
> >>+++ b/arch/arm64/include/asm/cpucaps.h
> >>@@ -45,7 +45,8 @@
> >>  #define ARM64_HARDEN_BRANCH_PREDICTOR		24
> >>  #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
> >>  #define ARM64_HAS_RAS_EXTN			26
> >>+#define ARM64_HW_DBM				27
> >>-#define ARM64_NCAPS				27
> >>+#define ARM64_NCAPS				28
> >>  #endif /* __ASM_CPUCAPS_H */
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>index 70712de687c7..243ec7c77c79 100644
> >>--- a/arch/arm64/include/asm/cpufeature.h
> >>+++ b/arch/arm64/include/asm/cpufeature.h
> >>@@ -126,6 +126,14 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> >>   */
> >>  #define ARM64_CPUCAP_STRICT_CPU_LOCAL_FEATURE	\
> >>  	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS)
> >>+/*
> >>+ * CPU feature detected on each local CPU. It is safe for a late CPU to
> >>+ * either have it or not.
> >>+ */
> >>+#define ARM64_CPUCAP_WEAK_CPU_LOCAL_FEATURE	 \
> >>+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|\
> >>+	 ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS	|\
> >>+	 ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE)
> >
> >OK, so this is similar to my suggestion for HAS_NO_HW_PREFETCH (though
> >that need not have the same answer -- I was speculating there).
> 
> Yes, I was under the assumption that HAS_NO_HW_PREFETCH is treated as
> a "Late CPU can't have the capability" type, hence the "STRICT_CPU_LOCAL",
> as we can't apply work-arounds anymore for this CPU. However, since
> we only suffer a performance impact, we could as well convert it to
> a WEAK one.

(Note: I'm not very familiar with ThunderX.  I may be assuming things I
don't understand when I assert that only performance is affected
here...)

[...]

> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index 2627a836e99d..8af755b8219d 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c
> >>@@ -894,6 +894,35 @@ static int __init parse_kpti(char *str)
> >>  __setup("kpti=", parse_kpti);
> >>  #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
> >>+#ifdef CONFIG_ARM64_HW_AFDBM
> >>+static bool has_hw_dbm(const struct arm64_cpu_capabilities *entry, int scope)
> >>+{
> >>+	/*
> >>+	 * DBM is a non-conflicting feature. i.e, the kernel can safely run
> >>+	 * a mix of CPUs with and without the feature. So, we unconditionally
> >>+	 * enable the capability to allow any late CPU to use the feature.
> >>+	 * We only enable the control bits on the CPU, if it actually supports.
> >>+	 */
> >>+	return true;
> >>+}
> >>+
> >>+static inline void __cpu_enable_hw_dbm(void)
> >>+{
> >>+	u64 tcr = read_sysreg(tcr_el1) | TCR_HD;
> >>+
> >>+	write_sysreg(tcr, tcr_el1);
> >>+	isb();
> >
> >Do we need this isb?  Do we care exactly when setting TCR_HD appears
> >to take effect?
> 
> Practically no, as it doesn't matter if we use it or not. But, since the
> CPU is anyway booting, there is no harm in enforcing it to take effect.

Ok.  Just wondering whether there was a requirement here that I wasn't
understanding.

It would be worth a comment here explaining that the ISB is believed
only to be improving determinism here, rather than being required for
correctness.

[...]

> >>@@ -1052,6 +1081,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >>  		.enable = cpu_clear_disr,
> >>  	},
> >>  #endif /* CONFIG_ARM64_RAS_EXTN */
> >>+#ifdef CONFIG_ARM64_HW_AFDBM
> >>+	{
> >>+		.desc = "Hardware pagetable Dirty Bit Management",
> >>+		.type = ARM64_CPUCAP_WEAK_CPU_LOCAL_FEATURE,
> >>+		.capability = ARM64_HW_DBM,
> >>+		.sys_reg = SYS_ID_AA64MMFR1_EL1,
> >>+		.sign = FTR_UNSIGNED,
> >>+		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
> >>+		.min_field_value = 2,
> >>+		.matches = has_hw_dbm,
> >
> >Can't we use has_cpuid_feature here?  Why do we need a fake .matches and
> >then code the check manually in the enable mathod?
> 
> We could, but then we need to add another *type*, where capabilities could
> be enabled by a late CPU, where something is not already enabled by the boot-time
> CPUs. i.e, if we boot a DBM capable CPU late, we won't be able to use the feature
> on it, with the current setup. I didn't want to complicate the infrastructure
> further just for this.

Fair enough.  For now this seems like a unique case.

[...]

Cheers
---Dave
