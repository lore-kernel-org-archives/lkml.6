Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05702C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95F62075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95F62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJXT2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:28:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:26424 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeJXT2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:28:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 04:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="84043490"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2018 04:01:09 -0700
Date:   Wed, 24 Oct 2018 04:01:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] KVM/nVMX: Do not validate that posted_intr_desc_addr is
 page aligned
Message-ID: <20181024110109.GA15991@linux.intel.com>
References: <1540071779-20848-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540071779-20848-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 11:42:59PM +0200, KarimAllah Ahmed wrote:
> The spec only requires the posted interrupt descriptor address to be
> 64-bytes aligned (i.e. bits[0:5] == 0). Using page_address_valid also
> forces the address to be page aligned.
> 
> Only validate that the address does not cross the maximum physical address
> without enforcing a page alignment.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 6de84e581c0 ("nVMX x86: check posted-interrupt descriptor addresss on vmentry of L2")
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kvm/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 30bf860..47962f2 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11668,7 +11668,7 @@ static int nested_vmx_check_apicv_controls(struct kvm_vcpu *vcpu,
>  	    !nested_exit_intr_ack_set(vcpu) ||
>  	    (vmcs12->posted_intr_nv & 0xff00) ||
>  	    (vmcs12->posted_intr_desc_addr & 0x3f) ||
> -	    (!page_address_valid(vcpu, vmcs12->posted_intr_desc_addr))))
> +	    (vmcs12->posted_intr_desc_addr >> cpuid_maxphyaddr(vcpu)))
>  		return -EINVAL;

Can you update the comment for this code block?  It has a stale blurb
about "the descriptor address has been already checked in
nested_get_vmcs12_pages" and it'd be nice to state why bits[5:0] must
be zero (your changelog is much more helpful than the current comment).

With that:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

>  
>  	/* tpr shadow is needed by all apicv features. */
> -- 
> 2.7.4
> 
