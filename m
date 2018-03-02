Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeCBUVS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932562AbeCBUVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:21:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4288217B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELv8B0nOgZv/cH/uk/fmsMtor74IlTK3O4fTFbcp5puNMusdoENTPPR4+X3Co2ikcqmJQRM8tFVmpKMMExl0LeQ=
MIME-Version: 1.0
In-Reply-To: <20180302105503.24428-4-vkuznets@redhat.com>
References: <20180302105503.24428-1-vkuznets@redhat.com> <20180302105503.24428-4-vkuznets@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 2 Mar 2018 20:20:54 +0000
X-Gmail-Original-Message-ID: <CALCETrVhRP5W8jS0a+_Kq8BqJatszz0vu6keB=M7kr5c=KLi4g@mail.gmail.com>
Message-ID: <CALCETrVhRP5W8jS0a+_Kq8BqJatszz0vu6keB=M7kr5c=KLi4g@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:55 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> vmx_save_host_state() is only called from kvm_arch_vcpu_ioctl_run() so
> the context is pretty well defined and as we're past 'swapgs' MSR_GS_BASE
> should contain kernel's GS base which we point to irq_stack_union.
>
> irq_stack_union needs to be exported as KVM can be a module.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kernel/cpu/common.c | 1 +
>  arch/x86/kvm/vmx.c           | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 348cf4821240..057393711093 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1398,6 +1398,7 @@ __setup("clearcpuid=", setup_clearcpuid);
>  #ifdef CONFIG_X86_64
>  DEFINE_PER_CPU_FIRST(union irq_stack_union,
>                      irq_stack_union) __aligned(PAGE_SIZE) __visible;
> +EXPORT_PER_CPU_SYMBOL(irq_stack_union);

GPL.

Also, can you add a static inline unsigned long
this_cpu_kernelmode_gs_base() that returns the actual value and then
use it here and in arch/x86/cpu/common.c?  I really don't like the way
that KVM code hardcodes all kinds of assumptions about how the rest of
the x86 code works rather than improving the x86 code to have the
right hooks for KVM's use.
