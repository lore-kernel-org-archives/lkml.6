Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82FC2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82FC2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLDNLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:11:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59792 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDNLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:11:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F85780D;
        Tue,  4 Dec 2018 05:11:40 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF7233F59C;
        Tue,  4 Dec 2018 05:11:38 -0800 (PST)
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
To:     John Garry <john.garry@huawei.com>, hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
Date:   Tue, 4 Dec 2018 13:11:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 03/12/2018 18:23, John Garry wrote:
> On 03/12/2018 17:28, Robin Murphy wrote:
>> Certain drivers such as large multi-queue network adapters can use pools
>> of mapped DMA buffers larger than the default dma_debug_entry pool of
>> 65536 entries, with the result that merely probing such a device can
>> cause DMA debug to disable itself during boot unless explicitly given an
>> appropriate "dma_debug_entries=..." option.
>>
>> Developers trying to debug some other driver on such a system may not be
>> immediately aware of this, and at worst it can hide bugs if they fail to
>> realise that dma-debug has already disabled itself unexpectedly by the
>> time the code of interest gets to run. Even once they do realise, it can
>> be a bit of a pain to emprirically determine a suitable number of
>> preallocated entries to configure without massively over-allocating.
>>
>> There's really no need for such a static limit, though, since we can
>> quite easily expand the pool at runtime in those rare cases that the
>> preallocated entries are insufficient, which is arguably the least
>> surprising and most useful behaviour.
> 
> Hi Robin,
> 
> Do you have an idea on shrinking the pool again when the culprit driver 
> is removed, i.e. we have so many unused debug entries now available?

I honestly don't believe it's worth the complication. This is a 
development feature with significant overheads already, so there's not 
an awful lot to gain by trying to optimise memory usage. If a system can 
ever load a driver that makes hundreds of thousands of simultaneous 
mappings, it can almost certainly spare 20-odd megabytes of RAM for the 
corresponding debug entries in perpetuity. Sure, it does mean you'd need 
to reboot to recover memory from a major leak, but that's mostly true of 
the current behaviour too, and rebooting during driver development is 
hardly an unacceptable inconvenience.

In fact, having got this far in, what I'd quite like to do is to get rid 
of dma_debug_resize_entries() such that we never need to free things at 
all, since then we could allocate whole pages as blocks of entries to 
save on masses of individual slab allocations.

Robin.

> 
> Thanks,
> John
> 
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  kernel/dma/debug.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>> index de5db800dbfc..46cc075aec99 100644
>> --- a/kernel/dma/debug.c
>> +++ b/kernel/dma/debug.c
>> @@ -47,6 +47,9 @@
>>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>  #endif
>> +/* If the pool runs out, try this many times to allocate this many 
>> new entries */
>> +#define DMA_DEBUG_DYNAMIC_ENTRIES 256
>> +#define DMA_DEBUG_DYNAMIC_RETRIES 2
>>
>>  enum {
>>      dma_debug_single,
>> @@ -702,12 +705,21 @@ static struct dma_debug_entry 
>> *dma_entry_alloc(void)
>>  {
>>      struct dma_debug_entry *entry;
>>      unsigned long flags;
>> +    int retry_count;
>>
>> -    spin_lock_irqsave(&free_entries_lock, flags);
>> +    for (retry_count = 0; ; retry_count++) {
>> +        spin_lock_irqsave(&free_entries_lock, flags);
>> +
>> +        if (num_free_entries > 0)
>> +            break;
>>
>> -    if (list_empty(&free_entries)) {
>> -        global_disable = true;
>>          spin_unlock_irqrestore(&free_entries_lock, flags);
>> +
>> +        if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
>> +            !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
>> +            continue;
>> +
>> +        global_disable = true;
>>          pr_err("debugging out of memory - disabling\n");
>>          return NULL;
>>      }
>>
> 
> 
