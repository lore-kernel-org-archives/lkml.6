Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D7E218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfABStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:49:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:50811 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbfABStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:49:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 10:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="134791813"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2019 10:49:30 -0800
Date:   Wed, 2 Jan 2019 10:49:30 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v1 6/8] kvm:cpuid  Add CPUID support for CET xsaves
 component query.
Message-ID: <20190102184930.GD7460@linux.intel.com>
References: <20181226081532.30698-1-weijiang.yang@intel.com>
 <20181226081532.30698-7-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226081532.30698-7-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 04:15:30PM +0800, Yang Weijiang wrote:
> CET xsaves component size is queried through CPUID.(EAX=0xD, ECX=11)
> and CPUID.(EAX=0xD, ECX=12).
> 
> Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7bcfa61375c0..5bac31e58955 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -565,6 +565,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	case 0xd: {
>  		int idx, i;
>  		u64 supported = kvm_supported_xcr0();
> +		u64 sv_supported;

What about u_supported and s_supported?  sv_supported doesn't make me
think "supervisor"e.

>  		entry->eax &= supported;
>  		entry->ebx = xstate_required_size(supported, false);
> @@ -584,18 +585,23 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  				entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
>  				cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
>  				entry[i].ebx = 0;
> +				sv_supported = entry[i].ecx +
> +					((u64)entry[i].edx << 32);

Use '|' instead of '+' to smush ECX and EDX together, as is it looks
like the code is calculating a size or something.

>  				if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
>  					entry[i].ebx =
>  						xstate_required_size(supported,
>  								     true);
> -			} else {
> +			} else if (!(entry[i].ecx & 1)) {

Now that we're actually consuming bit 0, it'd be nice to formally define
it as referring to supervisor state.

What about styling the code like this?  Might make it more obvious that
the logic for user vs. supervisor is identical, i.e. ECX bit 0 only
determines which mask is applied.

			if (idx == 1) {
				...
			} else {
				supported = (entry[i].ecx & 1) ? s_supported :
								 u_supported;
				if (entry[i].eax == 0 || !(supported & mask))
					continue;
				entry[i].ecx &= 1;
				entry[i].edx = 0;
			}


>  				if (entry[i].eax == 0 || !(supported & mask))
>  					continue;
> -				if (WARN_ON_ONCE(entry[i].ecx & 1))
> +				entry[i].ecx = 0;
> +				entry[i].edx = 0;
> +			} else {
> +				if (entry[i].eax == 0 || !(sv_supported & mask))
>  					continue;
> +				entry[i].ecx = 1;
> +				entry[i].edx = 0;
>  			}
> -			entry[i].ecx = 0;
> -			entry[i].edx = 0;

Removing this entirely isn't correct for CPUID.0xD.0x1, KVM should still
zero out the bits it doesn't handle, e.g. KVM will signal a fault if the
guest attempts to set any bits in IA32_XSS other than the CET bits.

>  			entry[i].flags |=
>  			       KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>  			++*nent;
> -- 
> 2.17.1
> 
