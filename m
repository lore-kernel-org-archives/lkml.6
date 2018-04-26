Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932177AbeDZP1r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:27:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36146 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbeDZP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:27:45 -0400
X-Google-Smtp-Source: AIpwx4+ojNHAqTs1Pp2A4o+A/WPtJ9YFS/QsOoYWh+fQyQ0yRdsFWxYJSfSpOn9gVDOQliu9MEOuYYL+K9KNOYQNS7I=
MIME-Version: 1.0
In-Reply-To: <20180426144137.GC3315@bigcity.dyn.berto.se>
References: <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se> <20180412133031.GA551@linaro.org>
 <20180412223904.GJ12256@bigcity.dyn.berto.se> <CAKfTPtDRtto7w806gYgdS_bCJ77EY0RRtszycB+TnG6aQ6ve4Q@mail.gmail.com>
 <20180420160013.GA13769@linaro.org> <20180422221827.GB27674@bigcity.dyn.berto.se>
 <20180423095420.GA23995@linaro.org> <20180425225603.GA26177@bigcity.dyn.berto.se>
 <20180426103133.GA6953@linaro.org> <20180426144137.GC3315@bigcity.dyn.berto.se>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Apr 2018 17:27:24 +0200
Message-ID: <CAKfTPtBpmXieT=0PEmNgTPg=r-zEbvhH-d0_qxC_S2iVUJ7HRw@mail.gmail.com>
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QFRpMU006969

Hi Niklas,

>> Thanks for the trace, I have been able to catch a problem with it.
>> Could you test the patch below to confirm that the problem is solved ?
>> The patch apply on-top of
>> c18bb396d3d261eb ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")
>
> I can confirm that with the patch bellow I can no longer produce the
> problem. Thanks!

Thanks for testing
Do you mind if I add
Tested-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

Peter, Ingo,
Do you want me to re-send the patch with all tags or you will take
this version ?

Regards,
Vincent

>
>>
>> From: Vincent Guittot <vincent.guittot@linaro.org>
>> Date: Thu, 26 Apr 2018 12:19:32 +0200
>> Subject: [PATCH] sched/fair: fix the update of blocked load when newly idle
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> With commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle"),
>> we release the rq->lock when updating blocked load of idle CPUs. This open
>> a time window during which another CPU can add a task to this CPU's cfs_rq.
>> The check for newly added task of idle_balance() is not in the common path.
>> Move the out label to include this check.
>>
>> Fixes: 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
>> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Reported-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c..15a9f5e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9847,6 +9847,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>       if (curr_cost > this_rq->max_idle_balance_cost)
>>               this_rq->max_idle_balance_cost = curr_cost;
>>
>> +out:
>>       /*
>>        * While browsing the domains, we released the rq lock, a task could
>>        * have been enqueued in the meantime. Since we're not going idle,
>> @@ -9855,7 +9856,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>       if (this_rq->cfs.h_nr_running && !pulled_task)
>>               pulled_task = 1;
>>
>> -out:
>>       /* Move the next balance forward */
>>       if (time_after(this_rq->next_balance, next_balance))
>>               this_rq->next_balance = next_balance;
>> --
>> 2.7.4
>>
>>
>>
>> [snip]
>>
>
> --
> Regards,
> Niklas Söderlund
