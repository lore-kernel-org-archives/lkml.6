Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4422AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F4221855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfAYWrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:47:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:26330 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfAYWrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:47:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 14:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,523,1539673200"; 
   d="scan'208";a="109853070"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.14])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2019 14:47:05 -0800
Date:   Fri, 25 Jan 2019 14:47:05 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 4/7] KVM:CPUID: Fix xsaves area size calculation for
 CPUID.(EAX=0xD,ECX=1).
Message-ID: <20190125224704.GD21849@linux.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-5-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122205909.24165-5-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:59:06AM +0800, Yang Weijiang wrote:
> According to latest Software Development Manual vol.2/3.2,
> for CPUID.(EAX=0xD,ECX=1), it should report xsaves area size
> containing all states enabled  by XCR0|IA32_MSR_XSS.
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index dbeb4e7904eb..67b464d1d749 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -136,7 +136,8 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>  
>  	best = kvm_find_cpuid_entry(vcpu, 0xD, 1);
>  	if (best && (best->eax & (F(XSAVES) | F(XSAVEC))))
> -		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
> +		best->ebx = xstate_required_size(vcpu->arch.xcr0 |
> +			    kvm_supported_xss(), true);

kvm_supported_xss() provides the wrong value, that's what's *supported*.
CPUID reflects what's actually enabled, e.g. vcpu->arch.ia32_xss.

If you're going to bother adding spaces to align things, might as well
align the parameters, e.g.:

		best->ebx = xstate_required_size(vcpu->arch.xcr0 |
						 vcpu->arch.ia32_xss, true);

>  
>  	/*
>  	 * The existing code assumes virtual address is 48-bit or 57-bit in the
> -- 
> 2.17.1
> 
