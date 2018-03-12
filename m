Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeCLMib (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:38:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeCLMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:38:29 -0400
Date: Mon, 12 Mar 2018 13:38:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, jolsa@redhat.com, kernel-team@fb.com,
        ephiepark@fb.com, Tejun Heo <tj@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH] perf: update perf_cgroup time for ancestor cgroup(s)
Message-ID: <20180312123824.GF4064@hirez.programming.kicks-ass.net>
References: <20180312053244.2593974-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312053244.2593974-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 10:32:44PM -0700, Song Liu wrote:
> When a perf_event is attached to parent cgroup, it should count events
> for all children cgroups:
> 
>  parent_group   <---- perf_event
>    \
>     - child_group  <---- process(es)
> 
> However, in our tests, we found this perf_event cannot report reliable
> results. This is because perf_event->cgrp and cpuctx->cgrp are not
> identical, thus perf_event->cgrp are not updated properly.

It might help now and in for our older selves, if you could provide a
simple reproducer for this.

> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reported-by: Ephraim Park <ephiepark@fb.com>
> ---
>  kernel/events/core.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5789810..623d38f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

> @@ -766,6 +821,17 @@ perf_cgroup_set_timestamp(struct task_struct *task,
>  	cgrp = perf_cgroup_from_task(task, ctx);
>  	info = this_cpu_ptr(cgrp->info);
>  	info->timestamp = ctx->timestamp;
> +
> +	/* set timestamp for ancestor cgroups */
> +	if (cgrp->css.cgroup->level > 1) {
> +		struct perf_cgroup_info *info = this_cpu_ptr(cgrp->info);
> +		struct perf_event *event;
> +
> +		list_for_each_entry(event, &ctx->pinned_groups, group_entry)
> +			perf_ancestor_cgroup_set_timestamp(event, cgrp, info);
> +		list_for_each_entry(event, &ctx->flexible_groups, group_entry)
> +			perf_ancestor_cgroup_set_timestamp(event, cgrp, info);
> +	}
>  }

That doesn't make any kind of sense... if we're interested in ancestor
groups, then WTH are you iterating _events_ ?

I'm expecting something like:

	struct cgroup_subsys_state *css;

	for (css = cgrp->css; css; css = css->parent) {
		/* fudge time */
	}
