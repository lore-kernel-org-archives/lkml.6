Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1CB68C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89C6208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX1jxknt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89C6208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933848AbeFLOD5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:03:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50761 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933295AbeFLODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:03:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so20796266wmd.0;
        Tue, 12 Jun 2018 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJS4WYZmQ2iV/5b5lcl8H2Qd4uBS2xzAYUXtKbMJ4qQ=;
        b=iX1jxkntEIgF1D9bCvHv2EuS4sm2955LxP2vxgtPUh3NnwgkNdyM+Xv8Vk2idg68fl
         ILuveog6jMe56HF8KRQjWnu0JIHpsvDYbRH7Sa6LOtd4IRqF1F135JAilANfRL8EKgYY
         foQ9Ho0DpmQEomncnZMydlxu2QQVA0EfPgJ2I5jBlZaK0ubHOuA4u47PbygrNFjXza6v
         vvMmNCtv0TNt9MYahkk92dLjgw9h6mZySnbEa2fHiaHfQa6Zk3Lm9Fk3+SjkIseFmf5h
         w9Q0V7Slv/CraLzXSxaGIp9RyIP7evvXxA5ZcA/VN9DP6Oiao1X26SHmqxDV6zMZpYC+
         ga6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NJS4WYZmQ2iV/5b5lcl8H2Qd4uBS2xzAYUXtKbMJ4qQ=;
        b=kb3OEZRaWWvYBEXbHwbh6+PEfZRIPLa1zlJSkYl5ynHQFIGXz+nq7C/wBVVngQiFzt
         5nAhfs2B4MTjJcV6qpy8wtMDEe+bK/+Zb7PEyfBaqnSBOdvRQAXQaj5MfC0DjdrzPZpE
         89ViSQP+TpqKdZm7xoJVtdTuVarAYRdwnoLXTrc6eW14U5h0DpokaH50PmRsK/gxnc7j
         4yicP0ZCJykIbXf2iaWivPWFkZPL/VBUb9Nr3xsrQLo+PmCPbAoxeYNbbmJWnmb1pdky
         3HfTyj3zhmXKiJ608vdrRXQqBohT+y093zy4atvdkBBrbEah4eQsz68ZlCaQY8AiJEkK
         7LAg==
X-Gm-Message-State: APt69E0AYkj+HtUe1IYYbuFfqegSb6Orh2RJIngl/81w83cMH8T89MbU
        LZFC4WyEdgdebfVCYNMOa7s=
X-Google-Smtp-Source: ADUXVKIt621rcyd+oeU7MruFE7yr2x5ttaec6tIwdw2LKV5GtvAFdLTYLBCSymi8Pnj+cJy2pyoyVg==
X-Received: by 2002:a1c:aa12:: with SMTP id t18-v6mr360667wme.54.1528812233776;
        Tue, 12 Jun 2018 07:03:53 -0700 (PDT)
Received: from 640k.lan ([82.84.102.137])
        by smtp.gmail.com with ESMTPSA id w2-v6sm117197wrn.77.2018.06.12.07.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 07:03:52 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM changes for 4.18 merge window
