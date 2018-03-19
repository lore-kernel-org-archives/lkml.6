Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968519AbeCSSIx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:08:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:62509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965309AbeCSSIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330555"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 00/15] x86: Enable FSGSBASE instructions
Date: Mon, 19 Mar 2018 10:49:12 -0700
Message-Id: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
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
* In context switch, a thread's FS/GS base is secured
regardless of its selector [1].
* (Subsequently) when ptracer updates FS/GS base, it is
(always) carried onto the tracee. This is an outcome of
discussions with our GDB contact. Also, checked with other
toolchains [7, 8].
* On paranoid entry, GS base is compared with the kernel’s
to decide the necessity of SWAPGS.

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

Andi Kleen (1):
  x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions

Andy Lutomirski (4):
  x86/fsgsbase/64: Make ptrace read FS/GS base accurately
  x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/fsgsbase/64: Preserve FS/GS state in __switch_to if FSGSBASE is on
  x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit

Chang S. Bae (10):
  x86/fsgsbase/64: Introduce FS/GS base helper functions
  x86/fsgsbase/64: Use FS/GS base helpers in core dump
  x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
  x86/ptrace: A new macro to get an offset of user_regs_struct
  x86/fsgsbase/64: Add putregs() to handle multiple elements' setting
  x86/fsgsbase/64: putregs() in a reverse order
  x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
  x86/fsgsbase/64: When copying a thread, use FSGSBASE if enabled
  x86/fsgsbase/64: With FSGSBASE, compare GS bases on paranoid_entry
  x86/fsgsbase/64: Support legacy behavior when FS/GS updated by ptracer

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 arch/x86/entry/entry_64.S                       |  54 ++++-
 arch/x86/include/asm/elf.h                      |   6 +-
 arch/x86/include/asm/fsgsbase.h                 | 200 +++++++++++++++++
 arch/x86/include/asm/inst.h                     |  15 ++
 arch/x86/kernel/cpu/common.c                    |  20 ++
 arch/x86/kernel/process_64.c                    | 274 ++++++++++++++++++++----
 arch/x86/kernel/ptrace.c                        | 253 ++++++++++++++++------
 8 files changed, 696 insertions(+), 128 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

-- 
2.7.4
