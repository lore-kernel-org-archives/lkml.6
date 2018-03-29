Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeC2MXe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:23:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47852 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeC2MXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:08 -0400
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
Subject: [PATCH v8 00/10] sched/cpuidle: Idle loop rework
Date: Thu, 29 Mar 2018 13:48:27 +0200
Message-ID: <40092860.XNQZrLjKDd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Thanks a lot for the feedback so far!

Special thanks for the testing results from Doug, Thomas and Len,
much appreciated!

After the recent Thomas' report on the v7.3 I found a bug in the new
implementation of tick_nohz_get_sleep_length() which generally didn't
take highres timers into account and overestimated the expected time
to the next event when they were in use.  It is fixed in this respin
of the series.

Instead of repeating the summary again, let me point you to the BZ
entry at https://bugzilla.kernel.org/show_bug.cgi?id=199227 created
for collecting information related to this patch series.  Some v7.3
testing results from Len and Doug are in there already.

Patches [0-4/10] in this revision are the same as in the v7 and patch 5
is the same as the v7.3 counterpart of it (posted separately):

> Patch 1 prepares the tick-sched code for the subsequent modifications and it
> doesn't change the code's functionality (at least not intentionally).
> 
> Patch 2 starts pushing the tick stopping decision deeper into the idle
> loop, but that is limited to do_idle() and tick_nohz_irq_exit().
> 
> Patch 3 makes cpuidle_idle_call() decide whether or not to stop the tick
> and sets the stage for the subsequent changes.
>
> Patch 4 is a new one just for the TICK_USEC definition changes.
>
> Patch 5 adds a bool pointer argument to cpuidle_select() and the ->select
> governor callback allowing them to return a "nohz" hint on whether or not to
> stop the tick to the caller.  It also adds code to decide what value to
> return as "nohz" to the menu governor and modifies its correction factor
> computations to take running tick into account if need be.

Patch 6 (which is new) contains some changes that previously were included
into the big reordering patch (patch [6/8] in the v7).  Essentially, it does
more tick-sched code reorganization in preparation for the subsequent changes
(and should not modify the functionality).

Patch 7 (which is new too) makes some hrtimer code modifications allowing it
to return the time to the next event with one timer excluded (which needs
to be done with respect to the tick timer).

Patch 8 reorders the idle state selection with respect to the stopping of
the tick and causes the additional "nohz" hint from cpuidle_select() to be
used for deciding whether or not to stop the tick.  It is not really new,
but some changes from the previous version of it went into the current
patch 6.

Patch 9 causes the menu governor to refine the state selection in case the
tick is not going to be stopped and the already selected state may not fit
before the next tick time (it has not changed except for being rebased).

Patch 10 Deals with the situation in which the tick was stopped previously,
but the idle governor still predicts short idle (it has not changed).

This series is complementary to the poll_idle() patches discussed recently

https://patchwork.kernel.org/patch/10282237/
https://patchwork.kernel.org/patch/10311775/

that have been queued up for v4.17 already.

There is a new git branch containing the current series at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 idle-loop-v8

Thanks,
Rafael
