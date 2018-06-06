Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNcgha0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F522601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeFFKWL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:22:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51283 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932304AbeFFKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:22:10 -0400
X-Google-Smtp-Source: ADUXVKL6YvOMKRIgiua7h489h2Rxya5Ps245Qu8GnhvmXYisIBF8wF6yfIIrHPsqm6O4q28KcOtJ9w==
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
Date: Wed, 6 Jun 2018 12:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 06:27, Viresh Kumar wrote:
> On 05-06-18, 16:54, Daniel Lezcano wrote:
>> On 05/06/2018 12:39, Viresh Kumar wrote:
>> I don't think you are doing a mistake. Even if this can happen
>> theoretically, I don't think practically that is the case.
>>
>> The play_idle() has 1ms minimum sleep time.
>>
>> The scenario you are describing means:
>>
>> 1. the loop in idle_injection_wakeup() takes more than 1ms to achieve
> 
> There are many ways in which idle_injection_wakeup() can get called.
> 
> - from hrtimer handler, this happens in softirq context, right? So interrupts
>   can still block the handler to run ?
> 
> - from idle_injection_start(), process context. RT or DL or IRQ activity can
>   block the CPU for long durations sometimes.
> 
>> 2. at the same time, the user of the idle injection unregisters while
>> the idle injection is acting precisely at CPU0 and exits before another
>> task was wakeup by the loop in 1. more than 1ms after.
>>
>> >From my POV, this scenario can't happen.
> 
> Maybe something else needs to be buggy as well to make this crap happen.
> 
>> Anyway, we must write rock solid code
> 
> That's my point.
> 
>> so may be we can use a refcount to
>> protect against that, so instead of freeing in unregister, we refput the
>> ii_dev pointer.
> 
> I think the solution can be a simple change in implementation of
> idle_injection_wakeup(), something like this..
> 
> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	int cpu;
> +
> +	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask)
> +		atomic_inc(&ii_dev->count);
>
> +
> +       mb(); //I am not sure but I think we need some kind of barrier here ?

(mb() are done in the atomic operations AFAICT).

What about:

	get_online_cpus();

	nr_tasks = cpumask_weight(
		cpumask_and(ii_dev->cpumask, cpu_online_mask);
			
	atomic_set(&ii_dev->count, nr_tasks);

	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
		iit = per_cpu_ptr(&idle_injection_thread, cpu);
		iit->should_run = 1;
		wake_up_process(iit->tsk);
	}

	put_online_cpus();
?

I'm wondering if we can have a CPU hotplugged right after the
'put_online_cpus', resulting in the 'should park' flag set and then the
thread goes in the kthread_parkme instead of jumping back the idle
injection function and decrease the count, leading up to the timer not
being set again.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
