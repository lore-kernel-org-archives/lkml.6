Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbeDWNYk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:24:40 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34662 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeDWNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:24:35 -0400
X-Google-Smtp-Source: AIpwx4804FYFKaTui7WI0hIdQT+I0G4dwhsP3mXDs1km3a6wSjyaHCE18lQSEagLExj5YJoZIWx44dkLxMOChW3ot70=
MIME-Version: 1.0
In-Reply-To: <CA+ToGPGvAeuEwGkPfxd6DKBG9nFbYbG1vQh7nosAtBT5uCPxYA@mail.gmail.com>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net> <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
 <20180423114850.GK4082@hirez.programming.kicks-ass.net> <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com>
 <20180423123847.GL4082@hirez.programming.kicks-ass.net> <CA+ToGPGvAeuEwGkPfxd6DKBG9nFbYbG1vQh7nosAtBT5uCPxYA@mail.gmail.com>
From: Diego Viola <diego.viola@gmail.com>
Date: Mon, 23 Apr 2018 10:24:33 -0300
Message-ID: <CA+ToGPGt56ncqrN-F64w9wkTCOVXzcnNXSrej-iUaWLqoQOo+g@mail.gmail.com>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 9:49 AM, Diego Viola <diego.viola@gmail.com> wrote:
> On Mon, Apr 23, 2018 at 9:38 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Mon, Apr 23, 2018 at 08:49:25AM -0300, Diego Viola wrote:
>>> On Mon, Apr 23, 2018 at 8:48 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> > On Mon, Apr 23, 2018 at 08:23:24AM -0300, Diego Viola wrote:
>>> >> > That's a Core2 era chip; does it actually have stable TSC ?
>>> >>
>>> >> I'm not sure.
>>> >
>>> > dmesg | grep -i tsc
>>> >
>>> > should be able to tell you.
>>>
>>> [diego@dualcore ~]$ dmesg | grep -i tsc
>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>> [    0.016666] tsc: Fast TSC calibration using PIT
>>> [    0.019999] tsc: Detected 2793.087 MHz processor
>>> [    0.019999] clocksource: tsc-early: mask: 0xffffffffffffffff
>>> max_cycles: 0x2842be30f1f, max_idle_ns: 440795236296 ns
>>> [    0.162058] clocksource: Switched to clocksource tsc-early
>>> [    0.300076] tsc: Marking TSC unstable due to TSC halts in idle
>>> [diego@dualcore ~]$
>>
>> Much thanks.. I suspect there a bunch of fail when marking unstable
>> before we register clocksource_tsc.
>>
>> The below patch is a bit ugly, but should cure a number of things; it
>> compiles but hasn't otherwise been tested, can you give it a spin?
>>
>> ---
>>
>>  - when TSC is unstable and we've already registered tsc-early, don't
>>    forget to unregister it; this then leaves us without a tsc
>>    clocksource entirely -- which is good.
>>
>>  - when we call mark_tsc_unstable() before we've registered
>>    clocksource_tsc things go wobbly because it doesn't know about
>>    clocksource_tsc_early. Fix that by:
>>
>>     - Make clocksource_mark_unstable() work for unregistered
>>       clocksources.
>>
>>        - which means we have to be able to detect this; use cs.list
>>          for this; initialize it empty.
>>        - means we also have to place all cs.list manipulation under
>>          watchdog_lock -- bit ugly.
>>
>>     - Make __clocksource_unstable() de-rate the clocksource.
>>
>>     - Call clocksource_mark_unstable() on both tsc and tsc_early.
>>
>> This way we should either end up with a derated tsc clocksource marked
>> UNSTABLE or no tsc clocksource at all, either should result in it not
>> becoming the active clocksource.
>>
>> ---
>>  arch/x86/kernel/tsc.c     | 22 +++++++++++-----------
>>  kernel/time/clocksource.c | 43 +++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 46 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 91e6da48cbb6..74392d9d51e0 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -1067,6 +1067,7 @@ static struct clocksource clocksource_tsc_early = {
>>         .resume                 = tsc_resume,
>>         .mark_unstable          = tsc_cs_mark_unstable,
>>         .tick_stable            = tsc_cs_tick_stable,
>> +       .list                   = LIST_HEAD_INIT(clocksource_tsc_early.list),
>>  };
>>
>>  /*
>> @@ -1086,6 +1087,7 @@ static struct clocksource clocksource_tsc = {
>>         .resume                 = tsc_resume,
>>         .mark_unstable          = tsc_cs_mark_unstable,
>>         .tick_stable            = tsc_cs_tick_stable,
>> +       .list                   = LIST_HEAD_INIT(clocksource_tsc.list),
>>  };
>>
>>  void mark_tsc_unstable(char *reason)
>> @@ -1098,13 +1100,9 @@ void mark_tsc_unstable(char *reason)
>>                 clear_sched_clock_stable();
>>         disable_sched_clock_irqtime();
>>         pr_info("Marking TSC unstable due to %s\n", reason);
>> -       /* Change only the rating, when not registered */
>> -       if (clocksource_tsc.mult) {
>> -               clocksource_mark_unstable(&clocksource_tsc);
>> -       } else {
>> -               clocksource_tsc.flags |= CLOCK_SOURCE_UNSTABLE;
>> -               clocksource_tsc.rating = 0;
>> -       }
>> +
>> +       clocksource_mark_unstable(&clocksource_tsc_early);
>> +       clocksource_mark_unstable(&clocksource_tsc);
>>  }
>>
>>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
>> @@ -1244,7 +1242,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>>
>>         /* Don't bother refining TSC on unstable systems */
>>         if (tsc_unstable)
>> -               return;
>> +               goto unreg;
>>
>>         /*
>>          * Since the work is started early in boot, we may be
>> @@ -1297,11 +1295,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>>
>>  out:
>>         if (tsc_unstable)
>> -               return;
>> +               goto unreg;
>>
>>         if (boot_cpu_has(X86_FEATURE_ART))
>>                 art_related_clocksource = &clocksource_tsc;
>>         clocksource_register_khz(&clocksource_tsc, tsc_khz);
>> +unreg:
>>         clocksource_unregister(&clocksource_tsc_early);
>>  }
>>
>> @@ -1311,8 +1310,8 @@ static int __init init_tsc_clocksource(void)
>>         if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
>>                 return 0;
>>
>> -       if (check_tsc_unstable())
>> -               return 0;
>> +       if (tsc_unstable)
>> +               goto unreg;
>>
>>         if (tsc_clocksource_reliable)
>>                 clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
>> @@ -1328,6 +1327,7 @@ static int __init init_tsc_clocksource(void)
>>                 if (boot_cpu_has(X86_FEATURE_ART))
>>                         art_related_clocksource = &clocksource_tsc;
>>                 clocksource_register_khz(&clocksource_tsc, tsc_khz);
>> +unreg:
>>                 clocksource_unregister(&clocksource_tsc_early);
>>                 return 0;
>>         }
>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index 0e974cface0b..f689c9e3ff5e 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -119,6 +119,16 @@ static DEFINE_SPINLOCK(watchdog_lock);
>>  static int watchdog_running;
>>  static atomic_t watchdog_reset_pending;
>>
>> +static void inline clocksource_watchdog_lock(unsigned long *flags)
>> +{
>> +       spin_lock_irqsave(&watchdog_lock, *flags);
>> +}
>> +
>> +static void inline clocksource_watchdog_unlock(unsigned long *flags)
>> +{
>> +       spin_unlock_irqrestore(&watchdog_lock, *flags);
>> +}
>> +
>>  static int clocksource_watchdog_kthread(void *data);
>>  static void __clocksource_change_rating(struct clocksource *cs, int rating);
>>
>> @@ -142,6 +152,13 @@ static void __clocksource_unstable(struct clocksource *cs)
>>         cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
>>         cs->flags |= CLOCK_SOURCE_UNSTABLE;
>>
>> +       if (list_empty(&cs->list)) {
>> +               cs->rating = 0;
>> +               return;
>> +       }
>> +
>> +       __clocksource_change_rating(cs, 0);
>> +
>>         if (cs->mark_unstable)
>>                 cs->mark_unstable(cs);
>>
>> @@ -164,7 +181,7 @@ void clocksource_mark_unstable(struct clocksource *cs)
>>
>>         spin_lock_irqsave(&watchdog_lock, flags);
>>         if (!(cs->flags & CLOCK_SOURCE_UNSTABLE)) {
>> -               if (list_empty(&cs->wd_list))
>> +               if (!list_empty(&cs->list) && list_empty(&cs->wd_list))
>>                         list_add(&cs->wd_list, &watchdog_list);
>>                 __clocksource_unstable(cs);
>>         }
>> @@ -319,9 +336,8 @@ static void clocksource_resume_watchdog(void)
>>
>>  static void clocksource_enqueue_watchdog(struct clocksource *cs)
>>  {
>> -       unsigned long flags;
>> +       INIT_LIST_HEAD(&cs->wd_list);
>>
>> -       spin_lock_irqsave(&watchdog_lock, flags);
>>         if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
>>                 /* cs is a clocksource to be watched. */
>>                 list_add(&cs->wd_list, &watchdog_list);
>> @@ -331,7 +347,6 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
>>                 if (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS)
>>                         cs->flags |= CLOCK_SOURCE_VALID_FOR_HRES;
>>         }
>> -       spin_unlock_irqrestore(&watchdog_lock, flags);
>>  }
>>
>>  static void clocksource_select_watchdog(bool fallback)
>> @@ -373,9 +388,6 @@ static void clocksource_select_watchdog(bool fallback)
>>
>>  static void clocksource_dequeue_watchdog(struct clocksource *cs)
>>  {
>> -       unsigned long flags;
>> -
>> -       spin_lock_irqsave(&watchdog_lock, flags);
>>         if (cs != watchdog) {
>>                 if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
>>                         /* cs is a watched clocksource. */
>> @@ -384,7 +396,6 @@ static void clocksource_dequeue_watchdog(struct clocksource *cs)
>>                         clocksource_stop_watchdog();
>>                 }
>>         }
>> -       spin_unlock_irqrestore(&watchdog_lock, flags);
>>  }
>>
>>  static int __clocksource_watchdog_kthread(void)
>> @@ -779,14 +790,19 @@ EXPORT_SYMBOL_GPL(__clocksource_update_freq_scale);
>>   */
>>  int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
>>  {
>> +       unsigned long flags;
>>
>>         /* Initialize mult/shift and max_idle_ns */
>>         __clocksource_update_freq_scale(cs, scale, freq);
>>
>>         /* Add clocksource to the clocksource list */
>>         mutex_lock(&clocksource_mutex);
>> +
>> +       clocksource_watchdog_lock(&flags);
>>         clocksource_enqueue(cs);
>>         clocksource_enqueue_watchdog(cs);
>> +       clocksource_watchdog_unlock(&flags);
>> +
>>         clocksource_select();
>>         clocksource_select_watchdog(false);
>>         mutex_unlock(&clocksource_mutex);
>> @@ -808,8 +824,13 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating)
>>   */
>>  void clocksource_change_rating(struct clocksource *cs, int rating)
>>  {
>> +       unsigned long flags;
>> +
>>         mutex_lock(&clocksource_mutex);
>> +       clocksource_watchdog_lock(&flags);
>>         __clocksource_change_rating(cs, rating);
>> +       clocksource_watchdog_unlock(&flags);
>> +
>>         clocksource_select();
>>         clocksource_select_watchdog(false);
>>         mutex_unlock(&clocksource_mutex);
>> @@ -821,6 +842,8 @@ EXPORT_SYMBOL(clocksource_change_rating);
>>   */
>>  static int clocksource_unbind(struct clocksource *cs)
>>  {
>> +       unsigned long flags;
>> +
>>         if (clocksource_is_watchdog(cs)) {
>>                 /* Select and try to install a replacement watchdog. */
>>                 clocksource_select_watchdog(true);
>> @@ -834,8 +857,12 @@ static int clocksource_unbind(struct clocksource *cs)
>>                 if (curr_clocksource == cs)
>>                         return -EBUSY;
>>         }
>> +
>> +       clocksource_watchdog_lock(&flags);
>>         clocksource_dequeue_watchdog(cs);
>>         list_del_init(&cs->list);
>> +       clocksource_watchdog_lock(&flags);
>> +
>>         return 0;
>>  }
>>
>
> Yes, compiling the kernel (torvalds/linux.git HEAD) with your patch right now.
>
> Thanks,
> Diego

I tried your patch with 4.17-rc2 but now my system won't boot, I
believe it fails at early booting.
