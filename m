Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423567AbeE1Mjc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:39:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163998AbeE1Mj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:39:27 -0400
Date: Mon, 28 May 2018 13:24:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        jolsa@kernel.org
Subject: Re: [RFC 2/2] perf: Sharing PMU counters across compatible events
Message-ID: <20180528112445.GB3452@worktop.programming.kicks-ass.net>
References: <20180504231102.2850679-1-songliubraving@fb.com>
 <20180504231102.2850679-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504231102.2850679-3-songliubraving@fb.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 04:11:02PM -0700, Song Liu wrote:
> On the critical paths, perf_events are added to/removed from the
> active_dup list of the perf_event. The first event added to the list
> will be the master event, and the only event that runs pmu->add().
> Later events will all refer to this master for read().
> 
>    cpuctx ->  perf_event_dup -> master
>                      ^       -> active_dup (list)
>                      |             ^  ^
>          perf_event /|  ----------/   |
>                      |                |
>          perf_event /   -------------/
> 

> +static void add_event_to_dup_event_list(struct perf_event *event,
> +					struct perf_cpu_context *cpuctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < cpuctx->dup_event_count; ++i)
> +		if (memcmp(&event->attr,
> +			   &cpuctx->dup_event_list[i].first->attr,
> +			   sizeof(event->attr)) == 0) {
> +			event->dup_id = i;
> +			return;
> +		}

(style nit: this needs {})

So we merge events when the attr's are an exact match; which includes
sampling and all those fancy things, right?

I think this scheme causes phase shifts in the samples when we combine
two otherwise identical events. Because while they have the same
sampling interval, they might not have the same effective runtime and
thus have a different 'remainder' for the current sample interval.

This could add up to a significant sample skew for unlucky
circumstances. On average I think it works out, but if you're always
landing on a shorter interval, the effective sample rate can go up
significantly.

> +	i = cpuctx->dup_event_count++;
> +	cpuctx->dup_event_list[i].first = event;
> +	cpuctx->dup_event_list[i].master = NULL;
> +	INIT_LIST_HEAD(&cpuctx->dup_event_list[i].active_dup);
> +	event->dup_id = i;
> +	INIT_LIST_HEAD(&event->dup_sibling_entry);
> +}
