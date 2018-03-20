Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCTKth (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:49:37 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33189 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeCTKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:49:35 -0400
X-Google-Smtp-Source: AG47ELuRTeYaAFOk1BwYN8/rMhzW5bcOFhCBa58IEX+0zbx5ztqU974jQU3BLc+F1p2kj6Yo5dO761HF0C8mSn7gqus=
MIME-Version: 1.0
In-Reply-To: <d9b202d75c484ef3b636ce181d1c04ca@MSX-L104.msx.ad.zih.tu-dresden.de>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
 <2043615.lCdO10SMaB@aspire.rjw.lan> <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
 <d9b202d75c484ef3b636ce181d1c04ca@MSX-L104.msx.ad.zih.tu-dresden.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Mar 2018 11:49:34 +0100
X-Google-Sender-Auth: uRTSxmhTJ0sSBWdFvWQ9nWWfsAY
Message-ID: <CAJZ5v0ijG5dZJ9mUKwwF9B8VAFuB_SSkV2gv8SuXP_S6aRKKUw@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
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

On Tue, Mar 20, 2018 at 11:01 AM, Thomas Ilsche
<thomas.ilsche@tu-dresden.de> wrote:
> On 2018-03-18 17:15, Rafael J. Wysocki wrote:
>>>
>>> Doug, Thomas,
>>>
>>> Thank you both for the reports, much appreciated!
>>>
>>> Below is a drop-in v6 replacement for patch [4/7].
>>>
>>> With this new patch applied instead of the [4/7] the behavior should be
>>> much
>>> more in line with the v4 behavior, so please try it if you can and let me
>>> know
>>> if that really is the case on your systems.
>>>
>>> Patches [5-7/7] from the original v5 apply on top of it right away for
>>> me,
>>> but I've also created a git branch you can use to pull all of the series
>>> with the below included:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>>   idle-loop
>
>
> Thanks for the git repo, that helps alot. I have tested v6 on a
> Skylake desktop and server system as well as a Haswell server system.
> The odd idle behavior of v5 is gone.

Thank you for the report!

> Some of the other findings may be obsolete by the upcoming respin,
> I will retest.
>
> Our originally observed Powernightmare pattern is effectively
> prevented in both idle and with a synthetic trigger.

That's great!

> However, I can reproduce simple workloads under which the revised
> menu governor wastes energy by going into *deeper* C-states than
> advisable.
>
> Consider the Skylake server system which has residencies in C1E of
> 20 us and C6 of 800 us. I use a small while(1) {usleep(300);}
> unsynchronized pinned to each core. While this is an artificial
> case, it is a very innocent one - easy to predict and regular. Between
> vanilla 4.16.0-rc5 and idle-loop/v6, the power consumption increases
> from 149.7 W to 158.1 W. On 4.16.0-rc5, the cores sleep almost
> entirely in C1E. With the patches applied, the cores spend ~75% of
> their sleep time in C6, ~25% in C1E. The average time/usage for C1E is
> also lower with v6 at ~350 us rather than the ~550 us in C6 (and in
> C1E with the baseline). Generally the new menu governor seems to chose
> C1E if the next timer is an enabled sched timer - which occasionally
> interrupts the sleep-interval into two C1E sleeps rather than one C6.
>
> Manually disabling C6, reduces power consumption back to 149.5 W.
>
> This is far from what I expected, I did not yet figure out why the
> patched menu governor decides to go to C6 under that workload. I
> have tested this previously with v4 and saw this behavior even
> without path "7/7".

I see.

I'm not sure what the source of this effect is either.  If that is
also present in the v7 I'm working on now, it should be easier to
diagnose in there.

> The results from Haswell-EP and Skylake desktop are similar.
>
> The tests are with a 1000 Hz kernel because I wanted to amplify
> effects that happening when C-state residencies and tick timers are
> closer together. But I suspect the results will be similar with
> 300 Hz as the impact from the sched tick interruption seems to be
> minor compared to the odd C-state selection.

OK

Thanks!
