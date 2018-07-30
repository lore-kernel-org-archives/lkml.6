Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4204C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D5220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imBENRn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D5220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeG3VER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:04:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40045 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeG3VER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:04:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so23403870oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zo76nSmFWfKQfSEwGeW83Acg8LhP42A1hUKU+1RVR4M=;
        b=imBENRn8oawcP6vcZU8S9BcyAKfhYWhMtEUJkG7OUQwnQB978drDhMcX2kXQgh7oK1
         jcLPtFVH3KyhGAnoPgv9FMI/ptburOOSEH9MW9zrIm/Tav6djgfiy1HwvQaLpGvgHLHz
         tW46nWiTA1WCwrufjoRB9irMjhll1fI3oyIxPWeUyvTUuVS97dcclbh/KustixgUmoAU
         biwaV8onRBLhDFuMxoZblBUcXik73NXzw7hhA8YgVovnh6zumz5vSHsmZpcKtaw63dX3
         RSwJ/taMwZn33Pcf4v8fs7+nejpHJFy9DqYbNoOWKizHaExw4kjj/B7DbVJf80PNsShq
         uugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zo76nSmFWfKQfSEwGeW83Acg8LhP42A1hUKU+1RVR4M=;
        b=akpK9EBPMKaqHCeeESYFf4Ph6ILvd/5lRN6UApdzI6uzVV6fmd2TgB4rbfFz5MdjLw
         rIhynnHfOgpAWM7iigiwej4kmsKhTMIAc2kDGGApRTCuftU/V1pXHWAlSEiP8x7lX2ll
         wHqXoR60Vv+IsSQs/izsgd9lnmnjocgkgfjUm05FQkQFaDT0+8y8vLh34HfcFZ5Jb8BY
         fX0T5pykHPlc30tLlJdsmd6tOproI5ZYRnKSl2hRXr0JQSBBmSRofH12MfgbPWTh4Wb8
         +UPB7GGNILQ0lxkhXyB3H3KGuBflWazCRw7Ptf950BqHhPJ3+Ymr2Fyr0lKAkgK/1OTi
         5d4w==
X-Gm-Message-State: AOUpUlF+BCvk0RuG5dAZwb6rIgAE8T1piN56ik8NLxSMJudDDvpT9Bc+
        /D09MKDVp0UhpcClcnZXNviN0sYfo+QrgLiWCa2Z3038uSI=
X-Google-Smtp-Source: AAOMgpccPC4MXaHcJWVbRsBTeygVQljFdhgHmqFxkeeyQkBQxJT2V1WoTrhg74i980Pf09PHIrF6oIoCObAv+Y7OprQ=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr21171709oif.348.1532978868789;
 Mon, 30 Jul 2018 12:27:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3408:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 12:27:48
 -0700 (PDT)
