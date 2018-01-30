Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeA3XRy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:17:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751717AbeA3XRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:17:52 -0500
Subject: Re: [PATCH v3 1/4] KVM: x86: Update the reverse_cpuid list to include
 CPUID_7_EDX
To: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <1517271028-15916-1-git-send-email-karahmed@amazon.de>
 <1517271028-15916-2-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91a5b0d3-37cc-2af3-a598-f3918697f91e@redhat.com>
Date: Tue, 30 Jan 2018 18:17:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517271028-15916-2-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2018 19:10, KarimAllah Ahmed wrote:
> [dwmw2: Stop using KF() for bits in it, too]
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  arch/x86/kvm/cpuid.c | 8 +++-----
>  arch/x86/kvm/cpuid.h | 1 +
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0099e10..c0eb337 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -67,9 +67,7 @@ u64 kvm_supported_xcr0(void)
>  
>  #define F(x) bit(X86_FEATURE_##x)
>  
> -/* These are scattered features in cpufeatures.h. */
> -#define KVM_CPUID_BIT_AVX512_4VNNIW     2
> -#define KVM_CPUID_BIT_AVX512_4FMAPS     3
> +/* For scattered features from cpufeatures.h; we currently expose none */
>  #define KF(x) bit(KVM_CPUID_BIT_##x)
>  
>  int kvm_update_cpuid(struct kvm_vcpu *vcpu)
> @@ -392,7 +390,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
> -		KF(AVX512_4VNNIW) | KF(AVX512_4FMAPS);
> +		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> @@ -477,7 +475,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
>  				entry->ecx &= ~F(PKU);
>  			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
> -			entry->edx &= get_scattered_cpuid_leaf(7, 0, CPUID_EDX);
> +			cpuid_mask(&entry->edx, CPUID_7_EDX);
>  		} else {
>  			entry->ebx = 0;
>  			entry->ecx = 0;
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index cdc70a3..dcfe227 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -54,6 +54,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>  	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
>  	[CPUID_7_ECX]         = {         7, 0, CPUID_ECX},
>  	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
> +	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
>  };
>  
>  static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
> 
