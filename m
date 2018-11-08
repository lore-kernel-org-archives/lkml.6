Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE2C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33F920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33F920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeKHTYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:24:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37230 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeKHTYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:24:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCA9E80D;
        Thu,  8 Nov 2018 01:49:30 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAF1E3F5CF;
        Thu,  8 Nov 2018 01:49:29 -0800 (PST)
Subject: Re: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated
 from perf
To:     leo.yan@linaro.org, Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
 <20181107032350.GH3983@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <054f82c1-451f-3c82-d5ab-e156c50e0c10@arm.com>
Date:   Thu, 8 Nov 2018 09:49:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107032350.GH3983@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo,

On 07/11/2018 03:23, leo.yan@linaro.org wrote:
> Hi Mathieu,
> 
> On Mon, Nov 05, 2018 at 03:26:30PM -0700, Mathieu Poirier wrote:
>> This patch deals with the release of the CLAIM tag when the ETM is
>> operated from perf.  Otherwise the tag is left asserted and subsequent
>> requests to use the device fail.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>> index fd5c4cca7db5..000796394662 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>> @@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
>>   	 */
>>   	etm_set_pwrdwn(drvdata);
>>   
>> +	coresight_disclaim_device_unlocked(drvdata->base);
>> +


> 
> Just remind, this isn't consistent with the sequency in function
> etm_disable_hw(), which has the reversed sequence between
> etm_set_pwrdwn() and coresight_disclaim_device_unlocked().
> 
> Not sure which one sequence is more suitable, at the first glance,
> accessing register after pwrdwn related operation might have risk for
> deadlock?

Good point.

I assume that the CLAIMSET/CLR registers are in the same power domain as
the LAR (Software Lock Access register) accessed below. But I will
confirm this with the architect. Based on the response, we could
streamline both the sequences.

Suzuki

> 
> Thanks,
> Leo Yan
> 
>>   	CS_LOCK(drvdata->base);
>>   }
>>   
>> -- 
>> 2.7.4
>>
