Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5215218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAYXDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:03:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:62616 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfAYXDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:03:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 15:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,523,1539673200"; 
   d="scan'208";a="141425107"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 15:03:34 -0800
Date:   Fri, 25 Jan 2019 15:03:34 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 7/7] KVM:X86: Enable MSR_IA32_XSS bit 11 and 12 for
 CET xsaves/xrstors.
Message-ID: <20190125230334.GG21849@linux.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-8-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122205909.24165-8-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:59:09AM +0800, Yang Weijiang wrote:
> For kvm Guest OS, right now, only bit 11(user mode CET) and bit 12
> (supervisor CET) are supported in XSS MSR, if other bits are being set,
> the write to XSS will be skipped.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 9c8cecac80ea..25ac22b3923a 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -47,6 +47,7 @@
>  #include <asm/virtext.h>
>  #include <asm/mce.h>
>  #include <asm/fpu/internal.h>
> +#include <asm/fpu/types.h>
>  #include <asm/perf_event.h>
>  #include <asm/debugreg.h>
>  #include <asm/kexec.h>
> @@ -4334,12 +4335,16 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_IA32_XSS:
>  		if (!vmx_xsaves_supported())
>  			return 1;
> +
>  		/*
> -		 * The only supported bit as of Skylake is bit 8, but
> -		 * it is not supported on KVM.
> +		 * Right now, only support XSS_CET_U[bit 11] and
> +		 * XSS_CET_S[bit 12] in MSR_IA32_XSS.
>  		 */
> -		if (data != 0)
> +
> +		if (!vmx_guest_cet_cap(vcpu) ||

This isn't super intuitive, as evidenced by the additional comment.
If you mask off the unsupported bits then you can make a clean check and
don't need a comment, e.g.:

		supported = kvm_supported_xss();
		if (!guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) &&
		    !guest_cpuid_has(vcpu, X86_FEATURE_IBT))
			supported &= ~(XSS_CET_S | XSS_CET_U);

		if (data & ~supported)
			return 1;

> +		    data & ~(KVM_SUPPORTED_XSS & host_xss))

Didn't you add kvm_supported_xss() in an earlier patch?  Might as well
use it here.

>  			return 1;
> +
>  		vcpu->arch.ia32_xss = data;
>  		if (vcpu->arch.ia32_xss != host_xss)
>  			add_atomic_switch_msr(vmx, MSR_IA32_XSS,
> -- 
> 2.17.1
> 
