Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeBSKYM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:24:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeBSKYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:24:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 19 Feb 2018 15:54:09 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] i2c: qup: fixed releasing dma without flush
 operation completion
In-Reply-To: <0ff28076-b105-9280-a7e0-767f923768fa@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
 <0ff28076-b105-9280-a7e0-767f923768fa@codeaurora.org>
Message-ID: <4d6ece838847032b87af6374264ea21b@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-08 19:33, Sricharan R wrote:
> Hi Abhishek,
> 
> On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
>> The QUP BSLP BAM generates the following error sometimes if the
>> current I2C DMA transfer fails and the flush operation has been
>> scheduled
>> 
>>     “bam-dma-engine 7884000.dma: Cannot free busy channel”
>> 
>> If any I2C error comes during BAM DMA transfer, then the QUP I2C
>> interrupt will be generated and the flush operation will be
>> carried out to make i2c consume all scheduled DMA transfer.
>> Currently, the same completion structure is being used for BAM
>> transfer which has already completed without reinit. It will make
>> flush operation wait_for_completion_timeout completed immediately
>> and will proceed for freeing the DMA resources where the
>> descriptors are still in process.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index 08f8e01..9faa26c41a 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Copyright (c) 2009-2013, The Linux Foundation. All rights 
>> reserved.
>> + * Copyright (c) 2009-2013, 2016-2018, The Linux Foundation. All 
>> rights reserved.
> 
> Not sure, if this was an intended change. But given that you are fixing 
> this,

  Thanks Sricharan.
  Since this is the first patch, so I updated the year.

> you can change the header to the new SPDX one.
> 

  Yes that would be better.
  I will fix that also.

  Thanks,
  Abhishek

>>   * Copyright (c) 2014, Sony Mobile Communications AB.
>>   *
>>   *
>> @@ -844,6 +844,8 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev 
>> *qup, struct i2c_msg *msg,
>>  	}
>> 
>>  	if (ret || qup->bus_err || qup->qup_err) {
>> +		reinit_completion(&qup->xfer);
>> +
>>  		if (qup_i2c_change_state(qup, QUP_RUN_STATE)) {
>>  			dev_err(qup->dev, "change to run state timed out");
>>  			goto desc_err;
>> 
> 
> Except for the above nit,
>   Acked-by: Sricharan R <sricharan@codeaurora.org>
> 
> Regards,
>  Sricharan
