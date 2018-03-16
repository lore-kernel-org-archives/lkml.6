Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeCPOYz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:24:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbeCPOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:24:52 -0400
Date: Fri, 16 Mar 2018 15:24:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, kernel-team@fb.com,
        ephiepark@fb.com
Subject: Re: [PATCH v2] perf: update perf_cgroup time for ancestor cgroup(s)
Message-ID: <20180316142447.GA4043@hirez.programming.kicks-ass.net>
References: <20180312165943.1057894-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312165943.1057894-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 09:59:43AM -0700, Song Liu wrote:
> When a perf_event is attached to parent cgroup, it should count events
> for all children cgroups:
> 
>  parent_group   <---- perf_event
>    \
>     - child_group  <---- process(es)
> 
> However, in our tests, we found this perf_event cannot report reliable
> results. Here is an example case:
> 
>   # create cgroups
>   mkdir -p /sys/fs/cgroup/p/c
>   # start perf for parent group
>   perf stat -e instructions -G "p"
> 
>   # on another console, run test process in child cgroup:
>   stressapptest -s 2 -M 1000 & echo $! > /sys/fs/cgroup/p/c/cgroup.procs
> 
>   # after the test process is done, stop perf in the first console shows
> 
>        <not counted>      instructions              p
> 
> The instruction should not be "not counted" as the process runs in the
> child cgroup.
> 
> We found this is because perf_event->cgrp and cpuctx->cgrp are not
> identical, thus perf_event->cgrp are not updated properly.
> 
> This patch fixes this by updating perf_cgroup properly for ancestor
> cgroup(s).
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reported-by: Ephraim Park <ephiepark@fb.com>

Yeah, that looks about right, Thanks!
