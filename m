Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C948C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFEA20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eybs+8vV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFEA20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeKXIU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:20:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeKXIUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VITkrZG/gk7QdC2jucncz68rp3F1kMHXdL0KqMlEm1w=; b=eybs+8vVSl/lego+Ed76kISbx
        rVb9QsAi6AYeN92batTbUA4ktZqjTgkr/IbbQjgQoAFo4O6yLm8Ee4N0L2fE92J8XrriGunz9yEmJ
        FanLKDkzUTiXkRepj7hD3YsTF707Yt4DlQDPgpaIpTRLXcqxJe0Fi0AAxnRrm2t4RfQr8FvUzwi/m
        8xuegTHPDC19Fx6FLZ9ZtGF/gkeuL4Ha4m7okU5ivbq5AtAlsd7LXxTT668aJpBoWckt1BM/1iuwv
        PAwtazPnLn6Q0HvFybEKetwvEW/ORo6x3qhdxvP5hLVNJ5k63AEgSo0psC6gwTu+CZ47fWUOL86Xs
        Z5FGO7P5w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQJ68-0006R5-8e; Fri, 23 Nov 2018 21:34:48 +0000
Date:   Fri, 23 Nov 2018 13:34:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        mhocko@suse.com, joro@8bytes.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181123213448.GW3065@bombadil.infradead.org>
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
 <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 05:23:06PM +0000, Robin Murphy wrote:
> On 15/11/2018 15:49, Souptick Joarder wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 12 ++----------
> >   1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index d1b0475..69c66b1 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >   int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
> >   {
> > -	unsigned long uaddr = vma->vm_start;
> > -	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -	int ret = -ENXIO;
> > +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > -	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> > -		ret = vm_insert_page(vma, uaddr, pages[i]);
> > -		if (ret)
> > -			break;
> > -		uaddr += PAGE_SIZE;
> > -	}
> > -	return ret;
> > +	return vm_insert_range(vma, vma->vm_start, pages, count);
> 
> AFIACS, vm_insert_range() doesn't respect vma->vm_pgoff, so doesn't this
> break partial mmap()s of a large buffer? (which I believe can be a thing)

Whoops.  That should have been:

return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff, count);

I suppose.

Although arguably we should respect vm_pgoff inside vm_insert_region()
and then callers automatically get support for vm_pgoff without having
to think about it ... although we should then also pass in the length
of the pages array to avoid pages being mapped in which aren't part of
the allocated array.

Hm.  More thought required.
