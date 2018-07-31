Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10098C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A666920857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeGaXOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:14:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbeGaXOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:14:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221A780D;
        Tue, 31 Jul 2018 14:32:04 -0700 (PDT)
Received: from [10.37.10.25] (unknown [10.37.10.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D863F5BA;
        Tue, 31 Jul 2018 14:32:02 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] coresight: etb10: Fix handling of perf mode
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
 <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
 <20180731170731.GA11692@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7b311596-025a-f4f4-1859-6f3531258b75@arm.com>
Date:   Tue, 31 Jul 2018 22:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180731170731.GA11692@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 06:07 PM, Mathieu Poirier wrote:
> Hello,
> 
> On Thu, Jul 26, 2018 at 01:54:40PM +0100, Suzuki K Poulose wrote:
>> If the ETB is already enabled in sysfs mode, the ETB reports
>> success even if a perf mode is requested. Fix this by checking
>> the requested mode.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etb10.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 306119e..e5808fd 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -148,8 +148,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
>>   		return -EBUSY;
>>   
>>   	/* Nothing to do, the tracer is already enabled. */
>> -	if (val == CS_MODE_SYSFS)
>> -		goto out;
>> +	if (val == CS_MODE_SYSFS) {
>> +		if (mode == CS_MODE_SYSFS)
>> +			goto out;
>> +		else
>> +			return -EBUSY;
>> +	}
> 
> How about:
> 
>          if (val == CS_MODE_PERF)
>                  return -EBUSY;
>   
> +       /* Don't let perf disturb sysFS sessions */
> +       if (val == CS_MODE_SYSFS && mode = CS_MODE_PERF)
> +               return -EBUSY;
> +
>          /* Nothing to do, the tracer is already enabled. */
>          if (val == CS_MODE_SYSFS)
>                  goto out;
> 
> 
> I just find it more readable that way.

Sure, thats fine by me.

Cheers
Suzuki

