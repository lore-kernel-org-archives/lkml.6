Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbeDLTNH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:13:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeDLTNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:13:05 -0400
Date: Thu, 12 Apr 2018 21:13:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Paul Turner <pjt@google.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] sched/fair: add support to tune PELT ramp/decay timings
Message-ID: <20180412191318.GA7129@worktop.programming.kicks-ass.net>
References: <20180409165134.707-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409165134.707-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 05:51:34PM +0100, Patrick Bellasi wrote:
> The PELT half-life is the time [ms] required by the PELT signal to build
> up a 50% load/utilization, starting from zero. This time is currently
> hardcoded to be 32ms, a value which seems to make sense for most of the
> workloads.
> 
> However, 32ms has been verified to be too long for certain classes of
> workloads. For example, in the mobile space many tasks affecting the
> user-experience run with a 16ms or 8ms cadence, since they need to match
> the common 60Hz or 120Hz refresh rate of the graphics pipeline.
> This contributed so fare to the idea that "PELT is too slow" to properly
> track the utilization of interactive mobile workloads, especially
> compared to alternative load tracking solutions which provides a
> better representation of tasks demand in the range of 10-20ms.

Initially the 32 was chosen to more or less correspond to the effective
scheduling period (sysctl_sched_latency based). The thinking was that if
you pick a PELT window shorter than the period, the result becomes
unstable due to not all tasks getting an equal go at things.

(of course, stuffing enough tasks on a rq will break this, but at that
point you have worse problems to deal with)

Should we retain this? Esp. with the lower end (8ms) I worry we'll see
more of those effects.


> Fortunately, since the integration of the utilization estimation
> support in mainline kernel:
> 
>    commit 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
> 
> a fast decay time is no longer an issue for tasks utilization estimation.
> Although estimated utilization does not slow down the decay of blocked
> utilization on idle CPUs, for mobile workloads this seems not to be a
> major concern compared to the benefits in interactivity responsiveness.

By picking a smaller PELT window, the util_est window shrinks
correspondingly; is that intentional or do we want to modify
UTIL_EST_WEIGHT_SHIFT to negate the PELT window changes?
