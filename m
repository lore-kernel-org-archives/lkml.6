Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7915EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01110214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01110214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeISAnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:43:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbeISAnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:43:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7677CED1;
        Tue, 18 Sep 2018 12:09:48 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F4A3F703;
        Tue, 18 Sep 2018 12:09:45 -0700 (PDT)
Subject: Re: [PATCH v7 5/6] iommu/arm-smmu-v3: Add support for non-strict mode
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1536935328.git.robin.murphy@arm.com>
 <4f9444c7224ea0e6e4cef8ddbf77bb5292a383e3.1536935328.git.robin.murphy@arm.com>
 <20180918171016.GL16498@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aec7c175-dd77-8cb7-7544-579bd73c162d@arm.com>
Date:   Tue, 18 Sep 2018 20:09:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918171016.GL16498@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 6:10 PM, Will Deacon wrote:
> On Fri, Sep 14, 2018 at 03:30:23PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Dynamically choose strict or non-strict mode for page table config based
>> on the iommu domain type.
> 
> It's the domain type in conjunction with the attribute that determines
> whether we use lazy or strict invalidation.
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> [rm: convert to domain attribute]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 30 ++++++++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index f10c852479fc..7bbfa5f7ce8e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -612,6 +612,7 @@ struct arm_smmu_domain {
>>   	struct mutex			init_mutex; /* Protects smmu pointer */
>>   
>>   	struct io_pgtable_ops		*pgtbl_ops;
>> +	bool				non_strict;
>>   
>>   	enum arm_smmu_domain_stage	stage;
>>   	union {
>> @@ -1633,6 +1634,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>>   	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>>   
>> +	if (smmu_domain->non_strict)
>> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> +
>>   	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>>   	if (!pgtbl_ops)
>>   		return -ENOMEM;
>> @@ -1934,13 +1938,17 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>   {
>>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>   
>> -	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
>> -		return -EINVAL;
>> -
>>   	switch (attr) {
>>   	case DOMAIN_ATTR_NESTING:
>> +		if (domain->type != IOMMU_DOMAIN_UNMANAGED)
>> +			return -EINVAL;
>>   		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>>   		return 0;
>> +	case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>> +		if (domain->type != IOMMU_DOMAIN_DMA)
>> +			return -EINVAL;
>> +		*(int *)data = smmu_domain->non_strict;
>> +		return 0;
>>   	default:
>>   		return -ENODEV;
> 
> Hmm, there's a change in behaviour here (and also in the set function)
> which is that unknown attributes now return -ENODEV for managed domains
> instead of -EINVAL. I don't know if that's a problem, but I'd be inclined
> to switch on the domain type and then have a nested switch for the supported
> attributes.

Sure, a nested switch did actually cross my mind, but I was worried it 
might be a little boilerplate-heavy since there's still only one of each 
case (and this quick'n'dirty copy-paste job didn't need any thought...)

If that's your preference too, though, I'll respin both driver patches 
that way.

Robin.
