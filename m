Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeCOWVJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:21:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60489 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeCOWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:20:59 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Thu, 15 Mar 2018 22:59:48 +0100
Message-ID: <2142751.3U6XgWyF8u@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Thanks a lot for the feedback so far!

One more respin after the last batch of comments from Peter and Frederic.

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
> 
> Patch 4 adds a bool pointer argument to cpuidle_select() and the ->select
> governor callback allowing them to return a "nohz" hint on whether or not to
> stop the tick to the caller.  It also adds code to decide what value to
> return as "nohz" to the menu governor.
> 
> Patch 5 reorders the idle state selection with respect to the stopping of
> the tick and causes the additional "nohz" hint from cpuidle_select() to be
> used for deciding whether or not to stop the tick.
> 
> Patch 6 causes the menu governor to refine the state selection in case the
> tick is not going to be stopped and the already selected state may not fit
> before the next tick time.
> 
> Patch 7 Deals with the situation in which the tick was stopped previously,
> but the idle governor still predicts short idle.

This series is complementary to the poll_idle() patch at

https://patchwork.kernel.org/patch/10282237/

Thanks,
Rafael
