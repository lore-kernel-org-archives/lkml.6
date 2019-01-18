Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC982C65C14
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6AB20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZBCXI76N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfARUUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:20:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49986 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfARUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:20:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IKKgJ3020110;
        Fri, 18 Jan 2019 14:20:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547842842;
        bh=aufRV8DxPBlCH1R+TJXTjW299Jj7QbDj1aFMqdBqcdQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZBCXI76NjRC3K0DYdc6kgHzAw9g/dvybIkh0XvXF3ilConZl3qujLISbMW7lIUDvT
         a3wWS8bFzFw4k+11aPUo/tSkknGthHroPUAVUuTWONWDSOLBwwW3h6p3xhZpJQfC49
         pBgKVPb6CBysx1tS05Dk7aGtMN3Aa6t1I2KKjjbw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IKKgHG060324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 14:20:42 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 14:20:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 14:20:42 -0600
Received: from [172.22.84.228] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IKKfKX012468;
        Fri, 18 Jan 2019 14:20:41 -0600
Subject: Re: [PATCH 2/4] staging: android: ion: Restrict cache maintenance to
 dma mapped memory
To:     Liam Mark <lmark@codeaurora.org>, <labbott@redhat.com>,
        <sumit.semwal@linaro.org>
CC:     <arve@android.com>, <tkjos@android.com>, <maco@android.com>,
        <joel@joelfernandes.org>, <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-3-git-send-email-lmark@codeaurora.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <69b18f39-8ce0-3c4d-3528-dfab8399f24f@ti.com>
Date:   Fri, 18 Jan 2019 14:20:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547836667-13695-3-git-send-email-lmark@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 12:37 PM, Liam Mark wrote:
> The ION begin_cpu_access and end_cpu_access functions use the
> dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
> maintenance.
> 
> Currently it is possible to apply cache maintenance, via the
> begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
> dma mapped.
> 
> The dma sync sg APIs should not be called on sg lists which have not been
> dma mapped as this can result in cache maintenance being applied to the
> wrong address. If an sg list has not been dma mapped then its dma_address
> field has not been populated, some dma ops such as the swiotlb_dma_ops ops
> use the dma_address field to calculate the address onto which to apply
> cache maintenance.
> 
> Also I don’t think we want CMOs to be applied to a buffer which is not
> dma mapped as the memory should already be coherent for access from the
> CPU. Any CMOs required for device access taken care of in the
> dma_buf_map_attachment and dma_buf_unmap_attachment calls.
> So really it only makes sense for begin_cpu_access and end_cpu_access to
> apply CMOs if the buffer is dma mapped.
> 
> Fix the ION begin_cpu_access and end_cpu_access functions to only apply
> cache maintenance to buffers which are dma mapped.
> 
> Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>  drivers/staging/android/ion/ion.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 6f5afab7c1a1..1fe633a7fdba 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -210,6 +210,7 @@ struct ion_dma_buf_attachment {
>  	struct device *dev;
>  	struct sg_table *table;
>  	struct list_head list;
> +	bool dma_mapped;
>  };
>  
>  static int ion_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -231,6 +232,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
>  
>  	a->table = table;
>  	a->dev = attachment->dev;
> +	a->dma_mapped = false;
>  	INIT_LIST_HEAD(&a->list);
>  
>  	attachment->priv = a;
> @@ -261,12 +263,18 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>  {
>  	struct ion_dma_buf_attachment *a = attachment->priv;
>  	struct sg_table *table;
> +	struct ion_buffer *buffer = attachment->dmabuf->priv;
>  
>  	table = a->table;
>  
> +	mutex_lock(&buffer->lock);
>  	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> -			direction))
> +			direction)) {
> +		mutex_unlock(&buffer->lock);
>  		return ERR_PTR(-ENOMEM);
> +	}
> +	a->dma_mapped = true;
> +	mutex_unlock(&buffer->lock);
>  
>  	return table;
>  }
> @@ -275,7 +283,13 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
>  			      struct sg_table *table,
>  			      enum dma_data_direction direction)
>  {
> +	struct ion_dma_buf_attachment *a = attachment->priv;
> +	struct ion_buffer *buffer = attachment->dmabuf->priv;
> +
> +	mutex_lock(&buffer->lock);
>  	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +	a->dma_mapped = false;
> +	mutex_unlock(&buffer->lock);
>  }
>  
>  static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> @@ -346,8 +360,9 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
>  
>  	mutex_lock(&buffer->lock);
>  	list_for_each_entry(a, &buffer->attachments, list) {

When no devices are attached then buffer->attachments is empty and the
below does not run, so if I understand this patch correctly then what
you are protecting against is CPU access in the window after
dma_buf_attach but before dma_buf_map.

This is the kind of thing that again makes me think a couple more
ordering requirements on DMA-BUF ops are needed. DMA-BUFs do not require
the backing memory to be allocated until map time, this is why the
dma_address field would still be null as you note in the commit message.
So why should the CPU be performing accesses on a buffer that is not
actually backed yet?

I can think of two solutions:

1) Only allow CPU access (mmap, kmap, {begin,end}_cpu_access) while at
least one device is mapped.

2) Treat the CPU access request like the a device map request and
trigger the allocation of backing memory just like if a device map had
come in.

I know the current Ion heaps (and most other DMA-BUF exporters) all do
the allocation up front so the memory is already there, but DMA-BUF was
designed with late allocation in mind. I have a use-case I'm working on
that finally exercises this DMA-BUF functionality and I would like to
have it export through ION. This patch doesn't prevent that, but seems
like it is endorsing the the idea that buffers always need to be backed,
even before device attach/map is has occurred.

Either of the above two solutions would need to target the DMA-BUF
framework,

Sumit,

Any comment?

Thanks,
Andrew

> -		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
> -				    direction);
> +		if (a->dma_mapped)
> +			dma_sync_sg_for_cpu(a->dev, a->table->sgl,
> +					    a->table->nents, direction);
>  	}
>  
>  unlock:
> @@ -369,8 +384,9 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>  
>  	mutex_lock(&buffer->lock);
>  	list_for_each_entry(a, &buffer->attachments, list) {
> -		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
> -				       direction);
> +		if (a->dma_mapped)
> +			dma_sync_sg_for_device(a->dev, a->table->sgl,
> +					       a->table->nents, direction);
>  	}
>  	mutex_unlock(&buffer->lock);
>  
> 
