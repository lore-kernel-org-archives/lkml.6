Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeE3Lvs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:51:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54836 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeE3Lvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:51:47 -0400
X-Google-Smtp-Source: ADUXVKLG3YRK+vWQMPpEksJy/3vq4GbgnWPD7Is+UdOxQGFuI8J78yEUAYDokU11bdYUZ4IjGInatQz+OHdiwNrN2g8=
MIME-Version: 1.0
In-Reply-To: <20180530105050.GI30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-5-git-send-email-vincent.guittot@linaro.org> <20180530105050.GI30654@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 May 2018 13:51:26 +0200
Message-ID: <CAKfTPtCx_pOOvR1ugh7fTadFuQAt711OsqLUdg=sTYtuMmYZDg@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] sched/dl: add dl_rq utilization tracking
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 12:50, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 25-May 15:12, Vincent Guittot wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fb18bcc..967e873 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7290,11 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>>       return false;
>>  }
>>
>> -static inline bool rt_rq_has_blocked(struct rq *rq)
>> +static inline bool others_rqs_have_blocked(struct rq *rq)
>
> Here you are going to fold in IRQ's utilization which, strictly
> speaking, is not a RQ. Moreover, we are checking only utilization.
>
> Can we use a better matching name? E.g.
>    others_have_blocked_util
>    non_cfs_blocked_util

others_have_blocked looks ok and consistent with cfs_rq_has_blocked

> ?
>
>>  {
>>       if (rq->avg_rt.util_avg)
>>               return true;
>>
>> +     if (rq->avg_dl.util_avg)
>> +             return true;
>> +
>>       return false;
>>  }
>>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
