Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeCVRVG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:21:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41271 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCVRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:21:04 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 22 Mar 2018 18:21:28 +0100
Message-ID: <3258417.cAAax18vkN@aspire.rjw.lan>
In-Reply-To: <000401d3c1f4$5043adb0$f0cb0910$@net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de> <000401d3c1f4$5043adb0$f0cb0910$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 22, 2018 4:41:54 PM CET Doug Smythies wrote:
> On 2018.03.21 23:25 Doug Smythies wrote:
> > On 2018.03.21 15:15 Rafael J. Wysocki wrote:
> >> On Wed, Mar 21, 2018 at 6:59 PM, Thomas Ilsche wrote:
> >>> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
> >>>>
> >>>> So please disregard this one entirely and take the v7.2 replacement
> >>>> instead of it:https://patchwork.kernel.org/patch/10299429/
> >>>>
> >>>> The current versions (including the above) is in the git branch at
> >>>>
> >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >>>>   idle-loop-v7.2
> >>>
> >>> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
> >>> as with v5: several cores which just keep the sched tick enabled.
> >>> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
> >>> full sched tick.
> >>> The resulting power consumption is ~105 W instead of ~ 70 W.
> >>>
> >>> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
> >>>
> >>> I have briefly ran v7 and I believe it was also affected.
> 
> I am not seeing any issues at all with V7.
> 
> >>
> >> Then it looks like menu_select() stubbornly thinks that the idle
> >> duration will be within the tick boundary on those cores.
> >> 
> >> That may be because the bumping up of the correction factor in
> >> menu_reflect() is too conservative or it may be necessary to do
> >> something radical to measured_us in menu_update() in case of a tick
> >> wakeup combined with a large next_timer_us value.
> >>
> >> For starters, please see if the attached patch (on top of the
> >> idle-loop-v7.2 git branch) changes this behavior in any way.
> >
> > O.K. I am seeing some weirdness.
> > On my system with both V7.2 and V7.2 plus this patch, I observe
> > A spike in Idle State 1 residency every 34+ minutes. And slightly
> > higher average idle power than before.
> > (I might not have done V7 idle tests long enough).
> 
> I re-did the idle test on V7, and for longer.
> It is great.
> See line added to the idle graph for V7.2+:
> 
> http://fast.smythies.com/rjw_v72p_v7_idle.png
> 
> >
> > It can be seen in the frequency sweep I did earlier today, with V7.2:
> >
> > http://fast.smythies.com/rjw_freq_sweep_72_combined.png
> >
> > Despite the note on the graph that says it might be real, I don't think
> > it is (I forgot to delete the note).
> >
> > With V7.2+ sometimes the event occurs at 17 minute intervals.
> > Here is a idle graph (for reference: we have seen idle package power
> > pretty steady at ~3.7 watts before).
> 
> Now shown on the new graph. Link above.

Thanks for the data!

I will send another update of patch [5/8] shortly which is closer to the
original v7 of it than the v7.[1-2].
