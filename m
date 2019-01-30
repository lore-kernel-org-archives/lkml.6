Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F63C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A320857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IwNXWB1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfA3Ob0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:31:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56968 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3ObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:31:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0UEVFoY128219;
        Wed, 30 Jan 2019 08:31:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548858675;
        bh=rsmEpZSkRSwegPlp55S2qGLkEE53Ax7GgdklRP59lps=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IwNXWB1wvL337Qab4Tm5nuSJ9TsiT3FjahP/6MX5owrvv7uM1C6ibwX3ebNa6cKqZ
         QwCi338w/8SHPXL8p6Cnoa3i7YVyogFkZBLWO44p0OUhkYQ30Ky8JPCmgkB/N7KBAM
         DPzgP1EhKruZUwgXQx6aL398VhPbrFEkN5sya6WQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0UEVEhl058028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 08:31:15 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 30
 Jan 2019 08:31:14 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 30 Jan 2019 08:31:14 -0600
Received: from [172.22.98.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0UEVDg9025693;
        Wed, 30 Jan 2019 08:31:13 -0600
Subject: Re: [PATCH 2/4] staging: android: ion: Restrict cache maintenance to
 dma mapped memory
To:     Liam Mark <lmark@codeaurora.org>
CC:     <devel@driverdev.osuosl.org>, <tkjos@android.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <arve@android.com>,
        <john.stultz@linaro.org>, <joel@joelfernandes.org>,
        <maco@android.com>, <sumit.semwal@linaro.org>,
        <christian@brauner.io>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-3-git-send-email-lmark@codeaurora.org>
 <69b18f39-8ce0-3c4d-3528-dfab8399f24f@ti.com>
 <alpine.DEB.2.10.1901181316380.9328@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1901291544001.19412@lmark-linux.qualcomm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <f2722cc4-1cac-5924-c496-396713c94aef@ti.com>
Date:   Wed, 30 Jan 2019 08:31:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1901291544001.19412@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 5:44 PM, Liam Mark wrote:
> On Fri, 18 Jan 2019, Liam Mark wrote:
> 
>> On Fri, 18 Jan 2019, Andrew F. Davis wrote:
>>
>>> On 1/18/19 12:37 PM, Liam Mark wrote:
>>>> The ION begin_cpu_access and end_cpu_access functions use the
>>>> dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
>>>> maintenance.
>>>>
>>>> Currently it is possible to apply cache maintenance, via the
>>>> begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
>>>> dma mapped.
>>>>
>>>> The dma sync sg APIs should not be called on sg lists which have not been
>>>> dma mapped as this can result in cache maintenance being applied to the
>>>> wrong address. If an sg list has not been dma mapped then its dma_address
>>>> field has not been populated, some dma ops such as the swiotlb_dma_ops ops
>>>> use the dma_address field to calculate the address onto which to apply
>>>> cache maintenance.
>>>>
>>>> Also I don’t think we want CMOs to be applied to a buffer which is not
>>>> dma mapped as the memory should already be coherent for access from the
>>>> CPU. Any CMOs required for device access taken care of in the
>>>> dma_buf_map_attachment and dma_buf_unmap_attachment calls.
>>>> So really it only makes sense for begin_cpu_access and end_cpu_access to
>>>> apply CMOs if the buffer is dma mapped.
>>>>
>>>> Fix the ION begin_cpu_access and end_cpu_access functions to only apply
>>>> cache maintenance to buffers which are dma mapped.
>>>>
>>>> Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
>>>> Signed-off-by: Liam Mark <lmark@codeaurora.org>
>>>> ---
>>>>  drivers/staging/android/ion/ion.c | 26 +++++++++++++++++++++-----
>>>>  1 file changed, 21 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
>>>> index 6f5afab7c1a1..1fe633a7fdba 100644
>>>> --- a/drivers/staging/android/ion/ion.c
>>>> +++ b/drivers/staging/android/ion/ion.c
>>>> @@ -210,6 +210,7 @@ struct ion_dma_buf_attachment {
>>>>  	struct device *dev;
>>>>  	struct sg_table *table;
>>>>  	struct list_head list;
>>>> +	bool dma_mapped;
>>>>  };
>>>>  
>>>>  static int ion_dma_buf_attach(struct dma_buf *dmabuf,
>>>> @@ -231,6 +232,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
>>>>  
>>>>  	a->table = table;
>>>>  	a->dev = attachment->dev;
>>>> +	a->dma_mapped = false;
>>>>  	INIT_LIST_HEAD(&a->list);
>>>>  
>>>>  	attachment->priv = a;
>>>> @@ -261,12 +263,18 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>>>>  {
>>>>  	struct ion_dma_buf_attachment *a = attachment->priv;
>>>>  	struct sg_table *table;
>>>> +	struct ion_buffer *buffer = attachment->dmabuf->priv;
>>>>  
>>>>  	table = a->table;
>>>>  
>>>> +	mutex_lock(&buffer->lock);
>>>>  	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
>>>> -			direction))
>>>> +			direction)) {
>>>> +		mutex_unlock(&buffer->lock);
>>>>  		return ERR_PTR(-ENOMEM);
>>>> +	}
>>>> +	a->dma_mapped = true;
>>>> +	mutex_unlock(&buffer->lock);
>>>>  
>>>>  	return table;
>>>>  }
>>>> @@ -275,7 +283,13 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
>>>>  			      struct sg_table *table,
>>>>  			      enum dma_data_direction direction)
>>>>  {
>>>> +	struct ion_dma_buf_attachment *a = attachment->priv;
>>>> +	struct ion_buffer *buffer = attachment->dmabuf->priv;
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>>  	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
>>>> +	a->dma_mapped = false;
>>>> +	mutex_unlock(&buffer->lock);
>>>>  }
>>>>  
>>>>  static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>>>> @@ -346,8 +360,9 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
>>>>  
>>>>  	mutex_lock(&buffer->lock);
>>>>  	list_for_each_entry(a, &buffer->attachments, list) {
>>>
>>> When no devices are attached then buffer->attachments is empty and the
>>> below does not run, so if I understand this patch correctly then what
>>> you are protecting against is CPU access in the window after
>>> dma_buf_attach but before dma_buf_map.
>>>
>>
>> Yes
>>
>>> This is the kind of thing that again makes me think a couple more
>>> ordering requirements on DMA-BUF ops are needed. DMA-BUFs do not require
>>> the backing memory to be allocated until map time, this is why the
>>> dma_address field would still be null as you note in the commit message.
>>> So why should the CPU be performing accesses on a buffer that is not
>>> actually backed yet?
>>>
>>> I can think of two solutions:
>>>
>>> 1) Only allow CPU access (mmap, kmap, {begin,end}_cpu_access) while at
>>> least one device is mapped.
>>>
>>
>> Would be quite limiting to clients.
>>

