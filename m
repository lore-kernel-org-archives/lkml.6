Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFAGvF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:51:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56657 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750796AbeFAGvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:51:02 -0400
Subject: Re: [PATCH 0/7] add non-strict mode support for arm-smmu-v3
To: Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <d65f87a4-db61-3cd2-1a6f-0322025840a8@arm.com>
 <96cc25b9-b21f-6067-384d-f52e6b8b25e7@huawei.com>
 <92b240f5-596e-87a9-863a-b18475042cce@arm.com>
CC: Libin <huawei.libin@huawei.com>, Guozhu Li <liguozhu@hisilicon.com>,
        Xinwei Hu <huxinwei@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B10ECBB.209@huawei.com>
Date: Fri, 1 Jun 2018 14:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <92b240f5-596e-87a9-863a-b18475042cce@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/31 22:25, Robin Murphy wrote:
> On 31/05/18 14:49, Hanjun Guo wrote:
>> Hi Robin,
>>
>> On 2018/5/31 19:24, Robin Murphy wrote:
>>> On 31/05/18 08:42, Zhen Lei wrote:
>>>> In common, a IOMMU unmap operation follow the below steps:
>>>> 1. remove the mapping in page table of the specified iova range
>>>> 2. execute tlbi command to invalid the mapping which is cached in TLB
>>>> 3. wait for the above tlbi operation to be finished
>>>> 4. free the IOVA resource
>>>> 5. free the physical memory resource
>>>>
>>>> This maybe a problem when unmap is very frequently, the combination of tlbi
>>>> and wait operation will consume a lot of time. A feasible method is put off
>>>> tlbi and iova-free operation, when accumulating to a certain number or
>>>> reaching a specified time, execute only one tlbi_all command to clean up
>>>> TLB, then free the backup IOVAs. Mark as non-strict mode.
>>>>
>>>> But it must be noted that, although the mapping has already been removed in
>>>> the page table, it maybe still exist in TLB. And the freed physical memory
>>>> may also be reused for others. So a attacker can persistent access to memory
>>>> based on the just freed IOVA, to obtain sensible data or corrupt memory. So
>>>> the VFIO should always choose the strict mode.
>>>>
>>>> Some may consider put off physical memory free also, that will still follow
>>>> strict mode. But for the map_sg cases, the memory allocation is not controlled
>>>> by IOMMU APIs, so it is not enforceable.
>>>>
>>>> Fortunately, Intel and AMD have already applied the non-strict mode, and put
>>>> queue_iova() operation into the common file dma-iommu.c., and my work is based
>>>> on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
>>>> unmap, but Intel and AMD IOMMU drivers are not.
>>>>
>>>> Below is the performance data of strict vs non-strict for NVMe device:
>>>> Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
>>>> Randomly Write IOPS: 143K(strict) vs 513K(non-strict)
>>>
>>> What hardware is this on? If it's SMMUv3 without MSIs (e.g. D05), then you'll still be using the rubbish globally-blocking sync implementation. If that is the case, I'd be very interested to see how much there is to gain from just improving that - I've had a patch kicking around for a while[1] (also on a rebased branch at [2]), but don't have the means for serious performance testing.
I will try your patch to see how much it can improve. I think the best way
to resovle the globally-blocking sync is that the hardware provide 64bits
CONS regitster, so that it can never be wrapped, and the spinlock can also
be removed.

>>
>> The hardware is the new D06 which the SMMU with MSIs,
> 
> Cool! Now that profiling is fairly useful since we got rid of most of the locks, are you able to get an idea of how the overhead in the normal case is distributed between arm_smmu_cmdq_insert_cmd() and __arm_smmu_sync_poll_msi()? We're always trying to improve our understanding of where command-queue-related overheads turn out to be in practice, and there's still potentially room to do nicer things than TLBI_NH_ALL ;)
Even if the software has no overhead, there may still be a problem, because
the smmu need to execute the commands in sequence, especially before
globally-blocking sync has been removed. Base on the actually execute time
of single tlbi and sync, we can get the upper limit in theory.

BTW, I will reply the reset of mail next week. I'm busy with other things now.

> 
> Robin.
> 
>> it's not D05 :)
>>
>> Thanks
>> Hanjun
>>
> 
> .
> 

-- 
Thanks!
BestRegards
