Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6akiEL/sGFt1cwAAmS7hNA
	; Thu, 07 Jun 2018 08:29:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D899A608BA; Thu,  7 Jun 2018 08:29:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56CE56063F;
	Thu,  7 Jun 2018 08:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56CE56063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeFGI3V (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:29:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932572AbeFGI3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:29:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F0480D;
        Thu,  7 Jun 2018 01:29:19 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12613F59D;
        Thu,  7 Jun 2018 01:29:17 -0700 (PDT)
Subject: Re: [PATCH v5 07/10] sched/irq: add irq utilization tracking
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-8-git-send-email-vincent.guittot@linaro.org>
 <72473e6f-8ade-8e26-3282-276fcae4c4c7@arm.com>
 <CAKfTPtC8c9sP7TjefZPN2SFuNVGS7Q12WBj3BBYEbJFzxVN-2A@mail.gmail.com>
 <fba5a810-3c3b-dc8b-15fb-8078a591ec2b@arm.com>
 <CAKfTPtAMf1FUyY-HtziVzZ8JecnKTrQ1LaF60hg6bd=Nv9pCQQ@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4368a36c-3df4-1454-1837-473e569b9080@arm.com>
Date: Thu, 7 Jun 2018 10:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAMf1FUyY-HtziVzZ8JecnKTrQ1LaF60hg6bd=Nv9pCQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 06:06 PM, Vincent Guittot wrote:
> Hi Dietmar,
> 
> Sorry for the late answer
> 
> On 31 May 2018 at 18:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> On 05/30/2018 08:45 PM, Vincent Guittot wrote:
>>> Hi Dietmar,
>>>
>>> On 30 May 2018 at 17:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>> On 05/25/2018 03:12 PM, Vincent Guittot wrote:
>>
>> [...]
>>
>>>>> +        */
>>>>> +       ret = ___update_load_sum(rq->clock - running, rq->cpu,
>>>>> &rq->avg_irq,
>>>>> +                               0,
>>>>> +                               0,
>>>>> +                               0);
>>>>> +       ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
>>>>> +                               1,
>>>>> +                               1,
>>>>> +                               1);
>>
>> Can you not change the function parameter list to the usual
>> (u64 now, struct rq *rq, int running)?
>>
>> Something like this (only compile and boot tested):
> 
> To be honest, I prefer to keep the specific sequence above in a
> dedicated function instead of adding it in core code.

No big issue.

> Furthermore,  we end up calling call twice ___update_load_avg instead
> of only once. This will set an intermediate and incorrect value in
> util_avg and this value can be read in the meantime

Can't buy this argument though because this is true with the current 
implementation as well since the 'decay load sum' - 'accrue load sum' 
sequence is not atomic.

What about calling update_irq_load_avg(rq, 0) in update_rq_clock_task() 
if (irq_delta + steal) eq. 0 and sched_feat(NONTASK_CAPACITY) eq. true 
in this #ifdef CONFIG_XXX_TIME_ACCOUNTING block?

Maintaining a irq/steal time signal makes only sense if at least one of 
the CONFIG_XXX_TIME_ACCOUNTING is set and NONTASK_CAPACITY is true. The 
call to update_irq_load_avg() in update_blocked_averages() isn't guarded 
my them.

[...]
