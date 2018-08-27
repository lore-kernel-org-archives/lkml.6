Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BBEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF60A21746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF60A21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeH0MHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:07:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbeH0MHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:07:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 998E7FFA4601C;
        Mon, 27 Aug 2018 16:21:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Mon, 27 Aug 2018
 16:21:45 +0800
Subject: Re: [PATCH v5 3/5] iommu/io-pgtable-arm: add support for non-strict
 mode
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <1534296510-12888-4-git-send-email-thunder.leizhen@huawei.com>
 <88575452-d370-2488-dd3f-6c3d3ebe150d@arm.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B83B498.1020408@huawei.com>
Date:   Mon, 27 Aug 2018 16:21:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <88575452-d370-2488-dd3f-6c3d3ebe150d@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/23 1:52, Robin Murphy wrote:
> On 15/08/18 02:28, Zhen Lei wrote:
>> To support the non-strict mode, now we only tlbi and sync for the strict
>> mode. But for the non-leaf case, always follow strict mode.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 20 ++++++++++++++------
>>   drivers/iommu/io-pgtable.h     |  3 +++
>>   2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 010a254..20d3e98 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -538,6 +538,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>       phys_addr_t blk_paddr;
>>       size_t tablesz = ARM_LPAE_GRANULE(data);
>>       size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>> +    size_t unmapped = size;
>>       int i, unmap_idx = -1;
>>
>>       if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>> @@ -575,11 +576,16 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>           tablep = iopte_deref(pte, data);
>>       }
>>
>> -    if (unmap_idx < 0)
> 
> [ side note: the more I see this test the more it looks slightly wrong, but that's a separate issue. I'll have to sit down and really remember what's going on here... ]
> 
>> -        return __arm_lpae_unmap(data, iova, size, lvl, tablep);
>> +    if (unmap_idx < 0) {
>> +        unmapped = __arm_lpae_unmap(data, iova, size, lvl, tablep);
>> +        if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT))
>> +            return unmapped;
>> +    }
> 
> I don't quite get this change - we should only be recursing back into __arm_lpae_unmap() here if nothing's actually been unmapped at this point - the block entry is simply replaced by a full next-level table and we're going to come back and split another block at that next level, or we raced against someone else splitting the same block and that's their table instead. Since that's reverting back to a "regular" unmap, I don't see where the need to introduce an additional flush to that path comes from (relative to the existing behaviour, at least).

The old block mapping maybe cached in TLBs, it should be invalidated completely before the new next-level mapping to be used. Just ensure that.

In fact, I think the code of arm_lpae_split_blk_unmap may has some mistakes. For example:
	if (size == split_sz)
		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);

It means that "the size" can only be the block/page size of the next-level. Suppose current level is 2M block, but we may unmap 12K, and
the above "if" will limit us only be able to unmap 4K.

Furthermore, the situation "if (unmap_idx < 0)" should not appear.

Maybe my analysis is wrong, I will try to test it.


> 
>>       io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
> 
> This is the flush which corresponds to whatever page split_blk_unmap() actually unmapped itself (and also covers any recursively-split intermediate-level entries)...
> 
>> -    return size;
>> +    io_pgtable_tlb_sync(&data->iop);
> 
> ...which does want this sync, but only technically for non-strict mode, since it's otherwise covered by the sync in iommu_unmap().

Because split_blk_unmap() is rarely to be called, it has little impact on the overall performance,
so I ommitted the if statement of non-strict, I will add it back.

> 
> I'm not *against* tightening up the TLB maintenance here in general, but if so that should be a separately-reasoned patch, not snuck in with other changes.

OK

> 
> Robin.
> 
>> +
>> +    return unmapped;
>>   }
>>
>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>> @@ -609,7 +615,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>               io_pgtable_tlb_sync(iop);
>>               ptep = iopte_deref(pte, data);
>>               __arm_lpae_free_pgtable(data, lvl + 1, ptep);
>> -        } else {
>> +        } else if (!(iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT)) {
>>               io_pgtable_tlb_add_flush(iop, iova, size, size, true);
>>           }
>>
>> @@ -771,7 +777,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>>       u64 reg;
>>       struct arm_lpae_io_pgtable *data;
>>
>> -    if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
>> +    if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
>> +            IO_PGTABLE_QUIRK_NON_STRICT))
>>           return NULL;
>>
>>       data = arm_lpae_alloc_pgtable(cfg);
>> @@ -863,7 +870,8 @@ static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>>       struct arm_lpae_io_pgtable *data;
>>
>>       /* The NS quirk doesn't apply at stage 2 */
>> -    if (cfg->quirks & ~IO_PGTABLE_QUIRK_NO_DMA)
>> +    if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
>> +        IO_PGTABLE_QUIRK_NON_STRICT))
>>           return NULL;
>>
>>       data = arm_lpae_alloc_pgtable(cfg);
>> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
>> index 2df7909..beb14a3 100644
>> --- a/drivers/iommu/io-pgtable.h
>> +++ b/drivers/iommu/io-pgtable.h
>> @@ -71,12 +71,15 @@ struct io_pgtable_cfg {
>>        *    be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
>>        *    software-emulated IOMMU), such that pagetable updates need not
>>        *    be treated as explicit DMA data.
>> +     * IO_PGTABLE_QUIRK_NON_STRICT: Put off TLBs invalidation and release
>> +     *    memory first.
>>        */
>>       #define IO_PGTABLE_QUIRK_ARM_NS        BIT(0)
>>       #define IO_PGTABLE_QUIRK_NO_PERMS    BIT(1)
>>       #define IO_PGTABLE_QUIRK_TLBI_ON_MAP    BIT(2)
>>       #define IO_PGTABLE_QUIRK_ARM_MTK_4GB    BIT(3)
>>       #define IO_PGTABLE_QUIRK_NO_DMA        BIT(4)
>> +    #define IO_PGTABLE_QUIRK_NON_STRICT    BIT(5)
>>       unsigned long            quirks;
>>       unsigned long            pgsize_bitmap;
>>       unsigned int            ias;
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

-- 
Thanks!
BestRegards

