Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeAaUXV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:23:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeAaUXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:23:18 -0500
Date: Wed, 31 Jan 2018 15:22:50 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v5 1/5] KVM: x86: Update the reverse_cpuid list to
 include CPUID_7_EDX
Message-ID: <20180131202250.GF22045@char.us.oracle.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-2-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517427467-28567-2-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VKPhGY020355

On Wed, Jan 31, 2018 at 08:37:43PM +0100, KarimAllah Ahmed wrote:
> [dwmw2: Stop using KF() for bits in it, too]
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
> index c2cea66..9a327d5 100644
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
> -- 
> 2.7.4
> 
