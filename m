Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F93DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDE4208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDE4208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbeHPRq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:46:58 -0400
Received: from foss.arm.com ([217.140.101.70]:37448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387920AbeHPRq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:46:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8110C7A9;
        Thu, 16 Aug 2018 07:47:58 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F1E3F5D0;
        Thu, 16 Aug 2018 07:47:57 -0700 (PDT)
Subject: Re: [PATCH 03/13] coresight: tmc-etb/etf: Prepare to handle errors
 enabling
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-4-git-send-email-suzuki.poulose@arm.com>
 <20180815192246.GA11625@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <0c55731b-b1cb-18ed-bf7c-057d1310cfdc@arm.com>
Date:   Thu, 16 Aug 2018 15:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815192246.GA11625@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/18 20:22, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:45PM +0100, Suzuki K Poulose wrote:
>> Prepare to handle errors in enabling the hardware and
>> report it back to the core driver.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 71 +++++++++++++++----------
>>   1 file changed, 44 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 4156c95..ceb4b30 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c

>> @@ -271,6 +285,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>>   static int tmc_enable_etf_link(struct coresight_device *csdev,
>>   			       int inport, int outport)
>>   {
>> +	int ret;
>>   	unsigned long flags;
>>   	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>   
>> @@ -280,11 +295,13 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>>   		return -EBUSY;
>>   	}
>>   
>> -	tmc_etf_enable_hw(drvdata);
>> -	drvdata->mode = CS_MODE_SYSFS;
>> +	ret = tmc_etf_enable_hw(drvdata);
>> +	if (!ret)
>> +		drvdata->mode = CS_MODE_SYSFS;
>>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>   
>> -	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
>> +	if (!ret)
>> +		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
>>   	return 0;
> 
> We need to tell the caller if an error as occured:
> 
>          return ret;
> 

Thanks for catching it, will fix.

Suzuki
