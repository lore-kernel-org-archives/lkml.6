Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52444C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45EF20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Kc3gXss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45EF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbeG0VEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388815AbeG0VEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:04:49 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972FF208A0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 19:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532720488;
        bh=1NgZ5FG/pWnWYOpn487YMbF/lDvbdQlmCDReYTUS5+g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1Kc3gXssNe4ZFd/VXnrdhQK+YOf6lZu3Yyj4LhdAhKof6jZteN6QQ17KzwxvEl2sV
         KMXjgn5dWP1ZBidSOWNauWGKKlxCmzS0K9/ros4db3Bcs+++zvIDPJcMhekqHv8wPN
         l9hIL/cUpoEFgP/HC6ohXBr19KKlXDXDyC3BTGJU=
Received: by mail-wr1-f49.google.com with SMTP id h9-v6so6139514wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:41:27 -0700 (PDT)
X-Gm-Message-State: AOUpUlGO5yizr9zc3/3QfE9LPSXfjrf2wK32lrXcb9pQu64BuujX8bwu
        QTk92M9zr2pBBDj1lNQv94CzTnwYy0vdpYz4+BZLvQ==
X-Google-Smtp-Source: AAOMgpdv/xWYiJUQFJuEhkw0KbVehLuDaXFmNmuyhRuUxtT1j3OSr90wMDWKrDa8uFnDefP9vw8sbhk2wzjyC7GamU0=
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr953403wri.221.1532720484054;
 Fri, 27 Jul 2018 12:41:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 12:41:03 -0700 (PDT)
In-Reply-To: <20170208080917.24320-9-khuey@kylehuey.com>
References: <20170208080917.24320-1-khuey@kylehuey.com> <20170208080917.24320-9-khuey@kylehuey.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 27 Jul 2018 12:41:03 -0700
X-Gmail-Original-Message-ID: <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
Message-ID: <CALCETrVS8ch-1harGv2NUy83ZLna8Vde1zNLxPTPaxuMexQMjw@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] KVM: x86: virtualize cpuid faulting
To:     Kyle Huey <me@kylehuey.com>
Cc:     "Robert O'Callahan" <robert@ocallahan.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        David Matlack <dmatlack@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andi Kleen <andi@firstfloor.org>,
        LKML <linux-kernel@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        "open list:USER-MODE LINUX (UML)" 
        <user-mode-linux-user@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2017 at 12:09 AM, Kyle Huey <me@kylehuey.com> wrote:
