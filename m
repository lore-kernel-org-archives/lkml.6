Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeD3LpQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:45:16 -0400
Received: from foss.arm.com ([217.140.101.70]:60606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753810AbeD3LmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:42:10 -0400
Subject: Re: [PATCH] drm/vmwgfx: Fix scatterlist unmapping
To: Thomas Hellstrom <thellstrom@vmware.com>,
        linux-graphics-maintainer@vmware.com, syeh@vmware.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <3a08f0343cb4e7a767601c59a381884121f9b751.1523632202.git.robin.murphy@arm.com>
 <85d48f28-5df7-8c7e-d175-ce651838db53@vmware.com>
 <8850b346-453f-e555-550d-7079b4f9d00d@arm.com>
 <9c6981bc-5b86-29d6-d58e-c8988031c706@vmware.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b2321c39-bda8-0ba9-d55d-5400aeefa5be@arm.com>
Date: Mon, 30 Apr 2018 12:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9c6981bc-5b86-29d6-d58e-c8988031c706@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/18 18:39, Thomas Hellstrom wrote:
> On 04/27/2018 06:56 PM, Robin Murphy wrote:
>> Hi Thomas,
>>
>> On 25/04/18 14:21, Thomas Hellstrom wrote:
>>> Hi, Robin,
>>>
>>> Thanks for the patch. It was some time since I put together that 
>>> code, but I remember hitting something similar to
>>>
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.linuxquestions.org_questions_linux-2Dkernel-2D70_-2527nents-2527-2Dargument-2Dof-2Ddma-5Funmap-5Fsg-2D4175621964_&d=DwIDaQ&c=uilaK90D4TOVoH58JNXRgQ&r=wnSlgOCqfpNS4d02vP68_E9q2BNMCwfD2OZ_6dCFVQQ&m=UACKfhMfw9wac0BNUWXnAiivjaBgY_jAEupre0zXoOQ&s=8NQNd-XBCViYHJH4fHk-RluFYd9CDjbYzXl_BWhC0ig&e= 
>>>
>>>
>>> Even if it's clear from the documentation that orig_nents should be 
>>> used.
>>
>> Hmmm, it's odd that you would see issues - it's always been something 
>> that CONFIG_DMA_API_DEBUG would have screamed about, and as far as I'm 
>> aware for x86, nents and orig_nents should always end up equal anyway. 
>> I would definitely be interested to see the specific fault details if 
>> it can be reproduced. I suppose one possibility is that there's some 
>> path where you inadvertently unmap something which was never mapped, 
>> but passing nents=0 means you manage to get away with it without the 
>> DMA API backend trying to interpret any bogus DMA addresses/lengths.
>>
>> FWIW, the rationale is that sync_sg/unmap_sg operate on sg->page 
>> (which can always be translated back to a meaningful CPU address for 
>> cache/write buffer maintenance), not sg->dma_address (which sometimes 
>> cannot), therefore passing a truncated list will have the effect of 
>> just not syncing the tail end of the buffer, which is clearly bad.
>>
>> Robin.
>>
> I agree. I browsed the current software- and hardware iommu dma backends 
> and all of them seem to set nents == orig_nents.
> Still, according to the docs sg_map() is free to erase any sg->page - 
> related information and given that, it would be more natural if all 
> operations after sg_map() would operate on sg->dma_address.

TBH I've never really understood that aspect of the API - I've yet to 
come across an implementation which does actually destroy the non-DMA 
parts of the scatterlist, and I can't think of a good reason why one 
would ever need or want to.

> I mean if 
> sg_map would truncate the sg list length to 1, and erase all other 
> information (which it clearly is free to do according to the docs), it 
> would be pretty meaningless to supply orig_nents for the unmapping 
> operation?

Sure, but not all implementations can work that way - a bounce-buffering 
scheme, for example, could quite feasibly merge pages in the bounce 
buffer and return a single DMA segment, but definitely needs all the 
original page info in unmap_sg in order to be able to copy new DMA data 
back to the right places. A non-coherent IOMMU implementation *could* 
walk the IOMMU page tables for every page worth of the DMA segment to 
get back to the relevant CPU addresses to perform cache maintenance 
with, but that's horrendously inefficient compared to just using the 
original CPU view directly (notably, they *do* have to do such a table 
walk for unmap_page, but only once since a single mapping is always 
physically contiguous by definition).

Robin.

> 
> /Thomas
>>> On 04/13/2018 05:14 PM, Robin Murphy wrote:
>>>> dma_unmap_sg() should be called with the same number of entries
>>>> originally passed to dma_map_sg(), not the number it returned, which 
>>>> may
>>>> be fewer. Admittedly this driver probably never runs on non-coherent
>>>> architectures where getting that wrong could lead to data loss, but 
>>>> it's
>>>> always good to be correct, and it's trivially easy to fix by just
>>>> restoring the SG table state before the call instead of afterwards.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>
>>>> Found by inspection while poking around TTM users.
>>>>
>>>>   drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c 
>>>> b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
>>>> index 21111fd091f9..971223d39469 100644
>>>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
>>>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
>>>> @@ -369,9 +369,9 @@ static void vmw_ttm_unmap_from_dma(struct 
>>>> vmw_ttm_tt *vmw_tt)
>>>>   {
>>>>       struct device *dev = vmw_tt->dev_priv->dev->dev;
>>>> +    vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>>>>       dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
>>>>           DMA_BIDIRECTIONAL);
>>>> -    vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
>>>>   }
>>>>   /**
>>>
>>>
> 
