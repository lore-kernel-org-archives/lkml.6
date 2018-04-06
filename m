Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeDFQD4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:03:56 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:42733 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDFQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:03:54 -0400
X-Google-Smtp-Source: AIpwx4+FLxJYb5tyxqDeQXOnq9+qsjB4T2fZg3cQpJJyQWmmL5ushRUyACGr0YKAQVAmtJ7JA5R5qyQ8KdCsS1MHXv4=
MIME-Version: 1.0
In-Reply-To: <95fe50be-cc8b-4345-7333-cdf656fad2a7@gmail.com>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org> <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
 <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com> <CAKfTPtDigSEOmtxk7daTTBb3o6kVR8AgUVhu4X6YWutK9yWNwg@mail.gmail.com>
 <CAKfTPtAisq0tQ_Kw3OptJYm=u7tSk6vyi3CFZJdhBxD=d=EN1g@mail.gmail.com>
 <796bbd7b-8512-7370-28c9-0f082dc3f287@gmail.com> <CAKfTPtD17yUrp5G7gPN6ijB+C-TKJcK1UTCmP_JhMK5DvSDN_g@mail.gmail.com>
 <95fe50be-cc8b-4345-7333-cdf656fad2a7@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 6 Apr 2018 18:03:33 +0200
Message-ID: <CAKfTPtAJCck6mpXhbMkZes2D6KMYsoB9WkCRL+6owJfMiNXq5w@mail.gmail.com>
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On 30 March 2018 at 10:37, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Am 30.03.2018 um 08:50 schrieb Vincent Guittot:
>> On 29 March 2018 at 19:40, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> Am 29.03.2018 um 09:41 schrieb Vincent Guittot:
>>
>>>>
>>>> I'm finally not so sure that i have the right set up to reproduce the
>>>> problem as I haven't been able to reproduce it since.
>>>>
>>>> Heiner,
>>>>
>>>> How fast the problem happens on your board ?
>>>> Are you doing anything specific on the console that trigger the problem ?
>>>>
>>> Hi Vincent,
>>>
>>> the lag when working on the console is constantly there, the "rcu_preempt
>>> detected stalls" happens after several hours (so far always within 24h)
>>> w/o any triggering event I would be aware of. It occured also when the
>>> system was idle at that point in time.
>>
>> Ok, so I don't have the problem on my hikey as the console never lag
>> on my setup.
>>
>> Can you send me the config of  your kernel ? I'd like to check if you
>> have enable something that could trigger such problem
>>
> Sure, he we go. I also add a system log.

Thanks for the config. I have used it for my setup but I can't
reproduce your regression. My platforms stay stable so I probably
missing something. Are you facing similar problem with other platforms
or only this celeron based platform ?

I have reviewed the code but don't see any obvious place in the patch
that can generate the problem. Nevertheless, would you mind to try the
patch below ? It's a blind test to try to narrow the problem.

Thanks

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c..e9835f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9794,9 +9794,9 @@ static int idle_balance(struct rq *this_rq,
struct rq_flags *rf)
  sd = rcu_dereference_check_sched_domain(this_rq->sd);
  if (sd)
  update_next_balance(sd, &next_balance);
- rcu_read_unlock();

  nohz_newidle_balance(this_rq);
+ rcu_read_unlock();

  goto out;
  }
-- 
2.7.4

>
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 4.16.0-rc7 Kernel Configuration
> #

[snip]
