Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01961C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A1218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfAaRlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:41:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfAaRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:41:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD134DF872;
        Thu, 31 Jan 2019 17:41:23 +0000 (UTC)
Received: from gondolin (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D89F660BF7;
        Thu, 31 Jan 2019 17:41:16 +0000 (UTC)
Date:   Thu, 31 Jan 2019 18:41:13 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v7 11/15] KVM: s390: add functions to (un)register GISC
 with GISA
Message-ID: <20190131184113.15dcf927.cohuck@redhat.com>
In-Reply-To: <20190131085247.13826-12-mimu@linux.ibm.com>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
        <20190131085247.13826-12-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 31 Jan 2019 17:41:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 09:52:42 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Add the Interruption Alert Mask (IAM) to the architecture specific
> kvm struct. This mask in the GISA is used to define for which ISC
> a GIB alert will be issued.
> 
> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
> are used to (un)register a GISC (guest ISC) with a virtual machine and
> its GISA.
> 
> Upon successful completion, kvm_s390_gisc_register() returns the
> ISC to be used for GIB alert interruptions. A negative return code
> indicates an error during registration.
> 
> Theses functions will be used by other adapter types like AP and PCI to
> request pass-through interruption support.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  13 +++++
>  arch/s390/kvm/interrupt.c        | 112 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)

> +/**
> + * kvm_s390_gisc_register - register a guest ISC
> + *
> + * @kvm:  the kernel vm to work with
> + * @gisc: the guest interruption sub class to register
> + *
> + * The function extends the vm specific alert mask to use.
> + * The effectve IAM mask in the GISA is updated as well

Typo: s/effectve/effective/

> + * in case the GISA is not part of the GIB alert list.
> + * It will be updated latest when the IAM gets restored
> + * by gisa_get_ipm_or_restore_iam().
> + *
> + * Returns: the nonspecific ISC (NISC) the gib alert mechanism
> + *          has registered with the channel subsystem.
> + *          -ENODEV in case the vm uses no GISA
> + *          -ERANGE in case the guest ISC is invalid
> + */
> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
> +{
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +
> +	if (!gi->origin)
> +		return -ENODEV;
> +	if (gisc > MAX_ISC)
> +		return -ERANGE;
> +
> +	spin_lock(&gi->alert.ref_lock);
> +	gi->alert.ref_count[gisc]++;
> +	if (gi->alert.ref_count[gisc] == 1) {
> +		gi->alert.mask |= 0x80 >> gisc;
> +		gisa_set_iam(gi->origin, gi->alert.mask);
> +	}
> +	spin_unlock(&gi->alert.ref_lock);
> +
> +	return gib->nisc;
> +}
> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> +
> +/**
> + * kvm_s390_gisc_unregister - unregister a guest ISC
> + *
> + * @kvm:  the kernel vm to work with
> + * @gisc: the guest interruption sub class to register
> + *
> + * The function reduces the vm specific alert mask to use.
> + * The effectve IAM mask in the GISA is updated as well

Same here.

> + * in case the GISA is not part of the GIB alert list.
> + * It will be updated latest when the IAM gets restored
> + * by gisa_get_ipm_or_restore_iam().
> + *
> + * Returns: the nonspecific ISC (NISC) the gib alert mechanism
> + *          has registered with the channel subsystem.
> + *          -ENODEV in case the vm uses no GISA
> + *          -ERANGE in case the guest ISC is invalid
> + *          -EINVAL in case the guest ISC is not registered
> + */
> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> +{
> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +	int rc = 0;
> +
> +	if (!gi->origin)
> +		return -ENODEV;
> +	if (gisc > MAX_ISC)
> +		return -ERANGE;
> +
> +	spin_lock(&gi->alert.ref_lock);
> +	if (gi->alert.ref_count[gisc] == 0) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	gi->alert.ref_count[gisc]--;
> +	if (gi->alert.ref_count[gisc] == 0) {
> +		gi->alert.mask &= ~(0x80 >> gisc);
> +		gisa_set_iam(gi->origin, gi->alert.mask);
> +	}
> +out:
> +	spin_unlock(&gi->alert.ref_lock);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
> +
>  void kvm_s390_gib_destroy(void)
>  {
>  	if (!gib)

Otherwise, looks good AFAICS.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
