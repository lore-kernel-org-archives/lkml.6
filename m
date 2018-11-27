Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD362086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD362086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeK1EVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbeK1EVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:21:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 991513078A50;
        Tue, 27 Nov 2018 17:22:39 +0000 (UTC)
Received: from x1.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD83B26FD8;
        Tue, 27 Nov 2018 17:22:38 +0000 (UTC)
Date:   Tue, 27 Nov 2018 10:22:37 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v2 2/3] vfio: ap: ioctl definitions for AP Queue
 Interrupt Control
Message-ID: <20181127102237.42d8e178@x1.home>
In-Reply-To: <1542906675-7949-3-git-send-email-pmorel@linux.ibm.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
        <1542906675-7949-3-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 27 Nov 2018 17:22:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 18:11:14 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We define two VFIO ioctl command to setup and clear
> the AP Queues interrupt.
> 
> Arguments passed by the guest are:
> - the apqn, AP queue number
> - the Notification by address
> - the identifier of the previously associated adapter


We have an extensible VFIO_DEVICE_SET_IRQS ioctl already, why does AP
need its own?


> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  include/uapi/linux/vfio.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 8131028..9a1b350 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -866,6 +866,31 @@ struct vfio_iommu_spapr_tce_remove {
>  };
>  #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>  
> +/**
> + * VFIO_AP_SET_IRQ - _IOWR(VFIO_TYPE, VFIO_BASE + 21, struct vfio_ap_aqic)
> + *
> + * Setup IRQ for an AP Queue
> + * @cmd contains the AP queue number (apqn)
> + * @status receives the resulting status of the command
> + * @nib is the Notification Indicator byte address
> + * @adapter_id allows to retrieve the associated adapter
> + */
> +struct vfio_ap_aqic {
> +	__u32   argsz;
> +	__u32   flags;
> +	/* out */
> +	__u32 status;
> +	/* in */
> +	__u32 adapter_id;
> +	__u64 nib;
> +	__u16 apqn;
> +	__u8 isc;
> +	__u8 reserved[5];
> +};
> +#define VFIO_AP_SET_IRQ			_IO(VFIO_TYPE, VFIO_BASE + 21)
> +#define VFIO_AP_CLEAR_IRQ		_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
>  /* ***************************************************************** */
>  
> +
>  #endif /* _UAPIVFIO_H */

