Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC9A2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfB0Jmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:42:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfB0Jmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:42:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 968CB3F73C;
        Wed, 27 Feb 2019 09:42:53 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A34AE5D6AA;
        Wed, 27 Feb 2019 09:42:44 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:42:42 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 4/7] vfio: ap: register IOMMU VFIO notifier
Message-ID: <20190227104242.1214d55e.cohuck@redhat.com>
In-Reply-To: <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 27 Feb 2019 09:42:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:29:57 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> To be able to use the VFIO interface to facilitate the
> mediated device memory pining/unpining we need to register

s/pining/pinning/ (unless it's pining for the fjords :)

> a notifier for IOMMU.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 53 ++++++++++++++++++++++++++++++++---
>  drivers/s390/crypto/vfio_ap_private.h |  2 ++
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 172d6eb..1b5130a 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -748,6 +748,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>  };
>  
>  /**
> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
> + *
> + * @nb: The notifier block
> + * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)

I'd drop this annotation; you only do something for UNMAP but nothing
prevents the caller from passing in something else :)

> + * @data: the specific unmap structure for vfio_iommu_type1

"data associated with the request" ?

(same reasoning as above)

> + *
> + * Unpins the guest IOVA. (The NIB guest address we pinned before).
> + * Return NOTIFY_OK after unpining on a UNMAP request.
> + * otherwise, returns NOTIFY_DONE .

"For an UNMAP request, unpin the guest IOVA (the NIB guest address we
pinned before). Other requests are ignored."

?

> + */

Looks sane to me.

With comments changed,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
