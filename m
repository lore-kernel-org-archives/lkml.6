Return-Path: <kernellwp@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525310873; cv=none;
        d=google.com; s=arc-20160816;
        b=ALIHUdS0hIpzlODKgDhCBUTccxcdCP1h5eGdqKmeS8cDZ1I57oF4L6eDla9SjBWDsM
         tB2yoxhH5Xvkh3j0Jji+YGuoayc8U+meEjNS/KiEFjzI6JUzIju3zGrB8uYiPX66Azol
         I4NIsj6xnyP1jtuvzrn/4ZZlmJwZU02KO/vW2qoU+lNfFldq3rIvqUod5f/+ZdXzQpcB
         R1sOHkTwGZ5oikSLKE1EmeZrna30OoDGtWuwhfn8IEmdDxiEGtTvCv8XKEuGyNp4dRbQ
         cqlNYn0W//Joq1sMKKToEuKv5qEshUMExOKG/BtRnHr0tFheCXT47SgkQPH1qTfEKYy7
         J9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=nYxxgHhk8BTGZ9llzl8bs8bc+jw/mTlso5X6nHkqw/Q=;
        b=TEbKIZcmtsPkICZIZ6+TEwDtqRIj3pwwcoRoacvMS8OMXeB+9fOVu6ZUuFn9GEwWBL
         uHLl9AM3xRa0yXjGsBZfTxGMm4Sfy0NHW4zrR/ldHiWJ3ujEzBZI3FOnYrcw787YK9GK
         ljXznxzcDjdjWl3I6BH8W2WsU4Twzj6CY52TmdNRACW4ApusG3iQMiIdmcVtSaPAXPMS
         i7aH3UvccWvHCxZjqvgARmJ2+MDL6F1k8GegWC7fNNH86+E3ZRDtUotwH6uHCkzmV2nu
         j1EfW6/yg1+hWiI/V7WZ4xLSGZn65LusKtDzPBjsfnM+4BYUi0pd9ujzF4SaS5GgVvA9
         xKYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BH3gQEcg;
       spf=pass (google.com: domain of kernellwp@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kernellwp@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BH3gQEcg;
       spf=pass (google.com: domain of kernellwp@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kernellwp@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrfzr1YAERwEnEna8fNgX0vKg5oEn9n5U3tSOBjx1901IiXkINNsMj1o9HzeIaXOHUfSC7SVmDVU1FWYWqeRvw=
MIME-Version: 1.0
In-Reply-To: <1517522386-18410-3-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de> <1517522386-18410-3-git-send-email-karahmed@amazon.de>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 3 May 2018 09:27:52 +0800
Message-ID: <CANRm+CzKXA6ktG9fV4E-Q=+ZWZbS+ApUPXjogJJQErEZD2jHHQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"the arch/x86 maintainers" <x86@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>, Dave Hansen <dave.hansen@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
	Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1599404374543729913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ashok=EF=BC=8C
2018-02-02 5:59 GMT+08:00 KarimAllah Ahmed <karahmed@amazon.de>:
> From: Ashok Raj <ashok.raj@intel.com>
>
> The Indirect Branch Predictor Barrier (IBPB) is an indirect branch
> control mechanism. It keeps earlier branches from influencing
> later ones.
>
> Unlike IBRS and STIBP, IBPB does not define a new mode of operation.
> It's a command that ensures predicted branch targets aren't used after
> the barrier. Although IBRS and IBPB are enumerated by the same CPUID
> enumeration, IBPB is very different.
>
> IBPB helps mitigate against three potential attacks:
>
> * Mitigate guests from being attacked by other guests.
>   - This is addressed by issing IBPB when we do a guest switch.
>
> * Mitigate attacks from guest/ring3->host/ring3.
>   These would require a IBPB during context switch in host, or after
>   VMEXIT. The host process has two ways to mitigate
>   - Either it can be compiled with retpoline
>   - If its going through context switch, and has set !dumpable then
>     there is a IBPB in that path.
>     (Tim's patch: https://patchwork.kernel.org/patch/10192871)
>   - The case where after a VMEXIT you return back to Qemu might make
>     Qemu attackable from guest when Qemu isn't compiled with retpoline.
>   There are issues reported when doing IBPB on every VMEXIT that resulted
>   in some tsc calibration woes in guest.
>
> * Mitigate guest/ring0->host/ring0 attacks.
>   When host kernel is using retpoline it is safe against these attacks.
>   If host kernel isn't using retpoline we might need to do a IBPB flush o=
n
>   every VMEXIT.
>

So for 1) guest->guest attacks 2) guest/ring3->host/ring3 attacks 3)
guest/ring0->host/ring0 attacks, if IBPB is enough to protect these
three scenarios and retpoline is not needed?

