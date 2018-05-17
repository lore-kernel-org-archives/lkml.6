Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeEQUFu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:05:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeEQUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:05:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4535602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] mm/dmapool: localize page allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
References: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
 <20180517181815.GC26718@bombadil.infradead.org>
 <9844a638-bc4e-46bd-133e-0c82a3e9d6ea@codeaurora.org>
 <20180517194612.GG26718@bombadil.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d49e594a-c18a-160f-ca4c-91520ff3b293@codeaurora.org>
Date: Thu, 17 May 2018 16:05:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517194612.GG26718@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2018 3:46 PM, Matthew Wilcox wrote:
>> Remember that the CPU core that is running this driver is most probably on
>> the same NUMA node as the device itself.
> Umm ... says who?  If my process is running on NUMA node 5 and I submit
> an I/O, it should be allocating from a pool on node 5, not from a pool
> on whichever node the device is attached to.

OK, let's do an exercise. Maybe, I'm missing something in the big picture.

If a user process is running at node 5, it submits some work to the hardware
via block layer that is eventually invoked by syscall. 

Whatever buffer process is using, it gets copied into the kernel space as
it is crossing a userspace/kernel space boundary.

Block layer packages a block request with the kernel pointers and makes a
request to the NVMe driver for consumption.

Last time I checked, dma_alloc_coherent() API uses the locality information
from the device not from the CPU for allocation.

While the metadata for dma_pool is pointing to the currently running CPU core,
the DMA buffer itself is created using the device node itself today without
my patch.

I would think that you actually want to run the process at the same NUMA node
as the CPU and device itself for performance reasons. Otherwise, performance
expectations should be low. 

Even if user says please keep my process to a particular NUMA node,
we keep pointing to the memory on the other node today. 

I don't know what is so special about memory on the default node. IMO, all memory
allocations used by a driver need to follow the device. 

I wish I could do this in kmalloc(). devm_kmalloc() follows the device as another
example not CPU.

With these assumptions, even though user said please use the NUMA node from the
device, we still keep pointing to the default domain for pointers.

Isn't this wrong?

> 
> If it actually makes a performance difference, then NVMe should allocate
> one pool per queue, rather than one pool per device like it currently
> does.
> 
>> Also, if it was a one time init kind of thing, I'd say "yeah, leave it alone". 
>> DMA pool is used by a wide range of drivers and it is used to allocate
>> fixed size buffers at runtime. 
>  * DMA Pool allocator
>  *
>  * Copyright 2001 David Brownell
>  * Copyright 2007 Intel Corporation
>  *   Author: Matthew Wilcox <willy@linux.intel.com>
> 
> I know what it's used for.
> 

cool, good to know.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
