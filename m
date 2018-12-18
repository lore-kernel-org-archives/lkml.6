Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA21C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D0721873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeLRMAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:00:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeLRMAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:00:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18DFF15AB;
        Tue, 18 Dec 2018 04:00:19 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286993F5C0;
        Tue, 18 Dec 2018 04:00:18 -0800 (PST)
Subject: Re: [PATCH v2 2/3] sched/fair: trigger asym_packing during idle load
 balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-3-git-send-email-vincent.guittot@linaro.org>
 <ff8844de-8dd7-c5b8-a90e-e15899d081af@arm.com>
 <CAKfTPtDKy07v6YUgz1fegTtsg_K-AcbU+t7y5wFQaTu0TK+_fA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f02b1bc4-c88f-398b-1c38-779f22bd4b34@arm.com>
Date:   Tue, 18 Dec 2018 12:00:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDKy07v6YUgz1fegTtsg_K-AcbU+t7y5wFQaTu0TK+_fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2018 08:17, Vincent Guittot wrote:
[...]
>> That change looks fine. However, you're mentioning newidle load_balance()
>> not being triggered - you'd want to set root_domain->overload for any
>> newidle pull to happen, probably with something like this:
> 
> It's not needed in this case because the dst cpu is already the target
> cpu and the migration will happen during this idle load balance.
> Setting root_domain->overload is useful only if you want another cpu
> to pull the task during another coming load_balance (newly or normal
> idle ones) which is not the case here.
> 

Right, I got the check wrong. The thing is, if you want to go through a
newidle balance, you need to have that overload flag raised beforehand.

I was about to draw a diagram but I kinda already did in the log of
757ffdd705ee ("sched/fair: Set rq->rd->overload when misfit").

So you would first need to raise the flag, e.g. when updating the lb stats
on a low-priority CPU, and when a higher-priority CPU goes newly idle,
the flag is raised, gates to idle_balance() are opened, and a newidle pull
from low-priority to high-priority can happen.

>>
>> -----8<-----
>> @@ -8398,6 +8408,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>>                 sg = sg->next;
>>         } while (sg != env->sd->groups);
>>
>> +       if (check_asym_packing(env, sds))
>> +               sg_status |= SG_OVERLOAD;
>> +
>>  #ifdef CONFIG_NO_HZ_COMMON
>>         if ((env->flags & LBF_NOHZ_AGAIN) &&
>>             cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
>> ----->8-----
>>
>> It's similar to what is done for misfit, although that's yet another
>> 'twisted' use of that flag which we might want to rename (I suggested
>> something like 'need_idle_balance' a while back but it wasn't really
>> popular).
