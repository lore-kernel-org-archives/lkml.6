Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeCQJes (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 05:34:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCQJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 05:34:47 -0400
Date: Sat, 17 Mar 2018 10:34:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@intel.com
Cc: tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V6 5/8] perf/x86/intel/uncore: add infrastructure for
 free running counter
Message-ID: <20180317093438.GI4064@hirez.programming.kicks-ass.net>
References: <1516911228-5293-1-git-send-email-kan.liang@intel.com>
 <1516911228-5293-5-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516911228-5293-5-git-send-email-kan.liang@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 12:13:45PM -0800, kan.liang@intel.com wrote:
> @@ -512,6 +538,17 @@ static int uncore_pmu_event_add(struct perf_event *event, int flags)
>  	if (!box)
>  		return -ENODEV;
>  
> +	/*
> +	 * The free funning counter is assigned in event_init().
> +	 * The free running counter event and free running counter
> +	 * are 1:1 mapped. It doesn't need to be tracked in event_list.
> +	 */
> +	if (uncore_pmc_freerunning(hwc->idx)) {
> +		if (flags & PERF_EF_START)
> +			uncore_pmu_event_start(event, 0);
> +		return 0;
> +	}
> +
>  	ret = n = uncore_collect_events(box, event, false);
>  	if (ret < 0)
>  		return ret;

This will result in some (probably) unexpected scheduling artifacts.
Probably the only way to really cure that is to have the free running
counters in their own PMU and not share with the GP counters of this
box.
