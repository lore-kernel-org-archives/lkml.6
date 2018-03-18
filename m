Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeCRQPZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 12:15:25 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:47100 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeCRQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 12:15:24 -0400
X-Google-Smtp-Source: AG47ELtxCs4bWegP/Asi10l8ajS01Y87/lAZO5D7aFOHO/kioqaJ5AaHd5oobDfzYYkW/kMrH4kyHniCTibJ+fc4UEo=
MIME-Version: 1.0
In-Reply-To: <2043615.lCdO10SMaB@aspire.rjw.lan>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
 <2043615.lCdO10SMaB@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 18 Mar 2018 17:15:22 +0100
X-Google-Sender-Auth: JgYxTmec280t8Z2z6CS57x5e0-o
Message-ID: <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
To: Peter Zijlstra <peterz@infradead.org>
Cc: Doug Smythies <dsmythies@telus.net>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 12:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, March 17, 2018 5:11:53 PM CET Doug Smythies wrote:
>> On 2018.03.17 Thomas Ilsche wrote:
>>
>> > Over the last week I tested v4+pollv2 and now v5+pollv3. With v5, I
>> > observe a particular idle behavior, that I have not seen before with
>> > v4. On a dual-socket Skylake system the idle power increases from
>> > 74.1 W (system total) to 85.5 W with a 300 HZ build and even to
>> > 138.3 W with a 1000 HZ build. A similar Haswell-EP system is also
>> > affected.
>>
>> I confirm your idle findings. There is a regression between V4 and V5.
>> The differences on my test computer are much less than on yours,
>> probably because I have only 8 CPUs.
>>
>> http://fast.smythies.com/rjw_idle.png
>>
>> 1000 Hz kernel only.
>
> Doug, Thomas,
>
> Thank you both for the reports, much appreciated!
>
> Below is a drop-in v6 replacement for patch [4/7].
>
> With this new patch applied instead of the [4/7] the behavior should be much
> more in line with the v4 behavior, so please try it if you can and let me know
> if that really is the case on your systems.
>
> Patches [5-7/7] from the original v5 apply on top of it right away for me,
> but I've also created a git branch you can use to pull all of the series
> with the below included:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  idle-loop
>
> Thanks!
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v6] cpuidle: Return nohz hint from cpuidle_select()
>
> Add a new pointer argument to cpuidle_select() and to the ->select
> cpuidle governor callback to allow a boolean value indicating
> whether or not the tick should be stopped before entering the
> selected state to be returned from there.
>
> Make the ladder governor ignore that pointer (to preserve its
> current behavior) and make the menu governor return 'false" through
> it if:
>  (1) the idle exit latency is constrained at 0,
>  (2) the selected state is a polling one, or
>  (3) the selected state is not deep enough.
>
> Since the value returned through the new argument pointer is not
> used yet, this change is not expected to alter the functionality of
> the code.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

[cut]

> @@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
>         if (latency_req > interactivity_req)
>                 latency_req = interactivity_req;
>
> +       expected_interval = TICK_USEC_HZ;
>         /*
>          * Find the idle state with the lowest power while satisfying
>          * our constraints.
> @@ -367,17 +374,44 @@ static int menu_select(struct cpuidle_dr
>                         continue;
>                 if (idx == -1)
>                         idx = i; /* first enabled state */
> -               if (s->target_residency > data->predicted_us)
> +               if (s->target_residency > data->predicted_us) {
> +                       /*
> +                        * Retain the tick if the selected state is shallower
> +                        * than the deepest available one with target residency
> +                        * within the tick period range.
> +                        *
> +                        * This allows the tick to be stopped even if the
> +                        * predicted idle duration is within the tick period
> +                        * range to counter the effect by which the prediction
> +                        * may be skewed towards lower values due to the tick
> +                        * bias.
> +                        */
> +                       expected_interval = s->target_residency;
>                         break;

BTW, I guess I need to explain the motivation here more thoroughly, so
here it goes.

The governor predicts idle duration under the assumption that the
tick will be stopped, so if the result of the prediction is within the tick
period range and it is not accurate, that needs to be taken into
account in the governor's statistics.  However, if the tick is allowed
to run every time the governor predicts idle duration within the tick
period range, the governor will always see that it was "almost
right" and the correction factor applied by it to improve the
prediction next time will not be sufficient.  For this reason, it
is better to stop the tick at least sometimes when the governor
predicts idle duration within the tick period range and the idea
here is to do that when the selected state is the deepest available
one with the target residency within the tick period range.  This
allows the opportunity to save more energy to be seized which
balances the extra overhead of stopping the tick.

HTH
