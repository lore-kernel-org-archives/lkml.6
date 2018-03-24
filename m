Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCXMrV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 08:47:21 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36373 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCXMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 08:47:20 -0400
X-Google-Smtp-Source: AG47ELvyOTdpgi82St0+UF0jJny2CUl6ca2Ba+MkssHYubJ+fTBKOKjFYQdEFmZdjV+z/z0Gp89DKg==
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
Date: Sat, 24 Mar 2018 13:47:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324064627.GA10884@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.03.2018 um 07:46 schrieb Vincent Guittot:
> Hi Heiner,
> 
> Le Friday 23 Mar 2018 à 22:28:09 (+0100), Heiner Kallweit a écrit :
>> Recently I started to get the following problems with linux-next:
>>
>> - When working via Putty/SSH on the system the console frequently freezes
>>   for few seconds. Sometimes only opening a second console makes the
>>   first one react again.
>>
>> - I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
>>   described in [1].
>>
>> Bisecting the issue resulted in:
>>
>> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
>> commit 31e77c93e432dec79c7d90b888bbfc3652592741
>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>> Date:   Wed Feb 14 16:26:46 2018 +0100
>>
>>     sched/fair: Update blocked load when newly idle
>>
>>     When NEWLY_IDLE load balance is not triggered, we might need to update the
>>     blocked load anyway. We can kick an ilb so an idle CPU will take care of
>>     updating blocked load or we can try to update them locally before entering
>>     idle. In the latter case, we reuse part of the nohz_idle_balance.
>>
>> After reversing this commit at least the issue with the freezing console
>> is gone. The second one appeared only sporadically, I still have to see
>> whether it pops up again.
>>
> 
> Can you check if the change below fix the problem ? 
> 
Thanks for the quick feedback. The change however didn't fix the probem, I didn't
notice any changed behavior.

> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3582117..672f212 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9430,6 +9430,9 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  
>  		has_blocked_load |= update_nohz_stats(rq, true);
>  
> +		if (flags == NOHZ_STATS_KICK)
> +			continue;
> +
>  		/*
>  		 * If time for next balance is due,
>  		 * do the balance.
> 
