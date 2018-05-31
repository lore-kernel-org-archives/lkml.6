Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755078AbeEaLYb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:24:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755055AbeEaLY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:24:26 -0400
Subject: Re: [PATCH 0/7] add non-strict mode support for arm-smmu-v3
To: Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d65f87a4-db61-3cd2-1a6f-0322025840a8@arm.com>
Date: Thu, 31 May 2018 12:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 08:42, Zhen Lei wrote:
> In common, a IOMMU unmap operation follow the below steps:
> 1. remove the mapping in page table of the specified iova range
> 2. execute tlbi command to invalid the mapping which is cached in TLB
> 3. wait for the above tlbi operation to be finished
> 4. free the IOVA resource
> 5. free the physical memory resource
> 
> This maybe a problem when unmap is very frequently, the combination of tlbi
> and wait operation will consume a lot of time. A feasible method is put off
> tlbi and iova-free operation, when accumulating to a certain number or
> reaching a specified time, execute only one tlbi_all command to clean up
> TLB, then free the backup IOVAs. Mark as non-strict mode.
> 
> But it must be noted that, although the mapping has already been removed in
> the page table, it maybe still exist in TLB. And the freed physical memory
> may also be reused for others. So a attacker can persistent access to memory
> based on the just freed IOVA, to obtain sensible data or corrupt memory. So
> the VFIO should always choose the strict mode.
> 
> Some may consider put off physical memory free also, that will still follow
> strict mode. But for the map_sg cases, the memory allocation is not controlled
> by IOMMU APIs, so it is not enforceable.
> 
> Fortunately, Intel and AMD have already applied the non-strict mode, and put
> queue_iova() operation into the common file dma-iommu.c., and my work is based
> on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
> unmap, but Intel and AMD IOMMU drivers are not.
> 
> Below is the performance data of strict vs non-strict for NVMe device:
> Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
> Randomly Write IOPS: 143K(strict) vs 513K(non-strict)

What hardware is this on? If it's SMMUv3 without MSIs (e.g. D05), then 
you'll still be using the rubbish globally-blocking sync implementation. 
If that is the case, I'd be very interested to see how much there is to 
gain from just improving that - I've had a patch kicking around for a 
while[1] (also on a rebased branch at [2]), but don't have the means for 
serious performance testing.

Robin.

[1] 
https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg20576.html
[2] git://linux-arm.org/linux-rm iommu/smmu

> 
> 
> Zhen Lei (7):
>    iommu/dma: fix trival coding style mistake
>    iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
>    iommu: prepare for the non-strict mode support
>    iommu/amd: make sure TLB to be flushed before IOVA freed
>    iommu/dma: add support for non-strict mode
>    iommu/io-pgtable-arm: add support for non-strict mode
>    iommu/arm-smmu-v3: add support for non-strict mode
> 
>   drivers/iommu/amd_iommu.c          |  2 +-
>   drivers/iommu/arm-smmu-v3.c        | 16 ++++++++++++---
>   drivers/iommu/arm-smmu.c           |  2 +-
>   drivers/iommu/dma-iommu.c          | 41 ++++++++++++++++++++++++++++++--------
>   drivers/iommu/io-pgtable-arm-v7s.c |  6 +++---
>   drivers/iommu/io-pgtable-arm.c     | 28 ++++++++++++++------------
>   drivers/iommu/io-pgtable.h         |  2 +-
>   drivers/iommu/ipmmu-vmsa.c         |  2 +-
>   drivers/iommu/msm_iommu.c          |  2 +-
>   drivers/iommu/mtk_iommu.c          |  2 +-
>   drivers/iommu/qcom_iommu.c         |  2 +-
>   include/linux/iommu.h              |  5 +++++
>   12 files changed, 76 insertions(+), 34 deletions(-)
> 
