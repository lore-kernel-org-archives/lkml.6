Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755663AbeDWQMO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:12:14 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37587 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbeDWQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:12:13 -0400
X-Google-Smtp-Source: AIpwx4+xkaZ0kp6fy4c+Rdq1aP7PJbWdgcvxwyRelq69QGtUG+rIhl/ZRWdCD3aFLEPe5pl1R50KTPe/bmWHyrILBqs=
MIME-Version: 1.0
In-Reply-To: <20180423151035.GP4129@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net> <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
 <20180423114850.GK4082@hirez.programming.kicks-ass.net> <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com>
 <20180423123847.GL4082@hirez.programming.kicks-ass.net> <20180423140052.GO4129@hirez.programming.kicks-ass.net>
 <20180423151035.GP4129@hirez.programming.kicks-ass.net>
From: Diego Viola <diego.viola@gmail.com>
Date: Mon, 23 Apr 2018 13:12:12 -0300
Message-ID: <CA+ToGPEZ189D8_VrVyMQPU2X_FKgP9d7QvwGhHmiOgAoe9de=g@mail.gmail.com>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 12:10 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Apr 23, 2018 at 04:00:52PM +0200, Peter Zijlstra wrote:
>> On Mon, Apr 23, 2018 at 02:38:47PM +0200, Peter Zijlstra wrote:
>> > @@ -834,8 +857,12 @@ static int clocksource_unbind(struct clocksource *cs)
>> >             if (curr_clocksource == cs)
>> >                     return -EBUSY;
>> >     }
>> > +
>> > +   clocksource_watchdog_lock(&flags);
>> >     clocksource_dequeue_watchdog(cs);
>> >     list_del_init(&cs->list);
>> > +   clocksource_watchdog_lock(&flags);
>>
>> It works a lot better when this is _unlock();
>>
>> > +
>> >     return 0;
>> >  }
>> >
>>
>> With that, and intel_idle.c modified to always issue the "halts in
>> idle" thing, my IVB comes up in hpet mode. Let me dig up a Core2 era
>> machine and see if that works too.
>
> OK, that was fairly painful, but the box managed to boot a modified
> kernel and seems to function correctly, lemme try suspend/resume.
>
>

I can confirm that applying Peter's patch to the 4.17-rc2 kernel and
changing kernel/time/clocksource.c:864 to _unlock solves my problem.

Peter, thank you so much, I appreciate your help a lot.

Diego
