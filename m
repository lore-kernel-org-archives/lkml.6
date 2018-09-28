Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E5A21528
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E5A21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeI1UZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:25:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50972 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbeI1UZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:25:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82515ED1;
        Fri, 28 Sep 2018 07:01:05 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5D6B3F5B3;
        Fri, 28 Sep 2018 07:01:03 -0700 (PDT)
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
 <1d2b57f7-be4e-39c5-4981-7f8e2f601b6a@arm.com>
 <20180928124704.GC1577@brain-police> <20180928135532.GA1581@brain-police>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <870b3c97-d05d-63a4-91e9-9f23099fad34@arm.com>
Date:   Fri, 28 Sep 2018 15:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928135532.GA1581@brain-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 14:55, Will Deacon wrote:
> On Fri, Sep 28, 2018 at 01:47:04PM +0100, Will Deacon wrote:
>> On Fri, Sep 28, 2018 at 01:26:00PM +0100, Robin Murphy wrote:
>>> On 28/09/18 13:19, Will Deacon wrote:
>>>> On Thu, Sep 20, 2018 at 05:10:25PM +0100, Robin Murphy wrote:
>>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>>> index f10c852479fc..db402e8b068b 100644
>>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>>> @@ -612,6 +612,7 @@ struct arm_smmu_domain {
>>>>>    	struct mutex			init_mutex; /* Protects smmu pointer */
>>>>>    	struct io_pgtable_ops		*pgtbl_ops;
>>>>> +	bool				non_strict;
>>>>>    	enum arm_smmu_domain_stage	stage;
>>>>>    	union {
>>>>> @@ -1407,6 +1408,12 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>>>>    		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>>>>>    	}
>>>>> +	/*
>>>>> +	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
>>>>> +	 * PTEs previously cleared by unmaps on the current CPU not yet visible
>>>>> +	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
>>>>> +	 * to guarantee those are observed before the TLBI. Do be careful, 007.
>>>>> +	 */
>>>>
>>>> Good, so you can ignore my comment on the previous patch :)
>>>
>>> Well, I suppose that comment in io-pgtable *could* have explicitly noted
>>> that same-CPU order is dealt with elsewhere - feel free to fix it up if you
>>> think it would be a helpful reminder for the future.
>>
>> I think I'll move it into the documentation for the new attribute, so that
>> any driver authors wanting to enable lazy invalidation know that they need
>> to provide this guarantee in their full TLB invalidation callback.
> 
> Hmm, so I started doing this but then realised we already required this
> behaviour for tlb_add_flush() afaict. That would mean that mainline
> currently has a bug for arm-smmu.c, because we use the _relaxed I/O
> accessors in there and there's no DSB after clearing the PTE on unmap().
> 
> Am I missing something?

Argh, no - I started having the same suspicion when changing those 
writel()s in patch #7, resolved to either mention it to you or 
investigate it myself as a separate fix, then promptly forgot entirely. 
Thanks for the reminder...

Robin.
