Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbeBBTe4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:34:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeBBTer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:34:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6E1B6050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A74BD55.5000402@codeaurora.org>
Date: Fri, 02 Feb 2018 11:34:45 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Bo Yan <byan@nvidia.com>, viresh.kumar@linaro.org,
        sgurrappadi@nvidia.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
References: <1516744675-21233-1-git-send-email-byan@nvidia.com> <1744712.rO4QOLozun@aspire.rjw.lan> <913f1715-bdd0-1c03-ad76-38be9d3d2298@nvidia.com> <17447147.z6jfkRxuEB@aspire.rjw.lan>
In-Reply-To: <17447147.z6jfkRxuEB@aspire.rjw.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 03:54 AM, Rafael J. Wysocki wrote:
> On Wednesday, January 24, 2018 9:53:14 PM CET Bo Yan wrote:
>>
>> On 01/23/2018 06:02 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
>>>>    drivers/cpufreq/cpufreq.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>> index 41d148af7748..95b1c4afe14e 100644
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
>>>>    	if (!cpufreq_driver)
>>>>    		return;
>>>>
>>>> +	if (unlikely(!cpufreq_suspended)) {
>>>> +		pr_warn("%s: resume after failing suspend\n", __func__);
>>>> +		return;
>>>> +	}
>>>>    	cpufreq_suspended = false;
>>>>
>>>>    	if (!has_target() && !cpufreq_driver->resume)
>>>>
>>> Good catch, but rather than doing this it would be better to avoid
>>> calling cpufreq_resume() at all if cpufreq_suspend() has not been called.
>> Yes, I thought about that, but there is no good way to skip over it
>> without introducing another flag. cpufreq_resume is called by
>> dpm_resume, cpufreq_suspend is called by dpm_suspend. In the failure
>> case, dpm_resume is called, but dpm_suspend is not. So on a higher level
>> it's already unbalanced.
>>
>> One possibility is to rely on the pm_transition flag. So something like:
>>
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index dc259d20c967..8469e6fc2b2c 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -842,6 +842,7 @@ static void async_resume(void *data, async_cookie_t
>> cookie)
>>    void dpm_resume(pm_message_t state)
>>    {
>>           struct device *dev;
>> +       bool suspended = (pm_transition.event != PM_EVENT_ON);
>>           ktime_t starttime = ktime_get();
>>
>>           trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>> @@ -885,7 +886,8 @@ void dpm_resume(pm_message_t state)
>>           async_synchronize_full();
>>           dpm_show_time(starttime, state, NULL);
>>
>> -       cpufreq_resume();
>> +       if (likely(suspended))
>> +               cpufreq_resume();
>>           trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>>    }
>
> I was thinking about something else.
>
> Anyway, I think your original patch is OK too, but without printing the
> message.  Just combine the cpufreq_suspended check with the cpufreq_driver
> one and the unlikely() thing is not necessary.
>

I rather have this fixed in the dpm_suspend/resume() code. This is just 
masking the first issue that's being caused by unbalanced error 
handling. If that means adding flags in dpm_suspend/resume() then that's 
what we should do right now and clean it up later if it can be improved. 
Making cpufreq more messy doesn't seem like the right answer.

Thanks,
Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
