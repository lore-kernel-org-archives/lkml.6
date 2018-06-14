Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4DB38C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99B42087E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Z70AQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99B42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936103AbeFNRBJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:01:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39798 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755208AbeFNRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:01:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so13289380wmc.4;
        Thu, 14 Jun 2018 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=erdnsPRKPC92+xwKuFqUqC46GRmvA6Vsw5OzRQIyv2o=;
        b=K5Z70AQ/FbS4yEYbdrEHPexIqSHT4PCWVjNwcGHDb5LhSVodfCWYBo50vMS3s8ezZQ
         0oXXLtDL9vNLhl4qQPwxCsEHE08mXBqnOCiBwbBHB/dfkJ1ePk3T3VbA01CoJTdBXQGC
         l0a+XY82r7cbBIFue7Q1OuwFeKXXAUAiIJjYhLlA/wrMjxqa6nIkGb9P7h3+/aa+FSbT
         KFvJBxVovelVp7A9a1Rj+4UzNAjggyxJYBh6ZA9n625noGVWhH6FDdDKTYzoXkY0mbqG
         ltEy3/v/Pv7qC+l1fcerQu0MFBcPb83aGaWzmu60exjVCdsJSv3K3i+FIXVh9nf+I7jE
         9SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=erdnsPRKPC92+xwKuFqUqC46GRmvA6Vsw5OzRQIyv2o=;
        b=W1squgOcrx7KRzBjEK/FHrlVUavPMEplQoc+k7QZcXJpoS+Ks5LefZP8EcJ0/dV4Ez
         iAlEUE95PbI/quoBFb41y30thSJ5F7mO/WznJcWm8mxQGoaNrPLSHRtHiErvvXKOs2Ov
         s8eO5kEyfq6F9lDXIVALQCAIC+pzOIP4uDHfJRuD4yqi5RpBbiAQ5ze5EBgxgqE+FFiG
         ygW9pz+knsb2JtuQGXmaegHAH6gtd9mIgtrC+5u4YLVGEJluH2dMpxvvTMG1QeMTD3UW
         WC0rQqyIIkJTq2An0UE3vDkxSw77exlgjwFBk26wYvlAdvGMrSwuIE9UbM8z4vsPge0D
         Mz3g==
X-Gm-Message-State: APt69E077E6YudIBswNsATjYRd3iky76jFYs7XStAZ1mgpI63Ydlc9uj
        wiqUpe8JDl/ZUzZNM3XjGoU=
X-Google-Smtp-Source: ADUXVKIQIP9c4bQPLia14tD2rumGO5aqSia5Kz4LEGjOQHDfBRneB6KCUYBo9WzvOiuNd8plGkygBg==
X-Received: by 2002:a1c:9e95:: with SMTP id h143-v6mr2369510wme.105.1528995666332;
        Thu, 14 Jun 2018 10:01:06 -0700 (PDT)
Received: from 640k.lan ([82.84.121.233])
        by smtp.gmail.com with ESMTPSA id i76-v6sm8369297wmd.20.2018.06.14.10.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 10:01:05 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] Second batch of KVM changes for 4.18
Date:   Thu, 14 Jun 2018 19:01:02 +0200
Message-Id: <1528995662-45180-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 2837461dbe6f4a9acc0d86f88825888109211c99:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-06-14 16:35:32 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 1f008e114b1ba17e1d73e61149070c502174bb89:

  KVM: x86: VMX: redo fix for link error without CONFIG_HYPERV (2018-06-14 18:53:14 +0200)

No conflicts expected this time (thanks Paul/Michael!), so hopefully
not a big deal for your travelling.

----------------------------------------------------------------
Mostly the PPC part of the release, but also switching to Arnd's fix
for the hyperv config issue and a typo fix.

Main PPC changes: reimplement the MMIO instruction emulation,
transactional memory support for PR KVM, improve radix page table
handling.

----------------------------------------------------------------
Alexey Kardashevskiy (3):
      KVM: PPC: Book3S: Use correct page shift in H_STUFF_TCE
      KVM: PPC: Book3S: Allow backing bigger guest IOMMU pages with smaller physical pages
      KVM: PPC: Book3S: Check KVM_CREATE_SPAPR_TCE_64 parameters

Arnd Bergmann (1):
      KVM: x86: VMX: redo fix for link error without CONFIG_HYPERV

Cameron Kaiser (1):
      KVM: PPC: Book3S PR: Handle additional interrupt types

