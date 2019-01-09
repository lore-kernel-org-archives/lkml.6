Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC1EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7993214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfAIR1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:27:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:21466 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfAIR1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:27:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 09:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="116799032"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 09 Jan 2019 09:27:38 -0800
Date:   Wed, 9 Jan 2019 09:27:38 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86/kvm/nVMX: don't skip emulated instruction twice when
 vmptr address is not backed
Message-ID: <20190109172738.GC1821@linux.intel.com>
References: <20190109172256.16711-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109172256.16711-1-vkuznets@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:22:56PM +0100, Vitaly Kuznetsov wrote:
> Since commit 09abb5e3e5e50 ("KVM: nVMX: call kvm_skip_emulated_instruction
> in nested_vmx_{fail,succeed}") nested_vmx_failValid() results in
> kvm_skip_emulated_instruction() so doing it again in handle_vmptrld() when
> vmptr address is not backed is wrong, we end up advancing RIP twice.
> 
> Fixes: fca91f6d60b6e ("kvm: nVMX: Set VM instruction error for VMPTRLD of unbacked page")
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

> ---
>  arch/x86/kvm/vmx/nested.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3170e291215d..2616bd2c7f2c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4540,9 +4540,8 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  			 * given physical address won't match the required
>  			 * VMCS12_REVISION identifier.
>  			 */
> -			nested_vmx_failValid(vcpu,
> +			return nested_vmx_failValid(vcpu,
>  				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
> -			return kvm_skip_emulated_instruction(vcpu);
>  		}
>  		new_vmcs12 = kmap(page);
>  		if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
> -- 
> 2.20.1
> 
