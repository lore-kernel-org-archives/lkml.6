Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCZJfw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:35:52 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:45124 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZJfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:35:50 -0400
X-Google-Smtp-Source: AG47ELtrxEA0yIU6wEnqtAVtKH68iwTaJvOPupdYOpoOOiP8/tbxAz/GFe2ZyecqnGauSLkB1t02vp+RPlVoR+RdegM=
MIME-Version: 1.0
In-Reply-To: <003601d3c4d1$fe4c0440$fae40cc0$@net>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan> <4731938.EeADOapqQb@aspire.rjw.lan>
 <1522008952.6308.46.camel@surriel.com> <5810003.D8QGLjubHr@aspire.rjw.lan> <003601d3c4d1$fe4c0440$fae40cc0$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Mar 2018 11:35:48 +0200
X-Google-Sender-Auth: liEqLb5h9hKY_wnG6CkWhZDU3OU
Message-ID: <CAJZ5v0hjjaAS=X6S3b0vEMfnNmHR-T9GvR0Ft6x33qtRgBBPQQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
To: Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 9:13 AM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.25 23:00 Doug Smythies wrote:
>> On 2018.03.25 14:25 Rik van Riel wrote:
>> On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
>>> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
>
> ...[snip]...
>
>>>>>
>>>>> OK, I am still seeing a performance
>>>>> degradation with the above, though
>>>>> not throughout the entire workload.
>>>>>
>>>>> It appears that making the idle loop
>>>>> do anything besides cpu_relax() for
>>>>> a significant amount of time slows
>>>>> things down.
>>>>
>>>> I see.
>>
>> I have no proof, but I do not see that as
>> the problem.
>>
>> I think the issue is the overall exiting
>> and then re-entering idle state 0 much
>> more often, and the related overheads, where
>> interrupts are disabled for short periods.

That is a very good point.

So far we have assumed that the performance impact was due to what
happened in poll_idle(), but it very well may be due to how often
poll_idle() is called and returns over a unit of time.

There may be workloads in which wakeups occur so often that idle
states above 1 are (almost) never selected and in these workloads
there will be increased overhead related to entering and exiting state
0 (polling) with the timeout.  That is inevitable.

Rik, if your workload is one of these, you will see performance
impact.  However, you also should see a difference in power (see
below).

>> My jury rigged way of trying to create similar
>> conditions seems to always have the ISR return with
>> the need_resched() flag set, so there is no difference
>> in idle state 0 entries per unit time between kernel
>> 4.16-rc6 and one with the poll fixes added.
>>
>> i.e. the difference between these numbers over some time:
>>
>> cat /sys/devices/system/cpu/cpu*/cpuidle/state0/usage
>>
>> Rik, I wonder if you see a difference with your real
>> workflow?
>
> Using iperf, I was able to show a difference on my computer.
> Another computer was used as the server, and my test computer
> was the client. (the other way around didn't show a difference)
>
> With Kernel 4.16-rc6 I got about ~2000 idle state 0 entries
> per minute and ~155 seconds residency. ~32 watts package power.
>
> With the poll stuff included I got ~46000 idle state 0 entries
> per minute and ~53 seconds residency. ~20 watts package power.

OK, so that's 30%+ of a difference in power.
