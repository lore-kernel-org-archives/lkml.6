Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbeE2JjV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:39:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932354AbeE2JjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:39:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6F006031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] time: Fix sleeptime injection for non-stop clocksource &
 persistent clock
To: Vinod Koul <vinod.koul@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527581718-5624-1-git-send-email-mojha@codeaurora.org>
 <20180529084819.GI5666@vkoul-mobl>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6a7557ac-9660-0cb6-c76b-008a3e28b2b6@codeaurora.org>
Date: Tue, 29 May 2018 15:09:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529084819.GI5666@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2018 2:18 PM, Vinod Koul wrote:
> On 29-05-18, 13:45, Mukesh Ojha wrote:
>> Currently, for both non-stop clocksource and persistent clock
>> there is a corner case, when a driver failed to go suspend mode
>> rtc_resume injects the sleeptime as timekeeping_rtc_skipresume
>> returned 'false' due to which we can see mismatch in time with
>> system clock.
>>
>> Success case:
>>                                           {sleeptime_injected=true}
>> rtc_suspend() => timekeeping_suspend() => timekeeping_resume() => rtc_resume()
>>
>> Failure case:
>>               {failure in sleep path} {sleeptime_injected=false}
>> rtc_suspend()       =>             rtc_resume()
>>
>> Change-Id: I98928761c98cec21a3033a55d3e10fb34138f38c
> This does not belong in upstream please remove. I think checkpatch warns.
>
> Also I see that you have sent to lkml and arm-msm mailing list, but have not
> CCed any maintainers. Please run ./scripts/get_maintainer.pl to find who to send
> patches to. Chances are it will get ignored...

Thanks Vinod.
Will resend it after including maintainers.

-Mukesh
>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>>   kernel/time/timekeeping.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 427e33d..c022d82 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1511,9 +1511,6 @@ void __weak read_boot_clock64(struct timespec64 *ts)
>>   	ts->tv_nsec = 0;
>>   }
>>   
>> -/* Flag for if timekeeping_resume() has injected sleeptime */
>> -static bool sleeptime_injected;
>> -
>>   /* Flag for if there is a persistent clock on this platform */
>>   static bool persistent_clock_exists;
>>   
>> @@ -1611,7 +1608,14 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
>>    */
>>   bool timekeeping_rtc_skipresume(void)
>>   {
>> -	return sleeptime_injected;
>> +	struct timekeeper *tk = &tk_core.timekeeper;
>> +	bool skip_rtc_resume = false;
>> +
>> +	skip_rtc_resume = ((tk->tkr_mono.clock->flags &
>> +			CLOCK_SOURCE_SUSPEND_NONSTOP) ||
>> +			(persistent_clock_exists)) ? true : false;
>> +
>> +	return skip_rtc_resume;
>>   }
>>   
>>   /**
>> @@ -1671,8 +1675,8 @@ void timekeeping_resume(void)
>>   	unsigned long flags;
>>   	struct timespec64 ts_new, ts_delta;
>>   	cycle_t cycle_now, cycle_delta;
>> +	bool sleeptime_injected = false;
>>   
>> -	sleeptime_injected = false;
>>   	read_persistent_clock64(&ts_new);
>>   
>>   	clockevents_resume();
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
>> Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
