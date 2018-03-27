Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeC0VGL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:06:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33014 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeC0VGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:06:09 -0400
X-Google-Smtp-Source: AIpwx4/fZ4yWr9cvfJ+ZmYZgqXECTro93Y1z7hUFoOsQ2CL3ci19PH3xA2C0Qmv4in7ADDoqGv3Rgp4pIuWJAYBuCD4=
MIME-Version: 1.0
In-Reply-To: <1522173560.6308.66.camel@surriel.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan> <1521736343.6308.25.camel@surriel.com>
 <4731938.EeADOapqQb@aspire.rjw.lan> <1522173560.6308.66.camel@surriel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Mar 2018 23:06:07 +0200
X-Google-Sender-Auth: cxT-a-sGD3uyxHccIDEq8a2X2V0
Message-ID: <CAJZ5v0j_Rp5tzs2hbhX+1rSBYU3JLxiV-DCN+8rOr=SkFgTKAw@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 7:59 PM, Rik van Riel <riel@surriel.com> wrote:
> On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
>
>> Does it improve if you do something like the below on top of it?
>
> First off, apologies for doing my testing wrong.
> There was an error, which was cleverly hidden by
> scripts, and things were not running the way they
> should.

No worries.

I'm glad that what you really see appears to match my understanding of
things. :-)

> After running the tests right, I have seen some
> results. My own test patch of disabling polling,
> and always dropping into at least C1, resulted in
> a CPU use increase of 0.4%.
>
> Your patch below, with a single cpu_relax(), and
> the local variable to not read the TSC too often,
> seems to give the best performance here, with a
> 0.2% reduction in CPU use.

Cool.

> Again, apologies for messing up the testing.
>
> I will kick off proper tests for that other patch
> series right now.

Thanks!

>> > Let me go test the nohz idle series by itself,
>> > without this patch.
>>
>> OK
>>
>> ---
>>  drivers/cpuidle/poll_state.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> Index: linux-pm/drivers/cpuidle/poll_state.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/poll_state.c
>> +++ linux-pm/drivers/cpuidle/poll_state.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/sched/idle.h>
>>
>>  #define POLL_IDLE_TIME_LIMIT (TICK_NSEC / 16)
>> +#define POLL_IDLE_COUNT              1000
>>
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>                              struct cpuidle_driver *drv, int
>> index)
>> @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
>>
>>       local_irq_enable();
>>       if (!current_set_polling_and_test()) {
>> +             unsigned int loop_count = 0;
>> +
>>               while (!need_resched()) {
>>                       cpu_relax();
>> +                     if (loop_count++ < POLL_IDLE_COUNT)
>> +                             continue;
>>
>> +                     loop_count = 0;
>>                       if (local_clock() - time_start >
>> POLL_IDLE_TIME_LIMIT)
>>                               break;
>>               }
>>
>>
> --
> All Rights Reversed.
