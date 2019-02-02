Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A00C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C215D21479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfBBFYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:24:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:23417 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfBBFYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:24:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 21:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="271934468"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2019 21:21:16 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Michael Chan" <michael.chan@broadcom.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Ricardo Neri" <ricardo.neri@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 00/10] x86/split_lock: Enable #AC exception for split locked accesses
Date:   Fri,  1 Feb 2019 21:14:41 -0800
Message-Id: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

==Introduction==

A split lock is any atomic operation whose operand crosses two cache
lines. Since the operand spans two cache lines and the operation must
be atomic, the system locks the bus while the CPU accesses the two cache
lines.

During bus locking, request from other CPUs or bus agents for control
of the bus are blocked. Blocking bus access from other CPUs plus
overhead of configuring bus locking protocol degrade not only the
performance of one CPU but overall system performance.

If operand is cacheable and completely contained in one cache line, atomic
operation is optimized by less expensive cache locking on Intel P6 and
recent processors. If split lock is detected and the two cache lines in the
operand can be merged into one cache line, cache locking instead of
more expensive bus locking will be used for atomic operation. Removing
split lock can improve overall performance.

Instructions that may cause split lock issue include lock add, lock btc,
xchg, lsl, far call, ltr, etc.

More information about split lock, bus locking, and cache locking can be
found in the latest Intel 64 and IA-32 Architecture Software Developer's
Manual.

==#AC for split lock==

Currently we can trace split lock event counter sq_misc.split_lock
for debug purpose. But for system deployed in the field, this event
counter after the fact is insufficient. We need a mechanism that
detects split lock before it happens to ensure that bus lock is never
incurred due to split lock.

Intel introduces a mechanism to detect split lock via Alignment Check
(#AC) exception before badly aligned atomic instructions might impact
whole system performance in Tremont and other future processors. 

This capability is critical for real time system designers who build
consolidated real time systems. These systems run hard real time
code on some cores and run "untrusted" user processes on some
other cores. The hard real time cannot afford to have any bus lock from
the untrusted processes to hurt real time performance. To date the
designers have been unable to deploy these solutions as they have no
way to prevent the "untrusted" user code from generating split lock and
bus lock to block the hard real time code to access memory during bus
locking.

This capability may also find usage in cloud. A user process with split
lock running in one guest can block other cores from accessing shared
memory during its split locked memory access. That may cause overall
system performance degradation.

Split lock may open a security hole where malicious user code may slow
down overall system by executing instructions with split lock.

==Enable #AC for Split Lock==

A control bit (bit 29) in TEST_CTL MSR 0x33 will be introduced in
future x86 processors. When the bit 29 is set, the processor causes
#AC exception for split locked accesses at all CPL.

User uses "setcpuid=ac_split_lock" or "setcpuid=255" to enable the feature.

Please note: The feature could be enumerated through
MSR IA32_CORE_CAPABILITY (0xCF). But the enumeration is not completely
published yet. So this patch set doesn't include the method.

The bit 29 specification in MSR TEST_CTL is published in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

==Handle Split Lock===

There may be different considerations to handle split lock, e.g. how
to handle split lock issue in firmware after kernel enables #AC for
split lock.

But we use a simple way to handle split lock which is suggested
by Thomas Gleixner and Dave Hansen:

- If split lock happens in kernel, a warning is issued and #AC for
split lock is disabled on the local CPU. The split lock issue should
be fixed in kernel.

- If split lock happens in user process, the process is killed by
SIGBUS. Unless the issue is fixed, the process cannot run in the
system.

- If split lock happens in firmware, system may hang in firmware. The
issue should be fixed in firmware.

- User can force to enable the feature if he knows the feature is
available.

==Patches==
Patch 1-4: Fix a few split lock issues.
Patch 5-7: Extend kernel option "clearcpuid=" to support multiple
options and CPU cap flags.
Patch 8: Add a new kernel option "setcpuid=" to force enable features.
Patch 9-10: Handle split lock

==Changelog==
v3:
- Handle split lock as suggested by Thomas Gleixner.
- Fix a few potential spit lock issues suggested by Thomas Gleixner.
- Support kernel option "setcpuid=" suggested by Dave Hanson and Thomas
Gleixner.
- Support flag string in "clearcpuid=" suggested by Dave Hanson and
Thomas Gleixner.

v2:
- Remove code that handles split lock issue in firmware and fix
x86_capability issue mainly based on comments from Thomas Gleixner and
Peter Zijlstra.

In previous version:
Comments from Dave Hansen:
- Enumerate feature in X86_FEATURE_SPLIT_LOCK_AC
- Separate #AC handler from do_error_trap
- Use CONFIG to configure inherit BIOS setting, enable, or disable split
  lock. Remove kernel parameter "split_lock_ac="
- Change config interface to debugfs from sysfs
- Fix a few bisectable issues
- Other changes.

Comment from Tony Luck and Dave Hansen:
- Dump right information in #AC handler

Comment from Alan Cox and Dave Hansen:
- Description of split lock in patch 0

Others:
- Remove tracing because we can trace split lock in existing
  sq_misc.split_lock.
- Add CONFIG to configure either panic or re-execute faulting instruction
  for split lock in kernel.
- other minor changes.

Fenghua Yu (10):
  x86/common: Align cpu_caps_cleared and cpu_caps_set to unsigned long
  drivers/net/b44: Align pwol_mask to unsigned long for better
    performance
  wlcore: Align reg_ch_conf_pending and tmp_ch_bitmap to unsigned long
    for better performance
  x86/split_lock: Align x86_capability to unsigned long to avoid split
    locked access
  x86/clearcpuid: Support multiple clearcpuid options
  x86/clearcpuid: Support feature flag string in kernel option
    clearcpuid
  Change document for kernel option clearcpuid
  x86/setcpuid: Add kernel option setcpuid
  x86/split_lock: Define #AC for split lock feature
  x86/split_lock: Handle #AC exception for split lock

 Documentation/admin-guide/kernel-parameters.txt | 21 +++++++-
 arch/x86/include/asm/cmdline.h                  |  3 ++
 arch/x86/include/asm/cpu.h                      |  2 +
 arch/x86/include/asm/cpufeature.h               |  2 +
 arch/x86/include/asm/cpufeatures.h              |  1 +
 arch/x86/include/asm/msr-index.h                |  4 ++
 arch/x86/include/asm/processor.h                |  4 +-
 arch/x86/kernel/cpu/common.c                    |  5 +-
 arch/x86/kernel/cpu/cpuid-deps.c                | 68 +++++++++++++++++++++----
 arch/x86/kernel/cpu/intel.c                     | 25 +++++++++
 arch/x86/kernel/fpu/init.c                      | 40 +++++++++++----
 arch/x86/kernel/setup.c                         |  3 ++
 arch/x86/kernel/smpboot.c                       |  3 ++
 arch/x86/kernel/traps.c                         | 30 ++++++++++-
 arch/x86/lib/cmdline.c                          | 17 ++++++-
 drivers/net/ethernet/broadcom/b44.c             |  3 +-
 drivers/net/wireless/ti/wlcore/cmd.c            |  3 +-
 drivers/net/wireless/ti/wlcore/wlcore.h         |  6 ++-
 18 files changed, 208 insertions(+), 32 deletions(-)

-- 
2.7.4

