Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14851C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0604218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfABTAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:00:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:37911 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbfABTAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:00:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 11:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="105028414"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga006.jf.intel.com with ESMTP; 02 Jan 2019 11:00:19 -0800
Date:   Wed, 2 Jan 2019 11:00:19 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v1 8/8] kvm:cpuid  Report CET SHSTK and IBT support in
 CPUID.(EAX=0x7,ECX=0).
Message-ID: <20190102190019.GF7460@linux.intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-9-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226081532.30698-9-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 04:15:32PM +0800, Yang Weijiang wrote:
> Guest OS can query CET SHSTK and IBT support by CPUID.(EAX=0x7,ECX=0),
> in return, ECX[bit 7] corresponds to SHSTK feature, and EDX[bit 20]
> corresponds to IBT feature.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 55c282f71f93..d7b60b3c4326 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -67,6 +67,8 @@ u64 kvm_supported_xcr0(void)
>  
>  #define F(x) bit(X86_FEATURE_##x)
>  
> +#define CET_IBT_BIT bit(20)

Properly define X86_FEATURE_CET_IBT if it's not being defined by some
other series, even if KVM is the only immediate user of the bit.  Linux
reserves all of word 18 for CPUID_7_0_EDX, i.e. defining the bit won't
bloat some random scattered word.

> +
>  /* For scattered features from cpufeatures.h; we currently expose none */
>  #define KF(x) bit(KVM_CPUID_BIT_##x)
>  
> @@ -407,12 +409,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
>  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> -		F(CLDEMOTE);
> +		F(CLDEMOTE) | F(SHSTK);
>  
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> -		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | CET_IBT_BIT;
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> -- 
> 2.17.1
> 
