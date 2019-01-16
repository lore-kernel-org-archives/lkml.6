Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5252220651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QMSpQLRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbfAPRFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:05:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbfAPRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:05:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GH5LxG022561;
        Wed, 16 Jan 2019 11:05:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547658321;
        bh=Al0Urcp4O7KPspzsdtP37aPzd5IjNr1giteeheotbCE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QMSpQLRMSmOMhY4ilLFbtEBVR6M97a6X3PbjKxlrFoGEoWMYJb/DHtVz2m+7Ws+Da
         8GGFsPdczRf2Q/vvj3D2ZU+uV5529zpuI6XYRPOlRsx2SpIx5cs+4z2WZQClVuVcKR
         qxgJh7K1NdaivRo7jx6B9C/rCzoDvgIB+vLtp87U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GH5L32123334
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 11:05:21 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 11:05:20 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 11:05:20 -0600
Received: from [172.22.93.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GH5KlG021402;
        Wed, 16 Jan 2019 11:05:20 -0600
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-14-afd@ti.com>
 <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
 <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <f53987d5-b7c1-61f4-de44-3d7b4a3c68fe@ti.com>
 <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <4a5d4147-765d-711f-af98-9022d0253b3b@ti.com>
Date:   Wed, 16 Jan 2019 11:05:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116151946.66vc6ibbivijdzvd@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 9:19 AM, Brian Starkey wrote:
> Hi :-)
> 
> On Tue, Jan 15, 2019 at 12:40:16PM -0600, Andrew F. Davis wrote:
>> On 1/15/19 12:38 PM, Andrew F. Davis wrote:
>>> On 1/15/19 11:45 AM, Liam Mark wrote:
>>>> On Tue, 15 Jan 2019, Andrew F. Davis wrote:
>>>>
>>>>> On 1/14/19 11:13 AM, Liam Mark wrote:
>>>>>> On Fri, 11 Jan 2019, Andrew F. Davis wrote:
>>>>>>
>>>>>>> Buffers may not be mapped from the CPU so skip cache maintenance here.
>>>>>>> Accesses from the CPU to a cached heap should be bracketed with
>>>>>>> {begin,end}_cpu_access calls so maintenance should not be needed anyway.
>>>>>>>
>>>>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>>>>>> ---
>>>>>>>  drivers/staging/android/ion/ion.c | 7 ++++---
>>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
>>>>>>> index 14e48f6eb734..09cb5a8e2b09 100644
>>>>>>> --- a/drivers/staging/android/ion/ion.c
>>>>>>> +++ b/drivers/staging/android/ion/ion.c
>>>>>>> @@ -261,8 +261,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
>>>>>>>  
>>>>>>>  	table = a->table;
>>>>>>>  
>>>>>>> -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
>>>>>>> -			direction))
>>>>>>> +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
>>>>>>> +			      direction, DMA_ATTR_SKIP_CPU_SYNC))
>>>>>>
>>>>>> Unfortunately I don't think you can do this for a couple reasons.
>>>>>> You can't rely on {begin,end}_cpu_access calls to do cache maintenance.
>>>>>> If the calls to {begin,end}_cpu_access were made before the call to 
>>>>>> dma_buf_attach then there won't have been a device attached so the calls 
>>>>>> to {begin,end}_cpu_access won't have done any cache maintenance.
>>>>>>
>>>>>
>>>>> That should be okay though, if you have no attachments (or all
>>>>> attachments are IO-coherent) then there is no need for cache
>>>>> maintenance. Unless you mean a sequence where a non-io-coherent device
>>>>> is attached later after data has already been written. Does that
>>>>> sequence need supporting? 
>>>>
>>>> Yes, but also I think there are cases where CPU access can happen before 
>>>> in Android, but I will focus on later for now.
>>>>
>>>>> DMA-BUF doesn't have to allocate the backing
>>>>> memory until map_dma_buf() time, and that should only happen after all
>>>>> the devices have attached so it can know where to put the buffer. So we
>>>>> shouldn't expect any CPU access to buffers before all the devices are
>>>>> attached and mapped, right?
>>>>>
>>>>
>>>> Here is an example where CPU access can happen later in Android.
>>>>
>>>> Camera device records video -> software post processing -> video device 
>>>> (who does compression of raw data) and writes to a file
>>>>
>>>> In this example assume the buffer is cached and the devices are not 
>>>> IO-coherent (quite common).
>>>>
>>>
>>> This is the start of the problem, having cached mappings of memory that
>>> is also being accessed non-coherently is going to cause issues one way
>>> or another. On top of the speculative cache fills that have to be
>>> constantly fought back against with CMOs like below; some coherent
>>> interconnects behave badly when you mix coherent and non-coherent access
>>> (snoop filters get messed up).
>>>
>>> The solution is to either always have the addresses marked non-coherent
>>> (like device memory, no-map carveouts), or if you really want to use
>>> regular system memory allocated at runtime, then all cached mappings of
>>> it need to be dropped, even the kernel logical address (area as painful
>>> as that would be).
> 
> Ouch :-( I wasn't aware about these potential interconnect issues. How
> "real" is that? It seems that we aren't really hitting that today on
> real devices.
> 

Sadly there is at least one real device like this now (TI AM654). We
spent some time working with the ARM interconnect spec designers to see
if this was allowed behavior, final conclusion was mixing coherent and
non-coherent accesses is never a good idea.. So we have been working to
try to minimize any cases of mixed attributes [0], if a region is
coherent then everyone in the system needs to treat it as such and
vice-versa, even clever CMO that work on other systems wont save you
here. :(

[0] https://github.com/ARM-software/arm-trusted-firmware/pull/1553


>>>
>>>> ION buffer is allocated.
>>>>
>>>> //Camera device records video
>>>> dma_buf_attach
>>>> dma_map_attachment (buffer needs to be cleaned)
>>>
>>> Why does the buffer need to be cleaned here? I just got through reading
>>> the thread linked by Laura in the other reply. I do like +Brian's
>>
>> Actually +Brian this time :)
>>
>>> suggestion of tracking if the buffer has had CPU access since the last
>>> time and only flushing the cache if it has. As unmapped heaps never get
>>> CPU mapped this would never be the case for unmapped heaps, it solves my
>>> problem.
>>>
>>>> [camera device writes to buffer]
>>>> dma_buf_unmap_attachment (buffer needs to be invalidated)
>>>
>>> It doesn't know there will be any further CPU access, it could get freed
>>> after this for all we know, the invalidate can be saved until the CPU
>>> requests access again.
> 
> We don't have any API to allow the invalidate to happen on CPU access
> if all devices already detached. We need a struct device pointer to
> give to the DMA API, otherwise on arm64 there'll be no invalidate.
> 
> I had a chat with a few people internally after the previous
> discussion with Liam. One suggestion was to use
> DMA_ATTR_SKIP_CPU_SYNC in unmap_dma_buf, but only if there's at least
> one other device attached (guarantees that we can do an invalidate in
> the future if begin_cpu_access is called). If the last device
> detaches, do a sync then.
> 
> Conversely, in map_dma_buf, we would track if there was any CPU access
> and use/skip the sync appropriately.
> 

Now that I think this all through I agree this patch is probably wrong.
The real fix needs to be better handling in the dma_map_sg() to deal
with the case of the memory not being mapped (what I'm dealing with for
unmapped heaps), and for cases when the memory in question is not cached
(Liam's issue I think). For both these cases the dma_map_sg() does the
wrong thing.

> I did start poking the code to check out how that would look, but then
> Christmas happened and I'm still catching back up.
> 
>>>
>>>> dma_buf_detach  (device cannot stay attached because it is being sent down 
>>>> the pipeline and Camera doesn't know the end of the use case)
>>>>
>>>
>>> This seems like a broken use-case, I understand the desire to keep
>>> everything as modular as possible and separate the steps, but at this
>>> point no one owns this buffers backing memory, not the CPU or any
>>> device. I would go as far as to say DMA-BUF should be free now to
>>> de-allocate the backing storage if it wants, that way it could get ready
>>> for the next attachment, which may change the required backing memory
>>> completely.
>>>
>>> All devices should attach before the first mapping, and only let go
>>> after the task is complete, otherwise this buffers data needs copied off
>>> to a different location or the CPU needs to take ownership in-between.
>>>
> 
> Yeah.. that's certainly the theory. Are there any DMA-BUF
> implementations which actually do that? I hear it quoted a lot,
> because that's what the docs say - but if the reality doesn't match
> it, maybe we should change the docs.
> 

Do you mean on the userspace side? I'm not sure, seems like Android
might be doing this wrong from what I can gather. From kernel side if
you mean the "de-allocate the backing storage", we will have some cases
like this soon, so I want to make sure userspace is not abusing DMA-BUF
in ways not specified in the documentation. Changing the docs to force
the backing memory to always be allocated breaks the central goal in
having attach/map in DMA-BUF separate.

>>>> //buffer is send down the pipeline
>>>>
>>>> // Usersapce software post processing occurs
>>>> mmap buffer
>>>
>>> Perhaps the invalidate should happen here in mmap.
>>>
>>>> DMA_BUF_IOCTL_SYNC IOCT with flags DMA_BUF_SYNC_START // No CMO since no 
>>>> devices attached to buffer
>>>
>>> And that should be okay, mmap does the sync, and if no devices are
>>> attached nothing could have changed the underlying memory in the
>>> mean-time, DMA_BUF_SYNC_START can safely be a no-op as they are.
> 
> Yeah, that's true - so long as you did an invalidate in unmap_dma_buf.
> Liam was saying that it's too painful for them to do that every time a
> device unmaps - when in many cases (device->device, no CPU) it's not
> needed.

Invalidates are painless, at least compared to a real cache flush, just
set the invalid bit vs actually writing out lines. I thought the issue
was on the map side.

> 
>>>
>>>> [CPU reads/writes to the buffer]
>>>> DMA_BUF_IOCTL_SYNC IOCTL with flags DMA_BUF_SYNC_END // No CMO since no 
>>>> devices attached to buffer
>>>> munmap buffer
>>>>
>>>> //buffer is send down the pipeline
>>>> // Buffer is send to video device (who does compression of raw data) and 
>>>> writes to a file
>>>> dma_buf_attach
>>>> dma_map_attachment (buffer needs to be cleaned)
>>>> [video device writes to buffer]
>>>> dma_buf_unmap_attachment 
>>>> dma_buf_detach  (device cannot stay attached because it is being sent down 
>>>> the pipeline and Video doesn't know the end of the use case)
>>>>
>>>>
>>>>
>>>>>> Also ION no longer provides DMA ready memory, so if you are not doing CPU 
>>>>>> access then there is no requirement (that I am aware of) for you to call 
>>>>>> {begin,end}_cpu_access before passing the buffer to the device and if this 
>>>>>> buffer is cached and your device is not IO-coherent then the cache maintenance
>>>>>> in ion_map_dma_buf and ion_unmap_dma_buf is required.
>>>>>>
>>>>>
>>>>> If I am not doing any CPU access then why do I need CPU cache
>>>>> maintenance on the buffer?
>>>>>
>>>>
>>>> Because ION no longer provides DMA ready memory.
>>>> Take the above example.
>>>>
>>>> ION allocates memory from buddy allocator and requests zeroing.
>>>> Zeros are written to the cache.
>>>>
>>>> You pass the buffer to the camera device which is not IO-coherent.
>>>> The camera devices writes directly to the buffer in DDR.
>>>> Since you didn't clean the buffer a dirty cache line (one of the zeros) is 
>>>> evicted from the cache, this zero overwrites data the camera device has 
>>>> written which corrupts your data.
>>>>
>>>
>>> The zeroing *is* a CPU access, therefor it should handle the needed CMO
>>> for CPU access at the time of zeroing.
>>>
> 
> Actually that should be at the point of the first non-coherent device
> mapping the buffer right? No point in doing CMO if the future accesses
> are coherent.

I see your point, as long as the zeroing is guaranteed to be the first
access to this buffer then it should be safe.

Andrew

> 
> Cheers,
> -Brian
> 
>>> Andrew
>>>
>>>> Liam
>>>>
>>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>>> a Linux Foundation Collaborative Project
>>>>
