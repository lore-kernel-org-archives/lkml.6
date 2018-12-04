Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45635206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45635206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeLDOWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:22:19 -0500
Received: from verein.lst.de ([213.95.11.211]:44016 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDOWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:22:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C09C968BDF; Tue,  4 Dec 2018 15:22:16 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:22:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Message-ID: <20181204142216.GB2618@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-5-hch@lst.de> <20181204100954.GN30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204100954.GN30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
> > +{
> > +	unsigned int pool_size_order = get_order(atomic_pool_size);
> > +	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> > +	struct page *page;
> > +	void *addr;
> > +	int ret;
> > +
> > +	if (dev_get_cma_area(NULL))
> > +		page = dma_alloc_from_contiguous(NULL, nr_pages,
> > +						 pool_size_order, false);
> > +	else
> > +		page = alloc_pages(gfp, pool_size_order);
> > +	if (!page)
> > +		goto out;
> > +
> > +	memset(page_address(page), 0, atomic_pool_size);
> 
> Note that this won't work if 'page' is a highmem page - should there
> be a check for that, or a check for the gfp flags?
>
> Also, is this memset() actually useful, or a waste of cycles - when we
> allocate from this pool (see dma_alloc_from_pool()), we always memset()
> the buffer.

Currently there is no user that supports highmem, but yes, the memset
should probably simply be removed.
