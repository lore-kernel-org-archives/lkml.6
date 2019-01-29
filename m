Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42544C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7B520881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h5aNLZUY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BBaDAk43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfA2Xo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:44:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfA2Xo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:44:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 08C98608FF; Tue, 29 Jan 2019 23:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548805497;
        bh=kTaYLfalgW056j/E7cVwznlxMi0cPQO3QY1JxhOCFjg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=h5aNLZUYNT6IdM05EvPt/akBg7VR2rpT4jOPH4dpm0d3AnFdeis7sMHZQMecgN8lY
         K3kYLTQ88/S/NC6CoMT+EebHKZvHOjcIK65qSSa6rKgwcV3l6b2RSfonQy5g7YtZSG
         ybOvEoMJh4W47Toh66Y6H51BSRl5LRVqKBD2Lo9w=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75770607F1;
        Tue, 29 Jan 2019 23:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548805495;
        bh=kTaYLfalgW056j/E7cVwznlxMi0cPQO3QY1JxhOCFjg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BBaDAk43MfPS5VZpORf1/VgEiu5M9bfvpnnHywDq3evvY78XksUdxxABLr7fymR7N
         zyOXNsxSSM0jUhXiyyBxtZIJvCe1kN2GsykG3UUPpLvCrqBOGKBitBmFbKTRiOkp/i
         u+lri9vHIF1Ttju5xZyCId5TYz/G01klQEB90XBk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75770607F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 29 Jan 2019 15:44:53 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, arve@android.com,
        john.stultz@linaro.org, joel@joelfernandes.org, maco@android.com,
        sumit.semwal@linaro.org, christian@brauner.io
Subject: Re: [PATCH 2/4] staging: android: ion: Restrict cache maintenance
 to dma mapped memory
In-Reply-To: <alpine.DEB.2.10.1901181316380.9328@lmark-linux.qualcomm.com>
Message-ID: <alpine.DEB.2.10.1901291544001.19412@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-3-git-send-email-lmark@codeaurora.org> <69b18f39-8ce0-3c4d-3528-dfab8399f24f@ti.com> <alpine.DEB.2.10.1901181316380.9328@lmark-linux.qualcomm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2046127808-1501696297-1548805494=:19412"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2046127808-1501696297-1548805494=:19412
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 18 Jan 2019, Liam Mark wrote:

