Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119620866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfAOTL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:11:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39036 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbfAOTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:11:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so4266138qtj.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k31KMB4hEdsJcQ/zEseqvir23EsTqybC8SJ5TQQ0oR0=;
        b=kBKUTSgHV7h6LHjQruT8gsQYpK+T0itHk7DunULLwQybU7err+lLqGBScts3l3pgl4
         pzS/jEJxp93IaicwENsChUpGBWEHdv0dimG+TZY9B6Zm7tEw85C09S+UZ2yiIFuyXw39
         B1txNcLJBvC2ziRE8fWCTatzw+5km/oaf98b4WdLI48DgarXZ9e9F0bQ/UETw8SMalsu
         RlRmXcwW9HY+oxHE4ASd8JTHRXhr0eRkV47fqTpUL3dUKYp4Isoua0QkOi/F4OFVuEhc
         cykGdcdI2aU5jd/tqozhNAjgXgnwklJdN1qhK/WM+quTVyjEJLxaBFgjYHJWfqx8a01f
         fymw==
X-Gm-Message-State: AJcUukdDLfWw7jPq+96sYHzej4Ug1rDxE1tupxw1QoGBBt6QYOpwBVBK
        VG/zo6tZAThXjAVl660LOn1RmqJfOqg=
X-Google-Smtp-Source: ALg8bN6PG8WviWvu1YBwx0Jb7P9XuJfqLQMzhS9LTlI3gklRUi7h3tPDXWti85AwpNYKHorETIiQ8w==
X-Received: by 2002:a0c:ec92:: with SMTP id u18mr4196447qvo.168.1547579515250;
        Tue, 15 Jan 2019 11:11:55 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id y4sm55998128qtc.47.2019.01.15.11.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 11:11:54 -0800 (PST)
Subject: Re: [PATCH 14/14] staging: android: ion: Add UNMAPPED heap type and
 helper
From:   Laura Abbott <labbott@redhat.com>
To:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-15-afd@ti.com>
 <bd3c15f2-2635-588e-80b4-18e8e44d27b3@redhat.com>
 <ee3bb691-8c9b-457c-5da3-522a4baff140@ti.com>
 <5718cc6c-1082-fec8-5c97-3f52bcfd98d9@redhat.com>