Date:   Tue, 12 Jun 2018 16:03:49 +0200
Message-Id: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 73fcb1a370c76b202d406e95d9dabb76eaccf484:

  Merge branch 'akpm' (patches from Andrew) (2018-05-18 21:24:26 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 766d3571d8e50d3a73b77043dc632226f9e6b389:

  kvm: fix typo in flag name (2018-06-12 15:06:35 +0200)

Sorry for the late pull request, I really wanted to get the top four
patches in because a (wrong) patch for that bug was sent to the list
about a week ago.  I didn't get as much attention/as many reviews as I
hoped for, but here they are anyway.  They aren't complicated, only
a bit tedious, so I'm not (too) worried.

Paolo

----------------------------------------------------------------
Small update for KVM.

* ARM: lazy context-switching of FPSIMD registers on arm64, "split"
regions for vGIC redistributor

* s390: cleanups for nested, clock handling, crypto, storage keys and
control register bits

* x86: many bugfixes, implement more Hyper-V super powers,
implement lapic_timer_advance_ns even when the LAPIC timer
is emulated using the processor's VMX preemption timer.  Two
security-related bugfixes at the top of the branch.

----------------------------------------------------------------
Arnd Bergmann (1):
      KVM: x86: use timespec64 for KVM_HC_CLOCK_PAIRING

Christian Borntraeger (1):
      Merge tag 'kvm-s390-master-4.17-1'

Christoffer Dall (1):
      KVM: arm/arm64: Introduce kvm_arch_vcpu_run_pid_change

Dan Carpenter (1):
      KVM: x86: prevent integer overflows in KVM_MEMORY_ENCRYPT_REG_REGION

Dave Martin (18):
      arm64: fpsimd: Fix TIF_FOREIGN_FPSTATE after invalidating cpu regs
      thread_info: Add update_thread_flag() helpers
      arm64: Use update{,_tsk}_thread_flag()
      KVM: arm64: Convert lazy FPSIMD context switch trap to C
      arm64: fpsimd: Generalise context saving for non-task contexts
      arm64: fpsimd: Avoid FPSIMD context leakage for the init task
      arm64: fpsimd: Eliminate task->mm checks
      arm64/sve: Refactor user SVE trap maintenance for external use
      KVM: arm64: Repurpose vcpu_arch.debug_flags for general-purpose flags
      KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing
      arm64/sve: Move read_zcr_features() out of cpufeature.h
      arm64/sve: Switch sve_pffr() argument from task to thread
      arm64/sve: Move sve_pffr() to fpsimd.h and make inline
      KVM: arm64: Save host SVE context as appropriate
      KVM: arm64: Remove eager host SVE state saving
      KVM: arm64: Remove redundant *exit_code changes in fpsimd_guest_exit()
      KVM: arm64: Fold redundant exit code checks out of fixup_guest_exit()
      KVM: arm64: Invoke FPSIMD context switch trap from C

David Hildenbrand (4):
      KVM: s390: introduce defines for control registers
      KVM: s390: no need to inititalize kvm->arch members to 0
      KVM: s390: generalize kvm_s390_get_tod_clock_ext()
      KVM: s390: vsie: simplify < 8k address checks

Eric Auger (13):
      KVM: arm/arm64: Set dist->spis to NULL after kfree
      KVM: arm/arm64: Document KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
      KVM: arm/arm64: Replace the single rdist region by a list
      KVM: arm/arm64: Helper to locate free rdist index
      KVM: arm/arm64: Revisit Redistributor TYPER last bit computation
      KVM: arm/arm64: Adapt vgic_v3_check_base to multiple rdist regions
      KVM: arm/arm64: Helper to register a new redistributor region
      KVM: arm/arm64: Remove kvm_vgic_vcpu_early_init
      KVM: arm/arm64: Check vcpu redist base before registering an iodev
      KVM: arm/arm64: Check all vcpu redistributors are set on map_resources
      KVM: arm/arm64: Add KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
      KVM: arm/arm64: Implement KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
      KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to 512

Felix Wilhelm (1):
      kvm: nVMX: Enforce cpl=0 for VMX instructions

Greg Kroah-Hartman (1):
      kvm: no need to check return value of debugfs_create functions

Janosch Frank (1):
      KVM: s390: Add storage key facility interpretation control

Jim Mattson (11):
      kvm: vmx: Introduce lapic_mode enumeration
      kvm: vmx: Basic APIC virtualization controls have three settings
      kvm: nVMX: Eliminate APIC access page sharing between L1 and L2
      kvm: mmu: Add guest_mode to kvm_mmu_page_role
      kvm: mmu: Don't expose private memslots to L2
      kvm: nVMX: Use nested_run_pending rather than from_vmentry
      KVM: nVMX: Restore the VMCS12 offsets for v4.0 fields
      KVM: nVMX: Ensure that VMCS12 field offsets do not change
      kvm: x86: Amend the KVM_GET_SUPPORTED_CPUID API documentation
      kvm: nVMX: Restrict VMX capability MSR changes
      kvm: nVMX: Add support for "VMWRITE to any supported field"

Jingqi Liu (1):
      KVM: x86: Expose CLDEMOTE CPU feature to guest VM

Junaid Shahid (1):
      kvm: x86: Refactor mmu_free_roots()

K. Y. Srinivasan (5):
      X86/Hyper-V: Enlighten APIC access
      X86/Hyper-V: Enable IPI enlightenments
      X86/Hyper-V: Enhanced IPI enlightenment
      X86/Hyper-V: Consolidate code for converting cpumask to vpset
      X86/Hyper-V: Consolidate the allocation of the hypercall input page

Liran Alon (6):
      KVM: nVMX: Use vmx local var for referencing vpid02
      KVM: nVMX: Don't flush TLB when vmcs12 uses VPID
      KVM: nVMX: Emulate L1 individual-address invvpid by L0 individual-address invvpid
      KVM: docs: mmu: Fix link to NPT presentation from KVM Forum 2008
      KVM: docs: mmu: KVM support exposing SLAT to guests
      KVM: docs: nVMX: Remove known limitations as they do not exist now

Marc Orr (1):
      kvm: Make VM ioctl do valloc for some archs

Mark Rutland (1):
      arm64: KVM: Use lm_alias() for kvm_ksym_ref()

Michael S. Tsirkin (1):
      kvm: fix typo in flag name

Paolo Bonzini (5):
      Merge tag 'kvmarm-for-v4.18' of git://git.kernel.org/.../kvmarm/kvmarm into HEAD
      Merge tag 'kvm-s390-next-4.18-1' of git://git.kernel.org/.../kvms390/linux into HEAD
      KVM: x86: introduce linear_{read,write}_system
      KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_virt_system
      kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor access

Radim Krčmář (1):
      Merge branch 'x86/hyperv' of git://git.kernel.org/.../tip/tip

Sean Christopherson (1):
      KVM: x86: remove obsolete EXPORT... of handle_mmio_page_fault

Souptick Joarder (1):
      kvm: Change return type to vm_fault_t

Thomas Gleixner (2):
      x86/Hyper-V/hv_apic: Include asm/apic.h
      x86/Hyper-V/hv_apic: Build the Hyper-V APIC conditionally

Tony Krowiak (1):
      KVM: s390: reset crypto attributes for all vcpus

Vitaly Kuznetsov (8):
      KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
      x86/hyper-v: move struct hv_flush_pcpu{,ex} definitions to common header
      KVM: x86: hyperv: use defines when parsing hypercall parameters
      KVM: x86: hyperv: do rep check for each hypercall separately
      KVM: introduce kvm_make_vcpus_request_mask() API
      KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} implementation
      KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}_EX implementation
      KVM: x86: hyperv: declare KVM_CAP_HYPERV_TLBFLUSH capability

