Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032073AbeEZPr1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:47:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031908AbeEZPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:47:23 -0400
Date: Sat, 26 May 2018 17:47:20 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 4.17-rc7
Message-ID: <20180526154720.GB23383@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 633711e82878dc29083fc5d2605166755e25b57a:

  kvm: rename KVM_HINTS_DEDICATED to KVM_HINTS_REALTIME (2018-05-17 19:12:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/kvm tags/for-linus

for you to fetch changes up to 696ca779a928d0e93d61c38ffc3a4d8914a9b9a0:

  KVM: x86: fix #UD address of failed Hyper-V hypercalls (2018-05-25 21:33:31 +0200)

----------------------------------------------------------------
KVM fixes for v4.17-rc7

PPC:
 - Close a hole which could possibly lead to the host timebase getting
   out of sync.

 - Three fixes relating to PTEs and TLB entries for radix guests.

 - Fix a bug which could lead to an interrupt never getting delivered
   to the guest, if it is pending for a guest vCPU when the vCPU gets
   offlined.

s390:
 - Fix false negatives in VSIE validity check (Cc stable)

x86:
 - Fix time drift of VMX preemption timer when a guest uses LAPIC timer
   in periodic mode (Cc stable)

 - Unconditionally expose CPUID.IA32_ARCH_CAPABILITIES to allow
   migration from hosts that don't need retpoline mitigation (Cc stable)

 - Fix guest crashes on reboot by properly coupling CR4.OSXSAVE and
   CPUID.OSXSAVE (Cc stable)

 - Report correct RIP after Hyper-V hypercall #UD (introduced in -rc6)

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      KVM: PPC: Book3S HV: XIVE: Resend re-routed interrupts on CPU priority change

David Hildenbrand (1):
      KVM: s390: vsie: fix < 8k check for the itdba

David Vrabel (1):
      x86/kvm: fix LAPIC timer drift when guest uses periodic mode

Jim Mattson (1):
      kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Nicholas Piggin (2):
      KVM: PPC: Book3S HV: Make radix use correct tlbie sequence in kvmppc_radix_tlbie_page
      KVM: PPC: Book3S HV: Make radix clear pte when unmapping

Paolo Bonzini (1):
      Merge tag 'kvm-s390-master-4.17-1' of git://git.kernel.org/.../kvms390/linux into kvm-master

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Snapshot timebase offset on guest entry
      KVM: PPC: Book 3S HV: Do ptesync in radix guest exit path

Radim Krčmář (2):
      Merge tag 'kvm-ppc-fixes-4.17-1' of git://git.kernel.org/.../paulus/powerpc
      KVM: x86: fix #UD address of failed Hyper-V hypercalls

Wei Huang (1):
      KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

 arch/powerpc/include/asm/kvm_book3s.h   |   1 +
 arch/powerpc/kernel/asm-offsets.c       |   1 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c  |   6 +-
 arch/powerpc/kvm/book3s_hv.c            |   1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  97 +++++++++++++++-------------
 arch/powerpc/kvm/book3s_xive_template.c | 108 +++++++++++++++++++++++++++++---
 arch/s390/kvm/vsie.c                    |   2 +-
 arch/x86/kvm/cpuid.c                    |   5 ++
 arch/x86/kvm/hyperv.c                   |  19 +++---
 arch/x86/kvm/lapic.c                    |  16 ++++-
 arch/x86/kvm/x86.c                      |  17 +++--
 11 files changed, 198 insertions(+), 75 deletions(-)
