Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBHLgF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:36:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33494 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeBHLgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:36:04 -0500
Date: Thu, 8 Feb 2018 11:35:59 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, Julien Thierry <julien.thierry@arm.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        jnair@caviumnetworks.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/20] arm64: capabilities: Add support for features
 enabled early
Message-ID: <20180208113559.GW5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-12-suzuki.poulose@arm.com>
 <20180207103855.GB5862@e103592.cambridge.arm.com>
 <a1275474-fbf0-91b2-befb-cbd59d5ccf1e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1275474-fbf0-91b2-befb-cbd59d5ccf1e@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 06:34:37PM +0000, Suzuki K Poulose wrote:
> On 07/02/18 10:38, Dave Martin wrote:
> >On Wed, Jan 31, 2018 at 06:27:58PM +0000, Suzuki K Poulose wrote:
> >>The kernel detects and uses some of the features based on the boot
> >>CPU and expects that all the following CPUs conform to it. e.g,
> >>with VHE and the boot CPU running at EL2, the kernel decides to
> >>keep the kernel running at EL2. If another CPU is brought up without
> >>this capability, we use custom hooks (via check_early_cpu_features())
> >>to handle it. To handle such capabilities add support for detecting
> >>and enabling capabilities based on the boot CPU.
> >>
> >>A bit is added to indicate if the capability should be detected
> >>early on the boot CPU. The infrastructure then ensures that such
> >>capabilities are probed and "enabled" early on in the boot CPU
> >>and, enabled on the subsequent CPUs.
> >>
> >>Cc: Julien Thierry <julien.thierry@arm.com>
> >>Cc: Dave Martin <dave.martin@arm.com>
> >>Cc: Will Deacon <will.deacon@arm.com>
> >>Cc: Mark Rutland <mark.rutland@arm.com>
> >>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/include/asm/cpufeature.h | 48 +++++++++++++++++++++++++++++--------
> >>  arch/arm64/kernel/cpufeature.c      | 48 +++++++++++++++++++++++++++----------
> >>  2 files changed, 74 insertions(+), 22 deletions(-)
> >>
> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h

[...]

> >>   * 3) Verification: When a CPU is brought online (e.g, by user or by the kernel),
> >>   *    the kernel should make sure that it is safe to use the CPU, by verifying
> >>@@ -139,11 +148,22 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> >>   *
> >>   *    As explained in (2) above, capabilities could be finalised at different
> >>   *    points in the execution. Each CPU is verified against the "finalised"
> >>- *    capabilities and if there is a conflict, the kernel takes an action, based
> >>- *    on the severity (e.g, a CPU could be prevented from booting or cause a
> >>- *    kernel panic). The CPU is allowed to "affect" the state of the capability,
> >>- *    if it has not been finalised already. See section 5 for more details on
> >>- *    conflicts.
> >>+ *    capabilities.
> >>+ *
> >>+ *	x------------------------------------------------------------------- x
> >>+ *	| Verification:       | Boot CPU | SMP CPUs by kernel | CPUs by user |
> >>+ *	|--------------------------------------------------------------------|
> >>+ *	| Primary boot CPU    |          |                    |              |
> >>+ *	|  capability         |   n      |      y             |       y      |
> >>+ *	|--------------------------------------------------------------------|
> >>+ *	| All others          |   n      |      n             |       y      |
> >>+ *	x--------------------------------------------------------------------x
> >
> >Minor clarify nit: it's not obvious that "n" means "no conflict" and "y"
> >means "conflict".
> >
> >Could we have blank cell versus "X" (with a note saying what that
> >means), or "ok" versus "CONFLICT"?
> 
> This is not strictly about conflicts, but about what each CPU get
> verified against.  Since there are multiple stages of "finalisation"

You're right: I meant something like "potential conflict", but I hadn't
read the previous paragraph carefully enough and didn't explain what I
meant very well.

> for the capabilities, the table shows how the CPUs get verified.
> 
> Would it help if I changed the description above the table to :
> 
>  *    As explained in (2) above, capabilities could be finalised at different
>  *    points in the execution. Each CPU is verified against the "finalised"
>  *    capabilities. The following table shows, the capabilities verified
>  *    against each CPU in the system.
>  *
>  *      x------------------------------------------------------------------- x
>  *      | Verified against:   | Boot CPU | SMP CPUs by kernel | CPUs by user |

I still find it a bit cryptic.

Would it be simpler just to write this out in prose, with reference to
the actual capability types?  I feel that things have to be abbreviated
a bit to fit nicely into the table otherwise.

What about:

 * As explained in (2) above, capabilities could be finalised at different
 * points in the execution, depending on the capability type. Each newly booted
 * CPU is verified against those capabilities that have been finalised by the
 * time that CPU boots:
 *
 *	* SCOPE_BOOT_CPU: all CPUs are verified against the capability except
 *	  for the primary boot CPU.
 *
 *	* SCOPE_LOCAL_CPU, SCOPE_SYSTEM: all CPUs hotplugged on by the user
 *	  after kernel boot are verified against the capability.

> >>+ *    If there is a conflict, the kernel takes an action, based on the severity
> >>+ *    (e.g, a CPU could be prevented from booting or cause a kernel panic).
> >>+ *    The CPU is allowed to "affect" the state of the capability, if it has not
> >>+ *    been finalised already. See section 5 for more details on conflicts.
> >>   *
> >>   * 4) Action: As mentioned in (2), the kernel can take an action for each detected
> >>   *    capability, on all CPUs on the system. This is always initiated only after

[...]

Cheers
---Dave
