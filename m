Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeCZONM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:13:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeCZONL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:13:11 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dave.martin@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ckadabi@codeaurora.org, shankerd@codeaurora.org,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 00/22] arm64: arm64: Rework cpu capabilities handling
Date: Mon, 26 Mar 2018 15:12:27 +0100
Message-Id: <1522073569-29174-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series reworks the arm64 CPU capabilities handling (which
manages the system features and errata). The current infrastructure
doesn't allow fine control for handling different features or errata.
There is one rule for features and another rule for errata.

* Features are checked only once, after all the boot time CPUs are
   activated. Any new CPU that is brought up is prevented from booting
   if it misses a feature already established. If the new CPU has a
   feature not enabled already, it is allowed to boot.

* Errata checks are performed on all the CPUs and any new CPU is
   OK to miss the capability. However if a late CPU requires a work around,
   then we fail the CPU.

   This doesn't always apply to some features. e.g, KPTI is a security
   feature which should be applied when at least one CPU needs it. So,
   the tests should be performed on all the booting CPUs individually.
   Also, if a CPU that needs this security feature is brought up later,
   when the system has not enabled it, the CPU can boot making the system
   insecure. Another exception is the hardware DBM for page tables. The
   kernel can safely run with a mix of CPUs that have the feature turned
   on and off. This again causes problem when a new CPU is brought up
   which may not have the feature, which is killed.

   Also there are other features like, GICV3 system register access,
   which now need to be enabled very early based on the boot CPU to
   allow the use of Priority handling to implement NMI.

This calls for finer level of control per capability and the series
implements the same by defining how to deal with a conflict of a
given capability on a CPU with that of the system level state. It
also consolidates the handling of features and errata into generic
helpers. The table of features and errata are left as they are to
allow easier look up for a given type.

The series also gets rid of duplicate entries for a single capability
by introducing a wrapper entry which takes care of managing a list
of entries with distinct matches/enable pair.

We also cleans up the MIDR range handling and cleans up some of the
errata checks where the entries were duplicated for checking different
CPU models. Finally it also implements a work around for Arm Cortex-A55
erratum 1024718 based on the new infrastructure.

Changes since V4
 - No functional changes to the series.
 - Rebased to arm64's for-next/core ( commit af4a81b9cd847441 )
 - Added Dave's Reviewed-by tags for patches 11, 15, 19, 21 & 22
 - Fixed a typo in the commit description of Patch 15

Changes since V3
 - Rebased to for-next/core (twice internally huh!)
 - Address review comments from Dave
 - Rename cap_list => match_list in Shared capability handling.
 - Rename cpu_has_erratum_1024718() to cpu_has_broken_dbm() in
   Patch 22, Erratum 1024718, for sharing the routine for different
   CPUs which could be affected.

Changes since V2
 - Mostly address review comments from Dave
 - Drop "Change the type for BP hardening to accept late CPUs"
   as we can't fake the capability, which is exposed to KVM guests.
 - Split the "arm64: capabilities: Group handling of features and
   errata" to smaller patches.
 - Add tags from Dave.
 - Use SCOPE_* in the Code instead of the ARM64_CPUCAP_SCOPE_* version.
 - Hide description for DBM feature, as we turn the capability on always
   irrespective of whether the CPUs have it or not.

Changes since V1
 - Pickup almost all suggestions by Dave.
 - Rename flags for handling conflicts
 - Rename the "enable" call back to cpu_enable
 - Update prototype for cpu_enable to void.
 - Handle capabilities with multiple table entries, simplifying the
   core logic.
 - Add capabilities based on Boot CPU.
 - Change the type for BP Hardening to accept late CPUs.
 - More usersfor midr_range list.
 - More commentary in the code.
 - Flip type of Software prefetching capability to Weak from Strict.



Dave Martin (1):
  arm64: capabilities: Update prototype for enable call back

Suzuki K Poulose (21):
  arm64: capabilities: Move errata work around check on boot CPU
  arm64: capabilities: Move errata processing code
  arm64: capabilities: Prepare for fine grained capabilities
  arm64: capabilities: Add flags to handle the conflicts on late CPU
  arm64: capabilities: Unify the verification
  arm64: capabilities: Filter the entries based on a given mask
  arm64: capabilities: Prepare for grouping features and errata work
    arounds
  arm64: capabilities: Split the processing of errata work arounds
  arm64: capabilities: Allow features based on local CPU scope
  arm64: capabilities: Group handling of features and errata workarounds
  arm64: capabilities: Introduce weak features based on local CPU
  arm64: capabilities: Restrict KPTI detection to boot-time CPUs
  arm64: capabilities: Add support for features enabled early
  arm64: capabilities: Change scope of VHE to Boot CPU feature
  arm64: capabilities: Clean up midr range helpers
  arm64: Add helpers for checking CPU MIDR against a range
  arm64: capabilities: Add support for checks based on a list of MIDRs
  arm64: capabilities: Handle shared entries
  arm64: Add MIDR encoding for Arm Cortex-A55 and Cortex-A35
  arm64: Delay enabling hardware DBM feature
  arm64: Add work around for Arm Cortex-A55 Erratum 1024718

 Documentation/arm64/silicon-errata.txt |   1 +
 arch/arm64/Kconfig                     |  14 ++
 arch/arm64/include/asm/cpucaps.h       |   3 +-
 arch/arm64/include/asm/cpufeature.h    | 258 ++++++++++++++++++++--
 arch/arm64/include/asm/cputype.h       |  43 ++++
 arch/arm64/include/asm/fpsimd.h        |   4 +-
 arch/arm64/include/asm/processor.h     |   7 +-
 arch/arm64/include/asm/virt.h          |   6 -
 arch/arm64/kernel/cpu_errata.c         | 294 +++++++++++++------------
 arch/arm64/kernel/cpufeature.c         | 381 +++++++++++++++++++++++++--------
 arch/arm64/kernel/fpsimd.c             |   5 +-
 arch/arm64/kernel/smp.c                |  44 ----
 arch/arm64/kernel/traps.c              |   4 +-
 arch/arm64/mm/fault.c                  |   3 +-
 arch/arm64/mm/proc.S                   |  13 +-
 15 files changed, 769 insertions(+), 311 deletions(-)

-- 
2.7.4
