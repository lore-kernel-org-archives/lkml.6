Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeENSwb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:52:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:55031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeENSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244618"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/15] x86/split_lock: Enable #AC exception for split locked accesses
Date: Mon, 14 May 2018 11:52:10 -0700
Message-Id: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing an atomic instruction, sometimes the data access crosses
the cache line boundary. This causes performance degradation. Intel
introduces mechanism to detect such split lock issue via alignment check
fault.

Instructions that may cause split lock issue include lock add, lock btc,
xchg, lsl, far call, ltr, etc.

To detect split lock, a new control bit (bit 29) in TEST_CTL MSR 0x33
will be introduced in future x86 processors. When the bit 29 is set,
the processor causes #AC(0) exception for split locked accesses at all
CPL.

BIOS or hardware may set or clear the control bit depending on
platforms. To avoid disturbing BIOS/hardware setting, by default,
kernel keeps split lock BIOS setting.

Kernel can override BIOS setting by explicitly enabling or disabling
the feature using kernel parameters "split_lock_ac=on" or
"split_lock_ac=off".

When an instruction accesses split locked data and triggers #AC
exception, the faulting instruction is handled as follows:
- the faulting instruction is re-executed when the instruction is
  from kernel.
- user process gets SIGBUS signal when the faulting instruction is
  from the user process. This behavior can be changed to re-execute
  the faulting user instruction by sysfs interface
  /sys/kernel/split_lock/user_mode.

We do see #AC exception is triggered and causes system hang in BIOS path
(e.g. during system reboot) after kernel enables the feature. Instead of
debugging potential system hangs due to split locked accesses in various
buggy BIOSes, kernel only maintains enabled feature in the kernel domain.
Once it's out of the kernel domain (i.e. S3, S4, S5, efi runtime
services, kexec, kdump, CPU offline, etc), kernel restores to BIOS
setting. When returning from BIOS, kernel restores to kernel setting.

Since kernel doesn't know when SMI comes, it's impossible for kernel
to disable split lock #AC before entering SMI. So SMI handler may
inherit kernel's split lock setting and kernel tester may end up
debug split lock issues in SMI.

In cases when user does want to detect and fix split lock #AC bang
in BIOS (e.g. in real time), the user can enable split lock #AC
using sysfs interface /sys/kernel/split_lock/bios.

The bit 29 specification in MSR TEST_CTL is published in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

Tests:
- /sys/kernel/split_lock/test_kernel (in patche 14) tests kernel
  space split lock.
- selftest (in patch 15) tests user space split lock.
- perf traces two events exceptions:split_lock_user and exceptions:
  split_lock_kernel.
- S3, S4, S5, CPU hotplug, kexec tests with split lock eanbled.

Fenghua Yu (15):
  x86/split_lock: Add CONFIG and enumerate #AC exception for split
    locked access feature
  x86/split_lock: Set up #AC exception for split locked accesses
  x86/split_lock: Handle #AC exception for split lock in kernel mode
  x86/split_lock: Use non locked bit set instruction in set_cpu_cap
  x86/split_lock: Use non atomic set and clear bit instructions to clear
    cpufeature
  x86/split_lock: Save #AC setting for split lock in BIOS in boot time
    and restore the setting in reboot
  x86/split_lock: Handle suspend/hibernate and resume
  x86/split_lock: Set split lock during EFI runtime service
  x86/split_lock: Explicitly enable or disable #AC for split locked
    accesses
  x86/split_lock: Add a sysfs interface to allow user to enable or
    disable split lock during run time
  x86/split_lock: Add sysfs interface to control user mode behavior
  x86/split_lock: Add sysfs interface to show and control BIOS split
    lock setting
  x86/split_lock: Trace #AC exception for split lock
  x86/split_lock: Add CONFIG and testing sysfs interface
  x86/split_lock: Add split lock user space test in selftest

 Documentation/admin-guide/kernel-parameters.txt    |  11 +
 arch/x86/Kconfig                                   |  22 +
 arch/x86/include/asm/cpu.h                         |  14 +
 arch/x86/include/asm/cpufeature.h                  |   3 +-
 arch/x86/include/asm/efi.h                         |   5 +
 arch/x86/include/asm/msr-index.h                   |   5 +
 arch/x86/include/asm/trace/common.h                |   8 +
 arch/x86/include/asm/trace/exceptions.h            |  21 +-
 arch/x86/kernel/cpu/Makefile                       |   1 +
 arch/x86/kernel/cpu/common.c                       |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c                   |  10 +-
 arch/x86/kernel/cpu/split_lock.c                   | 606 +++++++++++++++++++++
 arch/x86/kernel/traps.c                            |  12 +
 tools/testing/selftests/x86/Makefile               |   3 +-
 tools/testing/selftests/x86/split_lock_user_test.c | 187 +++++++
 15 files changed, 901 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/split_lock.c
 create mode 100644 tools/testing/selftests/x86/split_lock_user_test.c

-- 
2.5.0
