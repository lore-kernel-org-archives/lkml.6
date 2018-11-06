Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1DEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D752086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D752086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbeKGBQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:16:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbeKGBQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:16:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 684F030020A7;
        Tue,  6 Nov 2018 15:50:35 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AB0600C0;
        Tue,  6 Nov 2018 15:50:27 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     ltykernel@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH] KVM/VMX: Check ept_pointer before flushing ept tlb
In-Reply-To: <20181106133043.83570-1-Tianyu.Lan@microsoft.com>
References: <20181106133043.83570-1-Tianyu.Lan@microsoft.com>
Date:   Tue, 06 Nov 2018 16:50:26 +0100
Message-ID: <87lg66urwd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 06 Nov 2018 15:50:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltykernel@gmail.com writes:

> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> This patch is to initialize ept_pointer to INVALID_PAGE and check it
> before flushing ept tlb. If ept_pointer is invalidated, bypass the flush
> request.
>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kvm/vmx.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 4555077d69ce..edbc96cb990a 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1580,14 +1580,22 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
>  	/*
>  	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
>  	 * base of EPT PML4 table, strip off EPT configuration information.
> +	 * If ept_pointer is invalid pointer, bypass the flush request.
>  	 */
>  	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
> -		kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_for_each_vcpu(i, vcpu, kvm) {
> +			if (!VALID_PAGE(to_vmx(vcpu)->ept_pointer))
> +				return 0;
> +

To be honest I fail to understand the reason behind the patch: instead
of doing one unneeded flush request with ept_pointer==0 (after vCPU is
initialized) we now do the check every time. Could you please elaborate
on why this is needed?


>  			ret |= hyperv_flush_guest_mapping(
> -				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
> +				to_vmx(vcpu)->ept_pointer & PAGE_MASK);

I would use a local variable for 'to_vmx(vcpu)->ept_pointer' or even
'to_vmx(vcpu)->ept_pointer & PAGE_MASK' and use it in VALID_PAGE() - as
lower bits are unrelated;


> +		}
>  	} else {
> +		if (!VALID_PAGE(to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer))
> +			return 0;

Ditto.

> +
>  		ret = hyperv_flush_guest_mapping(
> -				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
> +			to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);

This doesn't belong to this patch.

>  	}
>  
>  	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> @@ -11568,6 +11576,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
>  	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
>  	vmx->pi_desc.sn = 1;
>  
> +	vmx->ept_pointer = INVALID_PAGE;
> +
>  	return &vmx->vcpu;
>  
>  free_vmcs:

-- 
Vitaly
