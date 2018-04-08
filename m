Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbeDHQck (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:32:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53955 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeDHQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:32:38 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 00/10] sched/cpuidle: Idle loop rework
Date: Sun, 08 Apr 2018 18:32:45 +0200
Message-ID: <1607755.Sz6cLBVOsW@aspire.rjw.lan>
In-Reply-To: <1736751.LdhZHb50jq@aspire.rjw.lan>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 4, 2018 10:32:12 AM CEST Rafael J. Wysocki wrote:
> Hi All,
> 
> Thanks a lot for the feedback so far!
> 
> For the motivation/summary, please refer to the BZ entry at
> 
>  https://bugzilla.kernel.org/show_bug.cgi?id=199227
> 
> created for collecting information related to this patch series.  Some v7.3
> testing results from Len and Doug are in there already.
> 
> The testing so far shows significant idle power improvements, both in terms of
> reducing the average idle power (about 10% on some systems) and in terms of
> reducing the idle power noise (in the vast majority of cases, with this series
> applied the idle power is mostly stable around the power floor of the system).
> The average power is also reduced in some non-idle workloads and there are
> some performance improvements in them.
> 
> It also is reported that the series generally addresses the problem it has been
> motivated by (ie. the "powernightmares" issue).
> 
> This revision is mostly a re-send of the v8 with three patches changed as
> follows.
> 
> > Patch 1 prepares the tick-sched code for the subsequent modifications and it
> > doesn't change the code's functionality (at least not intentionally).
> > 
> > Patch 2 starts pushing the tick stopping decision deeper into the idle
> > loop, but that is limited to do_idle() and tick_nohz_irq_exit().
> > 
> > Patch 3 makes cpuidle_idle_call() decide whether or not to stop the tick
> > and sets the stage for the subsequent changes.
> >
> > Patch 4 is a new one just for the TICK_USEC definition changes.
> >
> > Patch 5 adds a bool pointer argument to cpuidle_select() and the ->select
> > governor callback allowing them to return a "nohz" hint on whether or not to
> > stop the tick to the caller.  It also adds code to decide what value to
> > return as "nohz" to the menu governor and modifies its correction factor
> > computations to take running tick into account if need be.
> >
> > Patch 6 (which is new) contains some changes that previously were included
> > into the big reordering patch (patch [6/8] in the v7).  Essentially, it does
> > more tick-sched code reorganization in preparation for the subsequent changes
> > (and should not modify the functionality).
> 
> Patch 7 is a new version of its v8 counterpart.  It makes fewer changes to the
> existing code and adds a special function for the handling of the use case it
> is about.  It still makes some hrtimer code modifications allowing it to return
> the time to the next event with one timer excluded (which needs to be done with
> respect to the tick timer), though.
> 
> Patch 8 reorders the idle state selection with respect to the stopping of
> the tick and causes the additional "nohz" hint from cpuidle_select() to be
> used for deciding whether or not to stop the tick.  It is a rebased version
> of its v8 counterpart.
> 
> Patch 9 causes the menu governor to refine the state selection in case the
> tick is not going to be stopped and the already selected state does not fit
> the interval before the next tick time.  It is a new version that avoids
> using state 0 if it has been disabled (if state 0 has been disabled, the
> governor only should use it when no states are enabled at all).
> 
> > Patch 10 Deals with the situation in which the tick was stopped previously,
> > but the idle governor still predicts short idle (it has not changed).
> 
> This series is complementary to the poll_idle() patches discussed recently
> 
> https://patchwork.kernel.org/patch/10282237/
> https://patchwork.kernel.org/patch/10311775/
> 
> that have been merged for v4.17 already.
> 
> There is a new git branch containing the current series at
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  idle-loop-v9

The v9 along with some cleanups suggested by Frederic on top of it and with
ACKs from Peter (obtained on IRC) is now available from the pm-cpuidle branch
in the linux-pm.git tree.

It has been added to my linux-next branch, so it probably will be picked up by
linux-next tomorrow and I have a plan to push it for v4.17 in the second half
of the next week unless a major issue with it is found in the meantime.

Thanks,
Rafael