I can agree with that, option two seems more reasonable.

>>> 2) Treat the CPU access request like the a device map request and
>>> trigger the allocation of backing memory just like if a device map had
>>> come in.
>>>
>>
>> Which is, as you mention pretty much what we have now (though the buffer 
>> is allocated even earlier).
>>

It only behaves like it does because the buffer is always allocated. We
still need a way to allocate at map/CPU access time given to Ion heap
exporters.

>>> I know the current Ion heaps (and most other DMA-BUF exporters) all do
>>> the allocation up front so the memory is already there, but DMA-BUF was
>>> designed with late allocation in mind. I have a use-case I'm working on
>>> that finally exercises this DMA-BUF functionality and I would like to
>>> have it export through ION. This patch doesn't prevent that, but seems
>>> like it is endorsing the the idea that buffers always need to be backed,
>>> even before device attach/map is has occurred.
>>>
>>
>> I didn't interpret the DMA-buf contract as requiring the dma-map to be 
>> called in order for a backing store to be provided, I interpreted it as 
>> meaning there could be a backing store before the dma-map but at the 
>> dma-map call the final backing store configuration would be decided 
>> (perhaps involving migrating the memory to the final backing store).
>> I will let the dma-buf experts correct me on that.
>>
>> Limiting userspace clients to not be able to access buffers until after 
>> they are dma-mapped seems unfortuntate to me, dma-mapping usually means a 
>> change of ownership of the memory from the CPU to the device. So generally 
>> while a buffer is dma mapped you have the device access it (though of 
>> course it is supported for CPU to access to the buffer while dma mapped) 
>> and then once the buffer is dma-unmapped the CPU can access it.  This is 
>> how the DMA APIs are frequently used, and the changes above make ION align 
>> more with the way the DMA APIs are used. Basically when the buffer is not 
>> dma-mapped the CPU doesn't need to do any CMOs to access the buffer (and 
>> ION ensures not CMOs are applied) but if the CPU does want to access the 
>> buffer while it is dma mapped then ION ensures that the appropriate CMOs 
>> are applied.
>>
>> It seems like a legitimate uses case to me to allow clients to access the 
>> buffer before (and after) dma-mapping, example post processing of buffers.
>>
>>
>>> Either of the above two solutions would need to target the DMA-BUF
>>> framework,
>>>
>>> Sumit,
>>>
>>> Any comment?
>>>
> 
> In a separate thread Sumit seems to have confirmed that it is not a 
> requirement for exporters to defer the allocation until first dma map.
> 
> https://lore.kernel.org/lkml/CAO_48GEYPW0u6uWkkFgqjmmabLcBm69OD34QihSNGewqz_AqSQ@mail.gmail.com/
> 
> From Sumit:
> """
>> Maybe it should be up to the exporter if early CPU access is allowed?
>>
>> I'm hoping someone with authority over the DMA-BUF framework can clarify
>> original intentions here.
>>
> 
> I suppose dma-buf as a framework can't know or decide what the exporter 
> wants or can do - whether the exporter wants to use it for 'only 
> zero-copy', or do some intelligent things behind the scene, I think should 
> be best left to the exporter.
> """
> 
> So it seems like it is acceptable for ION to continue to support access to 
> the buffer from the CPU before it is DMA mapped.
> 

It sounds like it is to be left to the exporter, which means some heaps
should be allowed to *not* allow such a thing if they chose. More
control needs to be given to Ion heaps to make the framework usable by
more types of heaps.

But that is beyond the scope of this patch..

> I was wondering if there was any additional feedback on this change since 
> it does fix a bug where userspace can cause the system to crash and I 
> think the change also results in a more logical application of CMOs.
> 
> 

I'm not sure I like the direction, but this patch does seem technically
correct at blocking a crash,

Reviewed-by: Andrew F. Davis <afd@ti.com>

>>> Thanks,
>>> Andrew
>>>
>>>> -		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
>>>> -				    direction);
>>>> +		if (a->dma_mapped)
>>>> +			dma_sync_sg_for_cpu(a->dev, a->table->sgl,
>>>> +					    a->table->nents, direction);
>>>>  	}
>>>>  
>>>>  unlock:
>>>> @@ -369,8 +384,9 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>>>>  
>>>>  	mutex_lock(&buffer->lock);
>>>>  	list_for_each_entry(a, &buffer->attachments, list) {
>>>> -		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
>>>> -				       direction);
>>>> +		if (a->dma_mapped)
>>>> +			dma_sync_sg_for_device(a->dev, a->table->sgl,
>>>> +					       a->table->nents, direction);
>>>>  	}
>>>>  	mutex_unlock(&buffer->lock);
>>>>  
>>>>
>>>
>>
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
