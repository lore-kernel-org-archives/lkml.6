Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B2E21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeLROJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:09:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeLROJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:09:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A386580D;
        Tue, 18 Dec 2018 06:09:34 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33773F675;
        Tue, 18 Dec 2018 06:09:33 -0800 (PST)
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com>
 <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
 <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com>
 <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com>
Date:   Tue, 18 Dec 2018 14:09:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA0HQL9xsMbAH-2u63XaEJ-4mwzdBzNzvVSA8_3XyQ89g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2018 13:23, Vincent Guittot wrote:
[...]
>> Ah, I think I get it: you're saying that this balance_interval increase
>> is done because it is always assumed we do an active balance with
>> busiest->nr_running > 1 && pinned tasks, and that all that is left to
>> migrate after the active_balance is pinned tasks that we can't actually
>> migrate.
>>
>> Maybe that's what we should target (as always, totally untested):
>>
>> -----8<-----
>> @@ -9131,18 +9144,16 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>         } else
>>                 sd->nr_balance_failed = 0;
>>
>> -       if (likely(!active_balance)) {
>> -               /* We were unbalanced, so reset the balancing interval */
>> -               sd->balance_interval = sd->min_interval;
>> -       } else {
>> +       if (unlikely(active_balance && (env.flags & LBF_ALL_PINNED))) {
> 
> So it's not exactly LBF_ALL_PINNED but also some pinned tasks
> 

Wouldn't LBF_ALL_PINNED cover all relevant cases? It's set at the very top
of the 'if (busiest->nr_running > 1)' block and cleared whenever we find
at least one task we could pull, even if we don't pull it because of 
other reasons in can_migrate_task() (e.g. cache hotness).

If we have LBF_SOME_PINNED but not LBF_ALL_PINNED, we currently don't
increase the balance_interval, which is what we would want to maintain.

> but IIUC, you would like to extend the reset of balance  interval  to
> all the "good" reasons to trig active load balance

Right

> In fact the condition used in need_active_balance except the last
> remaining one. Good reasons are:
> - asym packing
> - /*
> * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> * It's worth migrating the task if the src_cpu's capacity is reduced
> * because of other sched_class or IRQs if more capacity stays
> * available on dst_cpu.
> */
> - misfit task
> 
> I can extend the test for these conditions

So that's all the need_active_balance() cases except the last
sd->nr_balance_failed one. I'd argue this could also be counted as a
"good" reason to active balance which shouldn't lead to a balance_interval
increase. Plus, it keeps to the logic of increasing the balance_interval
only when task affinity gets in the way.
