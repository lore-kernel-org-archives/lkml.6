Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeBPIVp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:21:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753977AbeBPIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:21:44 -0500
Date: Fri, 16 Feb 2018 09:21:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, cme@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, skannan@codeaurora.org
Subject: Re: [PATCH 1/1] perf: Add CPU hotplug support for events
Message-ID: <20180216082139.GF25181@hirez.programming.kicks-ass.net>
References: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
 <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 03:01:41PM -0800, Raghavendra Rao Ananta wrote:
> Perf framework doesn't allow prevserving CPU events across
> CPU hotplugs. The events are scheduled out as and when the
> CPU walks offline. Moreover, the framework also doesn't
> allow the clients to create events on an offline CPU. As
> a result, the clients have to keep on monitoring the CPU
> state until it comes back online.
> 
> Therefore, introducing the perf framework to support creation
> and preserving of (CPU) events for offline CPUs. Through
> this, the CPU's online state would be transparent to the
> client and it not have to worry about monitoring the CPU's
> state. Success would be returned to the client even while
> creating the event on an offline CPU. If during the lifetime
> of the event the CPU walks offline, the event would be
> preserved and would continue to count as soon as (and if) the
> CPU comes back online.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> ---
>  include/linux/perf_event.h |   7 +++
>  kernel/events/core.c       | 123 +++++++++++++++++++++++++++++++++------------
>  2 files changed, 97 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 7546822..bc07f16 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -489,6 +489,7 @@ struct perf_addr_filters_head {
>   * enum perf_event_state - the states of a event
>   */
>  enum perf_event_state {
> +	PERF_EVENT_STATE_DORMANT	= -5,
>  	PERF_EVENT_STATE_DEAD		= -4,
>  	PERF_EVENT_STATE_EXIT		= -3,
>  	PERF_EVENT_STATE_ERROR		= -2,
> @@ -687,6 +688,12 @@ struct perf_event {
>  #endif
>  
>  	struct list_head		sb_list;
> +
> +	/* Entry into the list that holds the events whose CPUs
> +	 * are offline. These events will be removed from the
> +	 * list and installed once the CPU wakes up.
> +	 */
> +	struct list_head		dormant_entry;

No this is absolutely disguisting. You can simply keep the events in the
dead CPU's context. It's really not that hard.

Also, you _still_ don't explain why you care about dead CPUs.
