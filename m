Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032989AbeE0Ptq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:49:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:28379 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032731AbeE0PqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741053"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split locked accesses
Date: Sun, 27 May 2018 08:45:49 -0700
Message-Id: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
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

Currently we can trace split lock event counter for debug purpose. But
for system deployed in the field, this event counter after the fact is
insufficient. We need a mechanism that allows the system ensure that
bus lock is never incurred due to split lock.

Intel introduces mechanism to detect split lock via alignment
check exception in Tremont and other future processors. If split lock is
from user process, #AC handler can kill the process or re-execute faulting
instruction depending on configuration. If split lock is from kernel, the
handler can cause kernel panic or re-execute faulting instruction
depending on configuration.

This capability is critical for real time system designers who build
consolidated real time systems. These systems run hard real time
code on some cores and run "untrusted" user processes on some
other cores. To date the designers have been unable to deploy these
solutions as they have no way to prevent the "untrusted" user code from
generating split lock and bus lock to block the hard real time code to
access memory during bus locking.

This capability may also find usage in cloud. A user process with split
lock running in one guest can block other cores from accessing shared
memory during its split locked memory access. That may cause overall
system performance degradation.

Split lock may open a security hole where malicious user code may slow
down overall system by executing instructions with split lock.

==Detect Split Lock==

To detect split lock, a new control bit (bit 29) in per-core TEST_CTL
MSR 0x33 will be introduced in future x86 processors. When the bit 29
is set, the processor causes #AC exception for split locked accesses at
all CPL.

The bit 29 specification in MSR TEST_CTL is published in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

==Handle Split Lock===

BIOS or hardware may set or clear the control bit depending on
platforms. To avoid disturbing BIOS/hardware setting, by default,
kernel inherits split lock BIOS setting with
CONFIG_SPLIT_LOCK_AC_ENABLE_DEFAUTL=2.

Kernel can override BIOS setting by explicitly enabling or disabling
the feature with CONFIG_SPLIT_LOCK_AC_ENABLE_DEFAULT=0 (disable) or
1 (enable).

When an instruction accesses split locked data and triggers #AC
exception, the faulting instruction is handled as follows:
- The faulting instruction is re-executed when the instruction is
  from kernel by default. If configured, split lock can causes kernel
  panic.
- User process gets SIGBUS signal when the faulting instruction is
  from the user process by default. If configured, this behavior can be
  changed to re-execute the faulting user instruction.

We do see #AC exception is triggered and causes system hang in BIOS path
(e.g. during system reboot) after kernel enables the feature. Instead of
debugging potential system hangs due to split locked accesses in various
buggy BIOSes, kernel only maintains enabled feature in the kernel domain.
Once it's out of the kernel domain (i.e. S3, S4, S5, efi runtime
services, kexec, kdump, CPU offline, etc), kernel restores to BIOS
setting. When returning from BIOS, kernel restores to kernel setting.

In cases when user does want to detect and fix split lock bang
in BIOS (e.g. in hard real time), the user can enable #AC for split lock
using debugfs interface /sys/kernel/debug/x86/split_lock/firmware.

Since kernel doesn't know when SMI comes, it's impossible for kernel
to disable #AC for split lock before entering SMI. So SMI handler may
inherit kernel's split lock setting and kernel tester may end up
debug split lock issues in SMI.

==Tests==

- /sys/kernel/debug/x86/split_lock/test_kernel (in patche 15) tests kernel
  space split lock.
- selftest (in patch 16) tests user space split lock.
- perf traces event sq_misc.split_lock
- S3, S4, S5, CPU hotplug, kexec tests with split lock eanbled.

==Changelog==
In this version:
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

Fenghua Yu (16):
  x86/split_lock: Add CONFIG and enumerate #AC exception for split
    locked access feature
  x86/split_lock: Handle #AC exception for split lock in kernel mode
  x86/split_lock: Set up #AC exception for split locked accesses on all
    CPUs
  x86/split_lock: Use non locked bit set instruction in set_cpu_cap
  x86/split_lock: Use non atomic set and clear bit instructions in
    clear_cpufeature()
  x86/split_lock: Save #AC setting for split lock in firmware in boot
    time and restore the setting in reboot
  x86/split_lock: Handle suspend/hibernate and resume
  x86/split_lock: Set split lock during EFI runtime service
  x86/split_lock: Add CONFIG to control #AC for split lock at boot time
  x86/split_lock: Add a debugfs interface to allow user to enable or
    disable #AC for split lock during run time
  x86/split_lock: Add CONFIG to control #AC for split lock from kernel
    at boot time
  x86/split_lock: Add a debugfs interface to allow user to change how to
    handle split lock in kernel mode during run time
  x86/split_lock: Add debugfs interface to control user mode behavior
  x86/split_lock: Add debugfs interface to show and control firmware
    setting for split lock
  x86/split_lock: Add CONFIG and debugfs interface for testing #AC for
    split lock in kernel mode
  x86/split_lock: Add user space split lock test in selftest

 arch/x86/Kconfig                                   |  49 ++
 arch/x86/include/asm/cpu.h                         |  18 +
 arch/x86/include/asm/cpufeature.h                  |   3 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/efi.h                         |   5 +
 arch/x86/include/asm/msr-index.h                   |   4 +
 arch/x86/kernel/cpu/Makefile                       |   1 +
 arch/x86/kernel/cpu/common.c                       |   2 +
 arch/x86/kernel/cpu/cpuid-deps.c                   |  10 +-
 arch/x86/kernel/cpu/test_ctl.c                     | 665 +++++++++++++++++++++
 arch/x86/kernel/setup.c                            |   2 +
 arch/x86/kernel/traps.c                            |  30 +-
 tools/testing/selftests/x86/Makefile               |   3 +-
 tools/testing/selftests/x86/split_lock_user_test.c | 207 +++++++
 14 files changed, 992 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/test_ctl.c
 create mode 100644 tools/testing/selftests/x86/split_lock_user_test.c

-- 
2.5.0
