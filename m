Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936825AbeE2PoQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:44:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935606AbeE2PoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C8136038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To: George Cherian <gcherian@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
 <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org>
 <5ff2bebc-fc39-dc82-d7e6-0483e38f7d9c@caviumnetworks.com>
 <37517652-9a74-83f8-1315-07fe79a78d73@codeaurora.org>
 <0959a657-5a98-1d4c-ed9d-ed057e3bd9ad@caviumnetworks.com>
From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <955aeba5-bd5e-6051-b283-ad544327ce64@codeaurora.org>
Date: Tue, 29 May 2018 09:44:05 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0959a657-5a98-1d4c-ed9d-ed057e3bd9ad@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/28/2018 1:09 AM, George Cherian wrote:
> Hi Prashanth,
>
> On 05/26/2018 02:30 AM, Prakash, Prashanth wrote:
>>
>> On 5/25/2018 12:27 AM, George Cherian wrote:
>>> Hi Prashanth,
>>>
>>> On 05/25/2018 12:55 AM, Prakash, Prashanth wrote:
>>>> Hi George,
>>>>
>>>> On 5/22/2018 5:42 AM, George Cherian wrote:
>>>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>>>> feedback via set of performance counters. To determine the actual
>>>>> performance level delivered over time, OSPM may read a set of
>>>>> performance counters from the Reference Performance Counter Register
>>>>> and the Delivered Performance Counter Register.
>>>>>
>>>>> OSPM calculates the delivered performance over a given time period by
>>>>> taking a beginning and ending snapshot of both the reference and
>>>>> delivered performance counters, and calculating:
>>>>>
>>>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>>>
>>>>> Implement the above and hook this to the cpufreq->get method.
>>>>>
>>>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>>>> ---
>>>>>    drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 44 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index b15115a..a046915 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>>        return ret;
>>>>>    }
>>>>>    +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>>>> +                     struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>>>> +{
>>>>> +    u64 delta_reference, delta_delivered;
>>>>> +    u64 reference_perf, ratio;
>>>>> +
>>>>> +    reference_perf = fb_ctrs_t0.reference_perf;
>>>>> +    if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
>>>>> +        delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>>>>> +    else /* Counters would have wrapped-around */
>>>>> +        delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
>>>>> +                    fb_ctrs_t1.reference;
>>>>> +
>>>>> +    if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
>>>>> +        delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
>>>>> +    else /* Counters would have wrapped-around */
>>>>> +        delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
>>>>> +                    fb_ctrs_t1.delivered;
>>>> We need to check that the wraparound time is long enough to make sure that
>>>> the counters cannot wrap around more than once. We can register a  get() api
>>>> only after checking that wraparound time value is reasonably high.
>>>>
>>>> I am not aware of any platforms where wraparound time is soo short, but
>>>> wouldn't hurt to check once during init.
>>> By design the wraparound time is a 64 bit counter, for that matter even
>>> all the feedback counters too are 64 bit counters. I don't see any
>>> chance in which the counters can wraparound twice in back to back reads.
>>> The only situation is in which system itself is running at a really high
>>> frequency. Even in that case today's spec is not sufficient to support the same.
>>
>> The spec doesn't say these have to be 64bit registers.  The wraparound
>> counter register is in spec to communicate the worst case(shortest)
>> counter rollover time.
>
> Spec says these are 32 or 64 bit registers. Spec also defines counter
> wraparound time in seconds. The minimum value possible is 1 as zero means the counters are never assumed to wrap around. Even in platforms with value set as 1 (1 sec) I dont really see a situation in which
> the counter can wraparound twice if we are putting a delay of 2usec
> between sampling.
ok.
>
>>
>> As as mentioned before this is just a defensive check to make sure that
>> the platform has not set it to some very low number (which is allowed
>> by the spec).
> It might be unnecessary to have a check like this.
>>
>>>
>>>>> +
>>>>> +    if (delta_reference)  /* Check to avoid divide-by zero */
>>>>> +        ratio = (delta_delivered * 1000) / delta_reference;
>>>> Why not just return the computed value here instead of *1000 and later /1000?
>>>> return (ref_per * delta_del) / delta_ref;
>>> Yes.
>>>>> +    else
>>>>> +        return -EINVAL;
>>>> Instead of EINVAL, i think we should return current frequency.
>>>>
>>> Sorry, I didn't get you, How do you calculate the current frequency?
>>> Did you mean reference performance?
>> I mean the performance that OSPM/Linux had requested earlier.
>> i.e the desired_perf
> Okay, I will make necessary changes for this in v2.
>
>>>
>>>> The counters can pause if CPUs are in idle state during our sampling interval, so
>>>> If the counters did not progress, it is reasonable to assume the delivered perf was
>>>> equal to desired perf.
>>> No, that is wrong. Here the check is for reference performance delta.
>>> This counter can never pause. In case of cpuidle only the delivered counters could pause. Delivered counters will pause only if the particular core enters power down mode, Otherwise we would be still clocking the core and we should be getting a delta across 2 sampling periods. In case if the reference counter is paused which by design is not correct then there is no point in returning reference performance numbers. That too is wrong. In case the low level FW is not updating the
>>> counters properly then it should be evident till Linux, instead of returning a bogus frequency.
>>
>> Again you are describing how it works on a specific platform and not
>> how it is described in spec. Section 8.4.7.1.3.1.1 of ACPI 6.2 states
>> "The Reference Performance Counter Register counts at a fixed rate
>> any time the processor is active."
>>  > Implies the counters *may* pause in idle state -I can imagine an
>> implementation where you can keep this counter running and
>> account for it via delivered counter, but we cannot make any
>> assumptions outside of what the spec describes.
>>
>>>>
>>>> Even if platform wanted to limit, since the CPUs were asleep(idle) we could not have
>>>> observed lower performance, so we will not throw off  any logic that could be driven
>>>> using the returned value.
>>>>> +
>>>>> +    return (reference_perf * ratio) / 1000;
>>>> This should be converted to KHz as cpufreq is not aware of CPPC abstract scale
>>> In our platform all performance registers are implemented in KHz. Because of which we never had an issue with conversion. I am  not
>>> aware whether ACPI mandates to use any particular unit. How is that
>>> implemented in your platform? Just to avoid any extra conversion don't
>>> you feel it is better to always report in KHz from firmware.
>> Again think of spec not a specific platform :)
>> - The CPPC spec works on abstract scale and cpufreq works in KHz.
>> - The above computed value is in abstract scale
>> - The abstarct scale may be in KHz on your platform, but we cannot assume the
>> same about all the platforms
> For now can I assume it to be in KHz only?

