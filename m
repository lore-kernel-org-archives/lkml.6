Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeCOUlN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:41:13 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34723 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeCOUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:41:11 -0400
X-Google-Smtp-Source: AG47ELvHx6jFzpP7HTc3ThK9V+mMjy6bmcMvq/iQnexSpjkHVwwz1r+NBulSzftpaGiE3WgBXfhnCDjbioFxfrt5Ay8=
MIME-Version: 1.0
In-Reply-To: <20180315181858.GA14983@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan> <3550231.xNMJN5JcLx@aspire.rjw.lan>
 <20180315181858.GA14983@lerouge>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Mar 2018 21:41:10 +0100
X-Google-Sender-Auth: -Wpti_DB9Yv0p8GRKWTD76GfdbU
Message-ID: <CAJZ5v0jGi_ewnJXxwuY1-y6Ti64Y601A4DQuDhtMJ+riYPJpzA@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 3/7] sched: idle: Do not stop the tick before cpuidle_idle_call()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Mar 15, 2018 at 7:19 PM, Frederic Weisbecker
<frederic@kernel.org> wrote:
> On Mon, Mar 12, 2018 at 10:53:25AM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make cpuidle_idle_call() decide whether or not to stop the tick.
>>
>> First, the cpuidle_enter_s2idle() path deals with the tick (and with
>> the entire timekeeping for that matter) by itself and it doesn't need
>> the tick to be stopped beforehand.
>
> Not sure you meant timekeeping either :)

Yeah, I meant nohz.

>>       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
>>               if (idle_should_enter_s2idle()) {
>> +                     rcu_idle_enter();
>> +
>>                       entered_state = cpuidle_enter_s2idle(drv, dev);
>>                       if (entered_state > 0) {
>>                               local_irq_enable();
>>                               goto exit_idle;
>>                       }
>> +
>> +                     rcu_idle_exit();
>>               }
>
> I'm not sure how the tick is stopped on suspend to idle. Perhaps through
> hrtimer (tick_cancel_sched_timer()) or clockevents code.

The latter.

It does clockevents_shutdown() down the road, eventually.

IOW, it couldn't care less. :-)

> But we may have a similar problem than with idle_poll() called right after
> call_cpuidle(). Ie: we arrive in cpuidle_enter_s2idle() with a tick that
> should be reprogrammed while it is not. No idea if that can hurt somehow.
>
> I guess it depends what happens to the tick on s2idle, I'm not clear with that.

No problem there, AFAICS.
