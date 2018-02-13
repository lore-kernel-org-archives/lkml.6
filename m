Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933441AbeBMFCi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:02:38 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45650 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeBMFCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:02:37 -0500
X-Google-Smtp-Source: AH8x227aLAMIEf8RPDGLBLjRWGlZ2n2KSWxKgpYF6gCyJuOrzC0jgniYFifADk95Z2btngVXlxOMpfmDiHB1qKLzBD0=
MIME-Version: 1.0
In-Reply-To: <1517813878-22248-1-git-send-email-wanpengli@tencent.com>
References: <1517813878-22248-1-git-send-email-wanpengli@tencent.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 13 Feb 2018 13:02:35 +0800
Message-ID: <CANRm+CxV+ZL-QpE=chKsmA01nS0vpCrwihRe+jPSiK3mzRzUrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: X86: Add per-VM no-HLT-exiting capability
To: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1D52lgU002011

Ping,
2018-02-05 14:57 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> From: Wanpeng Li <wanpengli@tencent.com>
>
> If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
> This patch adds the per-VM non-HLT-exiting capability.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * vmx_clear_hlt() around INIT handling
>  * vmx_clear_hlt() upon SMI and implement auto halt restart
>
>  Documentation/virtual/kvm/api.txt  | 11 +++++++++++
>  arch/x86/include/asm/kvm_emulate.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  7 +++++++
>  arch/x86/kvm/emulate.c             |  2 ++
>  arch/x86/kvm/vmx.c                 | 38 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c                 | 27 +++++++++++++++++++++++----
>  arch/x86/kvm/x86.h                 |  5 +++++
>  include/uapi/linux/kvm.h           |  1 +
>  8 files changed, 88 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 023da07..865b029 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4302,6 +4302,17 @@ enables QEMU to build error log and branch to guest kernel registered
>  machine check handling routine. Without this capability KVM will
>  branch to guests' 0x200 interrupt vector.
>
> +7.13 KVM_CAP_X86_GUEST_HLT
> +
> +Architectures: x86
> +Parameters: none
> +Returns: 0 on success
> +
> +This capability indicates that a guest using HLT to stop a virtual CPU
> +will not cause a VM exit. As such, time spent while a virtual CPU is
> +halted in this way will then be accounted for as guest running time on
> +the host, KVM_FEATURE_PV_UNHALT should be disabled.
> +
>  8. Other capabilities.
>  ----------------------
>
> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
> index b24b1c8..78cfe8ca 100644
> --- a/arch/x86/include/asm/kvm_emulate.h
> +++ b/arch/x86/include/asm/kvm_emulate.h
> @@ -225,6 +225,7 @@ struct x86_emulate_ops {
>         unsigned (*get_hflags)(struct x86_emulate_ctxt *ctxt);
>         void (*set_hflags)(struct x86_emulate_ctxt *ctxt, unsigned hflags);
>         int (*pre_leave_smm)(struct x86_emulate_ctxt *ctxt, u64 smbase);
> +       void (*smm_auto_halt_restart)(struct x86_emulate_ctxt *ctxt);
>
>  };
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8f0f09a..95b2c44 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -623,6 +623,11 @@ struct kvm_vcpu_arch {
>         unsigned nmi_pending; /* NMI queued after currently running handler */
>         bool nmi_injected;    /* Trying to inject an NMI this entry */
>         bool smi_pending;    /* SMI queued after currently running handler */
> +       /*
> +        * bit 0 is set if Value of Auto HALT Restart after Entry to SMM is true
> +        * bit 1 is set if Value of Auto HALT Restart When Exiting SMM is true
> +        */
> +       int smm_auto_halt_restart;
>
>         struct kvm_mtrr mtrr_state;
>         u64 pat;
> @@ -806,6 +811,8 @@ struct kvm_arch {
>
>         gpa_t wall_clock;
>
> +       bool hlt_in_guest;
> +
>         bool ept_identity_pagetable_done;
>         gpa_t ept_identity_map_addr;
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index d91eaeb..ee5bc65 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2597,6 +2597,8 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
>
>         smbase = ctxt->ops->get_smbase(ctxt);
>
> +       if (GET_SMSTATE(u16, smbase, 0x7f02) & 0x1)
> +               ctxt->ops->smm_auto_halt_restart(ctxt);
>         /*
>          * Give pre_leave_smm() a chance to make ISA-specific changes to the
>          * vCPU state (e.g. enter guest mode) before loading state from the SMM
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 3e71086..23789c9 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2474,6 +2474,24 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
>         return 0;
>  }
>
> +static bool vmx_need_clear_hlt(struct kvm_vcpu *vcpu)
> +{
> +       return kvm_hlt_in_guest(vcpu->kvm) &&
> +               vmcs_read32(GUEST_ACTIVITY_STATE) == GUEST_ACTIVITY_HLT;
> +}
> +
> +static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
> +{
> +       /*
> +        * Ensure that we clear the HLT state in the VMCS.  We don't need to
> +        * explicitly skip the instruction because if the HLT state is set,
> +        * then the instruction is already executing and RIP has already been
> +        * advanced.
> +        */
> +       if (vmx_need_clear_hlt(vcpu))
> +               vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
> +}
> +
>  static void vmx_queue_exception(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -2504,6 +2522,8 @@ static void vmx_queue_exception(struct kvm_vcpu *vcpu)
>                 intr_info |= INTR_TYPE_HARD_EXCEPTION;
>
>         vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
> +
> +       vmx_clear_hlt(vcpu);
>  }
>
>  static bool vmx_rdtscp_supported(void)
> @@ -5359,6 +5379,8 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>                 exec_control |= CPU_BASED_CR3_STORE_EXITING |
>                                 CPU_BASED_CR3_LOAD_EXITING  |
>                                 CPU_BASED_INVLPG_EXITING;
> +       if (kvm_hlt_in_guest(vmx->vcpu.kvm))
> +               exec_control &= ~CPU_BASED_HLT_EXITING;
>         return exec_control;
>  }
>
> @@ -5716,6 +5738,8 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>         update_exception_bitmap(vcpu);
>
>         vpid_sync_context(vmx->vpid);
> +       if (init_event)
> +               vmx_clear_hlt(vcpu);
>  }
>
>  /*
> @@ -5787,6 +5811,8 @@ static void vmx_inject_irq(struct kvm_vcpu *vcpu)
>         } else
>                 intr |= INTR_TYPE_EXT_INTR;
>         vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr);
> +
> +       vmx_clear_hlt(vcpu);
>  }
>
>  static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
> @@ -5817,6 +5843,8 @@ static void vmx_inject_nmi(struct kvm_vcpu *vcpu)
>
>         vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
>                         INTR_TYPE_NMI_INTR | INTR_INFO_VALID_MASK | NMI_VECTOR);
> +
> +       vmx_clear_hlt(vcpu);
>  }
>
>  static bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu)
> @@ -12048,6 +12076,10 @@ static int vmx_pre_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
>
>         vmx->nested.smm.vmxon = vmx->nested.vmxon;
>         vmx->nested.vmxon = false;
> +       if (vmx_need_clear_hlt(vcpu)) {
> +               vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
> +               vcpu->arch.smm_auto_halt_restart = 0x1;
> +       }
>         return 0;
>  }
>
> @@ -12056,6 +12088,12 @@ static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>         int ret;
>
> +       if (vcpu->arch.smm_auto_halt_restart & 0x3)
> +               vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_HLT);
> +       else if (vcpu->arch.smm_auto_halt_restart & 0x1)
> +               skip_emulated_instruction(vcpu);
> +       vcpu->arch.smm_auto_halt_restart = 0;
> +
>         if (vmx->nested.smm.vmxon) {
>                 vmx->nested.vmxon = true;
>                 vmx->nested.smm.vmxon = false;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 05dbdba..1bdfdcf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2785,6 +2785,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>         case KVM_CAP_SET_BOOT_CPU_ID:
>         case KVM_CAP_SPLIT_IRQCHIP:
>         case KVM_CAP_IMMEDIATE_EXIT:
> +       case KVM_CAP_X86_GUEST_HLT:
>                 r = 1;
>                 break;
>         case KVM_CAP_ADJUST_CLOCK:
> @@ -4106,6 +4107,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>
>                 r = 0;
>                 break;
> +       case KVM_CAP_X86_GUEST_HLT:
> +               kvm->arch.hlt_in_guest = cap->args[0];
> +               r = 0;
> +               break;
>         default:
>                 r = -EINVAL;
>                 break;
> @@ -5417,6 +5422,11 @@ static int emulator_pre_leave_smm(struct x86_emulate_ctxt *ctxt, u64 smbase)
>         return kvm_x86_ops->pre_leave_smm(emul_to_vcpu(ctxt), smbase);
>  }
>
> +static void emulator_smm_auto_halt_restart(struct x86_emulate_ctxt *ctxt)
> +{
> +       emul_to_vcpu(ctxt)->arch.smm_auto_halt_restart = 0x2;
> +}
> +
>  static const struct x86_emulate_ops emulate_ops = {
>         .read_gpr            = emulator_read_gpr,
>         .write_gpr           = emulator_write_gpr,
> @@ -5457,6 +5467,7 @@ static const struct x86_emulate_ops emulate_ops = {
>         .get_hflags          = emulator_get_hflags,
>         .set_hflags          = emulator_set_hflags,
>         .pre_leave_smm       = emulator_pre_leave_smm,
> +       .smm_auto_halt_restart = emulator_smm_auto_halt_restart,
>  };
>
>  static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
> @@ -6757,6 +6768,9 @@ static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
>
>         put_smstate(u32, buf, 0x7f14, kvm_read_cr4(vcpu));
>
> +       if (vcpu->arch.smm_auto_halt_restart)
> +               put_smstate(u16, buf, 0x7f02, 0x1);
> +
>         /* revision id */
>         put_smstate(u32, buf, 0x7efc, 0x00020000);
>         put_smstate(u32, buf, 0x7ef8, vcpu->arch.smbase);
> @@ -6785,6 +6799,9 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
>         put_smstate(u64, buf, 0x7f50, kvm_read_cr3(vcpu));
>         put_smstate(u64, buf, 0x7f48, kvm_read_cr4(vcpu));
>
> +       if (vcpu->arch.smm_auto_halt_restart)
> +               put_smstate(u16, buf, 0x7f02, 0x1);
> +
>         put_smstate(u32, buf, 0x7f00, vcpu->arch.smbase);
>
>         /* revision id */
> @@ -6828,10 +6845,6 @@ static void enter_smm(struct kvm_vcpu *vcpu)
>
>         trace_kvm_enter_smm(vcpu->vcpu_id, vcpu->arch.smbase, true);
>         memset(buf, 0, 512);
> -       if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> -               enter_smm_save_state_64(vcpu, buf);
> -       else
> -               enter_smm_save_state_32(vcpu, buf);
>
>         /*
>          * Give pre_enter_smm() a chance to make ISA-specific changes to the
> @@ -6840,6 +6853,11 @@ static void enter_smm(struct kvm_vcpu *vcpu)
>          */
>         kvm_x86_ops->pre_enter_smm(vcpu, buf);
>
> +       if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
> +               enter_smm_save_state_64(vcpu, buf);
> +       else
> +               enter_smm_save_state_32(vcpu, buf);
> +
>         vcpu->arch.hflags |= HF_SMM_MASK;
>         kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
>
> @@ -8029,6 +8047,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>
>         vcpu->arch.smi_pending = 0;
>         vcpu->arch.smi_count = 0;
> +       vcpu->arch.smm_auto_halt_restart = 0;
>         atomic_set(&vcpu->arch.nmi_queued, 0);
>         vcpu->arch.nmi_pending = 0;
>         vcpu->arch.nmi_injected = false;
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index b91215d..96fe84e 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -270,4 +270,9 @@ static inline bool kvm_mwait_in_guest(void)
>                 !boot_cpu_has_bug(X86_BUG_MONITOR);
>  }
>
> +static inline bool kvm_hlt_in_guest(struct kvm *kvm)
> +{
> +       return kvm->arch.hlt_in_guest;
> +}
> +
>  #endif
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index ed5fb32..1a2b2da 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -935,6 +935,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_PPC_GET_CPU_CHAR 151
>  #define KVM_CAP_S390_BPB 152
>  #define KVM_CAP_HYPERV_EVENTFD 153
> +#define KVM_CAP_X86_GUEST_HLT 154
>
>  #ifdef KVM_CAP_IRQ_ROUTING
>
> --
> 2.7.4
>
