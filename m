Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965170AbeEYIqM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:46:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35689 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965050AbeEYIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:46:09 -0400
X-Google-Smtp-Source: ADUXVKLzl4b0eAzEHMC5mLs9ROEcH+rw4VP5c1oN6NEifAibvV+tqhS+xSOeDeFj/8FyiOAsPFjH+P7no42ulWdayT4=
MIME-Version: 1.0
In-Reply-To: <5ff2bebc-fc39-dc82-d7e6-0483e38f7d9c@caviumnetworks.com>
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
 <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org> <5ff2bebc-fc39-dc82-d7e6-0483e38f7d9c@caviumnetworks.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 May 2018 10:46:08 +0200
X-Google-Sender-Auth: yFUzml4QddyYJiPDMFJypXAejkU
Message-ID: <CAJZ5v0gfY4+ibWfrQtYfqFqMAhAWTxmujqVuFYLBEHDOWs2jeA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To: George Cherian <gcherian@caviumnetworks.com>
Cc: "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 8:27 AM, George Cherian
<gcherian@caviumnetworks.com> wrote:
> Hi Prashanth,
>
>
> On 05/25/2018 12:55 AM, Prakash, Prashanth wrote:
>>
>> Hi George,
>>
>> On 5/22/2018 5:42 AM, George Cherian wrote:
>>>
>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>> feedback via set of performance counters. To determine the actual
>>> performance level delivered over time, OSPM may read a set of
>>> performance counters from the Reference Performance Counter Register
>>> and the Delivered Performance Counter Register.
>>>
>>> OSPM calculates the delivered performance over a given time period by
>>> taking a beginning and ending snapshot of both the reference and
>>> delivered performance counters, and calculating:
>>>
>>> delivered_perf = reference_perf X (delta of delivered_perf counter /
>>> delta of reference_perf counter).
>>>
>>> Implement the above and hook this to the cpufreq->get method.
>>>
>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 44
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index b15115a..a046915 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct
>>> cpufreq_policy *policy)
>>>         return ret;
>>>   }
>>>   +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs
>>> fb_ctrs_t0,
>>> +                                    struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>> +{
>>> +       u64 delta_reference, delta_delivered;
>>> +       u64 reference_perf, ratio;
>>> +
>>> +       reference_perf = fb_ctrs_t0.reference_perf;
>>> +       if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
>>> +               delta_reference = fb_ctrs_t1.reference -
>>> fb_ctrs_t0.reference;
>>> +       else /* Counters would have wrapped-around */
>>> +               delta_reference  = ((u64)(~((u64)0)) -
>>> fb_ctrs_t0.reference) +
>>> +                                       fb_ctrs_t1.reference;
>>> +
>>> +       if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
>>> +               delta_delivered = fb_ctrs_t1.delivered -
>>> fb_ctrs_t0.delivered;
>>> +       else /* Counters would have wrapped-around */
>>> +               delta_delivered  = ((u64)(~((u64)0)) -
>>> fb_ctrs_t0.delivered) +
>>> +                                       fb_ctrs_t1.delivered;
>>
>> We need to check that the wraparound time is long enough to make sure that
>> the counters cannot wrap around more than once. We can register a  get()
>> api
>> only after checking that wraparound time value is reasonably high.
>>
>> I am not aware of any platforms where wraparound time is soo short, but
>> wouldn't hurt to check once during init.
>
> By design the wraparound time is a 64 bit counter, for that matter even
> all the feedback counters too are 64 bit counters. I don't see any
> chance in which the counters can wraparound twice in back to back reads.
> The only situation is in which system itself is running at a really high
> frequency. Even in that case today's spec is not sufficient to support the
> same.
>
>>> +
>>> +       if (delta_reference)  /* Check to avoid divide-by zero */
>>> +               ratio = (delta_delivered * 1000) / delta_reference;
>>
>> Why not just return the computed value here instead of *1000 and later
>> /1000?
>> return (ref_per * delta_del) / delta_ref;
>
> Yes.
>>>
>>> +       else
>>> +               return -EINVAL;
>>
>> Instead of EINVAL, i think we should return current frequency.
>>
> Sorry, I didn't get you, How do you calculate the current frequency?
> Did you mean reference performance?
>
>> The counters can pause if CPUs are in idle state during our sampling
>> interval, so
>> If the counters did not progress, it is reasonable to assume the delivered
>> perf was
>> equal to desired perf.
>
> No, that is wrong. Here the check is for reference performance delta.
> This counter can never pause. In case of cpuidle only the delivered counters
> could pause. Delivered counters will pause only if the particular core
> enters power down mode, Otherwise we would be still clocking the core and we
> should be getting a delta across 2 sampling periods. In case if the
> reference counter is paused which by design is not correct then there is no
> point in returning reference performance numbers. That too is wrong. In case
> the low level FW is not updating the
> counters properly then it should be evident till Linux, instead of returning
> a bogus frequency.
>>
>>
>> Even if platform wanted to limit, since the CPUs were asleep(idle) we
>> could not have
>> observed lower performance, so we will not throw off  any logic that could
>> be driven
>> using the returned value.
>>>
>>> +
>>> +       return (reference_perf * ratio) / 1000;
>>
>> This should be converted to KHz as cpufreq is not aware of CPPC abstract
>> scale
>
> In our platform all performance registers are implemented in KHz. Because of
> which we never had an issue with conversion. I am  not
> aware whether ACPI mandates to use any particular unit. How is that
> implemented in your platform? Just to avoid any extra conversion don't
> you feel it is better to always report in KHz from firmware.
>
>>> +}
>>> +
>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>> +{
>>> +       struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>> +       int ret;
>>> +
>>> +       ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
>>> +}
>>
>> We need to make sure that we get a reasonably sample so make sure the
>> reported
>> performance is accurate.
>> The counters can capture short transient throttling/limiting, so by
>> sampling a really
>> short duration of time we could return quite inaccurate measure of
>> performance.
>>
> I would say it as a momentary thing only when the frequency is being ramped
> up/down.
>
>> We need to include some reasonable delay between the two calls. What is
>> reasonable
>> is debatable - so this can be few(2-10) microseconds defined as default.
>> If the same value
>> doesn't work for all the platforms, we might need to add a platform
>> specific value.
>>
> cppc_get_perf_ctrs itself is a slow call, we have to format the CPC packet
> and ring a doorbell and then the response to be read from the shared
> registers. My initial implementation had a delay but in testing,
> I found that it was unnecessary to have such a delay. Can you please
> let me know whether it works without delay in your platform?
>
> Or else let me know whether udelay(10) is sufficient in between the
> calls.
>
>>> +
>>>   static struct cpufreq_driver cppc_cpufreq_driver = {
>>>         .flags = CPUFREQ_CONST_LOOPS,
>>>         .verify = cppc_verify_policy,
>>>         .target = cppc_cpufreq_set_target,
>>> +       .get = cppc_cpufreq_get_rate,
>>>         .init = cppc_cpufreq_cpu_init,
>>>         .stop_cpu = cppc_cpufreq_stop_cpu,
>>>         .name = "cppc_cpufreq",
>>

I was about to apply the $subject patch, but now I would like you and
Prashanth to agree on it, so please ask Prashanth for an ACK on the
final version.
