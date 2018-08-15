Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5EA215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5EA215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeHOQCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:02:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbeHOQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3DB34023336;
        Wed, 15 Aug 2018 13:10:44 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCE412026D7E;
        Wed, 15 Aug 2018 13:10:41 +0000 (UTC)
Date:   Wed, 15 Aug 2018 15:10:39 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 14/22] KVM: s390: interfaces to clear CRYCB masks
Message-ID: <20180815151039.63d83d5d.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-15-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-15-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 13:10:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 13:10:45 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:11 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
> not get out of sync.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |    3 +++
>  arch/s390/kvm/kvm-s390.c         |   15 +++++++++++++++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 4a739d4..07e58d8 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -258,6 +258,7 @@ struct kvm_s390_sie_block {
>  	__u64	tecmc;			/* 0x00e8 */
>  	__u8	reservedf0[12];		/* 0x00f0 */
>  #define CRYCB_FORMAT_MASK 0x00000003
> +#define CRYCB_FORMAT0 0x00000000

This should probably go into a different patch (define is not used
here)?

>  #define CRYCB_FORMAT1 0x00000001
>  #define CRYCB_FORMAT2 0x00000003
>  	__u32	crycbd;			/* 0x00fc */
> @@ -861,6 +862,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>  void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  				 struct kvm_async_pf *work);
>  
> +void kvm_arch_crypto_clear_masks(struct kvm *kvm);
> +
>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>  extern char sie_exit;
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f7de123..8d8a65a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1919,6 +1919,21 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>  }
>  
> +void kvm_arch_crypto_clear_masks(struct kvm *kvm)
> +{
> +	mutex_lock(&kvm->lock);
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	memset(&kvm->arch.crypto.crycb->apcb0, 0,
> +	       sizeof(kvm->arch.crypto.crycb->apcb0));
> +	memset(&kvm->arch.crypto.crycb->apcb1, 0,
> +	       sizeof(kvm->arch.crypto.crycb->apcb1));
> +
> +	kvm_s390_vcpu_unblock_all(kvm);
> +	mutex_unlock(&kvm->lock);
> +}
> +EXPORT_SYMBOL(kvm_arch_crypto_clear_masks);

A quick grep shows that kvm-related exports tend to be
EXPORT_SYMBOL_GPL. Should that also be done here?

> +
>  static u64 kvm_s390_get_initial_cpuid(void)
>  {
>  	struct cpuid cpuid;

