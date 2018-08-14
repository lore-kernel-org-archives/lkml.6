Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68426C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1C217BC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE1C217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeHNLT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:19:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbeHNLT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:19:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA1B5D6502277;
        Tue, 14 Aug 2018 16:33:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 16:33:42 +0800
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com> <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B7293E5.7040702@huawei.com>
Date:   Tue, 14 Aug 2018 16:33:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/6 9:32, Yang, Shunyong wrote:
> Hi, Robin,
> 
> On 2018/7/26 22:37, Robin Murphy wrote:
>> On 2018-07-26 8:20 AM, Leizhen (ThunderTown) wrote:
>>> On 2018/7/25 6:25, Robin Murphy wrote:
>>>> On 2018-07-12 7:18 AM, Zhen Lei wrote:
>>>>> To support the non-strict mode, now we only tlbi and sync for the strict
>>>>> mode. But for the non-leaf case, always follow strict mode.
>>>>>
>>>>> Use the lowest bit of the iova parameter to pass the strict mode:
>>>>> 0, IOMMU_STRICT;
>>>>> 1, IOMMU_NON_STRICT;
>>>>> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
>>>>> other IOMMUs which still use strict mode.
>>>>>
>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> ---
>>>>>    drivers/iommu/io-pgtable-arm.c | 23 ++++++++++++++---------
>>>>>    1 file changed, 14 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>>>> index 010a254..9234db3 100644
>>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>>> @@ -292,7 +292,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>>>>>      static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>>                       unsigned long iova, size_t size, int lvl,
>>>>> -                   arm_lpae_iopte *ptep);
>>>>> +                   arm_lpae_iopte *ptep, int strict);
>>>>>      static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>>>>                    phys_addr_t paddr, arm_lpae_iopte prot,
>>>>> @@ -334,7 +334,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>>>>            size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>>>>              tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>>>>> -        if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
>>>>> +        if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp, IOMMU_STRICT) != sz))
>>>>>                return -EINVAL;
>>>>>        }
>>>>>    @@ -531,7 +531,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
>>>>>    static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>>>>                           unsigned long iova, size_t size,
>>>>>                           arm_lpae_iopte blk_pte, int lvl,
>>>>> -                       arm_lpae_iopte *ptep)
>>>>> +                       arm_lpae_iopte *ptep, int strict)
>>>>
>>>> DMA code should never ever be splitting blocks anyway, and frankly the TLB maintenance here is dodgy enough (since we can't reasonably do break-before make as VMSA says we should) that I *really* don't want to introduce any possibility of making it more asynchronous. I'd much rather just hard-code the expectation of strict == true for this.
>>>
>>> OK, I will hard-code strict=true for it.
>>>
>>> But since it never ever be happened, why did not give a warning at the beginning?
>>
>> Because DMA code is not the only caller of iommu_map/unmap. It's 
>> perfectly legal in the IOMMU API to partially unmap a previous mapping 
>> such that a block entry needs to be split. The DMA API, however, is a 
>> lot more constrined, and thus by construction the iommu-dma layer will 
>> never generate a block-splitting iommu_unmap() except as a result of 
>> illegal DMA API usage, and we obviously do not need to optimise for that 
>> (you will get a warning about mismatched unmaps under dma-debug, but 
>> it's a bit too expensive to police in the general case).
>>
> 
> When I was reading the code around arm_lpae_split_blk_unmap(), I was
> curious in which scenario a block will be split. Now with your comments
> "Because DMA code is not the only caller of iommu_map/unmap", it seems
> depending on the user.
> 
> Would you please explain this further? I mean besides DMA, which user
> will use iommu_map/umap and how it split a block.

I also think that arm_lpae_split_blk_unmap() scenario is not exist, maybe
we should remove it, and give a warning for this wrong usage.

> 
> Thanks.
> Shunyong.
> 
>>
>>>>>    {
>>>>>        struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>>>>        arm_lpae_iopte pte, *tablep;
>>>>> @@ -576,15 +576,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>>>>        }
>>>>>          if (unmap_idx < 0)
>>>>> -        return __arm_lpae_unmap(data, iova, size, lvl, tablep);
>>>>> +        return __arm_lpae_unmap(data, iova, size, lvl, tablep, strict);
>>>>>          io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
>>>>> +    if (!strict)
>>>>> +        io_pgtable_tlb_sync(&data->iop);
>>>>> +
>>>>>        return size;
>>>>>    }
>>>>>      static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>>                       unsigned long iova, size_t size, int lvl,
>>>>> -                   arm_lpae_iopte *ptep)
>>>>> +                   arm_lpae_iopte *ptep, int strict)
>>>>>    {
>>>>>        arm_lpae_iopte pte;
>>>>>        struct io_pgtable *iop = &data->iop;
>>>>> @@ -609,7 +612,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>>                io_pgtable_tlb_sync(iop);
>>>>>                ptep = iopte_deref(pte, data);
>>>>>                __arm_lpae_free_pgtable(data, lvl + 1, ptep);
>>>>> -        } else {
>>>>> +        } else if (strict) {
>>>>>                io_pgtable_tlb_add_flush(iop, iova, size, size, true);
>>>>>            }
>>>>>    @@ -620,25 +623,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>>             * minus the part we want to unmap
>>>>>             */
>>>>>            return arm_lpae_split_blk_unmap(data, iova, size, pte,
>>>>> -                        lvl + 1, ptep);
>>>>> +                        lvl + 1, ptep, strict);
>>>>>        }
>>>>>          /* Keep on walkin' */
>>>>>        ptep = iopte_deref(pte, data);
>>>>> -    return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
>>>>> +    return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep, strict);
>>>>>    }
>>>>>      static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>>>>>                     size_t size)
>>>>>    {
>>>>> +    int strict = ((iova & IOMMU_STRICT_MODE_MASK) == IOMMU_STRICT);
>>>>>        struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>>>>        arm_lpae_iopte *ptep = data->pgd;
>>>>>        int lvl = ARM_LPAE_START_LVL(data);
>>>>>    +    iova &= ~IOMMU_STRICT_MODE_MASK;
>>>>>        if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
>>>>>            return 0;
>>>>>    -    return __arm_lpae_unmap(data, iova, size, lvl, ptep);
>>>>> +    return __arm_lpae_unmap(data, iova, size, lvl, ptep, strict);
>>>>>    }
>>>>>      static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>>>>>
>>>>
>>>> .
>>>>
>>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 
> 
> .
> 

-- 
Thanks!
BestRegards

