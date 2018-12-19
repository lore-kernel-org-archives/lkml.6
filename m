Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E788AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23352184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeLSLQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:16:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33104 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbeLSLQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:16:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE17EBD;
        Wed, 19 Dec 2018 03:16:26 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DD513F5C0;
        Wed, 19 Dec 2018 03:16:25 -0800 (PST)
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
 <9b008c93-c78c-0761-5ac9-cc1c3806f24b@arm.com>
 <CAKfTPtDqtoUOnYMPhiAoG1Utc4YY+4Xm0=NgfzC7STWJDxiuYg@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7a1aaf61-c352-69fc-b990-861bc2aef85b@arm.com>
Date:   Wed, 19 Dec 2018 11:16:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDqtoUOnYMPhiAoG1Utc4YY+4Xm0=NgfzC7STWJDxiuYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 08:27, Vincent Guittot wrote:
[...]
>> Wouldn't LBF_ALL_PINNED cover all relevant cases? It's set at the very top
>> of the 'if (busiest->nr_running > 1)' block and cleared whenever we find
>> at least one task we could pull, even if we don't pull it because of
>> other reasons in can_migrate_task() (e.g. cache hotness).
>>
>> If we have LBF_SOME_PINNED but not LBF_ALL_PINNED, we currently don't
>> increase the balance_interval, which is what we would want to maintain.
> 
> But there are several other UC to do active migration and increase the interval
> like all except running tasks are pinned
> 

My point is that AFAICT the LBF_ALL_PINNED flag would cover all the cases
we care about, although the one you're mentioning is the only one I can 
think of. In that case LBF_ALL_PINNED would never be cleared, so when we do
the active balance we'd know it's because all other tasks were pinned so
we should probably increase the interval (see last snippet I sent).

[...]
>> So that's all the need_active_balance() cases except the last
>> sd->nr_balance_failed one. I'd argue this could also be counted as a
>> "good" reason to active balance which shouldn't lead to a balance_interval
>> increase. Plus, it keeps to the logic of increasing the balance_interval
>> only when task affinity gets in the way.
> 
> But this is some kind of affinity, the hotness is a way for the
> scheduler to temporarily pinned the task on a cpu to take advantage of
> cache hotness.
> 
> I would prefer to be conservative and only reset the interval when we
> are sure that active load balance is really what we want to do.
> Asym packing is one, we can add the misfit case and the move task on
> cpu with more available capacity as well. For the other case, it's
> less obvious and I would prefer to keep current behavior
> 

Mmm ok so this one is kinda about semantics on what do we really consider
as "pinning".

If we look at the regular load_balance() path, if all tasks are cache hot
(so we clear LBF_ALL_PINNED but don't pass can_migrate_task()) we won't
increase the balance_interval. Actually, if we have !active_balance we'll
reset it.

Seeing as the duration of a task's cache hotness (default .5ms) is small
compared to any balance_interval (1ms * sd_weight), IMO it would make sense
to reset the interval for all active balance cases. On top of that, we
would keep to the current logic of increasing the balance_interval *only*
when task->cpus_allowed gets in the way.
