Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF84C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EC9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EC9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeJEPrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:47:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeJEPrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9421243A2E;
        Fri,  5 Oct 2018 08:49:31 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F58269FC6;
        Fri,  5 Oct 2018 08:49:27 +0000 (UTC)
Date:   Fri, 5 Oct 2018 10:49:25 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v1 1/2] KVM: s390: Tracing APCB changes
Message-ID: <20181005104925.04a1f3ef.cohuck@redhat.com>
In-Reply-To: <1538728270-10340-2-git-send-email-pmorel@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
        <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
        <1538728270-10340-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 05 Oct 2018 08:49:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 10:31:09 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> kvm_arch_crypto_set_masks is a new function to centralize
> the setup the APCB masks inside the CRYCB SIE satelite.

s/satelite/satellite/

> 
> To trace APCB mask changes, we add KVM_EVENT() tracing to
> both kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 ++
>  arch/s390/kvm/kvm-s390.c         | 41 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 36d3531..22aa4da 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -861,6 +861,8 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  				 struct kvm_async_pf *work);
>  
>  void kvm_arch_crypto_clear_masks(struct kvm *kvm);
> +void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm);
>  
>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>  extern char sie_exit;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d3ea721..e871e5a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2057,6 +2057,46 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>  }
>  
> +void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm)
> +{
> +	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
> +
> +	mutex_lock(&kvm->lock);
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
> +	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
> +		memcpy(crycb->apcb1.apm, apm, 32);
> +		VM_EVENT(kvm, 3, "SET CRYCB: apm %016lx %016lx %016lx %016lx",
> +			 apm[0], apm[1], apm[2], apm[3]);
> +		memcpy(crycb->apcb1.aqm, aqm, 32);
> +		VM_EVENT(kvm, 3, "SET CRYCB: aqm %016lx %016lx %016lx %016lx",
> +			 aqm[0], aqm[1], aqm[2], aqm[3]);
> +		memcpy(crycb->apcb1.adm, adm, 32);
> +		VM_EVENT(kvm, 3, "SET CRYCB: adm %016lx %016lx %016lx %016lx",
> +			 adm[0], adm[1], adm[2], adm[3]);
> +		break;
> +	case CRYCB_FORMAT1:
> +	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
> +		memcpy(crycb->apcb0.apm, apm, 8);
> +		memcpy(crycb->apcb0.aqm, aqm, 2);
> +		memcpy(crycb->apcb0.adm, adm, 2);
> +		VM_EVENT(kvm, 3, "SET CRYCB: apm %016lx aqm %04x adm %04x",
> +			 apm[0], *((unsigned short *)aqm),
> +			 *((unsigned short *)adm));
> +		break;
> +	default:	/* Can not happen */
> +		break;
> +	}
> +
> +	/* recreate the shadow crycb for each vcpu */
> +	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
> +	kvm_s390_vcpu_unblock_all(kvm);
> +	mutex_unlock(&kvm->lock);


The locking and requests makes me wonder if we missed them before...
were they simply not needed for the prior use case (mdev group
notifier)?

> +}
> +EXPORT_SYMBOL_GPL(kvm_arch_crypto_set_masks);
> +
>  void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>  {
>  	mutex_lock(&kvm->lock);
> @@ -2067,6 +2107,7 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>  	memset(&kvm->arch.crypto.crycb->apcb1, 0,
>  	       sizeof(kvm->arch.crypto.crycb->apcb1));
>  
> +	VM_EVENT(kvm, 3, "%s", "CLR CRYCB:");
>  	/* recreate the shadow crycb for each vcpu */
>  	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
>  	kvm_s390_vcpu_unblock_all(kvm);