No, it will break platforms where abstract scale is not in KHz.

> I am not sure how to convert the abstract scale to Khz.
> Can you please give me some pointers on the same?

Take a look at cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf
in the same file (cppc_cpufreq.c). We use this in almost every function
registered with core cpufreq.
||
> In spec there is currently no interface which tells what is the abstract
> scale!!

CPPC v3 adds some additional hooks for this. On CPPC v2, we try to use
few DMI table entries to get the ratio between abstract scale and KHz.

>>>
>>>>> +}
>>>>> +
>>>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>>>> +{
>>>>> +    struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
>>>>> +}
>>>> We need to make sure that we get a reasonably sample so make sure the reported
>>>> performance is accurate.
>>>> The counters can capture short transient throttling/limiting, so by sampling a really
>>>> short duration of time we could return quite inaccurate measure of performance.
>>>>
>>> I would say it as a momentary thing only when the frequency is being ramped up/down.
>> This exact behavior would depend on how different limiting functions are implemented.
>> So this would vary from one platform to another.
>>>
>>>> We need to include some reasonable delay between the two calls. What is reasonable
>>>> is debatable - so this can be few(2-10) microseconds defined as default. If the same value
>>>> doesn't work for all the platforms, we might need to add a platform specific value.
>>>>
>>> cppc_get_perf_ctrs itself is a slow call, we have to format the CPC packet and ring a doorbell and then the response to be read from the shared registers. My initial implementation had a delay but in testing,
>>> I found that it was unnecessary to have such a delay. Can you please
>>> let me know whether it works without delay in your platform?
>>>
>>> Or else let me know whether udelay(10) is sufficient in between the
>>> calls.
>> Feedback counters need not be in PCC .
>> 2us should be sufficient.
> Yes I will add this to v2.
>>>>> +
>>>>>    static struct cpufreq_driver cppc_cpufreq_driver = {
>>>>>        .flags = CPUFREQ_CONST_LOOPS,
>>>>>        .verify = cppc_verify_policy,
>>>>>        .target = cppc_cpufreq_set_target,
>>>>> +    .get = cppc_cpufreq_get_rate,
>>>>>        .init = cppc_cpufreq_cpu_init,
>>>>>        .stop_cpu = cppc_cpufreq_stop_cpu,
>>>>>        .name = "cppc_cpufreq",
>>>>
>>
