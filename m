Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCTQoB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:44:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55160 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCTQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:43:47 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH v7 0/8] sched/cpuidle: Idle loop rework
Date: Tue, 20 Mar 2018 16:12:15 +0100
Message-ID: <2390019.oHdSGtR3EE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Thanks a lot for the feedback so far!

Respin after recent comments from Peter.

Patches [1-3] unmodified since v5, patch 4 is new and the other ones
have been updated to address feedback.

The previous summary that still applies:

On Sunday, March 4, 2018 11:21:30 PM CET Rafael J. Wysocki wrote:
> 
> The problem is that if we stop the sched tick in
> tick_nohz_idle_enter() and then the idle governor predicts short idle
> duration, we lose regardless of whether or not it is right.
> 
> If it is right, we've lost already, because we stopped the tick
> unnecessarily.  If it is not right, we'll lose going forward, because
> the idle state selected by the governor is going to be too shallow and
> we'll draw too much power (that has been reported recently to actually
> happen often enough for people to care).
> 
> This patch series is an attempt to improve the situation and the idea
> here is to make the decision whether or not to stop the tick deeper in
> the idle loop and in particular after running the idle state selection
> in the path where the idle governor is invoked.  This way the problem
> can be avoided, because the idle duration predicted by the idle governor
> can be used to decide whether or not to stop the tick so that the tick
> is only stopped if that value is large enough (and, consequently, the
> idle state selected by the governor is deep enough).
> 
> The series tires to avoid adding too much new code, rather reorder the
> existing code and make it more fine-grained.
>
> Patch 1 prepares the tick-sched code for the subsequent modifications and it
> doesn't change the code's functionality (at least not intentionally).
> 
> Patch 2 starts pushing the tick stopping decision deeper into the idle
> loop, but that is limited to do_idle() and tick_nohz_irq_exit().
> 
> Patch 3 makes cpuidle_idle_call() decide whether or not to stop the tick
> and sets the stage for the subsequent changes.

Patch 4 is a new one just for the TICK_USEC definition changes.

Patch 5 adds a bool pointer argument to cpuidle_select() and the ->select
governor callback allowing them to return a "nohz" hint on whether or not to
stop the tick to the caller.  It also adds code to decide what value to
return as "nohz" to the menu governor and modifies its correction factor
computations to take running tick into account if need be.
 
Patch 6 reorders the idle state selection with respect to the stopping of
the tick and causes the additional "nohz" hint from cpuidle_select() to be
used for deciding whether or not to stop the tick.
 
Patch 7 causes the menu governor to refine the state selection in case the
tick is not going to be stopped and the already selected state may not fit
before the next tick time.

Patch 8 Deals with the situation in which the tick was stopped previously,
but the idle governor still predicts short idle.

This series is complementary to the poll_idle() patch at

https://patchwork.kernel.org/patch/10282237/

and I have update the idle-loop branch in my tree

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 idle-loop

with the new patches.

Thanks,
Rafael
