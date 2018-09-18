Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00F121508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00F121508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeISA4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:56:25 -0400
Received: from foss.arm.com ([217.140.101.70]:49904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeISA4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:56:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D099FED1;
        Tue, 18 Sep 2018 12:22:23 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BEA3F5BD;
        Tue, 18 Sep 2018 12:22:21 -0700 (PDT)
Subject: Re: [PATCH v7 6/6] iommu/arm-smmu: Support non-strict mode
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1536935328.git.robin.murphy@arm.com>
 <09be4304bf23dde899be48dbddd93b09296f76bd.1536935328.git.robin.murphy@arm.com>
 <20180918171020.GM16498@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a6738582-2b18-8463-b525-73deb70797d1@arm.com>
Date:   Tue, 18 Sep 2018 20:22:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918171020.GM16498@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 6:10 PM, Will Deacon wrote:
> On Fri, Sep 14, 2018 at 03:30:24PM +0100, Robin Murphy wrote:
>> All we need is to wire up .flush_iotlb_all properly and implement the
>> domain attribute, and iommu-dma and io-pgtable-arm will do the rest for
>> us. Rather than bother implementing it for v7s format for the highly
>> unlikely chance of that being relevant, we can simply hide the
>> non-strict flag from io-pgtable for that combination just so anyone who
>> does actually try it will simply get over-invalidation instead of
>> failure to initialise domains.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 40 +++++++++++++++++++++++++++++++++-------
>>   1 file changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index fd1b80ef9490..aa5be334753b 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -246,6 +246,7 @@ struct arm_smmu_domain {
>>   	const struct iommu_gather_ops	*tlb_ops;
>>   	struct arm_smmu_cfg		cfg;
>>   	enum arm_smmu_domain_stage	stage;
>> +	bool				non_strict;
>>   	struct mutex			init_mutex; /* Protects smmu pointer */
>>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>>   	struct iommu_domain		domain;
>> @@ -863,6 +864,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>>   
>> +	if (smmu_domain->non_strict && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH32_S)
>> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> 
> Does this mean we end up over-invalidating when using short-descriptor?
> Could we not bypass the flush queue in this case instead? Ideally, we'd
> just reject the domain attribute but I don't know if we know about the
> page-table format early enough for that. Alternatively, we could force
> long format if the attribute is set.
> 
> What do you think?

If someone manages to run an arm64 kernel on a theoretical SMMUv2 
implementation which only supports short-descriptor, *and* explicitly 
sets the command-line option, then yes, they'll get both the synchronous 
TLBIs and the periodic TLBIALLs. As implied by the commit message, my 
natural response is "don't do that".

However, it will almost certainly take more effort to argue about it or 
come up with other bodges than it will to just implement the quirk in 
the v7s code, so if you really think it's a valid concern just shout.

Robin.
