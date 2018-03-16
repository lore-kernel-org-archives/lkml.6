Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeCPNZW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:25:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeCPNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:25:20 -0400
Date: Fri, 16 Mar 2018 14:25:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v6 0/4] Utilization estimation (util_est) for FAIR tasks
Message-ID: <20180316132506.GF4064@hirez.programming.kicks-ass.net>
References: <20180309095245.11071-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309095245.11071-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:52:41AM +0000, Patrick Bellasi wrote:
> Hi, here is an update of [1], based on today's tip/sched/core [2], which mainly
> adds some code cleanups suggested by Peter as well as fixes compilation for
> !CONFIG_SMP systems.
> 
> Most notably:
> a) The util_est's update flag has been renamed into UTIL_AVG_UNCHANGED, which
>    seems to better match its usages.
> b) The cpu_util_est() function has been removed to reduce cluttering by folding
>    its code directly into cpu_util(). This last function is thus now always
>    returning the estimated utilization of a CPU, unless this sched feature is
>    disabled.
> c) Not necessary READ_ONCE() have been removed from rq-lock protected code
>    paths. For util_est variable, that we read/modify/write only from rq-lock
>    protected, code we keep just the WRITE_ONCE() barriers, which are still
>    required for synchronization with lockless readers.
>    The READ_ONCE() have been instead maintained in all the getter functions,
>    like for example task_util() and cpu_util(), which can potentially be used
>    by lockless code. e.g. schedutil or load-balancer.
> 
> Results on both x86_64 and ARM (Android) targets, which have been collected and
> reported in previous postings [1,3], show negligible overheads, especially
> compared to the corresponding power/performance benefits on mobile platforms,
> where this feature helps to reduce the performance gap between PELT and another
> other out-of-tree load tracking solution.

Thanks Patrick!
