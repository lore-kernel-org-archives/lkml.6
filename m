Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNfau4iA"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F82A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeFFKpd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:45:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38195 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932589AbeFFKpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:45:31 -0400
X-Google-Smtp-Source: ADUXVKIMItIr+fqRjueD129pTsnEO2VW6g9qDI6qJkJmcJCgDcJs8hIhKXE61KboGwxdC/nqmd+Lfg==
Date: Wed, 6 Jun 2018 16:15:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-18, 12:22, Daniel Lezcano wrote:
> (mb() are done in the atomic operations AFAICT).

AFAIU, it is required to make sure the operations are seen in a particular order
on another CPU and the compiler doesn't reorganize code to optimize it.

For example, in our case what if the compiler reorganizes the atomic-set
operation after wakeup-process ? But maybe that wouldn't happen across function
calls and we should be safe then.

> What about:
> 
> 	get_online_cpus();
> 
> 	nr_tasks = cpumask_weight(
> 		cpumask_and(ii_dev->cpumask, cpu_online_mask);
> 			
> 	atomic_set(&ii_dev->count, nr_tasks);
> 
> 	for_each_cpu_and(cpu, ii_dev->cpumask, cpu_online_mask) {
> 		iit = per_cpu_ptr(&idle_injection_thread, cpu);
> 		iit->should_run = 1;
> 		wake_up_process(iit->tsk);
> 	}
> 
> 	put_online_cpus();
> ?

Looks good this time.

> I'm wondering if we can have a CPU hotplugged right after the
> 'put_online_cpus', resulting in the 'should park' flag set and then the
> thread goes in the kthread_parkme instead of jumping back the idle
> injection function and decrease the count, leading up to the timer not
> being set again.

True. That looks like a valid problem to me as well.

What about starting the hrtimer right from this routine itself, after taking
into account running-time, idle-time, delay, etc ? That would get rid of the
count stuff, this get_online_cpus(), etc.

Even if we restart the next play-idle cycle a bit early or with some delay, sky
wouldn't fall :)

-- 
viresh
