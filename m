Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeBFCqB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:46:01 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:32935 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFCpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:45:51 -0500
X-Google-Smtp-Source: AH8x226DWxPnkAI7296EZei9k06P1fOU9jRSLLCH0vfzxdnCSz2hf3FgGx1vcOKvTuB0NNjNnDtKGvWEifAPG44oAxA=
MIME-Version: 1.0
In-Reply-To: <1510584031-36240-3-git-send-email-pbonzini@redhat.com>
References: <1510584031-36240-1-git-send-email-pbonzini@redhat.com> <1510584031-36240-3-git-send-email-pbonzini@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 6 Feb 2018 10:45:50 +0800
Message-ID: <CANRm+CwnyTiZFD9D0JEhaBbmEPX91EHMTRQ4Z5ZFUZ3fzjVj9A@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: x86: add support for UMIP
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2017-11-13 22:40 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> Add the CPUID bits, make the CR4.UMIP bit not reserved anymore, and
> add UMIP support for instructions that are already emulated by KVM.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/cpuid.c            | 4 ++--
>  arch/x86/kvm/emulate.c          | 8 ++++++++
>  arch/x86/kvm/x86.c              | 3 +++
>  4 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c73e493adf07..1b005ccf4d0b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -86,7 +86,7 @@
>                           | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
>                           | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
>                           | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
> -                         | X86_CR4_SMAP | X86_CR4_PKE))
> +                         | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP))
>
>  #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0099e10eb045..77fb8732b47b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -387,8 +387,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>
>         /* cpuid 7.0.ecx*/
>         const u32 kvm_cpuid_7_0_ecx_x86_features =
> -               F(AVX512VBMI) | F(LA57) | F(PKU) |
> -               0 /*OSPKE*/ | F(AVX512_VPOPCNTDQ);
> +               F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
> +               F(AVX512_VPOPCNTDQ) | F(UMIP);
>
>         /* cpuid 7.0.edx*/
>         const u32 kvm_cpuid_7_0_edx_x86_features =
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index d90cdc77e077..d27339332ac8 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3725,6 +3725,10 @@ static int emulate_store_desc_ptr(struct x86_emulate_ctxt *ctxt,
>  {
>         struct desc_ptr desc_ptr;
>
> +       if ((ctxt->ops->get_cr(ctxt, 4) & X86_CR4_UMIP) &&
> +           ctxt->ops->cpl(ctxt) > 0)
> +               return emulate_gp(ctxt, 0);
> +
>         if (ctxt->mode == X86EMUL_MODE_PROT64)
>                 ctxt->op_bytes = 8;
>         get(ctxt, &desc_ptr);
> @@ -3784,6 +3788,10 @@ static int em_lidt(struct x86_emulate_ctxt *ctxt)
>
>  static int em_smsw(struct x86_emulate_ctxt *ctxt)
>  {
> +       if ((ctxt->ops->get_cr(ctxt, 4) & X86_CR4_UMIP) &&
> +           ctxt->ops->cpl(ctxt) > 0)
> +               return emulate_gp(ctxt, 0);
> +
>         if (ctxt->dst.type == OP_MEM)
>                 ctxt->dst.bytes = 2;
>         ctxt->dst.val = ctxt->ops->get_cr(ctxt, 0);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 03869eb7fcd6..cda567aadd28 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -791,6 +791,9 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>         if (!guest_cpuid_has(vcpu, X86_FEATURE_LA57) && (cr4 & X86_CR4_LA57))
>                 return 1;
>
> +       if (!guest_cpuid_has(vcpu, X86_FEATURE_UMIP) && (cr4 & X86_CR4_UMIP))
> +               return 1;

There is a scenario here, UMIP CPUID is not exposed to the guest since
it depends on SECONDARY_EXEC_DESC is set, however, SECONDARY_EXEC_DESC
depends on guest sets the X86_CR4_UMIP bit, the function kvm_set_cr4()
will inject a #GP and fails to set X86_CR4_UMIP bit since UMIP CPUID
is not exposed to the guest. This scenario can be observed when
running kvm-unit-tests/umip.flat in the L1.

Regards,
Wanpeng Li
