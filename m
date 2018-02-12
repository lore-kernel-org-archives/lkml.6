Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933885AbeBLLDL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:03:11 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:44759 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933397AbeBLLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:03:10 -0500
X-Google-Smtp-Source: AH8x226mczrZNV422aGfXLFyz8mBrt+IYwPgaoLZauw/OWJ/dPXuUlkokbjUg0CyRQmYLaRzOHsfdYOt4AKNBUHIwIo=
MIME-Version: 1.0
In-Reply-To: <20180212104537.GH25181@hirez.programming.kicks-ass.net>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-2-git-send-email-vincent.guittot@linaro.org> <20180212104537.GH25181@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Feb 2018 12:02:49 +0100
Message-ID: <CAKfTPtC+AEy64jBjkTap0yYBiCt06gUb5FAtDyRtMPXy_-qQNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sched: Stop nohz stats when decayed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 February 2018 at 11:45, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 12, 2018 at 09:07:52AM +0100, Vincent Guittot wrote:
>> @@ -9383,11 +9450,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>                * work being done for other cpus. Next load
>>                * balancing owner will pick it up.
>>                */
>> -             if (need_resched())
>> -                     break;
>> +             if (need_resched()) {
>> +                     has_blocked_load = true;
>> +                     goto abort;
>> +             }
>>
>>               rq = cpu_rq(balance_cpu);
>>
>> +             update_blocked_averages(rq->cpu);
>
> Does that want to be update_nohz_stats() ?

I was about to say yesy but the test if (!time_after(jiffies,
rq->last_blocked_load_update_tick)) worry me a bit because it can skip
the update and the chance to clear nohz.has_blocked.
As an example the tick is 10ms long on arm 32bits so we can easily
reach the 32ms decay within the current tick even if we have already
updated it

>
>> +             has_blocked_load |= rq->has_blocked_load;
>> +
>>               /*
>>                * If time for next balance is due,
>>                * do the balance.
