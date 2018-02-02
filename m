Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeBBV20 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:28:26 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14217 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBBV2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:28:17 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 02 Feb 2018 13:28:16 -0800
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
To: Saravana Kannan <skannan@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: <viresh.kumar@linaro.org>, <sgurrappadi@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
 <1744712.rO4QOLozun@aspire.rjw.lan>
 <913f1715-bdd0-1c03-ad76-38be9d3d2298@nvidia.com>
 <17447147.z6jfkRxuEB@aspire.rjw.lan> <5A74BD55.5000402@codeaurora.org>
X-Nvconfidentiality: public
From: Bo Yan <byan@nvidia.com>
Message-ID: <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com>
Date: Fri, 2 Feb 2018 13:28:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A74BD55.5000402@codeaurora.org>
X-Originating-IP: [172.17.136.14]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL108.nvidia.com (172.18.146.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 11:34 AM, Saravana Kannan wrote:
> On 02/02/2018 03:54 AM, Rafael J. Wysocki wrote:
>> On Wednesday, January 24, 2018 9:53:14 PM CET Bo Yan wrote:
>>>
>>> On 01/23/2018 06:02 PM, Rafael J. Wysocki wrote:
>>>> On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
>>>>>    drivers/cpufreq/cpufreq.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>> index 41d148af7748..95b1c4afe14e 100644
>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>> @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
>>>>>        if (!cpufreq_driver)
>>>>>            return;
>>>>>
>>>>> +    if (unlikely(!cpufreq_suspended)) {
>>>>> +        pr_warn("%s: resume after failing suspend\n", __func__);
>>>>> +        return;
>>>>> +    }
>>>>>        cpufreq_suspended = false;
>>>>>
>>>>>        if (!has_target() && !cpufreq_driver->resume)
>>>>>
>>>> Good catch, but rather than doing this it would be better to avoid
>>>> calling cpufreq_resume() at all if cpufreq_suspend() has not been 
>>>> called.
>>> Yes, I thought about that, but there is no good way to skip over it
>>> without introducing another flag. cpufreq_resume is called by
>>> dpm_resume, cpufreq_suspend is called by dpm_suspend. In the failure
>>> case, dpm_resume is called, but dpm_suspend is not. So on a higher 
>>> level
>>> it's already unbalanced.
>>>
>>> One possibility is to rely on the pm_transition flag. So something 
>>> like:
>>>
>>>
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index dc259d20c967..8469e6fc2b2c 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -842,6 +842,7 @@ static void async_resume(void *data, async_cookie_t
>>> cookie)
>>>    void dpm_resume(pm_message_t state)
>>>    {
>>>           struct device *dev;
>>> +       bool suspended = (pm_transition.event != PM_EVENT_ON);
>>>           ktime_t starttime = ktime_get();
>>>
>>>           trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>>> @@ -885,7 +886,8 @@ void dpm_resume(pm_message_t state)
>>>           async_synchronize_full();
>>>           dpm_show_time(starttime, state, NULL);
>>>
>>> -       cpufreq_resume();
>>> +       if (likely(suspended))
>>> +               cpufreq_resume();
>>>           trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>>>    }
>>
>> I was thinking about something else.
>>
>> Anyway, I think your original patch is OK too, but without printing the
>> message.  Just combine the cpufreq_suspended check with the 
>> cpufreq_driver
>> one and the unlikely() thing is not necessary.
>>
>
> I rather have this fixed in the dpm_suspend/resume() code. This is 
> just masking the first issue that's being caused by unbalanced error 
> handling. If that means adding flags in dpm_suspend/resume() then 
> that's what we should do right now and clean it up later if it can be 
> improved. Making cpufreq more messy doesn't seem like the right answer.
>
> Thanks,
> Saravana
>
>
dpm_suspend and dpm_resume by themselves are not balanced in this 
particular case. As it's currently structured, dpm_resume can't be 
omitted even if dpm_suspend is skipped due to earlier failure.  I think 
checking cpufreq_suspended flag is a reasonable compromise. If we can 
find a way to make dpm_suspend/dpm_resume also balanced, that will be best.
