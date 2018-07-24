Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1ECC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jbk6DANv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Na4O470X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF6D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeGXKp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:45:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388185AbeGXKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:45:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B4D4760B15; Tue, 24 Jul 2018 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532425188;
        bh=wnG+HoMq0Rt6ToeRuCWm9AvgGmdpKxxZgT8KvvGu8uc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jbk6DANvy7T0aPCJBwSZf0riNGktyMUhmo+ieWaGCAOn670ZAsSodzLvtYUkdDHWP
         Bp4IedLM6YDFwI4/js7kK2XIwOj1BwyIvudQ7zBi60XZe4n2YfRzginZmUCULXHBUN
         ynuYjvUybMkXzA7SKSdE2Lrc0WnMA4jF42foCGnU=
Received: from [10.79.40.85] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3255602BC;
        Tue, 24 Jul 2018 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532425187;
        bh=wnG+HoMq0Rt6ToeRuCWm9AvgGmdpKxxZgT8KvvGu8uc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Na4O470Xz49INxVGDFGgIMV4ZHEhjl5p0FH0ADy05R4uRB8yXxtN9VjPPY8KEVeD4
         NZNf5sjknm/MFYsuFlsHfwQZRcqMq37+kq2sPAt91g6V9f5xMF1oIwA3K82VfRkthT
         PXtVCuLd3Er3Yc7edkrDgJEVwyx0/M7nFcz5GXAc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3255602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context
 interrupts
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        andy.gross@linaro.org, mark.rutland@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-4-vivek.gautam@codeaurora.org>
 <20180724083633.GA19324@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <d6796a00-17da-c03e-ca7f-7a67139ad99a@codeaurora.org>
Date:   Tue, 24 Jul 2018 15:09:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724083633.GA19324@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


On 7/24/2018 2:06 PM, Will Deacon wrote:
> On Thu, Jul 19, 2018 at 11:23:56PM +0530, Vivek Gautam wrote:
>> Currently we check if the number of context banks is not equal to
>> num_context_interrupts. However, there are booloaders such as, one
>> on sdm845 that reserves few context banks and thus kernel views
>> less than the total available context banks.
>> So, although the hardware definition in device tree would mention
>> the correct number of context interrupts, this number can be
>> greater than the number of context banks visible to smmu in kernel.
>> We should therefore error out only when the number of context banks
>> is greater than the available number of context interrupts.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Suggested-by: Tomasz Figa <tfiga@chromium.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 7c69736a30f8..4cb53bf4f423 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	if (err)
>>   		return err;
>>   
>> -	if (smmu->version == ARM_SMMU_V2 &&
>> -	    smmu->num_context_banks != smmu->num_context_irqs) {
>> -		dev_err(dev,
>> -			"found only %d context interrupt(s) but %d required\n",
>> -			smmu->num_context_irqs, smmu->num_context_banks);
>> -		return -ENODEV;
>> +	if (smmu->version == ARM_SMMU_V2) {
>> +		if (smmu->num_context_banks > smmu->num_context_irqs) {
>> +			dev_err(dev,
>> +			      "found only %d context irq(s) but %d required\n",
>> +			      smmu->num_context_irqs, smmu->num_context_banks);
>> +			return -ENODEV;
>> +		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
>> +			/* loose extra context interrupts */
>> +			dev_notice(dev,
>> +			      "found %d context irq(s) but only %d required\n",
>> +			      smmu->num_context_irqs, smmu->num_context_banks);
>> +			smmu->num_context_irqs = smmu->num_context_banks;
>> +		}
> I don't see the utility in the new message. Can you simplify with the patch
> below on top? It's a bit weird that we only decide to ignore the extra irqs
> after calling platform_get_irq() on them, but that seems to be harmless.

Thanks. I will modify as suggested below and respin.

Best regards
Vivek

>
> Will
>
> --->8
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index aa46c1ed5bf9..5349e22b5c78 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2109,13 +2109,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   			      "found only %d context irq(s) but %d required\n",
>   			      smmu->num_context_irqs, smmu->num_context_banks);
>   			return -ENODEV;
> -		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
> -			/* loose extra context interrupts */
> -			dev_notice(dev,
> -			      "found %d context irq(s) but only %d required\n",
> -			      smmu->num_context_irqs, smmu->num_context_banks);
> -			smmu->num_context_irqs = smmu->num_context_banks;
>   		}
> +
> +		/* Ignore superfluous interrupts */
> +		smmu->num_context_irqs = smmu->num_context_banks;
>   	}
>   
>   	for (i = 0; i < smmu->num_global_irqs; ++i) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

