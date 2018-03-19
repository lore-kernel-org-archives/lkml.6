Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeCSJjx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:39:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39843 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbeCSJjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:39:51 -0400
X-Google-Smtp-Source: AG47ELseA1AD9l7RWEIihVT/mUSqTosyW9/+VeHrIKOHTVE+pDnT0fBFHNpJCnFLbrwfn6wcnpUvYrfJBFr0DbInH+8=
MIME-Version: 1.0
In-Reply-To: <20180319091159.GF4043@hirez.programming.kicks-ass.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <2021405.tG9RYD54xL@aspire.rjw.lan>
 <20180319091159.GF4043@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Mar 2018 10:39:50 +0100
X-Google-Sender-Auth: JEQH4RJCwBTdvqjtFvjKU0J4Gf4
Message-ID: <CAJZ5v0gHTyhXvYiLALbO8DrURBfHdUehQp2oi3iSwcCVkc7A+w@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 4/7] cpuidle: Return nohz hint from cpuidle_select()
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 15, 2018 at 11:11:35PM +0100, Rafael J. Wysocki wrote:
>
> I would suggest s/nohz_ret/stop_tick/ throughout, because I keep
> forgetting which way around the boolean works and the new name doesn't
> confuse.

OK

>> Index: linux-pm/drivers/cpuidle/governors/menu.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
>> +++ linux-pm/drivers/cpuidle/governors/menu.c
>> @@ -275,12 +275,16 @@ again:
>>       goto again;
>>  }
>>
>> +#define TICK_USEC_HZ   ((USEC_PER_SEC + HZ/2) / HZ)
>
> Do we want to put that next to TICK_NSEC?

That would be one change too far IMHO.

> Also, there are only 2 users of the existing TICK_USEC, do we want to:
>
>   s/TICK_USEC/USER_&/
>
> and then rename the new thing to TICK_USEC ?

Well, that can be done.

>>  /**
>>   * menu_select - selects the next idle state to enter
>>   * @drv: cpuidle driver containing state data
>>   * @dev: the CPU
>> + * @nohz_ret: indication on whether or not to stop the tick
>>   */
>> +static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>> +                    bool *nohz_ret)
>>  {
>>       struct menu_device *data = this_cpu_ptr(&menu_devices);
>>       struct device *device = get_cpu_device(dev->cpu);
>> @@ -303,8 +307,10 @@ static int menu_select(struct cpuidle_dr
>>               latency_req = resume_latency;
>>
>>       /* Special case when user has set very strict latency requirement */
>> +     if (unlikely(latency_req == 0)) {
>> +             *nohz_ret = false;
>>               return 0;
>> +     }
>>
>>       /* determine the expected residency time, round up */
>>       data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
>> @@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
>>       if (latency_req > interactivity_req)
>>               latency_req = interactivity_req;
>>
>> +     expected_interval = data->predicted_us;
>>       /*
>>        * Find the idle state with the lowest power while satisfying
>>        * our constraints.
>> @@ -369,15 +376,30 @@ static int menu_select(struct cpuidle_dr
>>                       idx = i; /* first enabled state */
>>               if (s->target_residency > data->predicted_us)
>>                       break;
>> +             if (s->exit_latency > latency_req) {
>> +                     /*
>> +                      * If we break out of the loop for latency reasons, use
>> +                      * the target residency of the selected state as the
>> +                      * expected idle duration so that the tick is retained
>> +                      * as long as that target residency is low enough.
>> +                      */
>> +                     expected_interval = drv->states[idx].target_residency;
>>                       break;
>> +             }
>>               idx = i;
>>       }
>>
>>       if (idx == -1)
>>               idx = 0; /* No states enabled. Must use 0. */
>>
>> +     /*
>> +      * Don't stop the tick if the selected state is a polling one or if the
>> +      * expected idle duration is shorter than the tick period length.
>> +      */
>> +     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
>> +         expected_interval < TICK_USEC_HZ)
>> +             *nohz_ret = false;
>> +
>>       data->last_state_idx = idx;
>>
>>       return data->last_state_idx;
>
> Yes, much clearer, Thanks!

But this has regressed since the v4, please see
https://patchwork.kernel.org/patch/10291097/

Thanks!
