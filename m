Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45082C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF882083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF882083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeGZIfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:35:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeGZIfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:35:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8449CD733530A;
        Thu, 26 Jul 2018 15:20:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 15:20:09 +0800
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B597628.2020103@huawei.com>
Date:   Thu, 26 Jul 2018 15:20:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/25 6:25, Robin Murphy wrote:
> On 2018-07-12 7:18 AM, Zhen Lei wrote:
>> To support the non-strict mode, now we only tlbi and sync for the strict
>> mode. But for the non-leaf case, always follow strict mode.
>>
>> Use the lowest bit of the iova parameter to pass the strict mode:
>> 0, IOMMU_STRICT;
>> 1, IOMMU_NON_STRICT;
>> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
>> other IOMMUs which still use strict mode.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 010a254..9234db3 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -292,7 +292,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>>     static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>                      unsigned long iova, size_t size, int lvl,
>> -                   arm_lpae_iopte *ptep);
>> +                   arm_lpae_iopte *ptep, int strict);
>>     static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>                   phys_addr_t paddr, arm_lpae_iopte prot,
>> @@ -334,7 +334,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>           size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>             tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>> -        if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
>> +        if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp, IOMMU_STRICT) != sz))
>>               return -EINVAL;
>>       }
>>   @@ -531,7 +531,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
>>   static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>                          unsigned long iova, size_t size,
>>                          arm_lpae_iopte blk_pte, int lvl,
>> -                       arm_lpae_iopte *ptep)
>> +                       arm_lpae_iopte *ptep, int strict)
> 
> DMA code should never ever be splitting blocks anyway, and frankly the TLB maintenance here is dodgy enough (since we can't reasonably do break-before make as VMSA says we should) that I *really* don't want to introduce any possibility of making it more asynchronous. I'd much rather just hard-code the expectation of strict == true for this.

OK, I will hard-code strict=true for it.

But since it never ever be happened, why did not give a warning at the beginning?

> 
> Robin.
> 
>>   {
>>       struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>       arm_lpae_iopte pte, *tablep;
>> @@ -576,15 +576,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>       }
>>         if (unmap_idx < 0)
>> -        return __arm_lpae_unmap(data, iova, size, lvl, tablep);
>> +        return __arm_lpae_unmap(data, iova, size, lvl, tablep, strict);
>>         io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
>> +    if (!strict)
>> +        io_pgtable_tlb_sync(&data->iop);
>> +
>>       return size;
>>   }
>>     static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>                      unsigned long iova, size_t size, int lvl,
>> -                   arm_lpae_iopte *ptep)
>> +                   arm_lpae_iopte *ptep, int strict)
>>   {
>>       arm_lpae_iopte pte;
>>       struct io_pgtable *iop = &data->iop;
>> @@ -609,7 +612,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>               io_pgtable_tlb_sync(iop);
>>               ptep = iopte_deref(pte, data);
>>               __arm_lpae_free_pgtable(data, lvl + 1, ptep);
>> -        } else {
>> +        } else if (strict) {
>>               io_pgtable_tlb_add_flush(iop, iova, size, size, true);
>>           }
>>   @@ -620,25 +623,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>            * minus the part we want to unmap
>>            */
>>           return arm_lpae_split_blk_unmap(data, iova, size, pte,
>> -                        lvl + 1, ptep);
>> +                        lvl + 1, ptep, strict);
>>       }
>>         /* Keep on walkin' */
>>       ptep = iopte_deref(pte, data);
>> -    return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
>> +    return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep, strict);
>>   }
>>     static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>>                    size_t size)
>>   {
>> +    int strict = ((iova & IOMMU_STRICT_MODE_MASK) == IOMMU_STRICT);
>>       struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>       arm_lpae_iopte *ptep = data->pgd;
>>       int lvl = ARM_LPAE_START_LVL(data);
>>   +    iova &= ~IOMMU_STRICT_MODE_MASK;
>>       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
>>           return 0;
>>   -    return __arm_lpae_unmap(data, iova, size, lvl, ptep);
>> +    return __arm_lpae_unmap(data, iova, size, lvl, ptep, strict);
>>   }
>>     static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>>
> 
> .
> 

-- 
Thanks!
BestRegards

