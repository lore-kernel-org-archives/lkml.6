Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeBZWqZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:46:25 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43440 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeBZWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:46:23 -0500
X-Google-Smtp-Source: AG47ELsUoaMaRO7h/nGag1KaHgOxNwnnhP+JA/lDU69YRctAz4JO/Rqa63a9hzQh8wVbGEID7ZUFC8mvapKXugSGJtM=
MIME-Version: 1.0
In-Reply-To: <20180226224224.244247-1-mka@chromium.org>
References: <20180226224224.244247-1-mka@chromium.org>
From: Guenter Roeck <groeck@google.com>
Date: Mon, 26 Feb 2018 14:46:22 -0800
Message-ID: <CABXOdTchzieb_qSZJ=FpE5TmrhhCVh5xBPzS2dOSaLHKL2M-EA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Make enum conversion explicit in kvm_pdptr_read()
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 2:42 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The type 'enum kvm_reg_ex' is an extension of 'enum kvm_reg', however
> the extension is only semantical and the compiler doesn't know about the
> relationship between the two types. In kvm_pdptr_read() a value of the
> extended type is passed to kvm_x86_ops->cache_reg(), which expects a
> value of the base type. Clang raises the following warning about the
> type mismatch:
>
> arch/x86/kvm/kvm_cache_regs.h:44:32: warning: implicit conversion from
>   enumeration type 'enum kvm_reg_ex' to different enumeration type
>   'enum kvm_reg' [-Wenum-conversion]
>     kvm_x86_ops->cache_reg(vcpu, VCPU_EXREG_PDPTR);
>
> Cast VCPU_EXREG_PDPTR to 'enum kvm_reg' to make the compiler happy.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  arch/x86/kvm/kvm_cache_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index f500293dad8d..58ba12071014 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -41,7 +41,7 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
>
>         if (!test_bit(VCPU_EXREG_PDPTR,
>                       (unsigned long *)&vcpu->arch.regs_avail))
> -               kvm_x86_ops->cache_reg(vcpu, VCPU_EXREG_PDPTR);
> +               kvm_x86_ops->cache_reg(vcpu, (enum kvm_reg)VCPU_EXREG_PDPTR);
>
>         return vcpu->arch.walk_mmu->pdptrs[index];
>  }
> --
> 2.16.1.291.g4437f3f132-goog
>