> Hardware support for faulting on the cpuid instruction is not required to
> emulate it, because cpuid triggers a VM exit anyways. KVM handles the relevant
> MSRs (MSR_PLATFORM_INFO and MSR_MISC_FEATURES_ENABLE) and upon a
> cpuid-induced VM exit checks the cpuid faulting state and the CPL.
> kvm_require_cpl is even kind enough to inject the GP fault for us.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/cpuid.c            |  3 +++
>  arch/x86/kvm/cpuid.h            | 11 +++++++++++
>  arch/x86/kvm/emulate.c          |  7 +++++++
>  arch/x86/kvm/x86.c              | 26 ++++++++++++++++++++++++++
>  5 files changed, 49 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a7066dc1a7e9..a0d6f0c47440 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -601,16 +601,18 @@ struct kvm_vcpu_arch {
>         u64 pat;
>
>         unsigned switch_db_regs;
>         unsigned long db[KVM_NR_DB_REGS];
>         unsigned long dr6;
>         unsigned long dr7;
>         unsigned long eff_db[KVM_NR_DB_REGS];
>         unsigned long guest_debug_dr7;
> +       u64 msr_platform_info;
> +       u64 msr_misc_features_enables;
>
>         u64 mcg_cap;
>         u64 mcg_status;
>         u64 mcg_ctl;
>         u64 mcg_ext_ctl;
>         u64 *mce_banks;
>
>         /* Cache MMIO info */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e85f6bd7b9d5..588ac8ae0a60 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -877,16 +877,19 @@ void kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
>         trace_kvm_cpuid(function, *eax, *ebx, *ecx, *edx);
>  }
>  EXPORT_SYMBOL_GPL(kvm_cpuid);
>
>  int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
>  {
>         u32 eax, ebx, ecx, edx;
>
> +       if (cpuid_fault_enabled(vcpu) && !kvm_require_cpl(vcpu, 0))
> +               return;
> +
>         eax = kvm_register_read(vcpu, VCPU_REGS_RAX);
>         ecx = kvm_register_read(vcpu, VCPU_REGS_RCX);
>         kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx);
>         kvm_register_write(vcpu, VCPU_REGS_RAX, eax);
>         kvm_register_write(vcpu, VCPU_REGS_RBX, ebx);
>         kvm_register_write(vcpu, VCPU_REGS_RCX, ecx);
>         kvm_register_write(vcpu, VCPU_REGS_RDX, edx);
>         return kvm_skip_emulated_instruction(vcpu);
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 35058c2c0eea..a6fd40aade7c 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -200,9 +200,20 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
>
>         best = kvm_find_cpuid_entry(vcpu, 0x1, 0);
>         if (!best)
>                 return -1;
>
>         return x86_stepping(best->eax);
>  }
>
> +static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
> +{
> +       return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
> +}
> +
> +static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
> +{
> +       return vcpu->arch.msr_misc_features_enables &
> +                 MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
> +}
> +
>  #endif
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index cedbba0f3402..8b4b5566c365 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3848,16 +3848,23 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
>         ctxt->interruptibility = KVM_X86_SHADOW_INT_STI;
>         ctxt->eflags |= X86_EFLAGS_IF;
>         return X86EMUL_CONTINUE;
>  }
>
>  static int em_cpuid(struct x86_emulate_ctxt *ctxt)
>  {
>         u32 eax, ebx, ecx, edx;
> +       u64 msr = 0;
> +
> +       ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
> +       if (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> +           ctxt->ops->cpl(ctxt)) {
> +               return emulate_gp(ctxt, 0);
> +       }

Not strictly a comment on your patch, but why on Earth do there need
to be two copies of this check?

>
>         eax = reg_read(ctxt, VCPU_REGS_RAX);
>         ecx = reg_read(ctxt, VCPU_REGS_RCX);
>         ctxt->ops->get_cpuid(ctxt, &eax, &ebx, &ecx, &edx);
>         *reg_write(ctxt, VCPU_REGS_RAX) = eax;
>         *reg_write(ctxt, VCPU_REGS_RBX) = ebx;
>         *reg_write(ctxt, VCPU_REGS_RCX) = ecx;
>         *reg_write(ctxt, VCPU_REGS_RDX) = edx;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e52c9088660f..1951b460da47 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -998,16 +998,18 @@ static u32 emulated_msrs[] = {
>
>         MSR_IA32_TSC_ADJUST,
>         MSR_IA32_TSCDEADLINE,
>         MSR_IA32_MISC_ENABLE,
>         MSR_IA32_MCG_STATUS,
>         MSR_IA32_MCG_CTL,
>         MSR_IA32_MCG_EXT_CTL,
>         MSR_IA32_SMBASE,
> +       MSR_PLATFORM_INFO,
> +       MSR_MISC_FEATURES_ENABLES,
>  };
>
>  static unsigned num_emulated_msrs;
>
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>  {
>         if (efer & efer_reserved_bits)
>                 return false;
> @@ -2285,16 +2287,31 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                         return 1;
>                 vcpu->arch.osvw.length = data;
>                 break;
>         case MSR_AMD64_OSVW_STATUS:
>                 if (!guest_cpuid_has_osvw(vcpu))
>                         return 1;
>                 vcpu->arch.osvw.status = data;
>                 break;
> +       case MSR_PLATFORM_INFO:
> +               if (!msr_info->host_initiated ||
> +                   data & ~MSR_PLATFORM_INFO_CPUID_FAULT ||
> +                   (!(data & MSR_PLATFORM_INFO_CPUID_FAULT) &&
> +                    cpuid_fault_enabled(vcpu)))
> +                       return 1;
> +               vcpu->arch.msr_platform_info = data;
> +               break;
> +       case MSR_MISC_FEATURES_ENABLES:
> +               if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
> +                   (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
> +                    !supports_cpuid_fault(vcpu)))
> +                       return 1;
> +               vcpu->arch.msr_misc_features_enables = data;
> +               break;
>         default:
>                 if (msr && (msr == vcpu->kvm->arch.xen_hvm_config.msr))
>                         return xen_hvm_config(vcpu, data);
>                 if (kvm_pmu_is_valid_msr(vcpu, msr))
>                         return kvm_pmu_set_msr(vcpu, msr_info);
>                 if (!ignore_msrs) {
>                         vcpu_debug_ratelimited(vcpu, "unhandled wrmsr: 0x%x data 0x%llx\n",
>                                     msr, data);
> @@ -2499,16 +2516,22 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                         return 1;
>                 msr_info->data = vcpu->arch.osvw.length;
>                 break;
>         case MSR_AMD64_OSVW_STATUS:
>                 if (!guest_cpuid_has_osvw(vcpu))
>                         return 1;
>                 msr_info->data = vcpu->arch.osvw.status;
>                 break;
> +       case MSR_PLATFORM_INFO:
> +               msr_info->data = vcpu->arch.msr_platform_info;
> +               break;
> +       case MSR_MISC_FEATURES_ENABLES:
> +               msr_info->data = vcpu->arch.msr_misc_features_enables;
> +               break;
>         default:
>                 if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
>                         return kvm_pmu_get_msr(vcpu, msr_info->index, &msr_info->data);
>                 if (!ignore_msrs) {
>                         vcpu_debug_ratelimited(vcpu, "unhandled rdmsr: 0x%x\n",
>                                                msr_info->index);
>                         return 1;
>                 } else {
> @@ -7613,16 +7636,19 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>
>         kvm_clear_async_pf_completion_queue(vcpu);
>         kvm_async_pf_hash_reset(vcpu);
>         vcpu->arch.apf.halted = false;
>
>         if (!init_event) {
>                 kvm_pmu_reset(vcpu);
>                 vcpu->arch.smbase = 0x30000;
> +
> +               vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
> +               vcpu->arch.msr_misc_features_enables = 0;

Jim, I assume you're worried about this bit?  It seems like
msr_platform_info should maybe be initialized to zero to avoid causing
an unintended migration issue.
