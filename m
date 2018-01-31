Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeAaS2m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:28:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41434 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeAaS2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:28:40 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 00/20] arm64: Rework cpu capabilities handling
Date: Wed, 31 Jan 2018 18:27:47 +0000
Message-Id: <20180131182807.32134-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
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

Suzuki K Poulose (19):
  arm64: capabilities: Move errata work around check on boot CPU
  arm64: capabilities: Move errata processing code
  arm64: capabilities: Prepare for fine grained capabilities
  arm64: capabilities: Add flags to handle the conflicts on late CPU
  arm64: capabilities: Unify the verification
  arm64: capabilities: Filter the entries based on a given mask
  arm64: capabilities: Group handling of features and errata
  arm64: capabilities: Introduce weak features based on local CPU
  arm64: capabilities: Restrict KPTI detection to boot-time CPUs
  arm64: capabilities: Add support for features enabled early
  arm64: capabilities: Change scope of VHE to Boot CPU feature
  arm64: capabilities: Clean up midr range helpers
  arm64: Add helpers for checking CPU MIDR against a range
  arm64: capabilities: Add support for checks based on a list of MIDRs
  arm64: Handle shared capability entries
  arm64: bp hardening: Allow late CPUs to enable work around
  arm64: Add MIDR encoding for Arm Cortex-A55 and Cortex-A35
  arm64: Delay enabling hardware DBM feature
  arm64: Add work around for Arm Cortex-A55 Erratum 1024718

 Documentation/arm64/silicon-errata.txt |   1 +
 arch/arm64/Kconfig                     |  14 ++
 arch/arm64/include/asm/cpucaps.h       |   3 +-
 arch/arm64/include/asm/cpufeature.h    | 237 +++++++++++++++++++++--
 arch/arm64/include/asm/cputype.h       |  42 +++++
 arch/arm64/include/asm/fpsimd.h        |   4 +-
 arch/arm64/include/asm/processor.h     |   7 +-
 arch/arm64/include/asm/virt.h          |   6 -
 arch/arm64/kernel/cpu_errata.c         | 284 +++++++++++++++-------------
 arch/arm64/kernel/cpufeature.c         | 333 +++++++++++++++++++++++++--------
 arch/arm64/kernel/fpsimd.c             |   5 +-
 arch/arm64/kernel/smp.c                |  44 -----
 arch/arm64/kernel/traps.c              |   4 +-
 arch/arm64/mm/fault.c                  |   3 +-
 arch/arm64/mm/proc.S                   |   9 +-
 15 files changed, 702 insertions(+), 294 deletions(-)

-- 
2.14.3
