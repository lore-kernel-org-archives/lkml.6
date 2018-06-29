Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C0CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3498727FAC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3498727FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755472AbeF2Oer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:34:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:9673 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbeF2Oep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:34:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 07:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="51490708"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2018 07:34:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "Ashok Raj" <ashok.raj@intel.com>,
        "Alan Cox" <alan@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/4] x86/split_lock: Enable #AC exception for split locked accesses
Date:   Fri, 29 Jun 2018 07:33:23 -0700
Message-Id: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
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

==Detect Split Lock==

To detect split lock, a new control bit (bit 29) in TEST_CTL MSR 0x33
will be introduced in future x86 processors. When the bit 29 is set,
the processor causes #AC exception for split locked accesses at all CPL.

The bit 29 specification in MSR TEST_CTL is published in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

==Handle Split Lock===

There may be different considerations to handle split lock, e.g. how
to handle split lock issue in firmware after kernel enables #AC for
split lock.

But we use a simple way to handle split lock:

- If split lock happens in kernel, a warning is issued and #AC for
split lock is disabled on the local CPU. The split lock issue should
be fixed in kernel.

Please note: After enabling this feature, we do find a kernel split
lock issue and fix it in patch 2. Patch 2 is before patch 3 in the
patch set because the WARN in patch 3 uses x86_capability bits which
cannot be set up without fix from patch 2.

- If split lock happens in user process, the process is killed by
SIGBUS. Unless the issue is fixed, the process cannot run in the
system.

- If split lock happens in firmware, system may hang in firmware. The
issue should be fixed in firmware.

- Kernel parameter 'ac_split_lock_off" opt-out of the feature.

==Changelog==
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

Fenghua Yu (4):
  x86/split_lock: Enumerate #AC exception for split locked access
    feature
  x86/split_lock: Align x86_capability to unsigned long to avoid split
    locked access
  x86/split_lock: Handle #AC exception for split lock
  x86/split_lock: Disable #AC for split locked accesses

 Documentation/admin-guide/kernel-parameters.txt |  4 ++
 arch/x86/include/asm/cpu.h                      |  3 +
 arch/x86/include/asm/cpufeatures.h              |  1 +
 arch/x86/include/asm/msr-index.h                |  4 ++
 arch/x86/include/asm/processor.h                |  3 +-
 arch/x86/kernel/cpu/Makefile                    |  1 +
 arch/x86/kernel/cpu/test_ctl.c                  | 96 +++++++++++++++++++++++++
 arch/x86/kernel/setup.c                         |  4 ++
 arch/x86/kernel/smpboot.c                       |  3 +
 arch/x86/kernel/traps.c                         | 32 ++++++++-
 10 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/test_ctl.c

-- 
2.5.0

