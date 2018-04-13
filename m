Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754467AbeDMOKb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:10:31 -0400
Received: from foss.arm.com ([217.140.101.70]:42924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753884AbeDMOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:10:30 -0400
Date: Fri, 13 Apr 2018 15:10:45 +0100
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, marc.zyngier@arm.com
Subject: [GIT PULL] arm64: Late updates for 4.17
Message-ID: <20180413141045.GD30135@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As I mentioned in the previous pull request, we had some nasty conflicts
with the KVM tree that resulted in us dropping some spectre-related work
shortly before the merge window opened. Now that the KVM tree has been
merged, we've put together an updated version of the patches based on
your merge commit (details in the tag). I appreciate this isn't ideal,
so if you'd rather just see this stuff at -rc1 please let me know and we
can do that instead.

There are also a couple of patches here adding some unused assembler
macros which will be needed by some 4.18 crypto code and we'd like to
head that dependency off early.

Thanks,

Will

--->8

The following changes since commit d8312a3f61024352f1c7cb967571fd53631b0d6c:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2018-04-09 11:42:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 24534b3511828c66215fdf1533d77a7bf2e1fdb2:

  arm64: assembler: add macros to conditionally yield the NEON under PREEMPT (2018-04-11 18:50:34 +0100)

----------------------------------------------------------------
Additional arm64 updates for 4.17

A few late updates to address some issues arising from conflicts with
other trees:

- Removal of Qualcomm-specific Spectre-v2 mitigation in favour of the
  generic SMCCC-based firmware call

- Fix EL2 hardening capability checking, which was bodged to reduce
  conflicts with the KVM tree

- Add some currently unused assembler macros for managing SIMD registers
  which will be used by some crypto code in the next merge window

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: assembler: add utility macros to push/pop stack frames
      arm64: assembler: add macros to conditionally yield the NEON under PREEMPT

Marc Zyngier (3):
      arm64: capabilities: Rework EL2 vector hardening entry
      arm64: Get rid of __smccc_workaround_1_hvc_*
      arm64: Move the content of bpi.S to hyp-entry.S

Shanker Donthineni (1):
      arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening

 arch/arm64/include/asm/assembler.h | 136 +++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h   |  13 ++--
 arch/arm64/include/asm/kvm_asm.h   |   2 -
 arch/arm64/kernel/Makefile         |   2 -
 arch/arm64/kernel/asm-offsets.c    |   3 +
 arch/arm64/kernel/bpi.S            | 102 ----------------------------
 arch/arm64/kernel/cpu_errata.c     |  97 ++++++++++----------------
 arch/arm64/kvm/hyp/entry.S         |  12 ----
 arch/arm64/kvm/hyp/hyp-entry.S     |  64 ++++++++++++++++-
 arch/arm64/kvm/hyp/switch.c        |  10 ---
 10 files changed, 242 insertions(+), 199 deletions(-)
 delete mode 100644 arch/arm64/kernel/bpi.S
