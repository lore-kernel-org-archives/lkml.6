Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C35ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E1220645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E1220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIZPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:47:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeIZPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:47:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1856818A;
        Wed, 26 Sep 2018 02:35:10 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF263F5B7;
        Wed, 26 Sep 2018 02:35:09 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Don't increase sd->balance_interval on
 newidle balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
References: <1537896922-8508-1-git-send-email-valentin.schneider@arm.com>
 <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9209a9ec-72b4-17d7-6596-71b55767a9aa@arm.com>
Date:   Wed, 26 Sep 2018 10:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB-UiXx39XZeJ0FNeYOU-pLFbY1u7vgbo584MNHSnpr=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/09/18 09:13, Vincent Guittot wrote:
> On Tue, 25 Sep 2018 at 19:38, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> When load_balance() fails to move some load because of task affinity,
>> we end up increasing sd->balance_interval to delay the next periodic
>> balance in the hopes that next time we look, that annoying pinned
>> task(s) will be gone.
> 
> It's not about hope but to minimize useless periodic load balance as
> there is no possibility to balance anything
> 
>>
>> However, idle_balance() pays no attention to sd->balance_interval, yet
>> it will still lead to an increase in balance_interval in case of
>> pinned tasks.
> 
> I would say that this makes sense as there is no way to pull the
> pinned task on this rq so running periodic load balance (busy or idle)
> is a waste of time  and resources
> 

Increasing the delay for the next periodic balance when there's pinned tasks
makes sense. The issue I have here is that the balance_interval can potentially
be doubled at every failed idle_balance() without waiting for a sufficient
amount of time.

When going through periodic balance, load_balance() is gated by:

    time_after_eq(jiffies, sd->last_balance + interval)

So if we previously ran load_balance() and failed to pull anything because 
of task affinity, we'll wait for at least the new interval before attempting
another load_balance().

On the other hand, idle_balance() will call load_balance() regardless of
balance_interval values. So if the task composition allows it, we can repeatedly
fail to load_balance() and thus double balance_interval at every idle_balance()
"tick". So you can go from 8ms to 512ms in a few successive idle_balance()s,
whereas periodic balance would have to wait for at least the sum of all
intermediate balance_intervals leading to 512 (8, 16, 32, etc).

>>
>> If we're going through several newidle balances (e.g. we have a
>> periodic task), this can lead to a huge increase of the
> 
> This only happen when overload is set which means that there are tasks
> on another CPU but this one can't pull one of them.
> 
> Can you give us details about the use case that you care about ?
> 

It's the same as I presented last week - devlib (some python target communication
library I use) has some phase where it spawns at lot of tasks at once to do
some setup (busybox, shutils, bash...). Some of those tasks are pinned to a
particular CPU, and that can lead to failed load_balance() - and to make things
worse, there's a lot of idle_balance() in there.

Eventually when I start running my actual workload a few ~100ms later, it's
impacted by that balance_interval increase.

Admittedly that's a specific use-case, but I don't think this quick increase
is something that was intended.

> Also, If the interval reaches a value that becomes a problem for you
> why don't you reduce the max_interval with sysfs ? This max interval
> can be reach in several other occasions
> 

True, although I saw that as an unwanted behaviour rather than a tuning problem.

>> balance_interval in a very small amount of time.
>>
>> To prevent that, don't increase the balance interval when going
>> through a newidle balance.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/sched/fair.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6bd142d..620910d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8782,13 +8782,22 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>         sd->nr_balance_failed = 0;
>>
>>  out_one_pinned:
>> +       ld_moved = 0;
>> +
>> +       /*
>> +        * idle_balance() disregards balance intervals, so we could repeatedly
>> +        * reach this code, which would lead to balance_interval skyrocketting
>> +        * in a short amount of time. Skip the balance_interval increase logic
>> +        * to avoid that.
>> +        */
>> +       if (env.idle == CPU_NEWLY_IDLE)
>> +               goto out;
>> +
>>         /* tune up the balancing interval */
>> -       if (((env.flags & LBF_ALL_PINNED) &&
>> -                       sd->balance_interval < MAX_PINNED_INTERVAL) ||
>> -                       (sd->balance_interval < sd->max_interval))
>> +       if ((env.flags & LBF_ALL_PINNED &&
>> +            sd->balance_interval < MAX_PINNED_INTERVAL) ||
>> +           (sd->balance_interval < sd->max_interval))
> 
> This looks like a code cleanup that is not related to the subject
> 

Absolutely, I figured I could get away with it but if that's preferred I can
split that more clearly

>>                 sd->balance_interval *= 2;
>> -
>> -       ld_moved = 0;
>>  out:
>>         return ld_moved;
>>  }
>> --
>> 2.7.4
>>
