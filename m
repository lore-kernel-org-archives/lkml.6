Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeBYOhG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 09:37:06 -0500
Received: from foss.arm.com ([217.140.101.70]:41442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeBYOhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 09:37:04 -0500
Date: Sun, 25 Feb 2018 14:36:53 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com,
        robh@kernel.org, sudeep.holla@arm.com, mathieu.poirier@linaro.org,
        peterz@infradead.org, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com, leo.yan@linaro.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
Message-ID: <20180225143653.peb4quk3ha5h3t5x@salmiak>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A90B77E.8040105@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A90B77E.8040105@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:53:18PM -0800, Saravana Kannan wrote:
> On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> > +static void dsu_pmu_event_update(struct perf_event *event)
> > +{
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	u64 delta, prev_count, new_count;
> > +
> > +	do {
> > +		/* We may also be called from the irq handler */
> > +		prev_count = local64_read(&hwc->prev_count);
> > +		new_count = dsu_pmu_read_counter(event);
> > +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
> > +			prev_count);
> > +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
> > +	local64_add(delta, &event->count);
> > +}
> > +
> > +static void dsu_pmu_read(struct perf_event *event)
> > +{
> > +	dsu_pmu_event_update(event);
> > +}

> I sent out a patch that'll allow PMUs to set an event flag to avoid
> unnecessary smp calls when the event can be read from any CPU. You could
> just always set that if you can't have multiple DSU's running the kernel (I
> don't know if the current ARM designs support having multiple DSUs in a
> SoC/system) or set it if associated_cpus == cpu_present_mask.

As-is, that won't be safe, given the read function calls the event_update()
function, which has side-effects on hwc->prec_count and event->count. Those
need to be serialized somehow.

Thanks,
Mark.
