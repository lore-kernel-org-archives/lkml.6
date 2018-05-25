Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967108AbeEYQG1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966464AbeEYQG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:06:26 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>, Wanpeng Li <wanpengli@tencent.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: VMX: fix building without CONFIG_HYPERV
References: <20180525153640.3228067-1-arnd@arndb.de>
Date: Fri, 25 May 2018 18:06:18 +0200
In-Reply-To: <20180525153640.3228067-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 25 May 2018 17:36:17 +0200")
Message-ID: <87d0xjwwhx.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The global ms_hyperv variable is part of the hyperv support, so
> we get a link error from accessing it in kernels that have this
> turned off:
>
> arch/x86/kvm/vmx.o: In function `alloc_loaded_vmcs':
> vmx.c:(.text+0x1654a): undefined reference to `ms_hyperv'
> vmx.c:(.text+0x1657a): undefined reference to `ms_hyperv'
>
> This changes the condition to first check the compile-time
> configuration symbol to avoid the link error.
>
> Fixes: ceef7d10dfb6 ("KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(I don't really like this IS_ENABLED(CONFIG_HYPERV) spreading across KVM
but keeping stuff like this ms_hyperv structure defined when
!IS_ENABLED(CONFIG_HYPERV) is also ugly. It may make sense to define
helpers similar to kvm_para_has_feature() and define them to 'false'
when Hyper-V support code is compiled out. I'll look into this option
later, this patch should be taken to fix the immediate issue).


> ---
>  arch/x86/kvm/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index ea098131dcce..e6d6ccab43c3 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4232,7 +4232,8 @@ static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>  			goto out_vmcs;
>  		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
>
> -		if (static_branch_unlikely(&enable_evmcs) &&
> +		if (IS_ENABLED(CONFIG_HYPERV) &&
> +		    static_branch_unlikely(&enable_evmcs) &&
>  		    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
>  			struct hv_enlightened_vmcs *evmcs =
>  				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;

-- 
  Vitaly
