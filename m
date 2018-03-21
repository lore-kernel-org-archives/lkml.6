Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCUGc6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:32:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57136 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUGc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:32:57 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Wed, 21 Mar 2018 07:33:21 +0100
Message-ID: <1690803.hdDb2ySb37@aspire.rjw.lan>
In-Reply-To: <002d01d3c08e$f43aa750$dcaff5f0$@net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com> <002d01d3c08e$f43aa750$dcaff5f0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 20, 2018 10:03:50 PM CET Doug Smythies wrote:
> Summary: My results with kernel 4.16-rc6 and V8 of the patch set
> are completely different, and now show no clear difference
> (a longer test might reveal something). 

Does this mean that you see the "powernightmares" pattern with the v8
again or are you referring to something else?

> On 2018.03.20 10:16 Doug Smythies wrote:
> > On 2018.03.20 03:02 Thomas Ilsche wrote:
> >
> >...[snip]...
> >
> >> Consider the Skylake server system which has residencies in C1E of
> >> 20 us and C6 of 800 us. I use a small while(1) {usleep(300);}
> >> unsynchronized pinned to each core. While this is an artificial
> >> case, it is a very innocent one - easy to predict and regular. Between
> >> vanilla 4.16.0-rc5 and idle-loop/v6, the power consumption increases
> >> from 149.7 W to 158.1 W. On 4.16.0-rc5, the cores sleep almost
> >> entirely in C1E. With the patches applied, the cores spend ~75% of
> >> their sleep time in C6, ~25% in C1E. The average time/usage for C1E is
> >> also lower with v6 at ~350 us rather than the ~550 us in C6 (and in
> >> C1E with the baseline). Generally the new menu governor seems to chose
> >> C1E if the next timer is an enabled sched timer - which occasionally
> >> interrupts the sleep-interval into two C1E sleeps rather than one C6.
> >>
> >> Manually disabling C6, reduces power consumption back to 149.5 W.
> >
> > ...[snip]...
> >
> > Note that one of the tests that I normally do is a work/sleep
> > frequency sweep from 100 to 2100 Hz, typically at a lowish
> > workload. I didn't notice anything odd with this test:
> > 
> > http://fast.smythies.com/rjw_freq_sweep.png

Would it be possible to produce this graph with the v8 of the
patchset?

> > However, your test is at 3333 Hz (well, minus overheads).
> > I did the same as you. And was surprised to confirm
> > your power findings. In my case package power goes from
> > ~8.6 watts to ~7.3 watts with idle state 4 (C6) disabled.
> >
> > I am getting different residency times than you though.
> > I also observe different overheads between idle state 4
> > being disabled or not. i.e. my actual loop frequency
> > drops from ~2801 Hz to ~2754 Hz.
> >
> > Example residencies over the previous minute:
> >
> > Idle state 4 (C6) disabled (seconds):
> >
> > Idle state 0: 0.001119
> > Idle state 1: 0.056638
> > Idle state 2: 13.100550
> > Idle state 3: 446.266744
> > Idle state 4: 0.000000
> >
> > Idle state 4 (C6) enabled (seconds):
> >
> > Idle state 0: 0.034502
> > Idle state 1: 1.949595
> > Idle state 2: 78.291793
> > Idle state 3: 96.467974
> > Idle state 4: 286.247524
> 
> Now, with kernel 4.16-rc6 and V8 of the patch set and the poll fix
> I am unable to measure the processor package power difference
> between idle state 0 enabled or disabled (i.e. it is in the noise).
> also the loop time changes (overhead changes) are minimal. However,
> the overall loop time has dropped to ~2730 Hz, so there seems to be
> a little more overhead in general.
> 
> I increased my loop frequency to ~3316 Hz. Similar.
> 
> I increased my loop frequency to ~15474 Hz. Similar.
> Compared to a stock 4.16-rc6 kernel: The loop rate dropped
> to 15,209 Hz and it (the stock kernel) used about 0.3 more
> watts (out of 10.97, or ~3% more).

So do you prefer v6 or v8?  I guess the former?
