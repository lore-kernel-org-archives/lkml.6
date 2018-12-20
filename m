Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ADDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261EC217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbeLTM3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:29:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731181AbeLTM27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:28:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C726C05B02A;
        Thu, 20 Dec 2018 12:28:59 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 411C5100034B;
        Thu, 20 Dec 2018 12:28:51 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:28:49 +0100
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
Subject: Re: [PATCH v5 08/15] KVM: s390: add the GIB and its related
 life-cyle functions
Message-ID: <20181220132849.2b7cf473.cohuck@redhat.com>
In-Reply-To: <20181219191756.57973-9-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-9-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Dec 2018 12:28:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 20:17:49 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The Guest Information Block (GIB) links the GISA of all guests
> that have adapter interrupts pending. These interrupts cannot be
> delivered because no vcpu of these guests is currently running in
> SIE context. Instead, a GIB alert is issued on the host to schedule
> these guests to run.
> 
> This mechanism allows to process adapter interrupts for currently
> not running guests.
> 
> The GIB is created during host initialization and associated with
> the Adapter Interruption Facility in case an Adapter Interruption
> Virtualization Facility is available.
> 
> The GIB initialization and thus the activation of the related code
> will be done in an upcoming patch of this series.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 10 +++++++++
>  arch/s390/kvm/interrupt.c        | 44 ++++++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c         |  1 +
>  arch/s390/kvm/kvm-s390.h         |  2 ++
>  4 files changed, 57 insertions(+)

> +int kvm_s390_gib_init(u8 nisc)
> +{
> +	int rc = 0;
> +
> +	if (!css_general_characteristics.aiv) {
> +		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
> +		goto out;
> +	}
> +
> +	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	if (!gib) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	gib->nisc = nisc;
> +	if (chsc_sgib((u32)(u64)gib)) {
> +		pr_err("Associating the GIB with the AIV facility failed\n");

I presume that logging the chsc response code (or returning it instead
of -EIO) would not give any interesting information?

> +		free_page((unsigned long)gib);
> +		gib = NULL;
> +		rc = -EIO;
> +		goto out;
> +	}
> +
> +	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
> +out:
> +	return rc;
> +}

Anyhow,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
