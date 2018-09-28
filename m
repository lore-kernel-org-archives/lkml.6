Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36334C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13DA20779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13DA20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeI1Utl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:49:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1Utl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:49:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9724DED1;
        Fri, 28 Sep 2018 07:25:39 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5A3A3F5B3;
        Fri, 28 Sep 2018 07:25:37 -0700 (PDT)
Subject: Re: [PATCH v8 3/7] iommu: Add "iommu.strict" command line option
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1537458163.git.robin.murphy@arm.com>
 <799fad801970298385af3abc8ca82620ad62c000.1537458163.git.robin.murphy@arm.com>
 <20180928125130.GD1577@brain-police>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a3839ea8-ef67-300a-49aa-19b8932b042b@arm.com>
Date:   Fri, 28 Sep 2018 15:25:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928125130.GD1577@brain-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 13:51, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 05:10:23PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Add a generic command line option to enable lazy unmapping via IOVA
>> flush queues, which will initally be suuported by iommu-dma. This echoes
>> the semantics of "intel_iommu=strict" (albeit with the opposite default
>> value), but in the driver-agnostic fashion of "iommu.passthrough".
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> [rm: move handling out of SMMUv3 driver, clean up documentation]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v8:
>>   - Rename "non-strict" to "strict" to better match existing options
>>   - Rewrite doc text/commit message
>>   - Downgrade boot-time message from warn/taint to info
>>
>>   .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
>>   drivers/iommu/iommu.c                         | 23 +++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9871e649ffef..92ae12aeabf4 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1749,6 +1749,18 @@
>>   		nobypass	[PPC/POWERNV]
>>   			Disable IOMMU bypass, using IOMMU for PCI devices.
>>   
>> +	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>> +			Format: { "0" | "1" }
>> +			0 - Lazy mode.
>> +			  Request that DMA unmap operations use deferred
>> +			  invalidation of hardware TLBs, for increased
>> +			  throughput at the cost of reduced device isolation.
>> +			  Will fall back to strict mode if not supported by
>> +			  the relevant IOMMU driver.
>> +			1 - Strict mode (default).
>> +			  DMA unmap operations invalidate IOMMU hardware TLBs
>> +			  synchronously.
>> +
>>   	iommu.passthrough=
>>   			[ARM64] Configure DMA to bypass the IOMMU by default.
>>   			Format: { "0" | "1" }
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 8c15c5980299..02b6603f0616 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>   #else
>>   static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>>   #endif
>> +static bool iommu_dma_strict __read_mostly = true;
>>   
>>   struct iommu_callback_data {
>>   	const struct iommu_ops *ops;
>> @@ -131,6 +132,21 @@ static int __init iommu_set_def_domain_type(char *str)
>>   }
>>   early_param("iommu.passthrough", iommu_set_def_domain_type);
>>   
>> +static int __init iommu_dma_setup(char *str)
>> +{
>> +	int ret;
>> +
>> +	ret = kstrtobool(str, &iommu_dma_strict);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!iommu_dma_strict)
>> +		pr_info("Enabling deferred TLB invalidation for DMA; protection against malicious/malfunctioning devices may be reduced.\n");
> 
> Printing here isn't quite right, because if somebody boots with something
> like:
> 
> 	"iommu.strict=1 iommu.strict=0 iommu.strict=0 iommu.strict=1"
> 
> then we'll print the wrong thing twice :)

But it's not wrong! For those two brief moments it *is* enabled :P

For reasons of conciseness, the subtlety that "enabled" doesn't 
necessarily imply "in use" is only conveyed by the "may".

> I think we either need to drop the print, or move it to a the DMA domain
> initialisation.

TBH I did toy with moving it around, but in the end it seemed neatest to 
have it right there next to the parameter handling, with the added 
advantage that it appears early in the log where system-wide things 
might be expected to appear, rather than mixed in with all the driver 
noise later.

AFAICS it's no worse than various other parameters - try booting with, 
say, "mem=640k mem=1G mem=cheese" and one finds that memory is in fact 
not limited (nor indeed cheese) regardless of what the log might say.

Robin.
