Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A111C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B761720835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gm+VLRI3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dP9FEdJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B761720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeJNNlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 09:41:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeJNNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 09:41:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B58D612F1; Sun, 14 Oct 2018 06:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539496873;
        bh=FYKibA8BqsUSCube4e/gzeQjcxR4MxZAPM4yqg647Oo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Gm+VLRI3HpyqBKkaTwn3UU8WNhG/rGL9nPKZsjXDCqVm1sUMMdmYHxvWi2HDhT806
         V7bYG/no8vLDfPdWdGq2Q4CEpqdgID59t3lmoeJlVYYlDYGV3JAQFEK9pGvUu8Bqrg
         szuX0ElC25sD23xNyjQdRw4fY6sqLOW52ZOpLrmM=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF0CE602A9;
        Sun, 14 Oct 2018 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539496871;
        bh=FYKibA8BqsUSCube4e/gzeQjcxR4MxZAPM4yqg647Oo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dP9FEdJNZV7z+Cz6+lsv8XlFOBb46osvIC/JzzQerDSMVldVcpkKyNfIEU62ZWMXB
         Gv+Gn4C+eNJD0EW2diD/Z9+gbXj6vA0GVH/1FREQ6YKUfrQNqXY0YGMjto6gYtoaAU
         wr1XT47it7oOGg/w/4oTvFRCsagHVXfN/TNXueNA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF0CE602A9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Sat, 13 Oct 2018 23:01:09 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Laura Abbott <labbott@redhat.com>
cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize
 re-mapping
In-Reply-To: <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
Message-ID: <alpine.DEB.2.10.1810132256240.4908@lmark-linux.qualcomm.com>
References: <1539214413-26173-1-git-send-email-john.stultz@linaro.org> <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Laura Abbott wrote:

