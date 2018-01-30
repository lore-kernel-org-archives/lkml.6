Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeA3LvL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:51:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeA3LvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:51:10 -0500
Date: Tue, 30 Jan 2018 12:50:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130115054.GA2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130104555.4125-5-mgorman@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:45:55AM +0000, Mel Gorman wrote:
> The select_idle_sibling (SIS) rewrite in commit 10e2f1acd010 ("sched/core:
> Rewrite and improve select_idle_siblings()") replaced a domain iteration
> with a search that broadly speaking does a wrapped walk of the scheduler
> domain sharing a last-level-cache. While this had a number of improvements,
> one consequence is that two tasks that share a waker/wakee relationship push
> each other around a socket. Even though two tasks may be active, all cores
> are evenly used. This is great from a search perspective and spreads a load
> across individual cores but it has adverse consequences for cpufreq. As each
> CPU has relatively low utilisation, cpufreq may decide the utilisation is
> too low to used a higher P-state and overall computation throughput suffers.

> While individual cpufreq and cpuidle drivers may compensate by artifically
> boosting P-state (at c0) or avoiding lower C-states (during idle), it does
> not help if hardware-based cpufreq (e.g. HWP) is used.

Not saying this patch is bad; but Rafael / Srinivas we really should do
better. Why isn't cpufreq (esp. sugov) fixing this? HWP or not, we can
still give it hints, and it looks like we're not doing that.

Mel, what hardware are you testing this on?
