Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51534C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0820685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD0820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeGXXAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:00:33 -0400
Received: from foss.arm.com ([217.140.101.70]:58196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeGXXAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:00:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025AB15A2;
        Tue, 24 Jul 2018 14:52:04 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 092233F5B3;
        Tue, 24 Jul 2018 14:52:00 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] add non-strict mode support for arm-smmu-v3
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aace9ec9-a36a-79a8-98eb-bbedd06f11a4@arm.com>
Date:   Tue, 24 Jul 2018 22:51:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-12 7:18 AM, Zhen Lei wrote:
> v2 -> v3:
> Add a bootup option "iommu_strict_mode" to make the manager can choose which
> mode to be used. The first 5 patches have not changed.
> +	iommu_strict_mode=	[arm-smmu-v3]
> +		0 - strict mode (default)
> +		1 - non-strict mode
> 
> v1 -> v2:
> Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
> 0, IOMMU_STRICT;
> 1, IOMMU_NON_STRICT;
> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
> other IOMMUs which still use strict mode. In other words, this patch series
> will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
> in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
> driver to io-pgtable module.

What exactly is the issue there? We don't have any problem with other 
quirks like NO_DMA, and as I said before, by the time we're allocating 
the io-pgtable in arm_smmu_domain_finalise() we already know everything 
there is to know about the domain.

> Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
> initialized when the related domain and IOMMU driver support non-strict mode.
> 
> v1:
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

How does that compare to passthrough performance? One thing I'm not 
entirely clear about is what the realistic use-case for this is - even 
if invalidation were infinitely fast, enabling translation still 
typically has a fair impact on overall system performance in terms of 
latency, power, memory bandwidth, etc., so I can't help wonder what 
devices exist today for which performance is critical and robustness* is 
unimportant, yet have crippled addressing capabilities such that they 
can't just use passthrough.

Robin.


* I don't want to say "security" here, since I'm actually a lot less 
concerned about the theoretical malicious endpoint/wild write scenarios 
than the the much more straightforward malfunctioning device and/or 
buggy driver causing use-after-free style memory corruption. Also, I'm 
sick of the word "security"...

> 
> Zhen Lei (6):
>    iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
>    iommu/dma: add support for non-strict mode
>    iommu/amd: use default branch to deal with all non-supported
>      capabilities
>    iommu/io-pgtable-arm: add support for non-strict mode
>    iommu/arm-smmu-v3: add support for non-strict mode
>    iommu/arm-smmu-v3: add bootup option "iommu_strict_mode"
> 
>   Documentation/admin-guide/kernel-parameters.txt | 12 +++++++
>   drivers/iommu/amd_iommu.c                       |  4 +--
>   drivers/iommu/arm-smmu-v3.c                     | 42 +++++++++++++++++++++++--
>   drivers/iommu/dma-iommu.c                       | 25 +++++++++++++++
>   drivers/iommu/io-pgtable-arm.c                  | 23 ++++++++------
>   include/linux/iommu.h                           |  7 +++++
>   6 files changed, 98 insertions(+), 15 deletions(-)
> 