In-Reply-To: <1532819412-51357-7-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com> <1532819412-51357-7-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 30 Jul 2018 12:27:48 -0700
Message-ID: <CALMp9eREhbUc73qDnNnriG+AgfXNTkmJuChbVepmCRxo+TSaaA@mail.gmail.com>
Subject: Re: [PATCH 06/10] KVM: x86: do not load vmcs12 pages while still in SMM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 4:10 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> If the vCPU enters system management mode while running a nested guest,
> RSM starts processing the vmentry while still in SMM.  In that case,
> however, the pages pointed to by the vmcs12 might be incorrectly
> loaded from SMRAM.  To avoid this, delay the handling of the pages
> until just before the next vmentry.  This is done with a new request
> and a new entry in kvm_x86_ops, which we will be able to reuse for
> nested VMX state migration.
>
> Extracted from a patch by Jim Mattson and KarimAllah Ahmed.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/vmx.c              | 53 +++++++++++++++++++++++++++--------------
>  arch/x86/kvm/x86.c              |  2 ++
>  3 files changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c13cd28d9d1b..da957725992d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -75,6 +75,7 @@
>  #define KVM_REQ_HV_EXIT                        KVM_ARCH_REQ(21)
>  #define KVM_REQ_HV_STIMER              KVM_ARCH_REQ(22)
>  #define KVM_REQ_LOAD_EOI_EXITMAP       KVM_ARCH_REQ(23)
> +#define KVM_REQ_GET_VMCS12_PAGES       KVM_ARCH_REQ(24)
>
>  #define CR0_RESERVED_BITS                                               \
>         (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> @@ -1085,6 +1086,8 @@ struct kvm_x86_ops {
>
>         void (*setup_mce)(struct kvm_vcpu *vcpu);
>
> +       void (*get_vmcs12_pages)(struct kvm_vcpu *vcpu);
> +
>         int (*smi_allowed)(struct kvm_vcpu *vcpu);
>         int (*pre_enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
>         int (*pre_leave_smm)(struct kvm_vcpu *vcpu, u64 smbase);
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 2630ab38d72c..17aede06ae0e 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10636,9 +10636,9 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
>  static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>                                                  struct vmcs12 *vmcs12);
>
> -static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
> -                                       struct vmcs12 *vmcs12)
> +static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  {
> +       struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>         struct page *page;
>         u64 hpa;
> @@ -11750,13 +11750,18 @@ static int check_vmentry_postreqs(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>         return 0;
>  }
>
> -static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
> +/*
> + * If p_exit_qual is NULL, this is being called from state restore (either
> + * kvm_set_nested_state or RSM).  Otherwise it's called from vmlaunch/vmresume.
> + */
> +static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *p_exit_qual)
>  {
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>         struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +       bool from_vmentry = !!p_exit_qual;
>         u32 msr_entry_idx;
> -       u32 exit_qual;
> -       int r;
> +       u32 dummy_exit_qual;
> +       int r = 0;
>
>         enter_guest_mode(vcpu);
>
> @@ -11770,17 +11775,27 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
>                 vcpu->arch.tsc_offset += vmcs12->tsc_offset;
>
>         r = EXIT_REASON_INVALID_STATE;
> -       if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
> +       if (prepare_vmcs02(vcpu, vmcs12, from_vmentry ? p_exit_qual : &dummy_exit_qual))
>                 goto fail;
>
> -       nested_get_vmcs12_pages(vcpu, vmcs12);
> +       if (from_vmentry) {
> +               nested_get_vmcs12_pages(vcpu);
>
> -       r = EXIT_REASON_MSR_LOAD_FAIL;
> -       msr_entry_idx = nested_vmx_load_msr(vcpu,
> -                                           vmcs12->vm_entry_msr_load_addr,
> -                                           vmcs12->vm_entry_msr_load_count);
> -       if (msr_entry_idx)
> -               goto fail;
> +               r = EXIT_REASON_MSR_LOAD_FAIL;
> +               msr_entry_idx = nested_vmx_load_msr(vcpu,
> +                                                   vmcs12->vm_entry_msr_load_addr,
> +                                                   vmcs12->vm_entry_msr_load_count);
> +               if (msr_entry_idx)
> +                       goto fail;
> +       } else {
> +               /*
> +                * The MMU is not initialized to point at the right entities yet and
> +                * "get pages" would need to read data from the guest (i.e. we will
> +                * need to perform gpa to hpa translation). Request a call
> +                * to nested_get_vmcs12_pages before the next VM-entry.
> +                */
> +               kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
> +       }

The from_vmentry variable seems unnecessary. Why not (a) hoist the
call to nested_vmx_load_msr() into nested_vmx_run and (b) always use
the deferred KVM_REQ_GET_VMCS12_PAGES?

>
>         /*
>          * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
> @@ -11795,8 +11810,7 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
>                 vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
>         leave_guest_mode(vcpu);
>         vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> -       nested_vmx_entry_failure(vcpu, vmcs12, r, exit_qual);
> -       return 1;
> +       return r;
>  }
>
>  /*
> @@ -11873,10 +11887,11 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>          */
>
>         vmx->nested.nested_run_pending = 1;
> -       ret = enter_vmx_non_root_mode(vcpu);
> +       ret = enter_vmx_non_root_mode(vcpu, &exit_qual);
>         if (ret) {
> +               nested_vmx_entry_failure(vcpu, vmcs12, ret, exit_qual);
>                 vmx->nested.nested_run_pending = 0;
> -               return ret;
> +               return 1;
>         }
>
>         /*
> @@ -12962,7 +12977,7 @@ static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
>
>         if (vmx->nested.smm.guest_mode) {
>                 vcpu->arch.hflags &= ~HF_SMM_MASK;
> -               ret = enter_vmx_non_root_mode(vcpu);
> +               ret = enter_vmx_non_root_mode(vcpu, NULL);
>                 vcpu->arch.hflags |= HF_SMM_MASK;
>                 if (ret)
>                         return ret;
> @@ -13111,6 +13126,8 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
>
>         .setup_mce = vmx_setup_mce,
>
> +       .get_vmcs12_pages = nested_get_vmcs12_pages,
> +
>         .smi_allowed = vmx_smi_allowed,
>         .pre_enter_smm = vmx_pre_enter_smm,
>         .pre_leave_smm = vmx_pre_leave_smm,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2b812b3c5088..8ddf5f94876f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7257,6 +7257,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>         bool req_immediate_exit = false;
>
>         if (kvm_request_pending(vcpu)) {
> +               if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
> +                       kvm_x86_ops->get_vmcs12_pages(vcpu);
>                 if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
>                         kvm_mmu_unload(vcpu);
>                 if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
> --
> 1.8.3.1
>
