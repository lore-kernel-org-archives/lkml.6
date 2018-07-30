Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B19713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CEE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7niwxdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CEE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeG3K61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:58:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeG3K61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mR4mX2xzq92WZ4zZaEHCdJdgLzTAz+X3zYct5j15oCI=; b=l7niwxdHp9YAzvfZREWAXLfCA
        c+tDzvif0yE6SKGGfv0BtIh+yqXNeA3bwjccjfidrIDBNf/e8dFJ4E2V7U3/Z4k7YL65PBoG8M/NX
        v1XOTnMV93wDmOjAfZ2qDHJ0/UZTN3PK/pf5bP0fP8nrA+HMqz+O6GXPO+hhqYWQ0B6DqUGJTnO1l
        Y+1eSYvvYiYnJF0qvQ7IxxWgKCiwtzpSKLxo8Sk3dIMO2qTI1R5zhFwG+xue8m1RKa9DLOHIiheXA
        d4UCKEc0Oe9icVE0t1Xue3Q3WirH8rPr7nwJtT68zlf3Q9SuJge2Gz+BuyAnjiKNgtbey08u71uZ/
        zSzpvQ7Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4Pb-00075r-Up; Mon, 30 Jul 2018 09:24:19 +0000
Date:   Mon, 30 Jul 2018 02:24:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        mst@redhat.com, hch@infradead.org, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com
Subject: Re: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
Message-ID: <20180730092419.GA26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Virtio direct mapping DMA API operations structure
> + *
> + * This defines DMA API structure for all virtio devices which would not
> + * either bring in their own DMA OPS from architecture or they would not
> + * like to use architecture specific IOMMU based DMA OPS because QEMU
> + * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
> + */
> +dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
> +			    unsigned long offset, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs)

All these functions should probably be marked static.

> +void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> +			size_t size, enum dma_data_direction dir,
> +			unsigned long attrs)
> +{
> +}

No need to implement no-op callbacks in struct dma_map_ops.

> +
> +int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
> +{
> +	return 0;
> +}

Including this one.

> +void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t gfp, unsigned long attrs)
> +{
> +	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
> +
> +	if (queue) {
> +		phys_addr_t phys_addr = virt_to_phys(queue);
> +		*dma_handle = (dma_addr_t)phys_addr;
> +
> +		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> +			free_pages_exact(queue, PAGE_ALIGN(size));
> +			return NULL;
> +		}
> +	}
> +	return queue;

queue is a very odd name in a generic memory allocator.

> +void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_addr, unsigned long attrs)
> +{
> +	free_pages_exact(vaddr, PAGE_ALIGN(size));
> +}
> +
> +const struct dma_map_ops virtio_direct_dma_ops = {
> +	.alloc			= virtio_direct_alloc,
> +	.free			= virtio_direct_free,
> +	.map_page		= virtio_direct_map_page,
> +	.unmap_page		= virtio_direct_unmap_page,
> +	.mapping_error		= virtio_direct_mapping_error,
> +};

This is missing a dma_map_sg implementation.  In general this is
mandatory for dma_ops.  So either you implement it or explain in
a common why you think you can skip it.

> +EXPORT_SYMBOL(virtio_direct_dma_ops);

EXPORT_SYMBOL_GPL like all virtio symbols, please.
