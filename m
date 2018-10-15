Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E9C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB02064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAB02064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeJOPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:36:26 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38316 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeJOPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:36:26 -0400
Received: by mail-ot1-f44.google.com with SMTP id l1so18000523otj.5;
        Mon, 15 Oct 2018 00:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=851BLYopi0B5hF5DLdZYQjBsFAeBNpr5HpY1/QerRmY=;
        b=TDJXOsgpI18Qn0ZuZH7oaA4m0C5ZgFkxaJOvmc2VcYEx9eKf6rlta5rlXRKELdim05
         3e8uufYARd+PmiixehbgwDlUFEVPkT5nYWBUBlrgRPl6j79/IdNrwsFoUqg31iQX12EW
         CNZdY8jEqocJ0/nLT1jxhaJ4pUaCyrvr2amfvfHyiQh8818hO8SlnKaP2R+bBXJQLd83
         UoStTUmj0wZwvlfIiuATlavQOSq1zoun/BMDnrsC05iqVj7vrRV5c9gyBvKI4d2Jt1Ox
         JCowjL0eJVKeQclRnA8X1px392qDzxCGEeOgatspyGGyr+JFMVgdCu1LuX2QYE12Szn+
         Qt2w==
X-Gm-Message-State: ABuFfojMVOTWPm6XtAwoUEt88Q5bF/RjjbVF2p3SOrIG9SzLiRA3Um3k
        WvMAUYmSL663RFrcCpLWq/jRwCzqL8nf8ePw3fU=
X-Google-Smtp-Source: ACcGV61yaHzRxlREA6Wcc8j/72ApNvSCWUheMdoPGGCfpxeg2LAJ8+CedD60s8yXkpto7QdlKwgjLYeO1p9eIUewNS0=
X-Received: by 2002:a9d:63:: with SMTP id 90-v6mr539311ota.244.1539589938061;
 Mon, 15 Oct 2018 00:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <000e01d4638a$91a20c60$b4e62520$@net>
