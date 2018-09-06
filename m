Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE63620844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE63620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeIFVsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:48:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeIFVsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:48:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351427A9;
        Thu,  6 Sep 2018 10:11:59 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EFBE3F557;
        Thu,  6 Sep 2018 10:11:57 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Kevin Hilman <khilman@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
To:     Olof Johansson <olof@lixom.net>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
 <1536246639-7420-1-git-send-email-sudeep.holla@arm.com>
 <20180906165932.csa5b4vlmaekv5y2@localhost>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <bc4cb705-e9a4-d006-66f0-7b32128b39d0@arm.com>
Date:   Thu, 6 Sep 2018 18:11:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906165932.csa5b4vlmaekv5y2@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/18 17:59, Olof Johansson wrote:
> Hi,
> 
> On Thu, Sep 06, 2018 at 04:10:39PM +0100, Sudeep Holla wrote:
>> Firmware can provide zero as values for sustained performance level and
>> corresponding sustained frequency in kHz in order to hide the actual
>> frequencies and provide only abstract values. It may endup with divide
>> by zero scenario resulting in kernel panic.
>>
>> Let's set the multiplication factor to one if either one or both of them
>> (sustained_perf_level and sustained_freq) are set to zero.
>>
>> Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
>> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/arm_scmi/perf.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> Hi ARM SoC team,
>>
>> Can you pick this patch directly ?
> 
> Applied, however:
> 

Thanks.

>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index 721e6c57beae..64342944d917 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>>  					le32_to_cpu(attr->sustained_freq_khz);
>>  		dom_info->sustained_perf_level =
>>  					le32_to_cpu(attr->sustained_perf_level);
>> -		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
>> +		if (!dom_info->sustained_freq_khz ||
>> +		    !dom_info->sustained_perf_level)
>> +			/* CPUFreq converts to kHz, hence default 1000 */
>> +			dom_info->mult_factor =	1000;
>> +		else
>> +			dom_info->mult_factor =
>> +					(dom_info->sustained_freq_khz * 1000) /
>>  					dom_info->sustained_perf_level;
>>  		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
> 
> I noticed you do memcpy of these name strings in a few places, and use
> it as a string. Any firmware that would return a non-terminated string
> would cause problems later on. strlcpy() might be a better approach.
> 

I seem to have assumed firmware always conforms to the definition: "Null
terminated ASCII string of up to 16 bytes in length" when I initially
wrote this.

Thanks for the finding this and the suggestion, it's always safer to
protect against firmware bugs. I will find all the occurrences and fix them.

-- 
Regards,
Sudeep
