Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755930AbeEaR64 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:58:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:18552 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755819AbeEaR6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:58:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725492"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/15] x86: Enable FSGSBASE instructions
Date: Thu, 31 May 2018 10:58:30 -0700
Message-Id: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSGSBASE is 64-bit instruction set to allow read/write
FS/GS base from any privilege. As introduced from
Ivybridge, enabling effort has been revolving quite long
[2,3,4] for various reasons. After extended discussions [1],
this patchset is proposed to introduce new ABIs of
customizing FS/GS base (separate from its selector).

FSGSBASE-enabled VM can be located on hosts with
either HW virtualization or SW emulation. KVM advertises
FSGSBASE when physical CPU has and emulation is
supported in QEMU/TCG [5]. In a pool of mixed systems, VMM
may disable FSGSBASE for seamless VM migrations [6].

A couple of major benefits are expected. Kernel will have
performance improvement in context switch by skipping MSR
write for GS base. User-level programs (such as JAVA-based)
benefit from avoiding system calls to edit FS/GS base.

Changes when FSGSBASE enabled:
(1) In context switch, a thread's FS/GS base is secured
regardless of its selector base on the discussion [1].
(2) (Subsequently) ptracer should expect divergence of FS/GS
index and base values. There was controveral debate on
the concerns with backward incompatibility with that.
(Cases for GDB than other toolchains [7,8]) Current
patchset as baseline version does not contain support
for the backward compatibility
(3) On paranoid entry, GS base is updated to per_CPU base
and the original base is restored at the exit

Updates from V1 [9]:
* (3), instead of comparing current and kernel GS bases
* (2); does not include ptracer backward compatibility
patches.
* With (3), CPU number is stored as early as possible
(before hitting IST stack) than at vDSO initialization.
* Include FSGSBASE documentation and enumerating capability
for user space
* Add TAINT_INSECURE flag and vDSO cleanup for the (CPU
number) initialization

[1] Recent discussion on LKML:
https://marc.info/?t=150147053700001&r=1&w=2
[2] Andy Lutomirski’s rebase work :
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fsgsbase
[3] Patch set shown in year 2016:
https://marc.info/?t=145857711900001&r=1&w=2
[4] First patch set: https://lkml.org/lkml/2015/4/10/573
[5] QEMU with FSGSBASE emulation:
https://github.com/qemu/qemu/blob/026aaf47c02b79036feb830206cfebb2a726510d/target/i386/translate.c#L8186
[6] 5-level EPT:
http://lkml.kernel.org/r/9ddf602b-6c8b-8c1e-ab46-07ed12366593@redhat.com
[7] RR/FSGSBASE:
https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
[8] CRIU/FSGSBASE:
https://lists.openvz.org/pipermail/criu/2018-March/040654.html
[9] V1:
https://lkml.org/lkml/2018/3/19/1699

Andi Kleen (3):
  x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
  x86/fsgsbase/64: Add documentation for FSGSBASE

Andy Lutomirski (4):
  x86/fsgsbase/64: Make ptrace read FS/GS base accurately
  x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/fsgsbase/64: Preserve FS/GS state in __switch_to if FSGSBASE is on
  x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit

Chang S. Bae (8):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
  x86/vdso: Move out the CPU number store
  taint: Add taint for insecure
  x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
  x86/fsgsbase/64: When copying a thread, use FSGSBASE if enabled
  x86/fsgsbase/64: Use per-CPU base as GS base on paranoid_entry

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/sysctl/kernel.txt                 |   1 +
 Documentation/x86/entry_64.txt                  |   9 +
 Documentation/x86/fsgs.txt                      | 104 +++++++++
 arch/x86/entry/entry_64.S                       |  74 +++++--
 arch/x86/entry/vdso/vgetcpu.c                   |   2 +-
 arch/x86/entry/vdso/vma.c                       |  38 +---
 arch/x86/include/asm/elf.h                      |   6 +-
 arch/x86/include/asm/fsgsbase.h                 | 171 +++++++++++++++
 arch/x86/include/asm/inst.h                     |  15 ++
 arch/x86/include/asm/segment.h                  |   4 +
 arch/x86/include/asm/vgtod.h                    |   2 -
 arch/x86/include/uapi/asm/hwcap2.h              |   3 +
 arch/x86/kernel/cpu/common.c                    |  39 ++++
 arch/x86/kernel/process_64.c                    | 274 ++++++++++++++++++++----
 arch/x86/kernel/ptrace.c                        |  28 +--
 arch/x86/kernel/setup_percpu.c                  |  30 ++-
 include/linux/kernel.h                          |   3 +-
 kernel/panic.c                                  |   1 +
 19 files changed, 681 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/x86/fsgs.txt
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4
