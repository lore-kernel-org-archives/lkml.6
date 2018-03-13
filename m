Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeCMXmC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:42:02 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44762 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeCMXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:42:00 -0400
X-Google-Smtp-Source: AG47ELs5n7S3Kbv7ZVvYtW8Ny/LtnrPi0Ob4Pfso7smYOoxvG7VSyX310wS8qw9QWzVjwzib8ICTNupg32wqCRtcbXc=
MIME-Version: 1.0
In-Reply-To: <CALMp9eT3R-RzA5mOPZos0uVenSNxjF=dEcFen77CBkw5CLShVw@mail.gmail.com>
References: <1520855584-10079-1-git-send-email-wanpengli@tencent.com>
 <1520855584-10079-2-git-send-email-wanpengli@tencent.com> <CALMp9eT3R-RzA5mOPZos0uVenSNxjF=dEcFen77CBkw5CLShVw@mail.gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 14 Mar 2018 07:41:56 +0800
Message-ID: <CANRm+Czm39_hrHnehyUobrG5QKRd7RjacW8OsBh_wwvbyWaF1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: X86: Provides userspace with a capability to
 not intercept MWAIT
To: Jim Mattson <jmattson@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        =?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2DNg8aX005976

Hi Jim,
2018-03-14 2:21 GMT+08:00 Jim Mattson <jmattson@google.com>:
> Is there a need for a new API for yielding MONITOR/MWAIT to the guest?
> Why not just tie this to the guest CPUID.01H:ECX[MWAIT] being set?

The API also will be used by HLT/PAUSE. Please refer to Paolo's
original proposal though I didn't find a link which is replied by
Paolo direclty. https://marc.info/?l=kvm&m=151182818103804&w=2

Regards,
Wanpeng Li

