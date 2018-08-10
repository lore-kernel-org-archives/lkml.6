Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC5E223F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC5E223F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeHJMSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:18:15 -0400
Received: from foss.arm.com ([217.140.101.70]:35528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:18:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09AAB80D;
        Fri, 10 Aug 2018 02:49:07 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481183F5D4;
        Fri, 10 Aug 2018 02:49:05 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: Optimise attempts to allocate iova from 32bit
 address range
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
References: <20180807085437.15965-1-ganapatrao.kulkarni@cavium.com>
 <318f9118-df78-e78f-1ae2-72a33cbee28e@arm.com>
 <CAKTKpr6HfLtkeertCyfA_vJt2rXi5qFOKKXohLfX1Z9QiK=Uvw@mail.gmail.com>
 <b7472748-8169-7628-11e5-471045cdf1de@arm.com>
 <CAKTKpr79N2VBixzGNZUt7XNav7vw3CtSgUTtTgu6rPQDEjv5NQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f5e38b8b-33e3-33a5-6176-175f6149f561@arm.com>
Date:   Fri, 10 Aug 2018 10:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKTKpr79N2VBixzGNZUt7XNav7vw3CtSgUTtTgu6rPQDEjv5NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/18 10:24, Ganapatrao Kulkarni wrote:
> Hi Robin,
> 
> On Fri, Aug 10, 2018 at 2:13 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2018-08-09 6:49 PM, Ganapatrao Kulkarni wrote:
>>>
>>> Hi Robin,
>>>
>>> On Thu, Aug 9, 2018 at 9:54 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 07/08/18 09:54, Ganapatrao Kulkarni wrote:
>>>>>
>>>>>
>>>>> As an optimisation for PCI devices, there is always first attempt
>>>>> been made to allocate iova from SAC address range. This will lead
>>>>> to unnecessary attempts/function calls, when there are no free ranges
>>>>> available.
>>>>>
>>>>> This patch optimises by adding flag to track previous failed attempts
>>>>> and avoids further attempts until replenish happens.
>>>>
>>>>
>>>>
>>>> Agh, what I overlooked is that this still suffers from the original
>>>> problem,
>>>> wherein a large allocation which fails due to fragmentation then blocks
>>>> all
>>>> subsequent smaller allocations, even if they may have succeeded.
>>>>
>>>> For a minimal change, though, what I think we could do is instead of just
>>>> having a flag, track the size of the last 32-bit allocation which failed.
>>>> If
>>>> we're happy to assume that nobody's likely to mix aligned and unaligned
>>>> allocations within the same domain, then that should be sufficiently
>>>> robust
>>>> whilst being no more complicated than this version, i.e. (modulo thinking
>>>> up
>>>> a better name for it):
>>>
>>>
>>> I agree, it would be better to track size and attempt to allocate for
>>> smaller chunks, if not for bigger one.
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>> ---
>>>>> This patch is based on comments from Robin Murphy <robin.murphy@arm.com>
>>>>> for patch [1]
>>>>>
>>>>> [1] https://lkml.org/lkml/2018/4/19/780
>>>>>
>>>>>     drivers/iommu/iova.c | 11 ++++++++++-
>>>>>     include/linux/iova.h |  1 +
>>>>>     2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>>>> index 83fe262..d97bb5a 100644
>>>>> --- a/drivers/iommu/iova.c
>>>>> +++ b/drivers/iommu/iova.c
>>>>> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
>>>>> long granule,
>>>>>           iovad->granule = granule;
>>>>>           iovad->start_pfn = start_pfn;
>>>>>           iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
>>>>> +       iovad->free_32bit_pfns = true;
>>>>
>>>>
>>>>
>>>>           iovad->max_32bit_free = iovad->dma_32bit_pfn;
>>>>
>>>>>           iovad->flush_cb = NULL;
>>>>>           iovad->fq = NULL;
>>>>>           iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>>>>> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain
>>>>> *iovad, struct iova *free)
>>>>>           cached_iova = rb_entry(iovad->cached32_node, struct iova,
>>>>> node);
>>>>>           if (free->pfn_hi < iovad->dma_32bit_pfn &&
>>>>> -           free->pfn_lo >= cached_iova->pfn_lo)
>>>>> +           free->pfn_lo >= cached_iova->pfn_lo) {
>>>>>                   iovad->cached32_node = rb_next(&free->node);
>>>>> +               iovad->free_32bit_pfns = true;
>>>>
>>>>
>>>>
>>>>                   iovad->max_32bit_free = iovad->dma_32bit_pfn;
>>>
>>>
>>> i think, you intended to say,
>>>     iovad->max_32bit_free += (free->pfn_hi - free->pfn_lo);
>>
>>
>> Nope, that's why I said it needed a better name ;)
>>
>> (I nearly called it last_failed_32bit_alloc_size, but that's a bit much)
> 
> may be we can name it "max32_alloc_size"?
>>
>> The point of this value (whetever it's called) is that at any given time it
>> holds an upper bound on the size of the largest contiguous free area. It
>> doesn't have to be the *smallest* upper bound, which is why we can keep
>> things simple and avoid arithmetic - in realistic use-cases like yours when
>> the allocations are a pretty constant size, this should work out directly
>> equivalent to the boolean, only with values of "size" and "dma_32bit_pfn"
>> instead of 0 and 1, so we don't do any more work than necessary. In the edge
>> cases where allocations are all different sizes, it does mean that we will
>> probably end up performing more failing allocations than if we actually
>> tried to track all of the free space exactly, but I think that's reasonable
>> - just because I want to make sure we handle such cases fairly gracefully,
>> doesn't mean that we need to do extra work on the typical fast path to try
>> and actually optimise for them (which is why I didn't really like the
>> accounting implementation I came up with).
>>
> 
> ok got it, thanks for the explanation.
>>>>
>>>>> +       }
>>>>>           cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>>>>>           if (free->pfn_lo >= cached_iova->pfn_lo)
>>>>> @@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long
>>>>> size,
>>>>>           struct iova *new_iova;
>>>>>           int ret;
>>>>>     +     if (limit_pfn <= iovad->dma_32bit_pfn &&
>>>>> +                       !iovad->free_32bit_pfns)
>>>>
>>>>
>>>>
>>>>                           size >= iovad->max_32bit_free)
>>>>
>>>>> +               return NULL;
>>>>> +
>>>>>           new_iova = alloc_iova_mem();
>>>>>           if (!new_iova)
>>>>>                   return NULL;
>>>>> @@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long
>>>>> size,
>>>>>           if (ret) {
>>>>>                   free_iova_mem(new_iova);
>>>>> +               if (limit_pfn <= iovad->dma_32bit_pfn)
>>>>> +                       iovad->free_32bit_pfns = false;
>>>>
>>>>
>>>>
>>>>                           iovad->max_32bit_free = size;
>>>
>>>
>>> same here, we should decrease available free range after successful
>>> allocation.
>>> iovad->max_32bit_free -= size;
>>
>>
>> Equivalently, the simple assignment is strictly decreasing the upper bound
>> already, since we can only get here if size < max_32bit_free in the first
>> place. One more thing I've realised is that this is all potentially a bit
>> racy as we're outside the lock here, so it might need to be pulled into
>> __alloc_and_insert_iova_range(), something like the rough diff below (name
>> changed again for the sake of it; it also occurs to me that we don't really
>> need to re-check limit_pfn in the failure path either, because even a 64-bit
>> allocation still has to walk down through the 32-bit space in order to fail
>> completely)
>>
>>>>
>>>> What do you think?
>>>
>>>
>>> most likely this should work, i will try this and confirm at the earliest,
>>
>>
>> Thanks for sticking with this.
>>
>> Robin.
>>
>> ----->8-----
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 83fe2621effe..7cbc58885877 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -190,6 +190,10 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>
>>          /* Walk the tree backwards */
>>          spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>> +       if (limit_pfn <= iovad->dma_32bit_pfn &&
>> +           size >= iovad->failed_alloc_size)
>> +               goto out_err;
>> +
>>          curr = __get_cached_rbnode(iovad, limit_pfn);
>>          curr_iova = rb_entry(curr, struct iova, node);
>>          do {
>> @@ -200,10 +204,8 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>                  curr_iova = rb_entry(curr, struct iova, node);
>>          } while (curr && new_pfn <= curr_iova->pfn_hi);
>>
>> -       if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>> -               spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> -               return -ENOMEM;
>> -       }
>> +       if (limit_pfn < size || new_pfn < iovad->start_pfn)
>> +               goto out_err;
>>
>>          /* pfn_lo will point to size aligned address if size_aligned is set
>> */
>>          new->pfn_lo = new_pfn;
>> @@ -214,9 +216,12 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>          __cached_rbnode_insert_update(iovad, new);
>>
>>          spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> -
>> -
>>          return 0;
>> +
>> +out_err:
>> +       iovad->failed_alloc_size = size;
>> +       spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>> +       return -ENOMEM;
>>   }
>>
>>   static struct kmem_cache *iova_cache;
> 
> 
> cant we bump up the size when ranges are freed? otherwise we never be
> able to attempt in 32bit range, even there is enough replenish.

Oh, I just left that part out of the example for clarity, since it's 
already under the lock - I didn't mean to suggest that that we should 
remove it!

(I was just too lazy to actually apply your patch to generate a real 
diff on top of it)

Robin.

> 
> 
> @@ -139,8 +139,10 @@ __cached_rbnode_delete_update(struct iova_domain
> *iovad, struct iova *free)
> 
>          cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>          if (free->pfn_hi < iovad->dma_32bit_pfn &&
> -           free->pfn_lo >= cached_iova->pfn_lo)
> +           free->pfn_lo >= cached_iova->pfn_lo) {
>                  iovad->cached32_node = rb_next(&free->node);
> +               iovad->failed_alloc_size += (free->pfn_hi - free->pfn_lo);
> +       }
> 