Marcelo Tosatti (1):
      KVM: x86: fix typo at kvm_arch_hardware_setup comment

Nicholas Piggin (9):
      KVM: PPC: Book3S HV: Lockless tlbie for HPT hcalls
      KVM: PPC: Book3S HV: Use a helper to unmap ptes in the radix fault path
      KVM: PPC: Book3S HV: Recursively unmap all page table entries when unmapping
      KVM: PPC: Book3S HV: Make radix use the Linux translation flush functions for partition scope
      KVM: PPC: Book3S HV: Make radix handle process scoped LPID flush in C, with relocation on
      KVM: PPC: Book3S HV: radix: Refine IO region partition scope attributes
      KVM: PPC: Book3S HV: radix: Do not clear partition PTE when RC or write bits do not match
      KVM: PPC: Book3S HV: Fix kvmppc_bad_host_intr for real mode interrupts
      KVM: PPC: Book3S HV: Send kvmppc_bad_interrupt NMIs to Linux handlers

Paolo Bonzini (1):
      Merge tag 'kvm-ppc-next-4.18-2' of git://git.kernel.org/.../paulus/powerpc into HEAD

Paul Mackerras (12):
      KVM: PPC: Book3S HV: Add 'online' register to ONE_REG interface
      KVM: PPC: Book3S HV: Set RWMR on POWER8 so PURR/SPURR count correctly
      KVM: PPC: Book3S HV: Fix inaccurate comment
      Merge remote-tracking branch 'remotes/powerpc/topic/ppc-kvm' into kvm-ppc-next
      KVM: PPC: Book3S PR: Enable use on POWER9 inside HPT-mode guests
      KVM: PPC: Book3S PR: Allow KVM_PPC_CONFIGURE_V3_MMU to succeed
      KVM: PPC: Book3S HV: Factor fake-suspend handling out of kvmppc_save/restore_tm
      Merge remote-tracking branch 'remotes/powerpc/topic/ppc-kvm' into kvm-ppc-next
      KVM: PPC: Book3S PR: Fix MSR setting when delivering interrupts
      KVM: PPC: Book3S PR: Fix failure status setting in treclaim. emulation
      KVM: PPC: Book3S PR: Don't let PAPR guest set MSR hypervisor bit
      KVM: PPC: Book3S PR: Enable use on POWER9 bare-metal hosts in HPT mode

Simon Guo (37):
      KVM: PPC: Add pt_regs into kvm_vcpu_arch and move vcpu->arch.gpr[] into it
      KVM: PPC: Move nip/ctr/lr/xer registers to pt_regs in kvm_vcpu_arch
      KVM: PPC: Fix a mmio_host_swabbed uninitialized usage issue
      KVM: PPC: Add KVMPPC_VSX_COPY_WORD_LOAD_DUMP type support for mmio emulation
      KVM: PPC: Reimplement non-SIMD LOAD/STORE instruction mmio emulation with analyse_instr() input
      KVM: PPC: Add giveup_ext() hook to PPC KVM ops
      KVM: PPC: Reimplement LOAD_FP/STORE_FP instruction mmio emulation with analyse_instr() input
      KVM: PPC: Reimplement LOAD_VSX/STORE_VSX instruction mmio emulation with analyse_instr() input
      KVM: PPC: Expand mmio_vsx_copy_type to cover VMX load/store element types
      KVM: PPC: Reimplement LOAD_VMX/STORE_VMX instruction mmio emulation with analyse_instr() input
      KVM: PPC: Book3S PR: Move kvmppc_save_tm/kvmppc_restore_tm to separate file
      KVM: PPC: Book3S PR: Add guest MSR parameter for kvmppc_save_tm()/kvmppc_restore_tm()
      KVM: PPC: Book3S PR: Turn on FP/VSX/VMX MSR bits in kvmppc_save_tm()
      KVM: PPC: Book3S PR: Add C function wrapper for _kvmppc_save/restore_tm()
      KVM: PPC: Book3S PR: Transition to Suspended state when injecting interrupt
      KVM: PPC: Book3S PR: Pass through MSR TM and TS bits to shadow_msr
      KVM: PPC: Book3S PR: Sync TM bits to shadow msr for problem state guest
      KVM: PPC: Book3S PR: Implement RFID TM behavior to suppress change from S0 to N0
      KVM: PPC: Book3S PR: Avoid changing TS bits when exiting guest
      KVM: PPC: Book3S PR: Add new kvmppc_copyto/from_vcpu_tm APIs
      KVM: PPC: Book3S PR: Add kvmppc_save/restore_tm_sprs() APIs
      KVM: PPC: Book3S PR: Add transaction memory save/restore skeleton
      KVM: PPC: Book3S PR: Add math support for PR KVM HTM
      KVM: PPC: Book3S PR: Emulate mtspr/mfspr using active TM SPRs
      KVM: PPC: Book3S PR: Always fail transactions in guest privileged state
      KVM: PPC: Book3S PR: Restore NV regs after emulating mfspr from TM SPRs
      KVM: PPC: Book3S PR: Add emulation for treclaim.
      KVM: PPC: Book3S PR: Add emulation for trechkpt.
      KVM: PPC: Book3S PR: Add emulation for tabort. in privileged state
      KVM: PPC: Book3S PR: Add guard code to prevent returning to guest with PR=0 and Transactional state
      KVM: PPC: Book3S PR: Support TAR handling for PR KVM HTM
      KVM: PPC: Book3S PR: Enable HTM for PR KVM for KVM_CHECK_EXTENSION ioctl
      KVM: PPC: Move vcpu_load/vcpu_put down to each ioctl case in kvm_arch_vcpu_ioctl
      KVM: PPC: Remove load/put vcpu for KVM_GET/SET_ONE_REG ioctl
      KVM: PPC: Book3S: Remove load/put vcpu for KVM_GET_REGS/KVM_SET_REGS
      KVM: PPC: Book3S PR: Enable kvmppc_get/set_one_reg_pr() for HTM registers
      KVM: PPC: Book3S PR: Fix failure status setting in tabort. emulation

