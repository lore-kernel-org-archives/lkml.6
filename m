Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A77C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F1208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9F1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLFRqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:46:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeLFRqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:46:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EAFBE1F05;
        Thu,  6 Dec 2018 17:46:12 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.34.244.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A038579D43;
        Thu,  6 Dec 2018 17:46:10 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     rkrcmar@redhat.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Subject: Re: [PATCH v4 14/14] KVM/nVMX: Use kvm_vcpu_map for accessing the enhanced VMCS
In-Reply-To: <1543829467-18025-15-git-send-email-karahmed@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de> <1543829467-18025-15-git-send-email-karahmed@amazon.de>
Date:   Thu, 06 Dec 2018 18:46:09 +0100
Message-ID: <875zw67dlq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 06 Dec 2018 17:46:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KarimAllah Ahmed <karahmed@amazon.de> writes:

> Use kvm_vcpu_map for accessing the enhanced VMCS since using

just a nitpick: "eVMCS" stands for Enlightened VMCS, not 'enhanced' :-)

> kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
> a "struct page".
>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kvm/vmx.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index a958700..83a614f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -894,7 +894,7 @@ struct nested_vmx {
>  	} smm;
>  
>  	gpa_t hv_evmcs_vmptr;
> -	struct page *hv_evmcs_page;
> +	struct kvm_host_map hv_evmcs_map;
>  	struct hv_enlightened_vmcs *hv_evmcs;
>  };
>  
> @@ -8456,10 +8456,8 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
>  	if (!vmx->nested.hv_evmcs)
>  		return;
>  
> -	kunmap(vmx->nested.hv_evmcs_page);
> -	kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
> +	kvm_vcpu_unmap(&vmx->nested.hv_evmcs_map);
>  	vmx->nested.hv_evmcs_vmptr = -1ull;
> -	vmx->nested.hv_evmcs_page = NULL;
>  	vmx->nested.hv_evmcs = NULL;
>  }
>  
> @@ -8559,7 +8557,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
>  		return nested_vmx_failValid(vcpu,
>  			VMXERR_VMCLEAR_VMXON_POINTER);
>  
> -	if (vmx->nested.hv_evmcs_page) {
> +	if (vmx->nested.hv_evmcs_map.hva) {
>  		if (vmptr == vmx->nested.hv_evmcs_vmptr)
>  			nested_release_evmcs(vcpu);
>  	} else {
> @@ -9355,13 +9353,11 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
>  
>  		nested_release_evmcs(vcpu);
>  
> -		vmx->nested.hv_evmcs_page = kvm_vcpu_gpa_to_page(
> -			vcpu, assist_page.current_nested_vmcs);
> -
> -		if (unlikely(is_error_page(vmx->nested.hv_evmcs_page)))
> +		if (kvm_vcpu_map(vcpu, gpa_to_gfn(assist_page.current_nested_vmcs),
> +				 &vmx->nested.hv_evmcs_map))
>  			return 0;
>  
> -		vmx->nested.hv_evmcs = kmap(vmx->nested.hv_evmcs_page);
> +		vmx->nested.hv_evmcs = vmx->nested.hv_evmcs_map.hva;
>  
>  		/*
>  		 * Currently, KVM only supports eVMCS version 1

-- 
Vitaly
