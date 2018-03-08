Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeCHUcP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:32:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750761AbeCHUcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:32:13 -0500
Date: Thu, 8 Mar 2018 21:31:32 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] KVM: X86: Provides userspace with a capability to
 not intercept MWAIT
Message-ID: <20180308203132.GJ12290@flask>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 17:49+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Allowing a guest to execute MWAIT without interception enables a guest
> to put a (physical) CPU into a power saving state, where it takes
> longer to return from than what may be desired by the host.
> 
> Don't give a guest that power over a host by default. (Especially,
> since nothing prevents a guest from using MWAIT even when it is not
> advertised via CPUID.)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> @@ -1041,7 +1041,8 @@ On systems that do not support this ioctl, it always fails. On systems that
>  do support it, it only works for extensions that are supported for enablement.
>  
>  To check if a capability can be enabled, the KVM_CHECK_EXTENSION ioctl should
> -be used.
> +be used. Blindly passing the KVM_CHECK_EXTENSION result to KVM_ENABLE_CAP is
> +a valid thing to do when vCPUs are associated to dedicated physical CPUs.

This is not true even for x86 KVM_CAP_SPLIT_IRQCHIP and neither is is a
need to limit ourselves.  Just leave it be.

> +7.13 KVM_CAP_X86_DISABLE_EXITS
> +
> +Architectures: x86
> +Parameters: args[0] defines which exits are disabled
> +Returns: 0 on success, -EINVAL when args[0] contains invalid exits
> +
> +Valid exits in args[0] are
> +
> +#define KVM_X86_DISABLE_EXITS_MWAIT            (1 << 0)
> +
> +Enabling this capability on a VM provides userspace with a way to no
> +longer intercepts some instructions for improved latency in some
> +workloads. Not enable KVM_FEATURE_PV_UNHALT if you block HLT.

The last sentence belong to the patch that enables HLT.
KVM could in theory handle the case (although it makes no sense), so if
it doesn't currently work, please add a check to kvm_update_cpuid() that
forbids KVM_FEATURE_PV_UNHALT when halt exits are disabled.

Also, it would be nicer to write that as
"Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits."

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -2780,9 +2780,15 @@ static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
>  	return r;
>  }
>  
> +static inline bool kvm_mwait_can_in_guest(void)

I think kvm_can_mwait_in_guest would be a better name.

> +{
> +	return boot_cpu_has(X86_FEATURE_MWAIT) &&
> +		!boot_cpu_has_bug(X86_BUG_MONITOR);
> +}
> +
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index b91215d..cd1215e 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -2,8 +2,6 @@
>  #ifndef ARCH_X86_KVM_X86_H
>  #define ARCH_X86_KVM_X86_H
>  
> -#include <asm/processor.h>
> -#include <asm/mwait.h>
>  #include <linux/kvm_host.h>
>  #include <asm/pvclock.h>
>  #include "kvm_cache_regs.h"
> @@ -264,10 +262,12 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
>  	    __rem;						\
>  	 })
>  
> -static inline bool kvm_mwait_in_guest(void)
> +#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
> +#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT)
> +
> +static inline bool kvm_mwait_in_guest(struct kvm *kvm)
>  {
> -	return boot_cpu_has(X86_FEATURE_MWAIT) &&
> -		!boot_cpu_has_bug(X86_BUG_MONITOR);
> +	return kvm->arch.mwait_in_guest;

With this nice variable, the wrapper actually makes the code harder to
read.  Please use kvm->arch.mwait_in_guest directly (and the same for
the other two future exits),

thanks.