>
> On Mon, Mar 12, 2018 at 4:53 AM, Wanpeng Li <kernellwp@gmail.com> wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Allowing a guest to execute MWAIT without interception enables a guest
>> to put a (physical) CPU into a power saving state, where it takes
>> longer to return from than what may be desired by the host.
>>
>> Don't give a guest that power over a host by default. (Especially,
>> since nothing prevents a guest from using MWAIT even when it is not
>> advertised via CPUID.)
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Jan H. Schönherr <jschoenh@amazon.de>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  Documentation/virtual/kvm/api.txt | 23 ++++++++++++++---------
>>  arch/x86/include/asm/kvm_host.h   |  2 ++
>>  arch/x86/kvm/svm.c                |  2 +-
>>  arch/x86/kvm/vmx.c                |  9 +++++----
>>  arch/x86/kvm/x86.c                | 24 ++++++++++++++++++++----
>>  arch/x86/kvm/x86.h                | 10 +++++-----
>>  include/uapi/linux/kvm.h          |  2 +-
>>  tools/include/uapi/linux/kvm.h    |  2 +-
>>  8 files changed, 49 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 98de506..76e5a15 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4358,6 +4358,20 @@ enables QEMU to build error log and branch to guest kernel registered
>>  machine check handling routine. Without this capability KVM will
>>  branch to guests' 0x200 interrupt vector.
>>
>> +7.13 KVM_CAP_X86_DISABLE_EXITS
>> +
>> +Architectures: x86
>> +Parameters: args[0] defines which exits are disabled
>> +Returns: 0 on success, -EINVAL when args[0] contains invalid exits
>> +
>> +Valid exits in args[0] are
>> +
>> +#define KVM_X86_DISABLE_EXITS_MWAIT            (1 << 0)
>> +
>> +Enabling this capability on a VM provides userspace with a way to no
>> +longer intercepts some instructions for improved latency in some
>> +workloads.
>> +
>>  8. Other capabilities.
>>  ----------------------
>>
>> @@ -4470,15 +4484,6 @@ reserved.
>>      Both registers and addresses are 64-bits wide.
>>      It will be possible to run 64-bit or 32-bit guest code.
>>
>> -8.8 KVM_CAP_X86_GUEST_MWAIT
>> -
>> -Architectures: x86
>> -
>> -This capability indicates that guest using memory monotoring instructions
>> -(MWAIT/MWAITX) to stop the virtual CPU will not cause a VM exit.  As such time
>> -spent while virtual CPU is halted in this way will then be accounted for as
>> -guest running time on the host (as opposed to e.g. HLT).
>> -
>>  8.9 KVM_CAP_ARM_USER_IRQ
>>
>>  Architectures: arm, arm64
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 0395c35..e107171 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -811,6 +811,8 @@ struct kvm_arch {
>>
>>         gpa_t wall_clock;
>>
>> +       bool mwait_in_guest;
>> +
>>         bool ept_identity_pagetable_done;
>>         gpa_t ept_identity_map_addr;
>>
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index be9c839..321b3fd 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -1390,7 +1390,7 @@ static void init_vmcb(struct vcpu_svm *svm)
>>         set_intercept(svm, INTERCEPT_XSETBV);
>>         set_intercept(svm, INTERCEPT_RSM);
>>
>> -       if (!kvm_mwait_in_guest()) {
>> +       if (!kvm_mwait_in_guest(svm->vcpu.kvm)) {
>>                 set_intercept(svm, INTERCEPT_MONITOR);
>>                 set_intercept(svm, INTERCEPT_MWAIT);
>>         }
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 6cefd7b..2302ae2 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -3733,13 +3733,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
>>               CPU_BASED_UNCOND_IO_EXITING |
>>               CPU_BASED_MOV_DR_EXITING |
>>               CPU_BASED_USE_TSC_OFFSETING |
>> +             CPU_BASED_MWAIT_EXITING |
>> +             CPU_BASED_MONITOR_EXITING |
>>               CPU_BASED_INVLPG_EXITING |
>>               CPU_BASED_RDPMC_EXITING;
>>
>> -       if (!kvm_mwait_in_guest())
>> -               min |= CPU_BASED_MWAIT_EXITING |
>> -                       CPU_BASED_MONITOR_EXITING;
>> -
>>         opt = CPU_BASED_TPR_SHADOW |
>>               CPU_BASED_USE_MSR_BITMAPS |
>>               CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
>> @@ -5531,6 +5529,9 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>>                 exec_control |= CPU_BASED_CR3_STORE_EXITING |
>>                                 CPU_BASED_CR3_LOAD_EXITING  |
>>                                 CPU_BASED_INVLPG_EXITING;
>> +       if (kvm_mwait_in_guest(vmx->vcpu.kvm))
>> +               exec_control &= ~(CPU_BASED_MWAIT_EXITING |
>> +                               CPU_BASED_MONITOR_EXITING);
>>         return exec_control;
>>  }
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 36ef3d8..5fae476 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2809,9 +2809,15 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
>>         return r;
>>  }
>>
>> +static inline bool kvm_can_mwait_in_guest(void)
>> +{
>> +       return boot_cpu_has(X86_FEATURE_MWAIT) &&
>> +               !boot_cpu_has_bug(X86_BUG_MONITOR);
>> +}
>> +
>>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  {
>> -       int r;
>> +       int r = 0;
>>
>>         switch (ext) {
>>         case KVM_CAP_IRQCHIP:
>> @@ -2867,8 +2873,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>         case KVM_CAP_ADJUST_CLOCK:
>>                 r = KVM_CLOCK_TSC_STABLE;
>>                 break;
>> -       case KVM_CAP_X86_GUEST_MWAIT:
>> -               r = kvm_mwait_in_guest();
>> +       case KVM_CAP_X86_DISABLE_EXITS:
>> +               if(kvm_can_mwait_in_guest())
>> +                       r |= KVM_X86_DISABLE_EXITS_MWAIT;
>>                 break;
>>         case KVM_CAP_X86_SMM:
>>                 /* SMBASE is usually relocated above 1M on modern chipsets,
>> @@ -2909,7 +2916,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>                 r = KVM_X2APIC_API_VALID_FLAGS;
>>                 break;
>>         default:
>> -               r = 0;
>>                 break;
>>         }
>>         return r;
>> @@ -4214,6 +4220,16 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>
>>                 r = 0;
>>                 break;
>> +       case KVM_CAP_X86_DISABLE_EXITS:
>> +               r = -EINVAL;
>> +               if (cap->args[0] & ~KVM_X86_DISABLE_VALID_EXITS)
>> +                       break;
>> +
>> +               if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
>> +                       kvm_can_mwait_in_guest())
>> +                       kvm->arch.mwait_in_guest = true;
>> +               r = 0;
>> +               break;
>>         default:
>>                 r = -EINVAL;
>>                 break;
>> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
>> index b91215d..cd1215e 100644
>> --- a/arch/x86/kvm/x86.h
>> +++ b/arch/x86/kvm/x86.h
>> @@ -2,8 +2,6 @@
>>  #ifndef ARCH_X86_KVM_X86_H
>>  #define ARCH_X86_KVM_X86_H
>>
>> -#include <asm/processor.h>
>> -#include <asm/mwait.h>
>>  #include <linux/kvm_host.h>
>>  #include <asm/pvclock.h>
>>  #include "kvm_cache_regs.h"
>> @@ -264,10 +262,12 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
>>             __rem;                                              \
>>          })
>>
>> -static inline bool kvm_mwait_in_guest(void)
>> +#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
>> +#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT)
>> +
>> +static inline bool kvm_mwait_in_guest(struct kvm *kvm)
>>  {
>> -       return boot_cpu_has(X86_FEATURE_MWAIT) &&
>> -               !boot_cpu_has_bug(X86_BUG_MONITOR);
>> +       return kvm->arch.mwait_in_guest;
>>  }
>>
>>  #endif
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 088c2c9..1065006 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -929,7 +929,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_S390_GS 140
>>  #define KVM_CAP_S390_AIS 141
>>  #define KVM_CAP_SPAPR_TCE_VFIO 142
>> -#define KVM_CAP_X86_GUEST_MWAIT 143
>> +#define KVM_CAP_X86_DISABLE_EXITS 143
>>  #define KVM_CAP_ARM_USER_IRQ 144
>>  #define KVM_CAP_S390_CMMA_MIGRATION 145
>>  #define KVM_CAP_PPC_FWNMI 146
>> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
>> index 0fb5ef9..b13c257 100644
>> --- a/tools/include/uapi/linux/kvm.h
>> +++ b/tools/include/uapi/linux/kvm.h
>> @@ -924,7 +924,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_S390_GS 140
>>  #define KVM_CAP_S390_AIS 141
>>  #define KVM_CAP_SPAPR_TCE_VFIO 142
>> -#define KVM_CAP_X86_GUEST_MWAIT 143
>> +#define KVM_CAP_X86_DISABLE_EXITS 143
>>  #define KVM_CAP_ARM_USER_IRQ 144
>>  #define KVM_CAP_S390_CMMA_MIGRATION 145
>>  #define KVM_CAP_PPC_FWNMI 146
>> --
>> 2.7.4
>>
