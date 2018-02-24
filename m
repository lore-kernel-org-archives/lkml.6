Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBXIIS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 03:08:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeBXIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 03:08:17 -0500
Date: Sat, 24 Feb 2018 09:08:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: mark.rutland@arm.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        avilaj@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf/core: Add API to look up PMU type by name
Message-ID: <20180224080809.GA25201@hirez.programming.kicks-ass.net>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:19:37PM -0800, Saravana Kannan wrote:
> When the event numbers registered by multiple PMUs overlap, the
> attr->type value passed to perf_event_create_kernel_counter() is used
> to determine which PMU to use to create a perf_event.
> 
> However, when the PMU in question is not a standard PMU (defined in
> perf_type_id), there is no way for a kernel client to look up the PMU
> type for the PMU of interest and set the attr->type appropriately.
> 
> So, add an API to look up the PMU type by name. That way, the kernel
> APIs can function in a fashion similar to the user space interface.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  kernel/events/core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 96db9ae..5d3df58 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10310,6 +10310,29 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
>  	return err;
>  }
>  
> +int perf_find_pmu_type_by_name(const char *name)
> +{
> +	struct pmu *pmu;
> +	int ret = -1;
> +
> +	mutex_lock(&pmus_lock);
> +
> +	list_for_each_entry(pmu, &pmus, entry) {
> +		if (!pmu->name || pmu->type < 0)
> +			continue;
> +
> +		if (!strcmp(name, pmu->name)) {
> +			ret = pmu->type;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&pmus_lock);
> +
> +	return ret;
> +}

Not without an in-tree user.
