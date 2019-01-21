Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F8C2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00B820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UicRo+Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfAUPCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:02:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbfAUPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FC3mnLsBxmVjz4DKYeKxXEHSuQXi5QXrH9YPAQjX6/Q=; b=UicRo+NesdR2gZZirMQyHG/rl
        GvAO0cP++AxFuM9U5fq6y/EUEem2PcXh+M21sz0etZ5SVwP3uvtA9MqDLgxCLuS7V8MhnGHSt47Sb
        1aGygM2iTAtN1LpeoJD6vyCayeFPD58FNiW6+lGPG8guGhLoSFbrC3tAnl5euH7qOw0F+egG6Jg6c
        WGirIBSPeRrsCg3/sYOPGszEnF11SLdNclh/SB3GMxUphOlp/HMkPEBblQxjSr55zQ2E3mNg7Sk24
        GfUopUDxUs+Fr06oy6oJKY4rSM62RtQD5Nsl+v4kVgtikGg06msPz53ArM1sRQVmyL7CepEi1TZof
        OE7Vyt9YQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glb5M-0007ua-E2; Mon, 21 Jan 2019 15:02:00 +0000
Date:   Mon, 21 Jan 2019 07:02:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add kv_to_page()
Message-ID: <20190121150200.GA14806@infradead.org>
References: <20190121003944.GA26866@bombadil.infradead.org>
 <20190121093739.GA19725@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121093739.GA19725@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > index d594f7520b7b..46326de4d9fe 100644
> > --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > @@ -308,10 +308,7 @@ static struct dma_page *__ttm_dma_alloc_page(struct dma_pool *pool)
> >  	vaddr = dma_alloc_attrs(pool->dev, pool->size, &d_page->dma,
> >  				pool->gfp_flags, attrs);
> >  	if (vaddr) {
> > -		if (is_vmalloc_addr(vaddr))
> > -			d_page->p = vmalloc_to_page(vaddr);
> > -		else
> > -			d_page->p = virt_to_page(vaddr);
> > +		d_page->p = kv_to_page(vaddr);
> >  		d_page->vaddr = (unsigned long)vaddr;

This code doesn't need cosmetic cleanup but a real fix.  Calling
either vmalloc_to_page OR virt_to_page on the return value of
dma_alloc_* is not allowed, an will break for many of the
implementations.

> > +++ b/drivers/md/bcache/util.c
> > @@ -244,10 +244,7 @@ void bch_bio_map(struct bio *bio, void *base)
> >  start:		bv->bv_len	= min_t(size_t, PAGE_SIZE - bv->bv_offset,
> >  					size);
> >  		if (base) {
> > -			bv->bv_page = is_vmalloc_addr(base)
> > -				? vmalloc_to_page(base)
> > -				: virt_to_page(base);
> > -
> > +			bv->bv_page = kv_to_page(base);
> >  			base += bv->bv_len;
> >  		}

This one also is broken, although not quite as badly.  Anyone using
vmalloc-like memory for bios need to call invalidate_kernel_vmap_range /
flush_kernel_vmap_range to maintain cache coherency for VIVT caches.

It seems this odd bcache API just makes it way to easy to miss that.

> > @@ -403,23 +402,14 @@ static int scif_create_remote_lookup(struct scif_dev *remote_dev,
> >  		goto error_window;
> >  	}
> > 
> > -	vmalloc_dma_phys = is_vmalloc_addr(&window->dma_addr[0]);
> > -	vmalloc_num_pages = is_vmalloc_addr(&window->num_pages[0]);
> > -
> >  	/* Now map each of the pages containing physical addresses */
> >  	for (i = 0, j = 0; i < nr_pages; i += SCIF_NR_ADDR_IN_PAGE, j++) {
> >  		err = scif_map_page(&window->dma_addr_lookup.lookup[j],
> > -				    vmalloc_dma_phys ?
> > -				    vmalloc_to_page(&window->dma_addr[i]) :
> > -				    virt_to_page(&window->dma_addr[i]),
> > -				    remote_dev);
> > +				kv_to_page(&window->dma_addr[i]), remote_dev);

Similar issue here.  We can't just DMA map pages returned from
vmalloc_to_page without very explicit cache maintainance.

> >  		pinned_pages->map_flags = SCIF_MAP_KERNEL;
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 9a7def7c3237..1382cc18e7db 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -833,10 +833,7 @@ int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
> >  			min = min_t(size_t, desc_len,
> >  				    min_t(size_t, len,
> >  					  PAGE_SIZE - offset_in_page(buf)));
> > -			if (vmalloced_buf)
> > -				vm_page = vmalloc_to_page(buf);
> > -			else
> > -				vm_page = kmap_to_page(buf);
> > +			vm_page = kv_to_page(buf);

Same issue here again :(

> > diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> > index 5d6724cee38f..4e13e88dd38c 100644
> > --- a/net/ceph/crypto.c
> > +++ b/net/ceph/crypto.c
> > @@ -191,11 +191,7 @@ static int setup_sgtable(struct sg_table *sgt, struct scatterlist *prealloc_sg,
> >  		struct page *page;
> >  		unsigned int len = min(chunk_len - off, buf_len);
> > 
> > -		if (is_vmalloc)
> > -			page = vmalloc_to_page(buf);
> > -		else
> > -			page = virt_to_page(buf);
> > -
> > +		page = kv_to_page(buf);
> >  		sg_set_page(sg, page, len, off);

Another issue of the same kind.

> > 
> > -static inline struct page * __pure pgv_to_page(void *addr)
> > -{
> > -	if (is_vmalloc_addr(addr))
> > -		return vmalloc_to_page(addr);
> > -	return virt_to_page(addr);
> > -}

This one plays really odd flush_dcache_page games, which looks like
a workaround for the above proper APIs.
