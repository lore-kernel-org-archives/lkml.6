Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D6ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E54C21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E54C21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeISAfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:35:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeISAfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:35:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10CC3ED1;
        Tue, 18 Sep 2018 12:01:58 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AE073F703;
        Tue, 18 Sep 2018 12:01:54 -0700 (PDT)
Subject: Re: [PATCH v7 4/6] iommu: Add bootup option "iommu.non_strict"
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1536935328.git.robin.murphy@arm.com>
 <41f81c46348db4acd9a542184f10e7ca24f6c219.1536935328.git.robin.murphy@arm.com>
 <20180918171013.GK16498@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f98e3245-bbaf-fdd9-d8d3-2ac9900af636@arm.com>
Date:   Tue, 18 Sep 2018 20:01:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918171013.GK16498@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 6:10 PM, Will Deacon wrote:
> On Fri, Sep 14, 2018 at 03:30:22PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Add a bootup option to make the system manager can choose which mode to
>> be used. The default mode is strict.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> [rm: move handling out of SMMUv3 driver]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 13 ++++++++++
>>   drivers/iommu/iommu.c                         | 26 +++++++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9871e649ffef..406b91759b62 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1749,6 +1749,19 @@
>>   		nobypass	[PPC/POWERNV]
>>   			Disable IOMMU bypass, using IOMMU for PCI devices.
>>   
>> +	iommu.non_strict=	[ARM64]
>> +			Format: { "0" | "1" }
>> +			0 - strict mode, default.
>> +			    Release IOVAs after the related TLBs are invalid
>> +			    completely.
>> +			1 - non-strict mode.
>> +			    Put off TLBs invalidation and release memory first.
>> +			    It's good for scatter-gather performance but lacks
>> +			    full isolation, an untrusted device can access the
>> +			    reused memory because the TLBs may still valid.
>> +			    Please take	full consideration before choosing this
>> +			    mode. Note that, VFIO will always use strict mode.
> 
> This text needs help. How about something like:
> 
> 	0 - strict mode, default.
> 	    Invalidate the TLB of the IOMMU hardware as part of every
> 	    unmap() operation.
> 	1 - lazy mode.
> 	    Defer TLB invalidation so that the TLB of the IOMMU hardware
> 	    is invalidated periodically, rather than as part of every
> 	    unmap() operation.
> 
> (generally, I think I'd s/non strict/lazy/ in this patch to avoid the double
> negatives)
> 
>> +
>>   	iommu.passthrough=
>>   			[ARM64] Configure DMA to bypass the IOMMU by default.
>>   			Format: { "0" | "1" }
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 8c15c5980299..2cabd0c0a4f3 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>   #else
>>   static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>>   #endif
>> +static bool iommu_dma_non_strict __read_mostly;
>>   
>>   struct iommu_callback_data {
>>   	const struct iommu_ops *ops;
>> @@ -131,6 +132,24 @@ static int __init iommu_set_def_domain_type(char *str)
>>   }
>>   early_param("iommu.passthrough", iommu_set_def_domain_type);
>>   
>> +static int __init iommu_dma_setup(char *str)
>> +{
>> +	int ret;
>> +
>> +	ret = kstrtobool(str, &iommu_dma_non_strict);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (iommu_dma_non_strict) {
>> +		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
>> +			"It's good for scatter-gather performance but lacks full isolation\n");
> 
> Hmm, not sure about this message either and tainting is probably over the
> top. Maybe drop the taint and just pr_info something like "IOMMU DMA ops
> using lazy TLB invalidation: unable to protect against malicious devices"
> 
>> +		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>> +	}
>> +
>> +	return 0;
>> +}
>> +early_param("iommu.non_strict", iommu_dma_setup);
>> +
>>   static ssize_t iommu_group_attr_show(struct kobject *kobj,
>>   				     struct attribute *__attr, char *buf)
>>   {
>> @@ -1072,6 +1091,13 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>>   		group->default_domain = dom;
>>   		if (!group->domain)
>>   			group->domain = dom;
>> +
>> +		if (dom && iommu_dma_non_strict) {
>> +			int attr = 1;
>> +			iommu_domain_set_attr(dom,
>> +					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
>> +					      &attr);
>> +		}
> 
> Hmm, I don't think we can guarantee that we're working with the DMA domain
> here. Does this all fall out in the wash for the identity domain?

Indeed so - for one, I expect drivers to reject it for anything that 
isn't their own default DMA ops domain type (as #5 and #6 do), and 
furthermore it only has any effect once iommu_dma_init_domain() reads it 
back if it stuck, and other domain types should never be getting passed 
into there anyway.

Robin.
