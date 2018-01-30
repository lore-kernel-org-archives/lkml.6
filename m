Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeA3P1V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:27:21 -0500
Received: from foss.arm.com ([217.140.101.70]:55234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbeA3P1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:27:19 -0500
Date: Tue, 30 Jan 2018 15:27:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 16/16] arm64: Add work around for Arm Cortex-A55 Erratum
 1024718
Message-ID: <20180130152714.GI5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-17-suzuki.poulose@arm.com>
 <20180126153314.GW5862@e103592.cambridge.arm.com>
 <58d36133-4f83-99f3-0423-7a80f3dd82f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d36133-4f83-99f3-0423-7a80f3dd82f8@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 04:29:53PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 15:33, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:09PM +0000, Suzuki K Poulose wrote:
> >>Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> >>from an erratum 1024718, which causes incorrect updates when DBM/AP
> >>bits in a page table entry is modified without a break-before-make
> >>sequence. The work around is to skip enabling the hardware DBM feature
> >>on the affected cores. The hardware Access Flag management features
> >>is not affected.
> >>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  Documentation/arm64/silicon-errata.txt |  1 +
> >>  arch/arm64/Kconfig                     | 14 ++++++++++++++
> >>  arch/arm64/kernel/cpufeature.c         | 14 +++++++++++++-
> >>  3 files changed, 28 insertions(+), 1 deletion(-)
> >
> >[...]
> >
> >>diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>index 8af755b8219d..64f1e911c6af 100644
> >>--- a/arch/arm64/kernel/cpufeature.c
> >>+++ b/arch/arm64/kernel/cpufeature.c
> >>@@ -914,9 +914,21 @@ static inline void __cpu_enable_hw_dbm(void)
> >>  	isb();
> >>  }
> >>+static bool cpu_has_erratum_1024718(void)
> >>+{
> >>+	static const struct midr_range __maybe_unused cpus[] = {
> >
> >Do you need __maybe_unused?  If #ifdef were used here then
> >__maybe_unused would be needed, but I thought that if code is optimised
> >out instead of conditionally copiled, this didn't apply.
> 
> Yep. I don't know if the compiler could optimise the array itself with
> the tag as a hint. I will double check.

I think the compiler should optimise cpus[] out as appropriate here,
even without the annotation.  It's scoped to this function and nothing
is done with it in the !IS_ENABLED() case.

I've relied heavily on this in the SVE code -- it massively reduces the
amount of #ifdefs and annotations required, which would otherwise clutter
the code a lot.

Since the kernel in general does rely on dead code elimination (and
presumably dead object elimination too) in order to avoid link failures,
I considered this reasonable.  The compiler did seem to do the right
thing for my code.

> 
> >
> >>+		MIDR_RANGE(MIDR_CORTEX_A55, 0, 0, 1, 0),	// A55 r0p0 -r1p0
> >>+		{},
> >>+	};
> >>+
> >>+	return IS_ENABLED(CONFIG_ARM64_ERRATUM_1024718) &&
> >>+	       is_midr_in_range_list(read_cpuid_id(), cpus);
> >
> >Why have a list with just one entry?  Do you expect more entries over
> >time?
> 
> Yes. I should have mentioned it here. See [1]
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554516.html

Right, that seemed the likely explanation!

Cheers
---Dave