> On Fri, 18 Jan 2019, Andrew F. Davis wrote:
> 
> > On 1/18/19 12:37 PM, Liam Mark wrote:
> > > The ION begin_cpu_access and end_cpu_access functions use the
> > > dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
> > > maintenance.
> > > 
> > > Currently it is possible to apply cache maintenance, via the
> > > begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
> > > dma mapped.
> > > 
> > > The dma sync sg APIs should not be called on sg lists which have not been
> > > dma mapped as this can result in cache maintenance being applied to the
> > > wrong address. If an sg list has not been dma mapped then its dma_address
> > > field has not been populated, some dma ops such as the swiotlb_dma_ops ops
> > > use the dma_address field to calculate the address onto which to apply
> > > cache maintenance.
> > > 
> > > Also I don’t think we want CMOs to be applied to a buffer which is not
> > > dma mapped as the memory should already be coherent for access from the
> > > CPU. Any CMOs required for device access taken care of in the
> > > dma_buf_map_attachment and dma_buf_unmap_attachment calls.
> > > So really it only makes sense for begin_cpu_access and end_cpu_access to
> > > apply CMOs if the buffer is dma mapped.
> > > 
> > > Fix the ION begin_cpu_access and end_cpu_access functions to only apply
> > > cache maintenance to buffers which are dma mapped.
> > > 
> > > Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
> > > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> > > ---
> > >  drivers/staging/android/ion/ion.c | 26 +++++++++++++++++++++-----
> > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> > > index 6f5afab7c1a1..1fe633a7fdba 100644
> > > --- a/drivers/staging/android/ion/ion.c
> > > +++ b/drivers/staging/android/ion/ion.c
> > > @@ -210,6 +210,7 @@ struct ion_dma_buf_attachment {
> > >  	struct device *dev;
> > >  	struct sg_table *table;
> > >  	struct list_head list;
> > > +	bool dma_mapped;
> > >  };
> > >  
> > >  static int ion_dma_buf_attach(struct dma_buf *dmabuf,
> > > @@ -231,6 +232,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
> > >  
> > >  	a->table = table;
> > >  	a->dev = attachment->dev;
> > > +	a->dma_mapped = false;
> > >  	INIT_LIST_HEAD(&a->list);
> > >  
> > >  	attachment->priv = a;
> > > @@ -261,12 +263,18 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
> > >  {
> > >  	struct ion_dma_buf_attachment *a = attachment->priv;
> > >  	struct sg_table *table;
> > > +	struct ion_buffer *buffer = attachment->dmabuf->priv;
> > >  
> > >  	table = a->table;
> > >  
> > > +	mutex_lock(&buffer->lock);
> > >  	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> > > -			direction))
> > > +			direction)) {
> > > +		mutex_unlock(&buffer->lock);
> > >  		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +	a->dma_mapped = true;
> > > +	mutex_unlock(&buffer->lock);
> > >  
> > >  	return table;
> > >  }
> > > @@ -275,7 +283,13 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
> > >  			      struct sg_table *table,
> > >  			      enum dma_data_direction direction)
> > >  {
> > > +	struct ion_dma_buf_attachment *a = attachment->priv;
> > > +	struct ion_buffer *buffer = attachment->dmabuf->priv;
> > > +
> > > +	mutex_lock(&buffer->lock);
> > >  	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> > > +	a->dma_mapped = false;
> > > +	mutex_unlock(&buffer->lock);
> > >  }
> > >  
> > >  static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> > > @@ -346,8 +360,9 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> > >  
> > >  	mutex_lock(&buffer->lock);
> > >  	list_for_each_entry(a, &buffer->attachments, list) {
> > 
> > When no devices are attached then buffer->attachments is empty and the
> > below does not run, so if I understand this patch correctly then what
> > you are protecting against is CPU access in the window after
> > dma_buf_attach but before dma_buf_map.
> > 
> 
> Yes
> 
> > This is the kind of thing that again makes me think a couple more
> > ordering requirements on DMA-BUF ops are needed. DMA-BUFs do not require
> > the backing memory to be allocated until map time, this is why the
> > dma_address field would still be null as you note in the commit message.
> > So why should the CPU be performing accesses on a buffer that is not
> > actually backed yet?
> > 
> > I can think of two solutions:
> > 
> > 1) Only allow CPU access (mmap, kmap, {begin,end}_cpu_access) while at
> > least one device is mapped.
> > 
> 
> Would be quite limiting to clients.
> 
> > 2) Treat the CPU access request like the a device map request and
> > trigger the allocation of backing memory just like if a device map had
> > come in.
> > 
> 
> Which is, as you mention pretty much what we have now (though the buffer 
> is allocated even earlier).
> 
> > I know the current Ion heaps (and most other DMA-BUF exporters) all do
> > the allocation up front so the memory is already there, but DMA-BUF was
> > designed with late allocation in mind. I have a use-case I'm working on
> > that finally exercises this DMA-BUF functionality and I would like to
> > have it export through ION. This patch doesn't prevent that, but seems
> > like it is endorsing the the idea that buffers always need to be backed,
> > even before device attach/map is has occurred.
> > 
> 
> I didn't interpret the DMA-buf contract as requiring the dma-map to be 
> called in order for a backing store to be provided, I interpreted it as 
> meaning there could be a backing store before the dma-map but at the 
> dma-map call the final backing store configuration would be decided 
> (perhaps involving migrating the memory to the final backing store).
> I will let the dma-buf experts correct me on that.
> 
> Limiting userspace clients to not be able to access buffers until after 
> they are dma-mapped seems unfortuntate to me, dma-mapping usually means a 
> change of ownership of the memory from the CPU to the device. So generally 
> while a buffer is dma mapped you have the device access it (though of 
> course it is supported for CPU to access to the buffer while dma mapped) 
> and then once the buffer is dma-unmapped the CPU can access it.  This is 
> how the DMA APIs are frequently used, and the changes above make ION align 
> more with the way the DMA APIs are used. Basically when the buffer is not 
> dma-mapped the CPU doesn't need to do any CMOs to access the buffer (and 
> ION ensures not CMOs are applied) but if the CPU does want to access the 
> buffer while it is dma mapped then ION ensures that the appropriate CMOs 
> are applied.
> 
> It seems like a legitimate uses case to me to allow clients to access the 
> buffer before (and after) dma-mapping, example post processing of buffers.
> 
> 
> > Either of the above two solutions would need to target the DMA-BUF
> > framework,
> > 
> > Sumit,
> > 
> > Any comment?
> > 

In a separate thread Sumit seems to have confirmed that it is not a 
requirement for exporters to defer the allocation until first dma map.

https://lore.kernel.org/lkml/CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com/

From Sumit:
"""
> Maybe it should be up to the exporter if early CPU access is allowed?
>
> I'm hoping someone with authority over the DMA-BUF framework can clarify
> original intentions here.
>

I suppose dma-buf as a framework can't know or decide what the exporter 
wants or can do - whether the exporter wants to use it for 'only 
zero-copy', or do some intelligent things behind the scene, I think should 
be best left to the exporter.
"""

So it seems like it is acceptable for ION to continue to support access to 
the buffer from the CPU before it is DMA mapped.

I was wondering if there was any additional feedback on this change since 
it does fix a bug where userspace can cause the system to crash and I 
think the change also results in a more logical application of CMOs.


> > Thanks,
> > Andrew
> > 
> > > -		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
> > > -				    direction);
> > > +		if (a->dma_mapped)
> > > +			dma_sync_sg_for_cpu(a->dev, a->table->sgl,
> > > +					    a->table->nents, direction);
> > >  	}
> > >  
> > >  unlock:
> > > @@ -369,8 +384,9 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> > >  
> > >  	mutex_lock(&buffer->lock);
> > >  	list_for_each_entry(a, &buffer->attachments, list) {
> > > -		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
> > > -				       direction);
> > > +		if (a->dma_mapped)
> > > +			dma_sync_sg_for_device(a->dev, a->table->sgl,
> > > +					       a->table->nents, direction);
> > >  	}
> > >  	mutex_unlock(&buffer->lock);
> > >  
> > > 
> > 
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
---2046127808-1501696297-1548805494=:19412--
