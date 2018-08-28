Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB82208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F1GvUkaa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N9rYuBI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB82208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeH1KtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:49:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeH1KtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:49:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7BA8E604BE; Tue, 28 Aug 2018 06:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535439549;
        bh=rYHGFQua5yUKkHi3ur7wqg3hOvWel1YiSJuqmXJx+cU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F1GvUkaaH6her/M+Y2pTOQ+j6zoVW3rgS2KxU0Il+z7i+CBhRUKlyXkp/OMMJfdyy
         eAArHZek+SsA5zom4iA4tQgsMoDEdH3i2qtqVvsc2L+ebNtwUKZBUeju00GMrqPxJs
         y5rvl4jkO0Y6ahrVhVC+0VTs3qDjvXfgJjV0rqCw=
Received: from [10.79.40.134] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B49A56021C;
        Tue, 28 Aug 2018 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535439548;
        bh=rYHGFQua5yUKkHi3ur7wqg3hOvWel1YiSJuqmXJx+cU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N9rYuBI07rC0aIyN7oexKusQlW+/6WM/RYHIhUyvo3GeSRD/O/8jQZLvPavV/VDWR
         mdIzCSwUhYOc6uOQtGXEvHLFvblMqUh2qQb4g4ibAPjc/D0VOVHUr7uDwBrEcTyN2W
         67wO1q+D2I55abkTBUbE1bEZl2qyYn8UXnz0z5qE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B49A56021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 4/5] iommu/arm-smmu: Make way to add Qcom's smmu-500
 errata handling
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        andy.gross@linaro.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814105528.20592-5-vivek.gautam@codeaurora.org>
 <cfca5369-eacd-bb4b-6f1e-68a56f72c327@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <1b73ab8e-a5fa-e917-cd78-1e0fafe8d00f@codeaurora.org>
Date:   Tue, 28 Aug 2018 12:29:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cfca5369-eacd-bb4b-6f1e-68a56f72c327@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


On 8/14/2018 10:29 PM, Robin Murphy wrote:
> On 14/08/18 11:55, Vivek Gautam wrote:
>> Cleanup to re-use some of the stuff
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>
> I think the overall diffstat would be an awful lot smaller if the 
> erratum workaround just has its own readl_poll_timeout() as it does in 
> the vendor kernel. The burst-polling loop is for minimising latency in 
> high-throughput situations, and if you're in a workaround which has to 
> lock *every* register write and issue two firmware calls around each 
> sync I think you're already well out of that game.

Sorry for the delayed response. I was on vacation.
I will fix this in my next version by adding the separate 
read_poll_timeout() for the erratum WA.

>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 32e86df80428..75c146751c87 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -391,21 +391,31 @@ static void __arm_smmu_free_bitmap(unsigned 
>> long *map, int idx)
>>       clear_bit(idx, map);
>>   }
>>   -/* Wait for any pending TLB invalidations to complete */
>> -static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
>> -                void __iomem *sync, void __iomem *status)
>> +static int __arm_smmu_tlb_sync_wait(void __iomem *status)
>>   {
>>       unsigned int spin_cnt, delay;
>>   -    writel_relaxed(0, sync);
>>       for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>>           for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
>>               if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
>> -                return;
>> +                return 0;
>>               cpu_relax();
>>           }
>>           udelay(delay);
>>       }
>> +
>> +    return -EBUSY;
>> +}
>> +
>> +/* Wait for any pending TLB invalidations to complete */
>> +static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
>> +                void __iomem *sync, void __iomem *status)
>> +{
>> +    writel_relaxed(0, sync);
>> +
>> +    if (!__arm_smmu_tlb_sync_wait(status))
>> +        return;
>> +
>>       dev_err_ratelimited(smmu->dev,
>>                   "TLB sync timed out -- SMMU may be deadlocked\n");
>>   }
>> @@ -461,8 +471,9 @@ static void arm_smmu_tlb_inv_context_s2(void 
>> *cookie)
>>       arm_smmu_tlb_sync_global(smmu);
>>   }
>>   -static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, 
>> size_t size,
>> -                      size_t granule, bool leaf, void *cookie)
>> +static void __arm_smmu_tlb_inv_range_nosync(unsigned long iova, 
>> size_t size,
>> +                        size_t granule, bool leaf,
>> +                        void *cookie)
>>   {
>>       struct arm_smmu_domain *smmu_domain = cookie;
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> @@ -498,6 +509,13 @@ static void 
>> arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>>       }
>>   }
>>   +static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, 
>> size_t size,
>> +                      size_t granule, bool leaf,
>> +                      void *cookie)
>> +{
>> +    __arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
>> +}
>> +
>
> AFAICS even after patch #5 this does absolutely nothing except make 
> the code needlessly harder to read :(

Sure, I will rather call arm_smmu_tlb_inv_range_nosync() from
qcom_errata_tlb_inv_range_nosync() then make this change.
Thanks for the review.

Best regards
Vivek

>
> Robin.
>
>>   /*
>>    * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs 
>> appears
>>    * almost negligible, but the benefit of getting the first one in 
>> as far ahead
>>

