Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82048C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E28218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfABSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:24:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:32487 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfABSYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:24:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 10:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,431,1539673200"; 
   d="scan'208";a="114952824"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 02 Jan 2019 10:24:46 -0800
Date:   Wed, 2 Jan 2019 10:24:46 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v1 5/8] kvm:x86  Enable MSR_IA32_XSS bit 11 and 12 for
 CET xsaves/xrstors.
Message-ID: <20190102182446.GC7460@linux.intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-6-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226081532.30698-6-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 04:15:29PM +0800, Yang Weijiang wrote:
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
> index fa2db6248404..5739ab393b90 100644
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
> @@ -4323,12 +4324,16 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
> +		if (data & ~(XFEATURE_MASK_SHSTK_USER
> +			     | XFEATURE_MASK_SHSTK_KERNEL))

New lines are usually after the operator, e.g.:

	if (data & ~(XFEATURE_MASK_SHSTK_USER |
		     XFEATURE_MASK_SHSTK_KERNEL))

And doesn't this flow need to check that the bits are actually supported?

>  			return 1;
> +
>  		vcpu->arch.ia32_xss = data;
>  		if (vcpu->arch.ia32_xss != host_xss)
>  			add_atomic_switch_msr(vmx, MSR_IA32_XSS,
> -- 
> 2.17.1
> 