> On 10/10/2018 04:33 PM, John Stultz wrote:
> > Since 4.12, much later narrowed down to commit 2a55e7b5e544
> > ("staging: android: ion: Call dma_map_sg for syncing and mapping"),
> > we have seen graphics performance issues on the HiKey960.
> > 
> > This was initially confounded by the fact that the out-of-tree
> > DRM driver was using HiSi custom ION heap which broke with the
> > 4.12 ION abi changes, so there was lots of suspicion that the
> > performance problems were due to switching to a somewhat simple
> > cma based DRM driver for HiKey960. Additionally, as no
> > performance regression was seen w/ the original HiKey board
> > (which is SMP, not big.LITTLE as w/ HiKey960), there was some
> > thought that the out-of-tree EAS code wasn't quite optimized.
> > 
> > But after chasing a number of other leads, I found that
> > reverting the ION code to 4.11-era got the majority of the
> > graphics performance back (there may yet be further EAS tweaks
> > needed), which lead me to the dma_map_sg change.
> > 
> > In talking w/ Laura and Liam, it was suspected that the extra
> > cache operations were causing the trouble. Additionally, I found
> > that part of the reason we didn't see this w/ the original
> > HiKey board is that its (proprietary blob) GL code uses ion_mmap
> > and ion_map_dma_buf is called very rarely, where as with
> > HiKey960, the (also proprietary blob) GL code calls
> > ion_map_dma_buf much more frequently via the kernel driver.
> > 
> > Anyway, with the cause of the performance regression isolated,
> > I've tried to find a way to improve the performance of the
> > current code.
> > 
> > This approach, which I've mostly copied from the drm_prime
> > implementation is to try to track the direction we're mapping
> > the buffers so we can avoid calling dma_map/unmap_sg on every
> > ion_map_dma_buf/ion_unmap_dma_buf call, and instead try to do
> > the work in attach/detach paths.
> > 
> > I'm not 100% sure of the correctness here, so close review would
> > be good, but it gets the performance back to being similar to
> > reverting the ION code to the 4.11-era.
> > 
> > Feedback would be greatly appreciated!
> > 
> > Cc: Beata Michalska <Beata.Michalska@arm.com>
> > Cc: Matt Szczesiak <matt.szczesiak@arm.com>
> > Cc: Anders Pedersen <Anders.Pedersen@arm.com>
> > Cc: John Reitan <John.Reitan@arm.com>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Martijn Coenen <maco@android.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >   drivers/staging/android/ion/ion.c | 36
> > +++++++++++++++++++++++++++++++-----
> >   1 file changed, 31 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/android/ion/ion.c
> > b/drivers/staging/android/ion/ion.c
> > index 9907332..a4d7fca 100644
> > --- a/drivers/staging/android/ion/ion.c
> > +++ b/drivers/staging/android/ion/ion.c
> > @@ -199,6 +199,7 @@ struct ion_dma_buf_attachment {
> >   	struct device *dev;
> >   	struct sg_table *table;
> >   	struct list_head list;
> > +	enum dma_data_direction dir;
> >   };
> >     static int ion_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -220,6 +221,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
> >     	a->table = table;
> >   	a->dev = attachment->dev;
> > +	a->dir = DMA_NONE;
> >   	INIT_LIST_HEAD(&a->list);
> >     	attachment->priv = a;
> > @@ -236,6 +238,18 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
> >   {
> >   	struct ion_dma_buf_attachment *a = attachment->priv;
> >   	struct ion_buffer *buffer = dmabuf->priv;
> > +	struct sg_table *table;
> > +
> > +	if (!a)
> > +		return;
> > +
> > +	table = a->table;
> > +	if (table) {
> > +		if (a->dir != DMA_NONE)
> > +			dma_unmap_sg(attachment->dev, table->sgl,
> > table->nents,
> > +				     a->dir);
> > +		sg_free_table(table);
> > +	}
> >     	free_duped_table(a->table);
> >   	mutex_lock(&buffer->lock);
> > @@ -243,6 +257,7 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
> >   	mutex_unlock(&buffer->lock);
> >     	kfree(a);
> > +	attachment->priv = NULL;
> >   }
> >     static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment
> > *attachment,
> > @@ -251,12 +266,24 @@ static struct sg_table *ion_map_dma_buf(struct
> > dma_buf_attachment *attachment,
> >   	struct ion_dma_buf_attachment *a = attachment->priv;
> >   	struct sg_table *table;
> >   -	table = a->table;
> > +	if (WARN_ON(direction == DMA_NONE || !a))
> > +		return ERR_PTR(-EINVAL);
> >   -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> > -			direction))
> > -		return ERR_PTR(-ENOMEM);
> > +	if (a->dir == direction)
> > +		return a->table;
> >   +	if (WARN_ON(a->dir != DMA_NONE))
> > +		return ERR_PTR(-EBUSY);
> > +
> > +	table = a->table;
> > +	if (!IS_ERR(table)) {
> > +		if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> > +				direction)) {
> > +			table = ERR_PTR(-ENOMEM);
> > +		} else {
> > +			a->dir = direction;
> > +		}
> > +	}
> >   	return table;
> >   }
> >   @@ -264,7 +291,6 @@ static void ion_unmap_dma_buf(struct
> > dma_buf_attachment *attachment,
> >   			      struct sg_table *table,
> >   			      enum dma_data_direction direction)
> >   {
> > -	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> 
> This changes the semantics so that the only time a buffer
> gets unmapped is on detach. I don't think we want to restrict
> Ion to that behavior but I also don't know if anyone else
> is relying on that. 

I also have a concern with this patch, wouldn't it run into difficulties 
if multiple devices were attached to the same cached ION buffer and one of 
those devices was IO-coherent but the other one wasn't.
For example if device A (which is non IO-coherent) wrote to the buffer but 
skipped the cache invalidation on dma_unmap and then if the buffer was 
dma-mapped into device B (which is IO-coherent) and then device B 
attempted to read the buffer it may end up reading stale cache entries.

I don't believe there is any requirement for device A to detach (which 
would do the cache invalidation) before having device B dma-map the 
buffer.

I believe there would also be issues if device B wrote to the buffer and 
then device A tried to read or write it.

> I thought there might have been some Qualcomm
> stuff that did that (Liam? Todd?)

Yes we have a form of "lazy mapping", which clients can opt into using, 
which results in iommu page table mapping not being unmaped on dma-unamp. 
Instead they are unmapped when the buffer is destroyed.

It is important to note that in our "lazy mapping" implementation cache 
maintenance is still applied on dma-map and dma-unmap.
If you need a full description of this feature I can provide it.

> 
> I suspect most of the cost of the dma_map/dma_unmap is from the
> cache flushing and not the actual mapping operations. If this
> is the case, another option might be to figure out how to
> incorporate dma_attrs so drivers can use DMA_ATTR_SKIP_CPU_SYNC
> to decide when they actually want to sync.

We have support for this locally on our 4.14 branch.
We have added a dma_map_attrs field to the dma_buf_attachment struct, 
clients can then specify dma-attributes here such as 
DMA_ATTR_SKIP_CPU_SYNC before dma-mapping the buffer, then we ensure that 
these dma attributes are passed to dma_map_sg_attrs when ion_map_dma_buf 
is called (same for ion_unmap_dma_buf).

I hope to try and upstream this at some point.

> 
> Thanks,
> Laura
> 
> >   }
> >     static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> > 
> 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
