Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1BDC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E520868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAWC5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:57:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfAWC5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:57:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55A34394D40;
        Wed, 23 Jan 2019 02:57:20 +0000 (UTC)
Received: from redhat.com (ovpn-122-113.rdu2.redhat.com [10.10.122.113])
        by smtp.corp.redhat.com (Postfix) with SMTP id B6876648B6;
        Wed, 23 Jan 2019 02:57:18 +0000 (UTC)
Date:   Tue, 22 Jan 2019 21:57:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>, luto@kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Message-ID: <20190122210710-mutt-send-email-mst@kernel.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 23 Jan 2019 02:57:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:59:31AM -0800, Stefano Stabellini wrote:
> On Mon, 21 Jan 2019, Peng Fan wrote:
> > on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> > address as the dma mem buffer which is predefined.
> > 
> > Without this patch, the flow is:
> > vring_map_one_sg -> vring_use_dma_api
> >                  -> dma_map_page
> > 		       -> __swiotlb_map_page
> > 		                ->swiotlb_map_page
> > 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> > However we are using per device dma area for rpmsg, phys_to_virt
> > could not return a correct virtual address for virtual address in
> > vmalloc area. Then kernel panic.
> > 
> > With this patch, vring_use_dma_api will return false, and
> > vring_map_one_sg will return sg_phys(sg) which is the correct phys
> > address in the predefined memory region.
> > vring_map_one_sg -> vring_use_dma_api
> >                  -> sg_phys(sg)
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..8993d7cb3592 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -248,6 +248,8 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
> >  
> >  static bool vring_use_dma_api(struct virtio_device *vdev)
> >  {
> > +	struct device *dma_dev = vdev->dev.parent;
> > +
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> >  
> > @@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() && !dma_dev->dma_mem)
> >  		return true;
> >  
> >  	return false;
> 
> I can see you spotted a real issue, but this is not the right fix. We
> just need something a bit more flexible than xen_domain(): there are
> many kinds of Xen domains on different architectures, we basically want
> to enable this (return true from vring_use_dma_api) only when the xen
> swiotlb is meant to be used. Does the appended patch fix the issue you
> have?
> 
> ---
> 
> xen: introduce xen_vring_use_dma
> 
> From: Stefano Stabellini <stefanos@xilinx.com>
> 
> Export xen_swiotlb on arm and arm64.
> 
> Use xen_swiotlb to determine when vring should use dma APIs to map the
> ring: when xen_swiotlb is enabled the dma API is required. When it is
> disabled, it is not required.
> 
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
> 
> diff --git a/arch/arm/include/asm/xen/swiotlb-xen.h b/arch/arm/include/asm/xen/swiotlb-xen.h
> new file mode 100644
> index 0000000..455ade5
> --- /dev/null
> +++ b/arch/arm/include/asm/xen/swiotlb-xen.h
> @@ -0,0 +1 @@
> +#include <xen/arm/swiotlb-xen.h>
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index cb44aa2..8592863 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -21,6 +21,8 @@
>  #include <asm/xen/hypercall.h>
>  #include <asm/xen/interface.h>
>  
> +int xen_swiotlb __read_mostly;
> +
>  unsigned long xen_get_swiotlb_free_pages(unsigned int order)
>  {
>  	struct memblock_region *reg;
> @@ -189,6 +191,7 @@ int __init xen_mm_init(void)
>  	struct gnttab_cache_flush cflush;
>  	if (!xen_initial_domain())
>  		return 0;
> +	xen_swiotlb = 1;
>  	xen_swiotlb_init(1, false);
>  	xen_dma_ops = &xen_swiotlb_dma_ops;
>  
> diff --git a/arch/arm64/include/asm/xen/swiotlb-xen.h b/arch/arm64/include/asm/xen/swiotlb-xen.h
> new file mode 100644
> index 0000000..455ade5
> --- /dev/null
> +++ b/arch/arm64/include/asm/xen/swiotlb-xen.h
> @@ -0,0 +1 @@
> +#include <xen/arm/swiotlb-xen.h>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755..bf8badc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -260,7 +260,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
>  	 */
> -	if (xen_domain())
> +	if (xen_vring_use_dma())
>  		return true;
>  
>  	return false;
> diff --git a/include/xen/arm/swiotlb-xen.h b/include/xen/arm/swiotlb-xen.h
> new file mode 100644
> index 0000000..2aac7c4
> --- /dev/null
> +++ b/include/xen/arm/swiotlb-xen.h
> @@ -0,0 +1,10 @@
> +#ifndef _ASM_ARM_XEN_SWIOTLB_XEN_H
> +#define _ASM_ARM_XEN_SWIOTLB_XEN_H
> +
> +#ifdef CONFIG_SWIOTLB_XEN
> +extern int xen_swiotlb;
> +#else
> +#define xen_swiotlb (0)
> +#endif
> +
> +#endif
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 0e21567..74a536d 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -46,4 +46,10 @@ enum xen_domain_type {
>  bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  		const struct bio_vec *vec2);
>  
> +#include <asm/xen/swiotlb-xen.h>
> +static inline int xen_vring_use_dma(void)
> +{
> +	return !!xen_swiotlb;

Given xen_swiotlb is only defined on arm, how will
this build on other architectures?

> +}
> +
>  #endif	/* _XEN_XEN_H */

I'd say at this point, I'm sorry we didn't come up with PLATFORM_ACCESS
when we added the xen hack.

I'm not objecting to this patch but I would also like to bypass the xen
hack for VIRTIO 1 devices. In particular I know rpmsg is still virtio 0
so it's not an issue for it. Is Xen already using VIRTIO 1, and without
setting PLATFORM_ACCESS? If not I would like to teach
vring_use_dma_api to return false on VIRTIO_1 && !PLATFORM_ACCESS.

Would that be acceptable?

-- 
MST
