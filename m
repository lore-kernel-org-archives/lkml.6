Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeDOMCm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:02:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34003 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeDOMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:02:40 -0400
X-Google-Smtp-Source: AIpwx4865HMp9XNiqUJcsGc50CJqNuoSaD5UDnpJs81hzGmQOBMgvWHboNkQTNqLHX1/FRfqUk9gTyyx4AZIVBSbxZs=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j=TL7Pvc6W+ieJ1D3C-9mJKMzmkcSRoHnquAwZC_k+0w@mail.gmail.com>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
 <1523531671-27491-7-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0j=TL7Pvc6W+ieJ1D3C-9mJKMzmkcSRoHnquAwZC_k+0w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 15 Apr 2018 14:02:39 +0200
Message-ID: <CAPDyKFrQ4eUcuNPp6nUak_LvEP1=FNZ4a8SCd-XwLkPuXv9oFQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/26] timer: Export next wakeup time of a CPU
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2018 at 10:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Apr 12, 2018 at 1:14 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> From: Lina Iyer <lina.iyer@linaro.org>
>>
>> Knowing the sleep duration of CPUs, is known to be needed while selecting
>> the most energy efficient idle state for a CPU or a group of CPUs.
>>
>> However, to be able to compute the sleep duration, we need to know at what
>> time the next expected wakeup is for the CPU. Therefore, let's export this
>> information via a new function, tick_nohz_get_next_wakeup(). Following
>> changes make use of it.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  include/linux/tick.h     | 10 ++++++++++
>>  kernel/time/tick-sched.c | 11 +++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/include/linux/tick.h b/include/linux/tick.h
>> index 389aa25..d341811 100644
>> --- a/include/linux/tick.h
>> +++ b/include/linux/tick.h
>> @@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
>>  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
>>  extern unsigned long tick_nohz_get_idle_calls(void);
>>  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
>> +extern ktime_t tick_nohz_get_next_wakeup(int cpu);
>>  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
>>  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
>>
>> @@ -151,6 +152,15 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>>         *delta_next = TICK_NSEC;
>>         return *delta_next;
>>  }
>> +
>> +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
>> +{
>> +       ktime_t t;
>> +
>> +       /* Next wake up is the tick period, assume it starts now */
>> +       return ktime_add(tick_nohz_get_sleep_length(&t), ktime_get());
>> +}
>
> Well, given that tick_nohz_get_sleep_length() is just the above in
> this case, wouldn't it be simpler to return ktime_add(ktime_get(),
> TICK_NSEC) from here?

Yes!

>
>> +
>>  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
>>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>>
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 646645e..08db7f3 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -1098,6 +1098,17 @@ unsigned long tick_nohz_get_idle_calls(void)
>>         return ts->idle_calls;
>>  }
>>
>> +/**
>> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
>> + */
>> +ktime_t tick_nohz_get_next_wakeup(int cpu)
>> +{
>> +       struct clock_event_device *dev =
>> +                       per_cpu(tick_cpu_device.evtdev, cpu);
>
> I would avoid breaking the line, honestly.

Alright, I have no problem with that.

[,,,]

Thanks for reviewing!

Kind regards
Uffe