Message-ID: <59d7f837-acb7-8ee0-ef47-f38f0c798d26@redhat.com>
Date:   Tue, 15 Jan 2019 11:11:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5718cc6c-1082-fec8-5c97-3f52bcfd98d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 10:43 AM, Laura Abbott wrote:
> On 1/15/19 7:58 AM, Andrew F. Davis wrote:
>> On 1/14/19 8:32 PM, Laura Abbott wrote:
>>> On 1/11/19 10:05 AM, Andrew F. Davis wrote:
>>>> The "unmapped" heap is very similar to the carveout heap except
>>>> the backing memory is presumed to be unmappable by the host, in
>>>> my specific case due to firewalls. This memory can still be
>>>> allocated from and used by devices that do have access to the
>>>> backing memory.
>>>>
>>>> Based originally on the secure/unmapped heap from Linaro for
>>>> the OP-TEE SDP implementation, this was re-written to match
>>>> the carveout heap helper code.
>>>>
>>>> Suggested-by: Etienne Carriere <etienne.carriere@linaro.org>
>>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>>> ---
>>>>    drivers/staging/android/ion/Kconfig           |  10 ++
>>>>    drivers/staging/android/ion/Makefile          |   1 +
>>>>    drivers/staging/android/ion/ion.h             |  16 +++
>>>>    .../staging/android/ion/ion_unmapped_heap.c   | 123 ++++++++++++++++++
>>>>    drivers/staging/android/uapi/ion.h            |   3 +
>>>>    5 files changed, 153 insertions(+)
>>>>    create mode 100644 drivers/staging/android/ion/ion_unmapped_heap.c
>>>>
>>>> diff --git a/drivers/staging/android/ion/Kconfig
>>>> b/drivers/staging/android/ion/Kconfig
>>>> index 0fdda6f62953..a117b8b91b14 100644
>>>> --- a/drivers/staging/android/ion/Kconfig
>>>> +++ b/drivers/staging/android/ion/Kconfig
>>>> @@ -42,3 +42,13 @@ config ION_CMA_HEAP
>>>>          Choose this option to enable CMA heaps with Ion. This heap is
>>>> backed
>>>>          by the Contiguous Memory Allocator (CMA). If your system has
>>>> these
>>>>          regions, you should say Y here.
>>>> +
>>>> +config ION_UNMAPPED_HEAP
>>>> +    bool "ION unmapped heap support"
>>>> +    depends on ION
>>>> +    help
>>>> +      Choose this option to enable UNMAPPED heaps with Ion. This heap is
>>>> +      backed in specific memory pools, carveout from the Linux memory.
>>>> +      Unlike carveout heaps these are assumed to be not mappable by
>>>> +      kernel or user-space.
>>>> +      Unless you know your system has these regions, you should say N
>>>> here.
>>>> diff --git a/drivers/staging/android/ion/Makefile
>>>> b/drivers/staging/android/ion/Makefile
>>>> index 17f3a7569e3d..c71a1f3de581 100644
>>>> --- a/drivers/staging/android/ion/Makefile
>>>> +++ b/drivers/staging/android/ion/Makefile
>>>> @@ -4,3 +4,4 @@ obj-$(CONFIG_ION_SYSTEM_HEAP) += ion_system_heap.o
>>>> ion_page_pool.o
>>>>    obj-$(CONFIG_ION_CARVEOUT_HEAP) += ion_carveout_heap.o
>>>>    obj-$(CONFIG_ION_CHUNK_HEAP) += ion_chunk_heap.o
>>>>    obj-$(CONFIG_ION_CMA_HEAP) += ion_cma_heap.o
>>>> +obj-$(CONFIG_ION_UNMAPPED_HEAP) += ion_unmapped_heap.o
>>>> diff --git a/drivers/staging/android/ion/ion.h
>>>> b/drivers/staging/android/ion/ion.h
>>>> index 97b2876b165a..ce74332018ba 100644
>>>> --- a/drivers/staging/android/ion/ion.h
>>>> +++ b/drivers/staging/android/ion/ion.h
>>>> @@ -341,4 +341,20 @@ static inline struct ion_heap
>>>> *ion_chunk_heap_create(phys_addr_t base, size_t si
>>>>    }
>>>>    #endif
>>>>    +#ifdef CONFIG_ION_UNMAPPED_HEAP
>>>> +/**
>>>> + * ion_unmapped_heap_create
>>>> + * @base:        base address of carveout memory
>>>> + * @size:        size of carveout memory region
>>>> + *
>>>> + * Creates an unmapped ion_heap using the passed in data
>>>> + */
>>>> +struct ion_heap *ion_unmapped_heap_create(phys_addr_t base, size_t
>>>> size);
>>>> +#else
>>>> +struct ion_heap *ion_unmapped_heap_create(phys_addr_t base, size_t size)
>>>> +{
>>>> +    return ERR_PTR(-ENODEV);
>>>> +}
>>>> +#endif
>>>> +
>>>>    #endif /* _ION_H */
>>>> diff --git a/drivers/staging/android/ion/ion_unmapped_heap.c
>>>> b/drivers/staging/android/ion/ion_unmapped_heap.c
>>>> new file mode 100644
>>>> index 000000000000..7602b659c2ec
>>>> --- /dev/null
>>>> +++ b/drivers/staging/android/ion/ion_unmapped_heap.c
>>>> @@ -0,0 +1,123 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * ION Memory Allocator unmapped heap helper
>>>> + *
>>>> + * Copyright (C) 2015-2016 Texas Instruments Incorporated -
>>>> http://www.ti.com/
>>>> + *    Andrew F. Davis <afd@ti.com>
>>>> + *
>>>> + * ION "unmapped" heaps are physical memory heaps not by default
>>>> mapped into
>>>> + * a virtual address space. The buffer owner can explicitly request
>>>> kernel
>>>> + * space mappings but the underlying memory may still not be
>>>> accessible for
>>>> + * various reasons, such as firewalls.
>>>> + */
>>>> +
>>>> +#include <linux/err.h>
>>>> +#include <linux/genalloc.h>
>>>> +#include <linux/scatterlist.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include "ion.h"
>>>> +
>>>> +#define ION_UNMAPPED_ALLOCATE_FAIL -1
>>>> +
>>>> +struct ion_unmapped_heap {
>>>> +    struct ion_heap heap;
>>>> +    struct gen_pool *pool;
>>>> +};
>>>> +
>>>> +static phys_addr_t ion_unmapped_allocate(struct ion_heap *heap,
>>>> +                     unsigned long size)
>>>> +{
>>>> +    struct ion_unmapped_heap *unmapped_heap =
>>>> +        container_of(heap, struct ion_unmapped_heap, heap);
>>>> +    unsigned long offset;
>>>> +
>>>> +    offset = gen_pool_alloc(unmapped_heap->pool, size);
>>>> +    if (!offset)
>>>> +        return ION_UNMAPPED_ALLOCATE_FAIL;
>>>> +
>>>> +    return offset;
>>>> +}
>>>> +
>>>> +static void ion_unmapped_free(struct ion_heap *heap, phys_addr_t addr,
>>>> +                  unsigned long size)
>>>> +{
>>>> +    struct ion_unmapped_heap *unmapped_heap =
>>>> +        container_of(heap, struct ion_unmapped_heap, heap);
>>>> +
>>>> +    gen_pool_free(unmapped_heap->pool, addr, size);
>>>> +}
>>>> +
>>>> +static int ion_unmapped_heap_allocate(struct ion_heap *heap,
>>>> +                      struct ion_buffer *buffer,
>>>> +                      unsigned long size,
>>>> +                      unsigned long flags)
>>>> +{
>>>> +    struct sg_table *table;
>>>> +    phys_addr_t paddr;
>>>> +    int ret;
>>>> +
>>>> +    table = kmalloc(sizeof(*table), GFP_KERNEL);
>>>> +    if (!table)
>>>> +        return -ENOMEM;
>>>> +    ret = sg_alloc_table(table, 1, GFP_KERNEL);
>>>> +    if (ret)
>>>> +        goto err_free;
>>>> +
>>>> +    paddr = ion_unmapped_allocate(heap, size);
>>>> +    if (paddr == ION_UNMAPPED_ALLOCATE_FAIL) {
>>>> +        ret = -ENOMEM;
>>>> +        goto err_free_table;
>>>> +    }
>>>> +
>>>> +    sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(paddr)), size, 0);
>>>> +    buffer->sg_table = table;
>>>> +
>>>
>>>
>>> If this memory is actually unmapped this is not going to work because
>>> the struct page will not be valid.
>>>
>>
>> If it will never get mapped then it doesn't need a valid struct page as
>> far as I can tell. We only use it as a marker to where the start of
>> backing memory is, and that is calculated based on the struct page
>> pointer address, not its contents.
>>
> 
> You can't rely on pfn_to_page returning a valid page pointer if the
> pfn doesn't point to reserved memory. Even if you aren't relying
> on the contents, that's no guarantee you can use that to to get
> the valid pfn back. You can get away with that sometimes but it's
> not correct to rely on it all the time.
> 

