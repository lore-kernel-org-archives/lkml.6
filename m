Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F879206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F879206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeGTODu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:03:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731361AbeGTODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F36EB4072CF7;
        Fri, 20 Jul 2018 13:15:33 +0000 (UTC)
Received: from redhat.com (ovpn-121-184.rdu2.redhat.com [10.10.121.184])
        by smtp.corp.redhat.com (Postfix) with SMTP id 097072026D6B;
        Fri, 20 Jul 2018 13:15:28 +0000 (UTC)
Date:   Fri, 20 Jul 2018 16:15:28 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180720160550-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720035941.6844-5-khandual@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 13:15:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 13:15:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 09:29:41AM +0530, Anshuman Khandual wrote:
>Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
> virito devices

s/virito/virtio/

> This adds a hook which a platform can define in order to allow it to
> override virtio device's DMA OPS irrespective of whether it has the
> flag VIRTIO_F_IOMMU_PLATFORM set or not. We want to use this to do
> bounce-buffering of data on the new secure pSeries platform, currently
> under development, where a KVM host cannot access all of the memory
> space of a secure KVM guest.  The host can only access the pages which
> the guest has explicitly requested to be shared with the host, thus
> the virtio implementation in the guest has to copy data to and from
> shared pages.
> 
> With this hook, the platform code in the secure guest can force the
> use of swiotlb for virtio buffers, with a back-end for swiotlb which
> will use a pool of pre-allocated shared pages.  Thus all data being
> sent or received by virtio devices will be copied through pages which
> the host has access to.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/dma-mapping.h | 6 ++++++
>  arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>  drivers/virtio/virtio.c                | 7 +++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 8fa3945..bc5a9d3 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -116,3 +116,9 @@ extern u64 __dma_get_required_mask(struct device *dev);
>  
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_DMA_MAPPING_H */
> +
> +#define platform_override_dma_ops platform_override_dma_ops
> +
> +struct virtio_device;
> +
> +extern void platform_override_dma_ops(struct virtio_device *vdev);
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 06f0296..5773bc7 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -38,6 +38,7 @@
>  #include <linux/of.h>
>  #include <linux/iommu.h>
>  #include <linux/rculist.h>
> +#include <linux/virtio.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
>  #include <asm/rtas.h>
> @@ -1396,3 +1397,8 @@ static int __init disable_multitce(char *str)
>  __setup("multitce=", disable_multitce);
>  
>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> +
> +void platform_override_dma_ops(struct virtio_device *vdev)
> +{
> +	/* Override vdev->parent.dma_ops if required */
> +}
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 6b13987..432c332 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -168,6 +168,12 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
>  
>  const struct dma_map_ops virtio_direct_dma_ops;
>  
> +#ifndef platform_override_dma_ops
> +static inline void platform_override_dma_ops(struct virtio_device *vdev)
> +{
> +}
> +#endif
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -179,6 +185,7 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (virtio_has_iommu_quirk(dev))
>  		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>  
> +	platform_override_dma_ops(dev);

Is there a single place where virtio_has_iommu_quirk is called now?
If so, we could put this into virtio_has_iommu_quirk then.

>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> -- 
> 2.9.3
