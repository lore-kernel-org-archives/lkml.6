Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBXBqZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:46:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51019 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeBXBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:46:22 -0500
X-Google-Smtp-Source: AG47ELsMS1bBSzRxRJRzqg638Yoq5WQP4eeugkL/0Rc1m2IrSCKyD6oOe15NfaW3rUVBcCnK5gFoEw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for 4.16-rc3
Date: Sat, 24 Feb 2018 02:46:16 +0100
Message-Id: <1519436776-2987-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 9c5e0afaf15788bcbd1c3469da701ac3da826886:

  KVM: SVM: Fix SEV LAUNCH_SECRET command (2018-02-24 02:24:13 +0100)

----------------------------------------------------------------
s390:
- optimization for the exitless interrupt support that was merged in 4.16-rc1
- improve the branch prediction blocking for nested KVM
- replace some jump tables with switch statements to improve expoline performance
- fixes for multiple epoch facility

ARM:
- fix the interaction of userspace irqchip VMs with in-kernel irqchip VMs
- make sure we can build 32-bit KVM/ARM with gcc-8.

x86:
- fixes for AMD SEV
- fixes for Intel nested VMX, emulated UMIP and a dump_stack() on VM startup
- fixes for async page fault migration
- small optimization to PV TLB flush (new in 4.16-rc1)
- syzkaller fixes

Generic:
- compiler warning fixes
- syzkaller fixes
- more improvements to the kvm_stat tool

Two more small Spectre fixes are going to reach you via Ingo.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: kvm: fix building with gcc-8

Brijesh Singh (5):
      crypto: ccp: Fix sparse, use plain integer as NULL pointer
      include: psp-sev: Capitalize invalid length enum
      KVM: SVM: no need to call access_ok() in LAUNCH_MEASURE command
      KVM: SVM: install RSM intercept
      KVM: SVM: Fix SEV LAUNCH_SECRET command

Chao Gao (1):
      KVM: nVMX: Don't halt vcpu when L1 is injecting events to L2

Christian Borntraeger (5):
      KVM: s390: optimize wakeup for exitless interrupts
      KVM: s390: do not set intervention requests for GISA interrupts
      KVM: s390: force bp isolation for VSIE
      KVM: s390: use switch vs jump table in priv.c
      KVM: s390: use switch vs jump table in intercept.c

Christoffer Dall (1):
      KVM: arm/arm64: Fix arch timers with userspace irqchips

David Hildenbrand (5):
      KVM: s390: use switch vs jump table in interrupt.c
      KVM: s390: take care of clock-comparator sign control
      KVM: s390: consider epoch index on hotplugged CPUs
      KVM: s390: consider epoch index on TOD clock syncs
      KVM: s390: provide only a single function for setting the tod (fix SCK)

Dou Liyang (1):
      x86/kvm: Make parse_no_xxx __init for kvm

Eric Biggers (1):
      KVM/x86: remove WARN_ON() for when vm_munmap() fails

Marc Hartmayer (4):
      tools/kvm_stat: simplify the sortkey function
      tools/kvm_stat: use a namedtuple for storing the values
      tools/kvm_stat: use a more pythonic way to iterate over dictionaries
      tools/kvm_stat: avoid 'is' for equality checks

Paolo Bonzini (4):
      Merge tag 'kvm-s390-master-4.16-1' of git://git.kernel.org/.../kvms390/linux into HEAD
      Merge tag 'kvm-arm-fixes-for-v4.16-1' of git://git.kernel.org/.../kvmarm/kvmarm into HEAD
      Merge tag 'kvm-s390-master-4.16-2' of git://git.kernel.org/.../kvms390/linux into HEAD
      KVM: x86: move LAPIC initialization after VMCS creation

Radim Krčmář (2):
      KVM: nVMX: preserve SECONDARY_EXEC_DESC without UMIP
      KVM: x86: fix backward migration with async_PF

Sebastian Ott (2):
      kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds
      kvm: fix warning for non-x86 builds

Stefan Raspl (8):
      tools/kvm_stat: fix crash when filtering out all non-child trace events
      tools/kvm_stat: print error on invalid regex
      tools/kvm_stat: fix debugfs handling
      tools/kvm_stat: mark private methods as such
      tools/kvm_stat: eliminate extra guest/pid selection dialog
      tools/kvm_stat: separate drilldown and fields filtering
      tools/kvm_stat: group child events indented after parent
      tools/kvm_stat: print 'Total' line for multiple events only

Wanpeng Li (3):
      KVM: mmu: Fix overlap between public and private memslots
      KVM: X86: Fix SMRAM accessing even if VM is shutdown
      KVM: X86: Avoid traversing all the cpus for pv tlb flush when steal time is disabled

 Documentation/virtual/kvm/cpuid.txt  |   4 +
 Documentation/virtual/kvm/msr.txt    |   3 +-
 arch/arm/kvm/hyp/Makefile            |   5 +
 arch/arm/kvm/hyp/banked-sr.c         |   4 +
 arch/s390/kvm/intercept.c            |  51 ++--
 arch/s390/kvm/interrupt.c            | 123 ++++++---
 arch/s390/kvm/kvm-s390.c             |  79 +++---
 arch/s390/kvm/kvm-s390.h             |   7 +-
 arch/s390/kvm/priv.c                 | 192 ++++++-------
 arch/s390/kvm/vsie.c                 |  20 ++
 arch/x86/include/asm/kvm_host.h      |   3 -
 arch/x86/include/uapi/asm/kvm_para.h |   1 +
 arch/x86/kernel/kvm.c                |  20 +-
 arch/x86/kvm/cpuid.c                 |   3 +-
 arch/x86/kvm/lapic.c                 |   1 -
 arch/x86/kvm/mmu.c                   |   2 +-
 arch/x86/kvm/svm.c                   |  37 ++-
 arch/x86/kvm/vmx.c                   |  10 +-
 arch/x86/kvm/x86.c                   |   7 +-
 drivers/crypto/ccp/psp-dev.c         |   8 +-
 include/linux/kvm_host.h             |   6 +-
 include/uapi/linux/psp-sev.h         |   2 +-
 tools/kvm/kvm_stat/kvm_stat          | 503 ++++++++++++++++++++---------------
 tools/kvm/kvm_stat/kvm_stat.txt      |   4 +-
 virt/kvm/arm/arch_timer.c            | 116 ++++----
 virt/kvm/kvm_main.c                  |   3 +-
 26 files changed, 698 insertions(+), 516 deletions(-)