I found https://lore.kernel.org/lkml/20190111181731.11782-1-hch@lst.de/T/#u
which I think is closer to what we might want to be looking at.

>>>> +    return 0;
>>>> +
>>>> +err_free_table:
>>>> +    sg_free_table(table);
>>>> +err_free:
>>>> +    kfree(table);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static void ion_unmapped_heap_free(struct ion_buffer *buffer)
>>>> +{
>>>> +    struct ion_heap *heap = buffer->heap;
>>>> +    struct sg_table *table = buffer->sg_table;
>>>> +    struct page *page = sg_page(table->sgl);
>>>> +    phys_addr_t paddr = PFN_PHYS(page_to_pfn(page));
>>>> +
>>>> +    ion_unmapped_free(heap, paddr, buffer->size);
>>>> +    sg_free_table(buffer->sg_table);
>>>> +    kfree(buffer->sg_table);
>>>> +}
>>>> +
>>>> +static struct ion_heap_ops unmapped_heap_ops = {
>>>> +    .allocate = ion_unmapped_heap_allocate,
>>>> +    .free = ion_unmapped_heap_free,
>>>> +    /* no .map_user, user mapping of unmapped heaps not allowed */
>>>> +    .map_kernel = ion_heap_map_kernel,
>>>> +    .unmap_kernel = ion_heap_unmap_kernel,
>>>> +};
>>>> +
>>>> +struct ion_heap *ion_unmapped_heap_create(phys_addr_t base, size_t size)
>>>> +{
>>>> +    struct ion_unmapped_heap *unmapped_heap;
>>>> +
>>>> +    unmapped_heap = kzalloc(sizeof(*unmapped_heap), GFP_KERNEL);
>>>> +    if (!unmapped_heap)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +
>>>> +    unmapped_heap->pool = gen_pool_create(PAGE_SHIFT, -1);
>>>> +    if (!unmapped_heap->pool) {
>>>> +        kfree(unmapped_heap);
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +    }
>>>> +    gen_pool_add(unmapped_heap->pool, base, size, -1);
>>>> +    unmapped_heap->heap.ops = &unmapped_heap_ops;
>>>> +    unmapped_heap->heap.type = ION_HEAP_TYPE_UNMAPPED;
>>>> +
>>>> +    return &unmapped_heap->heap;
>>>> +}
>>>> diff --git a/drivers/staging/android/uapi/ion.h
>>>> b/drivers/staging/android/uapi/ion.h
>>>> index 5d7009884c13..d5f98bc5f340 100644
>>>> --- a/drivers/staging/android/uapi/ion.h
>>>> +++ b/drivers/staging/android/uapi/ion.h
>>>> @@ -19,6 +19,8 @@
>>>>     *                 carveout heap, allocations are physically
>>>>     *                 contiguous
>>>>     * @ION_HEAP_TYPE_DMA:         memory allocated via DMA API
>>>> + * @ION_HEAP_TYPE_UNMAPPED:     memory not intended to be mapped into
>>>> the
>>>> + *                 linux address space unless for debug cases
>>>>     * @ION_NUM_HEAPS:         helper for iterating over heaps, a bit mask
>>>>     *                 is used to identify the heaps, so only 32
>>>>     *                 total heap types are supported
>>>> @@ -29,6 +31,7 @@ enum ion_heap_type {
>>>>        ION_HEAP_TYPE_CARVEOUT,
>>>>        ION_HEAP_TYPE_CHUNK,
>>>>        ION_HEAP_TYPE_DMA,
>>>> +    ION_HEAP_TYPE_UNMAPPED,
>>>>        ION_HEAP_TYPE_CUSTOM, /*
>>>>                       * must be last so device specific heaps always
>>>>                       * are at the end of this enum
>>>>
>>>
>>> Overall this seems way too similar to the carveout heap
>>> to justify adding another heap type. It also still missing
>>> the part of where exactly you call ion_unmapped_heap_create.
>>> Figuring that out is one of the blocking items for moving
>>> Ion out of staging.
>>>
>>
>> I agree with this being almost a 1:1 copy of the carveout heap, I'm just
>> not sure of a good way to do this without a new heap type. Adding flags
>> to the existing carveout type seem a bit messy. Plus then those flags
>> should be valid for other heap types, gets complicated quickly..
>>
>> I'll reply to the second part in your other top level response.
>>
>> Andrew
>>
>>> Thanks,
>>> Laura
> 

