Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA9DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B0B2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B0B2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392110AbeHPSov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:44:51 -0400
Received: from foss.arm.com ([217.140.101.70]:37990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389188AbeHPSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6937A9;
        Thu, 16 Aug 2018 08:45:35 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 236983F5BD;
        Thu, 16 Aug 2018 08:45:34 -0700 (PDT)
Subject: Re: [PATCH 05/13] coresight: etm3: Add support for handling errors
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-6-git-send-email-suzuki.poulose@arm.com>
 <20180815193456.GA17954@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <21cdb867-ece1-7da4-810a-da22f1268d90@arm.com>
Date:   Thu, 16 Aug 2018 16:45:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815193456.GA17954@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/18 20:34, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:47PM +0100, Suzuki K Poulose wrote:
>> Add support for reporting errors back from the SMP cross
>> function call for enabling ETM.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm3x.c | 42 ++++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>> index 9ce8fba..771691c 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>> @@ -355,11 +355,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>>   	return 0;
>>   }
>>   
>> -static void etm_enable_hw(void *info)
>> +static int etm_enable_hw(struct etm_drvdata *drvdata)
>>   {
>>   	int i;
>>   	u32 etmcr;
>> -	struct etm_drvdata *drvdata = info;
>>   	struct etm_config *config = &drvdata->config;
>>   
>>   	CS_UNLOCK(drvdata->base);
>> @@ -421,6 +420,21 @@ static void etm_enable_hw(void *info)
>>   	CS_LOCK(drvdata->base);
>>   
>>   	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
>> +	return 0;
>> +}
>> +
>> +struct etm_enable_arg {
>> +	struct etm_drvdata *drvdata;
>> +	int rc;
>> +}
> 
> This doesn't compile a ';' is missing.

Oops. Sorry about that. I will give the series a spin on arm32.

Suzuki
