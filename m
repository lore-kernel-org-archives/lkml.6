Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0E208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF0E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeK2Di4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:38:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbeK2Diz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:38:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940D93644;
        Wed, 28 Nov 2018 08:36:41 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2793F5AF;
        Wed, 28 Nov 2018 08:36:38 -0800 (PST)
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Stephen Boyd <sboyd@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, robh+dt@kernel.org, will.deacon@arm.com
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thor.thayer@linux.intel.com
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
 <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
Date:   Wed, 28 Nov 2018 16:36:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2018 16:24, Stephen Boyd wrote:
> Quoting Vivek Gautam (2018-11-27 02:11:41)
>> @@ -1966,6 +1970,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>   
>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>> +                                  const char * const *clks)
>> +{
>> +       int i;
>> +
>> +       if (smmu->num_clks < 1)
>> +               return;
>> +
>> +       smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>> +                                 sizeof(*smmu->clks), GFP_KERNEL);
>> +       if (!smmu->clks)
>> +               return;
>> +
>> +       for (i = 0; i < smmu->num_clks; i++)
>> +               smmu->clks[i].id = clks[i];
> 
> Is this clk_bulk_get_all()?

Ooh, did that finally get merged while we weren't looking? Great!

Much as I don't want to drag this series out to a v19, it *would* be 
neat if we no longer need to open-code that bit...

Robin.
