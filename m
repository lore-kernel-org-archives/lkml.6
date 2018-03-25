Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCYLxp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 07:53:45 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:42368 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCYLxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 07:53:43 -0400
X-Google-Smtp-Source: AIpwx4+yOKrkashjxfXoxtj04Zg6l+FjFzByPD86xjthRtnMldbtHcjmJmvawUxZ9wX4iDsJOeUUsqujoIEyTRjlW1A=
MIME-Version: 1.0
In-Reply-To: <001401d3c3d0$2a4623d0$7ed26b70$@net>
References: <001401d3c3d0$2a4623d0$7ed26b70$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 25 Mar 2018 13:53:42 +0200
X-Google-Sender-Auth: EEkNxzYdEGcDDZbkFhxgwkzeqWk
Message-ID: <CAJZ5v0hhrFrPj834pR6COcF_nJ8Xm7qYJeW9oJUQ0Pe9bGTRuw@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 1:28 AM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.14 07:04 Rafael J. Wysocki wrote:
>
>> If poll_idle() is allowed to spin until need_resched() returns 'true',
>> it may actually spin for a much longer time than expected by the idle
>> governor, since set_tsk_need_resched() is not always called by the
>> timer interrupt handler.  If that happens, the CPU may spend much
>> more time than anticipated in the "polling" state.
>>
>> To prevent that from happening, limit the time of the spinning loop
>> in poll_idle().
>
> ...[snip]...
>
>> +#define POLL_IDLE_TIME_LIMIT (TICK_NSEC / 16)
>
> The other ongoing threads on this aside, potentially, there might
> be another issue.
>
> What if the next available idle state, after 0, has a residency
> that is greater than TICK_NSEC / 16? Meaning these numbers, for example:
>
> /sys/devices/system/cpu/cpu0/cpuidle/state*/residency
>
> The suggestion is that upon a timeout exit from idle state 0,
> the measured_us should maybe be rejected, because the statistics
> are being biased and it doesn't seem to correct itself.

OK

> Up to 1300% (<- not a typo) extra power consumption has been observed.
>
> Supporting experimental data:
>
> My processor:
> /sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
> /sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
> /sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:211 <<< Important
> /sys/devices/system/cpu/cpu0/cpuidle/state4/residency:345
>
> A 1000 Hz kernel (TICK_NSEC/16) = 62.5 nsec; idle system:

nsec or usec?

> Idle state 0 time: Typically 0 uSec.
> Processor package power: 3.7 watts (steady)
>
> Now, disable idle states 1 and 2:
>
> Idle state 0 time (all 8 CPUs): ~~ 430 Seconds / minute
> Processor package power: ~52 watts (1300% more power, 14X)

But that's because you have disabled states 1 and 2, isn't it?

> A 250 Hz kernel (TICK_NSEC/16) = 250 nSec; idle system:
>
> Idle state 0 time: Typically < 1 mSec / minute
> Processor package power: 3.7 to 3.8 watts
>
> Now, disable idle states 1 and 2:
>
> Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
> Processor package power: 3.7 to 3.8 watts
>
> A 1000 Hz kernel with:
>
> +#define POLL_IDLE_TIME_LIMIT   (TICK_NSEC / 4)
>
> Note: Just for a test. I am not suggesting this should change.
>
> instead. i.e. (TICK_NSEC/4) = 250 nSec.
>
> Idle state 0 time: Typically 0 uSec.
> Processor package power: 3.7 watts (steady)
>
> Now, disable idle states 1 and 2:
>
> Idle state 0 time (all 8 CPUs): Typically 0 to 70 mSecs / minute
> Processor package power: ~3.8 watts
>
> Note 1: My example is contrived via disabling idle states, so
> I don't know if it actually needs to be worried about.
>
> Note 2: I do not know if there is some processor where
> cpuidle/state1/residency is > 62.5 nSec.

If that's usec, I would be quite surprised if there were any. :-)

> Note 3: I am trying to figure out a way to test rejecting
> measured_us upon timeout exit, but haven't made much progress.

Rejecting it has side effects too, because it basically means lost information.

Reaching the time limit means that the CPU could have been idle much
longer, even though we can't say how much.  That needs to be recorded
in the data used for the next-time prediction or that is going to be
inaccurate too.

Of course, what number to record is a good question. :-)
