Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbeDNLWK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 07:22:10 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:39779 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeDNLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 07:22:08 -0400
X-Google-Smtp-Source: AIpwx49/FKrbq6MO5l2i6PpwLlsBLEKVR7Fy58EN0/sn0Lf27fBHvRp/L2rgF6VLZfhZ2BJsbb56YwOw+ddd07uF3n8=
MIME-Version: 1.0
In-Reply-To: <a2b1e908-9e20-0c72-5f8e-bd14d4a7f3b0@gmail.com>
References: <20180412091822.GG12256@bigcity.dyn.berto.se> <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se> <20180412133031.GA551@linaro.org>
 <a2b1e908-9e20-0c72-5f8e-bd14d4a7f3b0@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 14 Apr 2018 13:21:47 +0200
Message-ID: <CAKfTPtB1uaXT9ZnGJ5JDCyduBWkZBv62GDmqP46ms6s9G-Q_Lg@mail.gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiner,

On 12 April 2018 at 21:43, Heiner Kallweit <hkallweit1@gmail.com> wrote:

>>>>
>>>> I'm going to prepare a debug patch to spy what's happening when entering idle
>>
>> I'd like to narrow the problem a bit more with the 2 patchies aboves. Can you try
>> them separatly on top of c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net"))
>> and check if one of them fixes the problem ?i
>>
>> (They should apply on linux-next as well)
>>
>> First patch always kick ilb instead of doing ilb on local cpu before entering idle
>>
>> ---
>>  kernel/sched/fair.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c..b21925b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9739,8 +9739,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
>>        * candidate for ilb instead of waking up another idle CPU.
>>        * Kick an normal ilb if we failed to do the update.
>>        */
>> -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>> -             kick_ilb(NOHZ_STATS_KICK);
>> +     kick_ilb(NOHZ_STATS_KICK);
>>       raw_spin_lock(&this_rq->lock);
>>  }
>>
>>
> I tested both patches, with both of them the issue still occurs. However,
> on top of linux-next from yesterday I have the impression that it happens
> less frequent with the second patch.
> On top of the commit mentioned by you I don't see a change in system behavior
> with either patch.

Thanks for the tests.
I was expecting to have more differences between the 2 patches and
especially no problem with the 1st patch which only send a ipi
reschedule to the other CPU if it is idle.
It seems to not really be related to what is done but to the fact that
it is done at that place in the code

Thanks
>
> Regards, Heiner
