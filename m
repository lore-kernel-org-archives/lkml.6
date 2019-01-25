Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA22C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE320218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAYWkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:40:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:30833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfAYWkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:40:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 14:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,523,1539673200"; 
   d="scan'208";a="117545028"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2019 14:40:15 -0800
Date:   Fri, 25 Jan 2019 14:40:15 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 3/7] KVM:CPUID: Add CPUID support for CET xsaves
 component query.
Message-ID: <20190125224015.GC21849@linux.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-4-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122205909.24165-4-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:59:05AM +0800, Yang Weijiang wrote:
> CET xsaves component size is queried through CPUID.(EAX=0xD, ECX=11)
> and CPUID.(EAX=0xD, ECX=12).
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 60 +++++++++++++++++++++++++++++++++-----------
>  arch/x86/kvm/x86.c   |  4 +++
>  arch/x86/kvm/x86.h   |  4 +++
>  3 files changed, 54 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index cb1aece25b17..dbeb4e7904eb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -27,6 +27,8 @@
>  #include "trace.h"
>  #include "pmu.h"
>  
> +extern u64 host_xss;

Probably better to put this in x86.h next to host_xcr0.

> +
>  static u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  {
>  	int feature_bit = 0;
> @@ -65,6 +67,19 @@ u64 kvm_supported_xcr0(void)
>  	return xcr0;
>  }
>  
> +u64 kvm_supported_xss(void)
> +{
> +	u64 xss = host_xss & KVM_SUPPORTED_XSS;
> +
> +	/*
> +	 * Either SHSTK or IBT feature depends on the xsaves component.
> +	 */
> +	if (!boot_cpu_has(X86_FEATURE_SHSTK) && !boot_cpu_has(X86_FEATURE_IBT))
> +		xss &= ~(XFEATURE_MASK_SHSTK_USER | XFEATURE_MASK_SHSTK_KERNEL);

This looks wrong, e.g. the SHSTK bits are allowed for SHSTK=false && IBT=true?

And isn't this redundant, i.e. if the features aren't supported by the
boot cpu then shouldn't the associated bits be cleared in host_xss?

> +
> +	return xss;
> +}
> +
>  #define F(x) bit(X86_FEATURE_##x)
>  
>  /* For scattered features from cpufeatures.h; we currently expose none */
> @@ -503,6 +518,16 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			 * if the host doesn't support it.
>  			 */
>  			entry->edx |= F(ARCH_CAPABILITIES);
> +			/*
> +			 * If host doesn't have CET capability,
> +			 * do not report CET related info.
> +			 */
> +			if (!boot_cpu_has(X86_FEATURE_SHSTK))
> +				entry->ecx &= ~F(SHSTK);
> +
> +			if (!boot_cpu_has(X86_FEATURE_IBT))
> +				entry->edx &= ~F(IBT);
> +
>  		} else {
>  			entry->ebx = 0;
>  			entry->ecx = 0;
> @@ -564,14 +589,17 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	}
>  	case 0xd: {
>  		int idx, i;
> -		u64 supported = kvm_supported_xcr0();
> +		u64 u_supported = kvm_supported_xcr0();
> +		u64 s_supported = kvm_supported_xss();
> +		u64 supported;
> +		int compacted;
>  
> -		entry->eax &= supported;
> -		entry->ebx = xstate_required_size(supported, false);
> +		entry->eax &= u_supported;
> +		entry->ebx = xstate_required_size(u_supported, false);
>  		entry->ecx = entry->ebx;
> -		entry->edx &= supported >> 32;
> +		entry->edx &= u_supported >> 32;
>  		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> -		if (!supported)
> +		if (!u_supported)

Should this be '!u_supported && !s_supported'?

>  			break;
>  
>  		for (idx = 1, i = 1; idx < 64; ++idx) {
> @@ -583,19 +611,23 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			if (idx == 1) {
>  				entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
>  				cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
> -				entry[i].ebx = 0;
> -				if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
> -					entry[i].ebx =
> -						xstate_required_size(supported,
> -								     true);
> +				supported = u_supported | s_supported;
> +				compacted = entry[i].eax &
> +					(F(XSAVES) | F(XSAVEC));
> +				entry[i].ebx = xstate_required_size(supported,
> +								    compacted);
> +				entry[i].ecx &= s_supported;
> +				entry[i].edx = 0;
>  			} else {
> +				supported = (entry[i].ecx & 1) ? s_supported :
> +								 u_supported;
>  				if (entry[i].eax == 0 || !(supported & mask))
>  					continue;
> -				if (WARN_ON_ONCE(entry[i].ecx & 1))
> -					continue;
> +				entry[i].ecx &= 1;
> +				entry[i].edx = 0;
> +				if (entry[i].ecx)
> +					entry[i].ebx = 0;
>  			}
> -			entry[i].ecx = 0;
> -			entry[i].edx = 0;
>  			entry[i].flags |=
>  			       KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>  			++*nent;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a0f8b71b2132..b0ae24913423 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -212,6 +212,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  };
>  
>  u64 __read_mostly host_xcr0;
> +u64 __read_mostly host_xss;
>  
>  static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
>  
> @@ -6838,6 +6839,9 @@ int kvm_arch_init(void *opaque)
>  	if (boot_cpu_has(X86_FEATURE_XSAVE))
>  		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>  
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))
> +		rdmsrl(MSR_IA32_XSS, host_xss);
> +
>  	kvm_lapic_init();
>  #ifdef CONFIG_X86_64
>  	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 224cd0a47568..c61da41c3c5c 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -283,6 +283,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
>  				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
>  				| XFEATURE_MASK_PKRU)
> +
> +#define KVM_SUPPORTED_XSS	(XFEATURE_MASK_SHSTK_USER \
> +				| XFEATURE_MASK_SHSTK_KERNEL)
> +
>  extern u64 host_xcr0;
>  
>  extern u64 kvm_supported_xcr0(void);
> -- 
> 2.17.1
> 
