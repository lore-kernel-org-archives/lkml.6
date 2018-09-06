Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F557C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F1220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F1220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeIFTOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:14:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbeIFTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:14:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7737A9;
        Thu,  6 Sep 2018 07:38:17 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E453F3F614;
        Thu,  6 Sep 2018 07:38:15 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
To:     Quentin Perret <quentin.perret@arm.com>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
 <20180906131752.ysubfiufocddpoey@queper01-lin>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <538c5bdc-bd3b-922a-c51c-f47e5cf2257d@arm.com>
Date:   Thu, 6 Sep 2018 15:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906131752.ysubfiufocddpoey@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/18 14:17, Quentin Perret wrote:
> Hi Sudeep,
> 
> On Wednesday 05 Sep 2018 at 17:38:11 (+0100), Sudeep Holla wrote:
>> @@ -166,7 +166,12 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>>  					le32_to_cpu(attr->sustained_freq_khz);
>>  		dom_info->sustained_perf_level =
>>  					le32_to_cpu(attr->sustained_perf_level);
>> -		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
>> +		if (!dom_info->sustained_freq_khz ||
>> +		    !dom_info->sustained_perf_level)
>> +			dom_info->mult_factor =	1;
> 
> I'm sorry I missed that the first time I reviewed this patch, but after
> discussing with Ionela, we found out that there is actually a case where
> this could be a problem. If you have perf levels that are 1,2,3,4 (for
> example), then with mult_factor=1 you'll register OPPs at 1Hz, 2Hz, 3Hz,
> 4Hz into PM_OPP. And that will be turned into 0 KHz for all of them at
> the CPUFreq level when divided by 1000 in dev_pm_opp_init_cpufreq_table().
>

Good find.

> I guess a quick fix would be to have a default mult_factor of 1000 ...
> 

I agree.

> What do you think ?

I will respin and send.

-- 
Regards,
Sudeep
