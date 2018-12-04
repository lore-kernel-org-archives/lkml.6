Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4D6206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4D6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeLDQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:32:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeLDQcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:32:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E125BA78;
        Tue,  4 Dec 2018 08:32:05 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D413F614;
        Tue,  4 Dec 2018 08:32:04 -0800 (PST)
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
 <20181204142938.GC2767@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dae44ed0-6b84-0ed3-87c2-97940576709d@arm.com>
Date:   Tue, 4 Dec 2018 16:32:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204142938.GC2767@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 14:29, Christoph Hellwig wrote:
>> +	for (retry_count = 0; ; retry_count++) {
>> +		spin_lock_irqsave(&free_entries_lock, flags);
>> +
>> +		if (num_free_entries > 0)
>> +			break;
>>   
>>   		spin_unlock_irqrestore(&free_entries_lock, flags);
> 
> Taking a spinlock just to read a single integer value doesn't really
> help anything.

If the freelist is non-empty we break out with the lock still held in 
order to actually allocate our entry - only if there are no free entries 
left do we drop the lock in order to handle the failure. This much is 
just the original logic shuffled around a bit (with the tweak that 
testing num_free_entries seemed justifiably simpler than the original 
list_empty() check).

>> +
>> +		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
>> +		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
> 
> Don't we need GFP_ATOMIC here?  Also why do we need the retries?

Ah, right, we may be outside our own spinlock, but of course the whole 
DMA API call which got us here might be under someone else's and/or in a 
non-sleeping context - I'll fix that.

The number of retries is just to bound the loop due to its inherent 
raciness - since we drop the lock to create more entries, under 
pathological conditions by the time we get back in to grab one they 
could have all gone. 2 retries (well, strictly it's 1 try and 1 retry) 
was an entirely arbitrary choice just to accommodate that happening very 
occasionally by chance.

However, if the dynamic allocations need GFP_ATOMIC for external reasons 
anyway, then I don't need the lock-juggling that invites that race in 
the first place, and the whole loop disappears again. Neat!

Robin.
