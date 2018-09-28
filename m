Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A452170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A452170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeI1Sti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:49:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48496 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeI1Stg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:49:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D167ED1;
        Fri, 28 Sep 2018 05:26:04 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1CA3F5D3;
        Fri, 28 Sep 2018 05:26:02 -0700 (PDT)
Subject: Re: [PATCH v8 5/7] iommu/arm-smmu-v3: Add support for non-strict mode
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1537458163.git.robin.murphy@arm.com>
 <b98f8f695178c9c9ac6e081680090d5ac97e8d7c.1537458163.git.robin.murphy@arm.com>
 <20180928121900.GB1577@brain-police>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d2b57f7-be4e-39c5-4981-7f8e2f601b6a@arm.com>
Date:   Fri, 28 Sep 2018 13:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928121900.GB1577@brain-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 13:19, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 05:10:25PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Now that io-pgtable knows how to dodge strict TLB maintenance, all
>> that's left to do is bridge the gap between the IOMMU core requesting
>> DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE for default domains, and showing the
>> appropriate IO_PGTABLE_QUIRK_NON_STRICT flag to alloc_io_pgtable_ops().
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> [rm: convert to domain attribute, tweak commit message]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v8:
>>   - Use nested switches for attrs
>>   - Document barrier semantics
>>
>>   drivers/iommu/arm-smmu-v3.c | 79 ++++++++++++++++++++++++++-----------
>>   1 file changed, 56 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index f10c852479fc..db402e8b068b 100644
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
>> @@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>>   	}
>>   
>> +	/*
>> +	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
>> +	 * PTEs previously cleared by unmaps on the current CPU not yet visible
>> +	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
>> +	 * to guarantee those are observed before the TLBI. Do be careful, 007.
>> +	 */
> 
> Good, so you can ignore my comment on the previous patch :)

Well, I suppose that comment in io-pgtable *could* have explicitly noted 
that same-CPU order is dealt with elsewhere - feel free to fix it up if 
you think it would be a helpful reminder for the future.

Cheers,
Robin.
