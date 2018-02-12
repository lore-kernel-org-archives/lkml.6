Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbeBLJoL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:44:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933099AbeBLJoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:44:09 -0500
Date: Mon, 12 Feb 2018 10:44:06 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
Message-ID: <20180212094406.GE5821@krava>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 03:07:00PM -0800, Raghavendra Rao Ananta wrote:

SNIP

>  
>  	if (!task) {
> +#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
> +		struct perf_cpu_context *cpuctx =
> +			container_of(ctx, struct perf_cpu_context, ctx);
> +
> +		if (!cpuctx->online) {
> +			perf_prepare_install_in_context(event);
> +			return;
> +		}
> +#endif
>  		cpu_function_call(cpu, __perf_install_in_context, event);
>  		return;
>  	}
> @@ -2421,6 +2443,43 @@ static int  __perf_install_in_context(void *info)
>  	raw_spin_unlock_irq(&ctx->lock);
>  }
>  
> +#if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
> +static void perf_deferred_install_in_context(int cpu)
> +{
> +	struct perf_event *event, *tmp;
> +	struct perf_event_context *ctx;
> +
> +	/* This function is called twice while coming online. Once for
> +	 * CPUHP_PERF_PREPARE and the other for CPUHP_AP_PERF_ONLINE.
> +	 * Only during the CPUHP_AP_PERF_ONLINE state, we can confirm
> +	 * that CPU PMU is ready and can be installed to.
> +	 */
> +	if (!cpu_online(cpu))
> +		return;
> +
> +	spin_lock(&dormant_event_list_lock);
> +	list_for_each_entry_safe(event, tmp, &dormant_event_list,
> +						dormant_entry) {
> +		if (cpu != event->cpu)
> +			continue;

I wonder having per cpu lists would be better here,
could be quite busy for big number of CPUs

jirka