Wanpeng Li (2):
      KVM: X86: Fix reserved bits check for MOV to CR3
      KVM: VMX: Optimize tscdeadline timer latency

 Documentation/virtual/kvm/api.txt                 |  27 +-
 Documentation/virtual/kvm/devices/arm-vgic-v3.txt |  30 +-
 Documentation/virtual/kvm/mmu.txt                 |   6 +-
 Documentation/virtual/kvm/nested-vmx.txt          |  11 -
 arch/arm/include/asm/kvm_host.h                   |  14 +-
 arch/arm/include/uapi/asm/kvm.h                   |   1 +
 arch/arm64/Kconfig                                |   7 +
 arch/arm64/include/asm/cpufeature.h               |  29 --
 arch/arm64/include/asm/fpsimd.h                   |  21 +
 arch/arm64/include/asm/kvm_asm.h                  |   8 +-
 arch/arm64/include/asm/kvm_host.h                 |  49 ++-
 arch/arm64/include/asm/processor.h                |  15 +-
 arch/arm64/include/asm/thread_info.h              |  13 +-
 arch/arm64/include/uapi/asm/kvm.h                 |   1 +
 arch/arm64/kernel/fpsimd.c                        | 177 ++++----
 arch/arm64/kernel/ptrace.c                        |   1 +
 arch/arm64/kvm/Kconfig                            |   1 +
 arch/arm64/kvm/Makefile                           |   2 +-
 arch/arm64/kvm/debug.c                            |   8 +-
 arch/arm64/kvm/fpsimd.c                           | 110 +++++
 arch/arm64/kvm/hyp/debug-sr.c                     |   6 +-
 arch/arm64/kvm/hyp/entry.S                        |  43 --
 arch/arm64/kvm/hyp/hyp-entry.S                    |  19 -
 arch/arm64/kvm/hyp/switch.c                       | 124 ++++--
 arch/arm64/kvm/hyp/sysreg-sr.c                    |   4 +-
 arch/arm64/kvm/sys_regs.c                         |   9 +-
 arch/mips/kvm/mips.c                              |   2 +-
 arch/powerpc/kvm/book3s_hv.c                      |   3 +-
 arch/powerpc/kvm/powerpc.c                        |   2 +-
 arch/s390/include/asm/ctl_reg.h                   |  12 +
 arch/s390/include/asm/kvm_host.h                  |   1 +
 arch/s390/include/asm/mmu.h                       |   2 +-
 arch/s390/include/asm/mmu_context.h               |   2 +-
 arch/s390/include/asm/pgtable.h                   |   4 +-
 arch/s390/kvm/guestdbg.c                          |   2 +-
 arch/s390/kvm/interrupt.c                         |  20 +-
 arch/s390/kvm/kvm-s390.c                          |  61 +--
 arch/s390/kvm/kvm-s390.h                          |  13 +
 arch/s390/kvm/priv.c                              |  28 +-
 arch/s390/kvm/vsie.c                              |  10 +-
 arch/s390/mm/gmap.c                               |   6 +-
 arch/s390/mm/pgtable.c                            |   4 +-
 arch/x86/hyperv/Makefile                          |   3 +-
 arch/x86/hyperv/hv_apic.c                         | 256 +++++++++++
 arch/x86/hyperv/hv_init.c                         |  32 +-
 arch/x86/hyperv/mmu.c                             |  97 +----
 arch/x86/include/asm/hyperv-tlfs.h                |  55 ++-
 arch/x86/include/asm/kvm_emulate.h                |   6 +-
 arch/x86/include/asm/kvm_host.h                   |   7 +-
 arch/x86/include/asm/mshyperv.h                   |  44 +-
 arch/x86/include/asm/vmx.h                        |   2 +
 arch/x86/kvm/cpuid.c                              |   3 +-
 arch/x86/kvm/emulate.c                            |  76 ++--
 arch/x86/kvm/hyperv.c                             | 171 +++++++-
 arch/x86/kvm/lapic.c                              |  12 +-
 arch/x86/kvm/lapic.h                              |  14 +
 arch/x86/kvm/mmu.c                                |  78 ++--
 arch/x86/kvm/svm.c                                |  16 +-
 arch/x86/kvm/trace.h                              |  51 +++
 arch/x86/kvm/vmx.c                                | 489 +++++++++++++++++-----
 arch/x86/kvm/x86.c                                |  97 +++--
 arch/x86/kvm/x86.h                                |   4 +-
 include/kvm/arm_vgic.h                            |  17 +-
 include/linux/kvm_host.h                          |  19 +-
 include/linux/sched.h                             |   6 +
 include/linux/thread_info.h                       |  11 +
 include/uapi/linux/kvm.h                          |   5 +-
 tools/include/uapi/linux/kvm.h                    |   4 +-
 virt/kvm/Kconfig                                  |   3 +
 virt/kvm/arm/arm.c                                |  32 +-
 virt/kvm/arm/vgic/vgic-debug.c                    |  17 +-
 virt/kvm/arm/vgic/vgic-init.c                     | 100 +++--
 virt/kvm/arm/vgic/vgic-kvm-device.c               |  53 ++-
 virt/kvm/arm/vgic/vgic-mmio-v3.c                  | 112 ++++-
 virt/kvm/arm/vgic/vgic-v3.c                       |  99 ++++-
 virt/kvm/arm/vgic/vgic.h                          |  46 +-
 virt/kvm/kvm_main.c                               |  83 ++--
 77 files changed, 2191 insertions(+), 837 deletions(-)
 create mode 100644 arch/arm64/kvm/fpsimd.c
 create mode 100644 arch/x86/hyperv/hv_apic.c
