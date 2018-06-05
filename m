Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932517AbeFEXPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:15:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeFEXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:15:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACDB760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
To: Joel Fernandes <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>, connoro@google.com,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Todd Kjos <tkjos@google.com>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <CAKfTPtD8RDxT=-oO2VYJRbtwoEyEKEAau-Ad-bAd8L2T2zKWEg@mail.gmail.com>
 <20180605151129.GC32302@e110439-lin>
 <20180605153105.GM16081@localhost.localdomain>
 <20180605165431.GF32302@e110439-lin>
 <20180605204608.GA3510@joelaf.mtv.corp.google.com>
From: Saravana Kannan <skannan@codeaurora.org>
Message-ID: <af0e3158-d97c-b546-ea51-03b77d4cd501@codeaurora.org>
Date: Tue, 5 Jun 2018 16:15:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605204608.GA3510@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 01:46 PM, Joel Fernandes wrote:
> On Tue, Jun 05, 2018 at 05:54:31PM +0100, Patrick Bellasi wrote:
>> On 05-Jun 17:31, Juri Lelli wrote:
>>> On 05/06/18 16:11, Patrick Bellasi wrote:
>>>
>>> [...]
>>>
>>>> If I run an experiment with your example above, while using the
>>>> performance governor to rule out any possible scale invariance
>>>> difference, here is what I measure:
>>>>
>>>>     Task1 (40ms delayed by the following Task2):
>>>>                                 mean          std     max
>>>>        running_avg        455.387449    22.940168   492.0
>>>>        util_avg           433.233288    17.395477   458.0
>>>>
>>>>     Task2 (waking up at same time of Task1 and running before):
>>>>                                 mean          std     max
>>>>        running_avg        430.281834    22.405175   455.0
>>>>        util_avg           421.745331    22.098873   456.0
>>>>
>>>> and if I compare Task1 above with another experiment where Task1 is
>>>> running alone:
>>>>
>>>>     Task1 (running alone):
>>>>                                 mean          std     min
>>>>        running_avg        460.257895    22.103704   460.0
>>>>        util_avg           435.119737    17.647556   461.0
>>> Wait, why again in this last case running_avg != util_avg? :)
>> I _think_ it's mostly due to the rouding errors we have because of the
>> reasons I've explained in the reply to Joel:
>>
>>     https://lkml.org/lkml/2018/6/5/559
>>     20180605152156.GD32302@e110439-lin
>>
>> at the end, while commenting about the division overhead.
>>
>> I should try the above examples while tracking the full signal at
>> ___update_load_avg() time.
> Is that the only issue? I think if a CFS task is blocked by another CFS task
> due to preemption, then with your patch we would account the CFS blocked time
> as well into the blocked task's running utilization, which seems incorrect.
> Or did I miss something?
This is my concern too. This will negatively affect any task packing 
because more tasks are going to be runnable but not running and that 
going to increase the over all frequency (I'm assuming you want to use 
this for frequency guidance eventually?).

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