In-Reply-To: <000e01d4638a$91a20c60$b4e62520$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Oct 2018 09:52:02 +0200
Message-ID: <CAJZ5v0jieqjQXdYaP4qKhyv5gFm5tEREyxfgrxGhgiAxg5Pf0g@mail.gmail.com>
Subject: Re: [RFC/RFT/[PATCH] cpuidle: New timer events oriented governor for
 tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Sun, Oct 14, 2018 at 8:53 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> I tried your TEO idle governor.

Thanks!

> On 2018.10.11 14:02 Rafael J. Wysocki wrote:
>
> ...[cut]...
>
> > It has been tested on a few different systems with a number of
> > different workloads and compared with the menu governor.  In the
> > majority of cases the workloads performed similarly regardless of
> > the cpuidle governor in use, but in one case the TEO governor
> > allowed the workload to perform 75% better, which is a clear
> > indication that some workloads may benefit from using it quite
> > a bit depending on the hardware they run on.
>
> Could you supply more detail for the 75% better case, so that
> I can try to repeat the results on my system?

This was encryption on Skylake X, but I'll get more details on that later.

> ...[cut]...
>
> > It is likely to select the "polling" state less often than menu
> > due to the lack of the extra latency limit derived from the
> > predicted idle duration, so the workloads depending on that
> > behavior may be worse off (but less energy should be used
> > while running them at the same time).
>
> Yes, and I see exactly that with the 1 core pipe test: Less
> performance (~10%), but also less processor package power
> (~3%), compared to the 8 patch set results from the other day.
>
> The iperf test (running 3 clients at once) results were similar
> for both power and throughput.
>
> > Overall, it selects deeper idle states than menu more often, but
> > that doesn't seem to make a significant difference in the majority
> > of cases.
>
> Not always, that viscous powernightmare sweep test that I run used
> way way more processor package power and spent a staggering amount
> of time in idle state 0. [1].

Can you please remind me what exactly the workload is in that test?

>
> ... [cut]...
>
> > + * The sleep length is the maximum duration of the upcoming idle time of the
> > + * CPU and it is always known to the kernel.  Using it alone for selecting an
> > + * idle state for the CPU every time is a viable option in principle, but that
> > + * might lead to suboptimal results if the other wakeup sources are more active
> > + * for some reason.  Thus this governor estimates whether or not the CPU idle
> > + * time is likely to be significantly shorter than the sleep length and selects
> > + * an idle state for it in accordance with that, as follows:
>
> There is something wrong here, in my opinion, but I have not isolated exactly where
> by staring at the code.
> Read on.
>
> ... [cut]...
>
> > + * Assuming an idle interval every second tick, take the maximum number of CPU
> > + * wakeups regarded as recent to rougly correspond to 10 minutes.
> > + *
> > + * When the total number of CPU wakeups goes above this value, all of the
> > + * counters corresponding to the given CPU undergo a "decay" and the counting
> > + * of recent events stars over.
> > + */
> > +#define TEO_MAX_RECENT_WAKEUPS       (300 * HZ)
>
> In my opinion, there are problems with this is approach:
>
> First, the huge huge range of possible times between decay events,
> anywhere from ~ a second to approximately a week.
>         In an idle 1000 HZ system, at 2 idle entries per 4 second watchdog event:
>         time = 300,000 wakes * 2 seconds/wake = 6.9 days
>         Note: The longest single idle time I measured was 3.5 seconds, but that is
>         always combined with a shorter one. Even using a more realistic, and
>         just now measured, average value of 0.7 idles/second would be 2.4 days.
>
> Second: It leads to unpredictable behaviour, sometimes for a long time, until
> the effects of some previous work are completely flushed. And from the first
> point above, that previous work might have been days ago. In my case, and while
> doing this work, it resulted in non-repeatability of tests and confusion
> for awhile. Decay events are basically asynchronous to the actual tasks being
> executed. For data to support what I am saying I did the following:
>         Do a bunch of times {
>                 Start the powernightmare sweep test.
>                 Abort after several seconds (enough time to flush filters
>                         and prefer idle state 0)
>                 Wait a random amount of time
>                 Start a very light work load, but such that the sleep time
>                         per work cycle is less than one tick
>                 Observe varying times until idle state 0 is not excessively selected.
>                         Anywhere from 0 to 17 minutes (the maximum length of test) was observed.
>         }
>
> Additional information:
>
> Periodic workflow: I am having difficulty understanding an unexpected high
> number of idle entries/exits in steady state (i.e. once things have settled
> down and the filters have finally flushed) For example, a 60% work / 40% sleep
> at 500 hertz workflow seems to have an extra idle entry exit. Trace excerpt
> (edited, the first column is uSeconds since previous):
>
>      140 cpu_idle: state=4294967295 cpu_id=7
>     1152 cpu_idle: state=4 cpu_id=7    <<<< The expected ~1200 uSecs of work
>      690 cpu_idle: state=4294967295 cpu_id=7  <<<< Unexpected, Expected ~800 uSecs
>       18 cpu_idle: state=2 cpu_id=7           <<<< So this extra idle makes up the difference
>      138 cpu_idle: state=4294967295 cpu_id=7  <<<< But why is it there?
>     1152 cpu_idle: state=4 cpu_id=7     <<<< Repeat
>      690 cpu_idle: state=4294967295 cpu_id=7
>       13 cpu_idle: state=2 cpu_id=7
>      143 cpu_idle: state=4294967295 cpu_id=7
>     1152 cpu_idle: state=4 cpu_id=7      <<<< Repeat
>      689 cpu_idle: state=4294967295 cpu_id=7
>       19 cpu_idle: state=2 cpu_id=7
>
> Now compare with trace data for kernel 4.16-rc6 with the 9 patches
> from the other day (which is what I expect to see):
>
>      846 cpu_idle: state=4294967295 cpu_id=7
>     1150 cpu_idle: state=4 cpu_id=7    <<<< The expected ~1200 uSecs of work
>      848 cpu_idle: state=4294967295 cpu_id=7 <<<< The expected ~800 uSecs of idle
>     1152 cpu_idle: state=4 cpu_id=7    <<<< Repeat
>      848 cpu_idle: state=4294967295 cpu_id=7
>     1151 cpu_idle: state=4 cpu_id=7    <<<< Repeat
>      848 cpu_idle: state=4294967295 cpu_id=7
>     1152 cpu_idle: state=4 cpu_id=7    <<<< Repeat
>      848 cpu_idle: state=4294967295 cpu_id=7
>     1152 cpu_idle: state=4 cpu_id=7    <<<< Repeat
>
> Anyway, in the end we really only care about power. So for this test:
> Kernel 4.19-rc6 + 9 patches: 9.133 watts
> TEO (on top of 4.19-rc7):
> At start, high number of idle state 0 entries: 11.33 watts (+24%)
> After awhile, it shifted to idle state 1: 10.00 watts (+9.5%)
> After awhile, it shifted to idle state 2: 9.67 watts (+5.9%)
> That seemed to finally be a steady state scenario (at least for over 2 hours).
> Note: it was always using idle state 4 also.
>
> ...[snip]...
>
> > +     /* Decay past events information. */
> > +     for (i = 0; i < drv->state_count; i++) {
> > +             cpu_data->states[i].early_wakeups_old += cpu_data->states[i].early_wakeups;
> > +             cpu_data->states[i].early_wakeups_old /= 2;
> > +             cpu_data->states[i].early_wakeups = 0;
> > +
> > +             cpu_data->states[i].hits_old += cpu_data->states[i].hits;
> > +             cpu_data->states[i].hits_old /= 2;
> > +             cpu_data->states[i].hits = 0;
>
> I wonder if this decay rate is strong enough.
>
> Hope this helps.

Yes, it does, thank you!

Cheers,
Rafael
