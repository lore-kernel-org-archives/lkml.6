Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8663020665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfAIRvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfAIRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:51:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE77AA1F64;
        Wed,  9 Jan 2019 17:51:52 +0000 (UTC)
Received: from gondolin (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD0A958B5;
        Wed,  9 Jan 2019 17:51:50 +0000 (UTC)
Date:   Wed, 9 Jan 2019 18:51:47 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH] x86/kvm/nVMX: don't skip emulated instruction twice
 when vmptr address is not backed
Message-ID: <20190109185147.3d9ecec4.cohuck@redhat.com>
In-Reply-To: <20190109172256.16711-1-vkuznets@redhat.com>
References: <20190109172256.16711-1-vkuznets@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 09 Jan 2019 17:51:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 18:22:56 +0100
Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> Since commit 09abb5e3e5e50 ("KVM: nVMX: call kvm_skip_emulated_instruction
> in nested_vmx_{fail,succeed}") nested_vmx_failValid() results in
> kvm_skip_emulated_instruction() so doing it again in handle_vmptrld() when
> vmptr address is not backed is wrong, we end up advancing RIP twice.
> 
> Fixes: fca91f6d60b6e ("kvm: nVMX: Set VM instruction error for VMPTRLD of unbacked page")
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
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

Not that I would be a nested vmx expert, but this looks correct.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