Regards,
Wanpeng Li

> Even when using retpoline for indirect calls, in certain conditions 'ret'
> can use the BTB on Skylake-era CPUs. There are other mitigations
> available like RSB stuffing/clearing.
>
> * IBPB is issued only for SVM during svm_free_vcpu().
>   VMX has a vmclear and SVM doesn't.  Follow discussion here:
>   https://lkml.org/lkml/2018/1/15/146
>
> Please refer to the following spec for more details on the enumeration
> and control.
>
> Refer here to get documentation about mitigations.
>
> https://software.intel.com/en-us/side-channel-security-support
>
> [peterz: rebase and changelog rewrite]
> [karahmed: - rebase
>            - vmx: expose PRED_CMD if guest has it in CPUID
>            - svm: only pass through IBPB if guest has it in CPUID
>            - vmx: support !cpu_has_vmx_msr_bitmap()]
>            - vmx: support nested]
> [dwmw2: Expose CPUID bit too (AMD IBPB only for now as we lack IBRS)
>         PRED_CMD is a write-only MSR]
>
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/1515720739-43819-6-git-send-email-ashok.ra=
j@intel.com
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v6:
> - introduce msr_write_intercepted_l01
>
> v5:
> - Use MSR_TYPE_W instead of MSR_TYPE_R for the MSR.
> - Always merge the bitmaps unconditionally.
> - Add PRED_CMD to direct_access_msrs.
> - Also check for X86_FEATURE_SPEC_CTRL for the msr reads/writes
> - rewrite the commit message (from ashok.raj@)
> ---
>  arch/x86/kvm/cpuid.c | 11 +++++++-
>  arch/x86/kvm/svm.c   | 28 ++++++++++++++++++
>  arch/x86/kvm/vmx.c   | 80 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  3 files changed, 116 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index c0eb337..033004d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -365,6 +365,10 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_en=
try2 *entry, u32 function,
>                 F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
>                 0 /* SKINIT, WDT, LWP */ | F(FMA4) | F(TBM);
>
> +       /* cpuid 0x80000008.ebx */
> +       const u32 kvm_cpuid_8000_0008_ebx_x86_features =3D
> +               F(IBPB);
> +
>         /* cpuid 0xC0000001.edx */
>         const u32 kvm_cpuid_C000_0001_edx_x86_features =3D
>                 F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
> @@ -625,7 +629,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_en=
try2 *entry, u32 function,
>                 if (!g_phys_as)
>                         g_phys_as =3D phys_as;
>                 entry->eax =3D g_phys_as | (virt_as << 8);
> -               entry->ebx =3D entry->edx =3D 0;
> +               entry->edx =3D 0;
> +               /* IBPB isn't necessarily present in hardware cpuid */
> +               if (boot_cpu_has(X86_FEATURE_IBPB))
> +                       entry->ebx |=3D F(IBPB);
> +               entry->ebx &=3D kvm_cpuid_8000_0008_ebx_x86_features;
> +               cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
>                 break;
>         }
>         case 0x80000019:
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f40d0da..254eefb 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -249,6 +249,7 @@ static const struct svm_direct_access_msrs {
>         { .index =3D MSR_CSTAR,                           .always =3D tru=
e  },
>         { .index =3D MSR_SYSCALL_MASK,                    .always =3D tru=
e  },
>  #endif
> +       { .index =3D MSR_IA32_PRED_CMD,                   .always =3D fal=
se },
>         { .index =3D MSR_IA32_LASTBRANCHFROMIP,           .always =3D fal=
se },
>         { .index =3D MSR_IA32_LASTBRANCHTOIP,             .always =3D fal=
se },
>         { .index =3D MSR_IA32_LASTINTFROMIP,              .always =3D fal=
se },
> @@ -529,6 +530,7 @@ struct svm_cpu_data {
>         struct kvm_ldttss_desc *tss_desc;
>
>         struct page *save_area;
> +       struct vmcb *current_vmcb;
>  };
>
>  static DEFINE_PER_CPU(struct svm_cpu_data *, svm_data);
> @@ -1703,11 +1705,17 @@ static void svm_free_vcpu(struct kvm_vcpu *vcpu)
>         __free_pages(virt_to_page(svm->nested.msrpm), MSRPM_ALLOC_ORDER);
>         kvm_vcpu_uninit(vcpu);
>         kmem_cache_free(kvm_vcpu_cache, svm);
> +       /*
> +        * The vmcb page can be recycled, causing a false negative in
> +        * svm_vcpu_load(). So do a full IBPB now.
> +        */
> +       indirect_branch_prediction_barrier();
>  }
>
>  static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
> +       struct svm_cpu_data *sd =3D per_cpu(svm_data, cpu);
>         int i;
>
>         if (unlikely(cpu !=3D vcpu->cpu)) {
> @@ -1736,6 +1744,10 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, i=
nt cpu)
>         if (static_cpu_has(X86_FEATURE_RDTSCP))
>                 wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
>
> +       if (sd->current_vmcb !=3D svm->vmcb) {
> +               sd->current_vmcb =3D svm->vmcb;
> +               indirect_branch_prediction_barrier();
> +       }
>         avic_vcpu_load(vcpu, cpu);
>  }
>
> @@ -3684,6 +3696,22 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr)
>         case MSR_IA32_TSC:
>                 kvm_write_tsc(vcpu, msr);
>                 break;
> +       case MSR_IA32_PRED_CMD:
> +               if (!msr->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
> +                       return 1;
> +
> +               if (data & ~PRED_CMD_IBPB)
> +                       return 1;
> +
> +               if (!data)
> +                       break;
> +
> +               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> +               if (is_guest_mode(vcpu))
> +                       break;
> +               set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD, 0, 1)=
;
> +               break;
>         case MSR_STAR:
>                 svm->vmcb->save.star =3D data;
>                 break;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index d46a61b..263eb1f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -592,6 +592,7 @@ struct vcpu_vmx {
>         u64                   msr_host_kernel_gs_base;
>         u64                   msr_guest_kernel_gs_base;
>  #endif
> +
>         u32 vm_entry_controls_shadow;
>         u32 vm_exit_controls_shadow;
>         u32 secondary_exec_control;
> @@ -936,6 +937,8 @@ static void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, b=
ool masked);
>  static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
>                                             u16 error_code);
>  static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
> +static void __always_inline vmx_disable_intercept_for_msr(unsigned long =
*msr_bitmap,
> +                                                         u32 msr, int ty=
pe);
>
>  static DEFINE_PER_CPU(struct vmcs *, vmxarea);
>  static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
> @@ -1907,6 +1910,29 @@ static void update_exception_bitmap(struct kvm_vcp=
u *vcpu)
>         vmcs_write32(EXCEPTION_BITMAP, eb);
>  }
>
> +/*
> + * Check if MSR is intercepted for L01 MSR bitmap.
> + */
> +static bool msr_write_intercepted_l01(struct kvm_vcpu *vcpu, u32 msr)
> +{
> +       unsigned long *msr_bitmap;
> +       int f =3D sizeof(unsigned long);
> +
> +       if (!cpu_has_vmx_msr_bitmap())
> +               return true;
> +
> +       msr_bitmap =3D to_vmx(vcpu)->vmcs01.msr_bitmap;
> +
> +       if (msr <=3D 0x1fff) {
> +               return !!test_bit(msr, msr_bitmap + 0x800 / f);
> +       } else if ((msr >=3D 0xc0000000) && (msr <=3D 0xc0001fff)) {
> +               msr &=3D 0x1fff;
> +               return !!test_bit(msr, msr_bitmap + 0xc00 / f);
> +       }
> +
> +       return true;
> +}
> +
>  static void clear_atomic_switch_msr_special(struct vcpu_vmx *vmx,
>                 unsigned long entry, unsigned long exit)
>  {
> @@ -2285,6 +2311,7 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, in=
t cpu)
>         if (per_cpu(current_vmcs, cpu) !=3D vmx->loaded_vmcs->vmcs) {
>                 per_cpu(current_vmcs, cpu) =3D vmx->loaded_vmcs->vmcs;
>                 vmcs_load(vmx->loaded_vmcs->vmcs);
> +               indirect_branch_prediction_barrier();
>         }
>
>         if (!already_loaded) {
> @@ -3342,6 +3369,34 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, stru=
ct msr_data *msr_info)
>         case MSR_IA32_TSC:
>                 kvm_write_tsc(vcpu, msr_info);
>                 break;
> +       case MSR_IA32_PRED_CMD:
> +               if (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
> +                       return 1;
> +
> +               if (data & ~PRED_CMD_IBPB)
> +                       return 1;
> +
> +               if (!data)
> +                       break;
> +
> +               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> +
> +               /*
> +                * For non-nested:
> +                * When it's written (to non-zero) for the first time, pa=
ss
> +                * it through.
> +                *
> +                * For nested:
> +                * The handling of the MSR bitmap for L2 guests is done i=
n
> +                * nested_vmx_merge_msr_bitmap. We should not touch the
> +                * vmcs02.msr_bitmap here since it gets completely overwr=
itten
> +                * in the merging.
> +                */
> +               vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR=
_IA32_PRED_CMD,
> +                                             MSR_TYPE_W);
> +               break;
>         case MSR_IA32_CR_PAT:
>                 if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
>                         if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
> @@ -10044,9 +10099,23 @@ static inline bool nested_vmx_merge_msr_bitmap(s=
truct kvm_vcpu *vcpu,
>         struct page *page;
>         unsigned long *msr_bitmap_l1;
>         unsigned long *msr_bitmap_l0 =3D to_vmx(vcpu)->nested.vmcs02.msr_=
bitmap;
> +       /*
> +        * pred_cmd is trying to verify two things:
> +        *
> +        * 1. L0 gave a permission to L1 to actually passthrough the MSR.=
 This
> +        *    ensures that we do not accidentally generate an L02 MSR bit=
map
> +        *    from the L12 MSR bitmap that is too permissive.
> +        * 2. That L1 or L2s have actually used the MSR. This avoids
> +        *    unnecessarily merging of the bitmap if the MSR is unused. T=
his
> +        *    works properly because we only update the L01 MSR bitmap la=
zily.
> +        *    So even if L0 should pass L1 these MSRs, the L01 bitmap is =
only
> +        *    updated to reflect this when L1 (or its L2s) actually write=
 to
> +        *    the MSR.
> +        */
> +       bool pred_cmd =3D msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_C=
MD);
>
> -       /* This shortcut is ok because we support only x2APIC MSRs so far=
. */
> -       if (!nested_cpu_has_virt_x2apic_mode(vmcs12))
> +       if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
> +           !pred_cmd)
>                 return false;
>
>         page =3D kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
> @@ -10079,6 +10148,13 @@ static inline bool nested_vmx_merge_msr_bitmap(s=
truct kvm_vcpu *vcpu,
>                                 MSR_TYPE_W);
>                 }
>         }
> +
> +       if (pred_cmd)
> +               nested_vmx_disable_intercept_for_msr(
> +                                       msr_bitmap_l1, msr_bitmap_l0,
> +                                       MSR_IA32_PRED_CMD,
> +                                       MSR_TYPE_W);
> +
>         kunmap(page);
>         kvm_release_page_clean(page);
>
> --
> 2.7.4
>
