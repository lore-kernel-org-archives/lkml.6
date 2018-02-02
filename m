Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeBBNTp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:19:45 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35250 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:19:34 -0500
X-Google-Smtp-Source: AH8x2253jQORNqmqQx1fKRimqYkwT87xS9DsM2LBg7YTpqwj35P5ilbfw+CQSFdQmHdd+2iQ56T1M/dIvFB3TUCqu4U=
MIME-Version: 1.0
In-Reply-To: <7d50aeb5-cc2d-521b-2f31-5477e6e18f20@codeaurora.org>
References: <e9d13871-184b-dee3-c45f-c6d19e671eea@codeaurora.org>
 <1949391.4ffJqIIJSQ@aspire.rjw.lan> <7d50aeb5-cc2d-521b-2f31-5477e6e18f20@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2018 14:19:33 +0100
X-Google-Sender-Auth: zRFmxgAt_J1Jl9iVDVHywo_Bkn0
Message-ID: <CAJZ5v0g1vJV5Lo0EaubUePF3X4eYn8nBrf9q3d9fL6s6o=MGPw@mail.gmail.com>
Subject: Re: Query related to usage of cpufreq_suspend() & cpufreq_resume
To: Prateek Sood <prsood@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gkohli@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bo Yan <byan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 1:53 PM, Prateek Sood <prsood@codeaurora.org> wrote:
> On 02/02/2018 05:18 PM, Rafael J. Wysocki wrote:
>> On Friday, February 2, 2018 12:41:58 PM CET Prateek Sood wrote:
>>> Hi Viresh,
>>>
>>> One scenario is there where a kernel panic is observed in
>>> cpufreq during suspend/resume.
>>>
>>> pm_suspend()
>>>   suspend_devices_and_enter()
>>>     dpm_suspend_start()
>>>       dpm_prepare()
>>>
>>> Failure in dpm_prepare() happend with following dmesg:
>>>
>>> [ 3746.316062] PM: Device xyz not prepared for power transition: code -16
>>> [ 3746.316071] PM: Some devices failed to suspend, or early wake event detected
>>>
>>>
>>> pm_suspend()
>>>   suspend_devices_and_enter()
>>>     dpm_suspend_start()
>>>       dpm_prepare() //failed
>>>     dpm_resume_end()
>>>       dpm_resume()
>>>         cpufreq_resume()
>>>           cpufreq_start_governor()
>>>             sugov_start()
>>>               cpufreq_add_update_util_hook()
>>>
>>> After failure in dpm_prepare(), dpm_resume() called
>>> cpufreq_resume(). Corresponding cpufreq_suspend() was not
>>> called due to failure of dpm_prepare().
>>>
>>> This resulted in WARN_ON(per_cpu(cpufreq_update_util_data, cpu))
>>> in cpufreq_add_update_util_hook() and cpufreq_add_update_util_hook->func
>>> being inconsistent state. It caused crash in scheduler.
>>>
>>> Following are some of the ways to mitigate this issue. Could
>>> you please provide feedback on below two approaches or suugest
>>> a better way to fix this problem.
>>>
>>> -----------------------8<------------------------------
>>>
>>> Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>
>>> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>>> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
>>>
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index 02a497e..732e5a2 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -1038,6 +1038,7 @@ void dpm_resume(pm_message_t state)
>>>  {
>>>         struct device *dev;
>>>         ktime_t starttime = ktime_get();
>>> +       bool valid_resume = false;
>>>
>>>         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>>>         might_sleep();
>>> @@ -1055,6 +1056,7 @@ void dpm_resume(pm_message_t state)
>>>         }
>>>
>>>         while (!list_empty(&dpm_suspended_list)) {
>>> +               valid_resume = true;
>>>                 dev = to_device(dpm_suspended_list.next);
>>>                 get_device(dev);
>>>                 if (!is_async(dev)) {
>>> @@ -1080,7 +1082,8 @@ void dpm_resume(pm_message_t state)
>>>         async_synchronize_full();
>>>         dpm_show_time(starttime, state, 0, NULL);
>>>
>>> -       cpufreq_resume();
>>> +       if (valid_resume)
>>> +               cpufreq_resume();
>>>         trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>>>  }
>>>
>>> --------------------8<--------------------------------------
>>>
>>> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 421f318..439eab8 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1648,7 +1648,7 @@ void cpufreq_suspend(void)
>>>  {
>>>         struct cpufreq_policy *policy;
>>>
>>> -       if (!cpufreq_driver)
>>> +       if (!cpufreq_driver || cpufreq_suspended)
>>>                 return;
>>>
>>>         if (!has_target() && !cpufreq_driver->suspend)
>>> @@ -1683,7 +1683,7 @@ void cpufreq_resume(void)
>>>         struct cpufreq_policy *policy;
>>>         int ret;
>>>
>>> -       if (!cpufreq_driver)
>>> +       if (!cpufreq_driver || !cpufreq_suspended)
>>>                 return;
>>>
>>>         cpufreq_suspended = false;
>>
>> Since we have cpufreq_suspended already, the second one is better.
>>
>
> Thanks Rafael for the inputs, I will send a formal patch.

Bo Yan has posted something really similar already, however:

https://patchwork.kernel.org/patch/10181101/

so I would prefer to apply a new version of that one with the latest
comment taken into account:

https://patchwork.kernel.org/patch/10183075/

for the credit to go to the first submitter.
