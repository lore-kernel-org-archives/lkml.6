Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEQJU4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:20:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35478 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeEQJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:20:54 -0400
X-Google-Smtp-Source: AB8JxZpgdHy5TsPWX0b9x+t0/VRtwX4jFGDbH8LwSYow7CSS8usElpk24T4g9QzyMle0xsMqv2/7zA==
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: check if the runtime pm enabled
To: Vinod <vkoul@kernel.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180514161852.9620-1-srinivas.kandagatla@linaro.org>
 <20180517052107.GT13271@vkoul-mobl>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2136d6a5-c039-d319-0d32-b0f6ef81e4e0@linaro.org>
Date: Thu, 17 May 2018 10:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180517052107.GT13271@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/18 06:21, Vinod wrote:
> On 14-05-18, 17:18, Srinivas Kandagatla wrote:
>> Disabling pm runtime at probe is not sufficient to get BAM working
>> on remotely controller instances. pm_runtime_get_sync() would return
>> -EACCES in such cases.
>> So check if runtime pm is enabled before returning error from bam functions.
>>
>> Fixes: 5b4a68952a89 ("dmaengine: qcom: bam_dma: disable runtime pm on remote controlled")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/dma/qcom/bam_dma.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index d29275b97e84..5f4babebc508 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -540,7 +540,7 @@ static void bam_free_chan(struct dma_chan *chan)
>>   	int ret;
>>   
>>   	ret = pm_runtime_get_sync(bdev->dev);
>> -	if (ret < 0)
>> +	if (pm_runtime_enabled(bdev->dev) && ret < 0)
> 
> would it make sense to first check enabled and do _get_sync()
>
Both of them check the disable_depth, however doing it the way you 
suggested would avoid some additional calls.

>          if (pm_runtime_enabled()) {
>                  ret = pm_runtime_get_sync() {
>                  ...
>                  }
>          }
sound like good idea!
> 
Just noticed that some of the drivers use:

         err = pm_runtime_get_sync(dev);
         if (err < 0 && err !=-EACCES)
		return;

others warp up this into local function.

Will send a v2!


thanks,
srini

> thus making clear in code that we do calls only when it is enabled. Also you can
> add a local macro for this code and use that rather than copy pasting :)
> 
