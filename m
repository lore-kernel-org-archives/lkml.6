Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDKQLK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:11:10 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:52113 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeDKQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:11:08 -0400
X-Google-Smtp-Source: AIpwx4+nb7BmU4kSO0MviWJyZAQ6oeY7OViJ8mlQNfC4JUZuLR7Vctru63tudjFEUwhTdFusCx5rKwYBNZUXrZ2EYxg=
MIME-Version: 1.0
In-Reply-To: <20180411160000.GO4082@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net> <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
 <20180411160000.GO4082@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Apr 2018 18:10:47 +0200
Message-ID: <CAKfTPtDjyjC5R7bhjGxhV8BN5J+LdzJmMgwaaVuE9ypvcSKapA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2018 at 18:00, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 11, 2018 at 05:41:24PM +0200, Vincent Guittot wrote:
>> Yes. and to be honest I don't have any clues of the root cause :-(
>> Heiner mentioned that it's much better in latest linux-next but I
>> haven't seen any changes related to the code of those patches
>
> Yeah, it's a bit of a puzzle. Now you touch nohz, and the patches in
> next that are most likely to have affected this are rjw's
> cpuidle-vs-nohz patches. The common demoninator being nohz.
>
> Now I think rjw's patches will ensure we enter nohz _less_, they avoid
> stopping the tick when we expect to go idle for a short period only.
>
> So if your patch makes nohz go wobbly, going nohz less will make that
> better.
>
> Of course, I've no actual clue as to what that patch (it's the last one
> in the series, right?:
>
>   31e77c93e432 ("sched/fair: Update blocked load when newly idle")
>
> ) does that is so offensive to that one machine. You never did manage to
> reproduce, right?

yes

>
> Could is be that for some reason the nohz balancer now takes a very long
> time to run?

Heiner mentions that is was a relatively slow celeron and he uses
ondemand governor. So I was about to ask him to use performance
governor to see if it can be because cpu runs slow and takes too muche
time to enter idle

>
> Could something like the following happen (and this is really flaky
> thinking here):
>
> last CPU goes idle, we enter idle_balance(), that kicks ilb, ilb runs,
> which somehow again triggers idle_balance and around we go?
>
> I'm not immediately seeing how that could happen, but if we do something
> daft like that we can tie up the CPU for a while, mostly with IRQs
> disabled, and that would be visible as that latency he sees.
>
>
