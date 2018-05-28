Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938620AbeE1MGa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:06:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36656 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938528AbeE1MGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:06:23 -0400
X-Google-Smtp-Source: ADUXVKIiQ3O0g9yZCkPFHnVsAI020xNsaNUrZy80FljJvO6sZ4VqnBbtoDdIy2geZSe6zGg/W7uf31yDLWxGXjk1TOE=
MIME-Version: 1.0
In-Reply-To: <20180528104127.GB1293@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-9-git-send-email-vincent.guittot@linaro.org> <20180528104127.GB1293@localhost.localdomain>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 28 May 2018 14:06:02 +0200
Message-ID: <CAKfTPtAn6F6J9=KFJrG_fMMeGvTn3abn1sMAdjpQMKLz0p9egA@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] cpufreq/schedutil: take into account interrupt
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On 28 May 2018 at 12:41, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi Vincent,
>
> On 25/05/18 15:12, Vincent Guittot wrote:
>> The time spent under interrupt can be significant but it is not reflected
>> in the utilization of CPU when deciding to choose an OPP. Now that we have
>> access to this metric, schedutil can take it into account when selecting
>> the OPP for a CPU.
>> The CPU utilization is :
>>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
>
> IIUC the code below you actually propose that
>
>  util = [(max_cap - util_irq) * util_rq] / max_cap + util_irq
>
> where
>
>  util_rq  = /Sum rq util_avg
>  util_irq = irq util_avg
>
> So, which one is what you have in mind? Or am I wrong? :)

mmh ... aren't they equal  ?

util = [(max_cap - util_irq) * util_rq] / max_cap + util_irq
util = [(max_cap/max_cap - util_irq/max_cap) * util_rq]  + util_irq
util = [(1 - util_irq/max_cap) * util_rq]  + util_irq
util = util_irq +  [(1 - util_irq/max_cap) * util_rq]

>
> [...]
>
>>  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>> @@ -190,9 +192,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>>       if (rq->rt.rt_nr_running) {
>>               util = sg_cpu->max;
>>       } else {
>> +             /* Sum rq utilization*/
>>               util = sg_cpu->util_dl;
>>               util += sg_cpu->util_cfs;
>>               util += sg_cpu->util_rt;
>> +
>> +             /* Weight rq's utilization to the normal context */
>> +             util *= (sg_cpu->max - sg_cpu->util_irq);
>> +             util /= sg_cpu->max;
>> +
>> +             /* Add interrupt utilization */
>> +             util += sg_cpu->util_irq;
>
> Thanks,
>
> - Juri
