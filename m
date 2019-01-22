Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C480C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B046217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548187184;
	bh=jH7AH4owR95tO4IEbKdAkLeziPUKi8UODE0gkFkCess=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=J/7SepwtgaegCutgjZP2IWkpK3dXT0cJn0ET5iA/G/SgkP1XfRqMDJnCg6IQ9//Ca
	 EFvjyAtYUAOVwjjiwR2xKlfPGXsFiPKyjsrZClGmUuPDiLr5c2xJ2mKnhHtby/nWSs
	 yAAplm/HgV6BC6uNVoOLnDm1eO6MFRFgn4CQ5Ye4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAVT7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:59:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfAVT7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:59:42 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0401321726;
        Tue, 22 Jan 2019 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548187180;
        bh=jH7AH4owR95tO4IEbKdAkLeziPUKi8UODE0gkFkCess=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=d5R61jVHBCVGVCnWA/qh2NRQDzaXkREwWN1Kmdsb6tjajyBkQg7k75KQ+3R614ZqC
         HWYfsjzhTarI1SesCZq14MquDSZABXVhoQTFEllbQv2e2UuTFLitono92/BbzhS6q/
         Sg2n8fs/bq1MgLdcLn+WZUq4MGym9lZyuvC1kRgA=
Date:   Tue, 22 Jan 2019 11:59:31 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Peng Fan <peng.fan@nxp.com>
cc:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>, luto@kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
In-Reply-To: <20190121050056.14325-1-peng.fan@nxp.com>
Message-ID: <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
References: <20190121050056.14325-1-peng.fan@nxp.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Peng Fan wrote:
> on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> address as the dma mem buffer which is predefined.
> 
> Without this patch, the flow is:
> vring_map_one_sg -> vring_use_dma_api
>                  -> dma_map_page
> 		       -> __swiotlb_map_page
> 		                ->swiotlb_map_page
> 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> However we are using per device dma area for rpmsg, phys_to_virt
> could not return a correct virtual address for virtual address in
> vmalloc area. Then kernel panic.
> 
> With this patch, vring_use_dma_api will return false, and
> vring_map_one_sg will return sg_phys(sg) which is the correct phys
> address in the predefined memory region.
> vring_map_one_sg -> vring_use_dma_api
>                  -> sg_phys(sg)
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..8993d7cb3592 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -248,6 +248,8 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>  
>  static bool vring_use_dma_api(struct virtio_device *vdev)
>  {
> +	struct device *dma_dev = vdev->dev.parent;
> +
>  	if (!virtio_has_iommu_quirk(vdev))
>  		return true;
>  
> @@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
>  	 */
> -	if (xen_domain())
> +	if (xen_domain() && !dma_dev->dma_mem)
>  		return true;
>  
>  	return false;

I can see you spotted a real issue, but this is not the right fix. We
just need something a bit more flexible than xen_domain(): there are
many kinds of Xen domains on different architectures, we basically want
to enable this (return true from vring_use_dma_api) only when the xen
swiotlb is meant to be used. Does the appended patch fix the issue you
have?

---

xen: introduce xen_vring_use_dma

From: Stefano Stabellini <stefanos@xilinx.com>

Export xen_swiotlb on arm and arm64.

Use xen_swiotlb to determine when vring should use dma APIs to map the
ring: when xen_swiotlb is enabled the dma API is required. When it is
disabled, it is not required.

Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>

diff --git a/arch/arm/include/asm/xen/swiotlb-xen.h b/arch/arm/include/asm/xen/swiotlb-xen.h
new file mode 100644
index 0000000..455ade5
--- /dev/null
+++ b/arch/arm/include/asm/xen/swiotlb-xen.h
@@ -0,0 +1 @@
+#include <xen/arm/swiotlb-xen.h>
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index cb44aa2..8592863 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -21,6 +21,8 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/interface.h>
 
+int xen_swiotlb __read_mostly;
+
 unsigned long xen_get_swiotlb_free_pages(unsigned int order)
 {
 	struct memblock_region *reg;
@@ -189,6 +191,7 @@ int __init xen_mm_init(void)
 	struct gnttab_cache_flush cflush;
 	if (!xen_initial_domain())
 		return 0;
+	xen_swiotlb = 1;
 	xen_swiotlb_init(1, false);
 	xen_dma_ops = &xen_swiotlb_dma_ops;
 
diff --git a/arch/arm64/include/asm/xen/swiotlb-xen.h b/arch/arm64/include/asm/xen/swiotlb-xen.h
new file mode 100644
index 0000000..455ade5
--- /dev/null
+++ b/arch/arm64/include/asm/xen/swiotlb-xen.h
@@ -0,0 +1 @@
+#include <xen/arm/swiotlb-xen.h>
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755..bf8badc 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -260,7 +260,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	 * the DMA API if we're a Xen guest, which at least allows
 	 * all of the sensible Xen configurations to work correctly.
 	 */
-	if (xen_domain())
+	if (xen_vring_use_dma())
 		return true;
 
 	return false;
diff --git a/include/xen/arm/swiotlb-xen.h b/include/xen/arm/swiotlb-xen.h
new file mode 100644
index 0000000..2aac7c4
--- /dev/null
+++ b/include/xen/arm/swiotlb-xen.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_ARM_XEN_SWIOTLB_XEN_H
+#define _ASM_ARM_XEN_SWIOTLB_XEN_H
+
+#ifdef CONFIG_SWIOTLB_XEN
+extern int xen_swiotlb;
+#else
+#define xen_swiotlb (0)
+#endif
+
+#endif
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0e21567..74a536d 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -46,4 +46,10 @@ enum xen_domain_type {
 bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 		const struct bio_vec *vec2);
 
+#include <asm/xen/swiotlb-xen.h>
+static inline int xen_vring_use_dma(void)
+{
+	return !!xen_swiotlb;
+}
+
 #endif	/* _XEN_XEN_H */
