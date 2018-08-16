Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0094221480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0094221480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392127AbeHPSpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:45:34 -0400
Received: from foss.arm.com ([217.140.101.70]:38020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389292AbeHPSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:45:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844137A9;
        Thu, 16 Aug 2018 08:46:17 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994733F5BD;
        Thu, 16 Aug 2018 08:46:16 -0700 (PDT)
Subject: Re: [PATCH 06/13] coresight: etb10: Handle errors enabling the device
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-7-git-send-email-suzuki.poulose@arm.com>
 <20180815193807.GB17954@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <b62fec35-ca6b-acf3-4201-0a2776672798@arm.com>
Date:   Thu, 16 Aug 2018 16:46:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815193807.GB17954@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/18 20:38, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:48PM +0100, Suzuki K Poulose wrote:
>> Prepare the etb10 driver to return errors in enabling
>> the device.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 9fd77fd..37d2c88 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -107,7 +107,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>>   	return depth;
>>   }
>>   
>> -static void etb_enable_hw(struct etb_drvdata *drvdata)
>> +static void __etb_enable_hw(struct etb_drvdata *drvdata)
>>   {
>>   	int i;
>>   	u32 depth;
>> @@ -135,6 +135,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
>>   	CS_LOCK(drvdata->base);
>>   }
>>   
>> +static int etb_enable_hw(struct etb_drvdata *drvdata)
>> +{
>> +	__etb_enable_hw(drvdata);
>> +	return 0;
>> +}
>> +
>>   static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>>   {
>>   	int ret = 0;
>> @@ -150,7 +156,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>>   	if (mode == CS_MODE_PERF) {
>>   		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
>>   		if (ret)
>> -			goto out;
>> +			return ret;
>>   	}
>>   
>>   	val = local_cmpxchg(&drvdata->mode,
>> @@ -172,12 +178,14 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
>>   		goto out;
> 
> Leaving this here doesn't compile when 'out' is removed below.

I will fix it for arm32. Sorry about that.

Suzuki