Souptick Joarder (1):
      KVM: PPC: Book3S: Change return type to vm_fault_t

 arch/powerpc/include/asm/asm-prototypes.h |   6 +
 arch/powerpc/include/asm/kvm_book3s.h     |  37 +-
 arch/powerpc/include/asm/kvm_book3s_64.h  |  20 +-
 arch/powerpc/include/asm/kvm_booke.h      |  20 +-
 arch/powerpc/include/asm/kvm_host.h       |  21 +-
 arch/powerpc/include/asm/kvm_ppc.h        |  17 +-
 arch/powerpc/include/asm/reg.h            |   1 +
 arch/powerpc/include/uapi/asm/kvm.h       |   1 +
 arch/powerpc/kernel/asm-offsets.c         |  18 +-
 arch/powerpc/kvm/Makefile                 |   3 +
 arch/powerpc/kvm/book3s.c                 |  23 +-
 arch/powerpc/kvm/book3s.h                 |   6 +
 arch/powerpc/kvm/book3s_32_mmu.c          |   2 +-
 arch/powerpc/kvm/book3s_64_mmu.c          |  11 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c       |   3 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c    | 348 +++++++++-----
 arch/powerpc/kvm/book3s_64_vio.c          |  71 ++-
 arch/powerpc/kvm/book3s_64_vio_hv.c       |  54 ++-
 arch/powerpc/kvm/book3s_emulate.c         | 371 ++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c              |  97 +++-
 arch/powerpc/kvm/book3s_hv_builtin.c      |  21 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S   |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  36 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c      |   2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 318 +++----------
 arch/powerpc/kvm/book3s_hv_tm.c           |  10 +-
 arch/powerpc/kvm/book3s_hv_tm_builtin.c   |  10 +-
 arch/powerpc/kvm/book3s_pr.c              | 482 +++++++++++++++----
 arch/powerpc/kvm/book3s_segment.S         |  13 +
 arch/powerpc/kvm/book3s_xive_template.c   |   4 +-
 arch/powerpc/kvm/booke.c                  |  41 +-
 arch/powerpc/kvm/booke_emulate.c          |   6 +-
 arch/powerpc/kvm/e500_emulate.c           |   6 +-
 arch/powerpc/kvm/e500_mmu.c               |   2 +-
 arch/powerpc/kvm/e500_mmu_host.c          |   8 +-
 arch/powerpc/kvm/emulate_loadstore.c      | 752 +++++++++---------------------
 arch/powerpc/kvm/powerpc.c                | 311 +++++++++---
 arch/powerpc/kvm/tm.S                     | 384 +++++++++++++++
 arch/x86/kvm/vmx.c                        |   6 +-
 arch/x86/kvm/x86.c                        |   2 +-
 40 files changed, 2313 insertions(+), 1233 deletions(-)
 create mode 100644 arch/powerpc/kvm/tm.S
