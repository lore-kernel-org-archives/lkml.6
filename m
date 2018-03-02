Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426515AbeCBKmh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:42:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52882 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424102AbeCBKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:42:28 -0500
Date: Fri, 2 Mar 2018 10:42:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: robh@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, peterz@infradead.org,
        jonathan.cameron@huawei.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        sudeep.holla@arm.com, frowand.list@gmail.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
Message-ID: <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A90B77E.8040105@codeaurora.org>
 <20180225143653.peb4quk3ha5h3t5x@salmiak>
 <5A972A7D.9020301@codeaurora.org>
 <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
 <5A986425.9080007@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A986425.9080007@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 12:35:49PM -0800, Saravana Kannan wrote:
> On 03/01/2018 03:49 AM, Mark Rutland wrote:
> > On Wed, Feb 28, 2018 at 02:17:33PM -0800, Saravana Kannan wrote:
> > > On 02/25/2018 06:36 AM, Mark Rutland wrote:
> > > > On Fri, Feb 23, 2018 at 04:53:18PM -0800, Saravana Kannan wrote:
> > > > > On 01/02/2018 03:25 AM, Suzuki K Poulose wrote:
> > > > > > +static void dsu_pmu_event_update(struct perf_event *event)
> > > > > > +{
> > > > > > +	struct hw_perf_event *hwc = &event->hw;
> > > > > > +	u64 delta, prev_count, new_count;
> > > > > > +
> > > > > > +	do {
> > > > > > +		/* We may also be called from the irq handler */
> > > > > > +		prev_count = local64_read(&hwc->prev_count);
> > > > > > +		new_count = dsu_pmu_read_counter(event);
> > > > > > +	} while (local64_cmpxchg(&hwc->prev_count, prev_count, new_count) !=
> > > > > > +			prev_count);
> > > > > > +	delta = (new_count - prev_count) & DSU_PMU_COUNTER_MASK(hwc->idx);
> > > > > > +	local64_add(delta, &event->count);
> > > > > > +}
> > > > > > +
> > > > > > +static void dsu_pmu_read(struct perf_event *event)
> > > > > > +{
> > > > > > +	dsu_pmu_event_update(event);
> > > > > > +}
> > > > 
> > > > > I sent out a patch that'll allow PMUs to set an event flag to avoid
> > > > > unnecessary smp calls when the event can be read from any CPU. You could
> > > > > just always set that if you can't have multiple DSU's running the kernel (I
> > > > > don't know if the current ARM designs support having multiple DSUs in a
> > > > > SoC/system) or set it if associated_cpus == cpu_present_mask.
> > > > 
> > > > As-is, that won't be safe, given the read function calls the event_update()
> > > > function, which has side-effects on hwc->prec_count and event->count. Those
> > > > need to be serialized somehow.
> > > 
> > > You have to grab the dsu_pmu->pmu_lock spin lock anyway because the system
> > > registers are shared across all CPUs.
> > 
> > I believe that lock is currently superfluous, because the perf core
> > ensures operations are cpu-affine, and have interrupts disabled in most
> > cases (thanks to the context lock).
> 
> I don't think it's superfluous. You have a common "event counter" selection
> register and a common "event counter value" register. You can two CPUs
> racing to read two unrelated event counters and end up causing one of them
> to read a bogus value from the wrong event counter.

It's important to note that the DSU PMU's event_init() ensures events
are affine to a single CPU, and the perf core code serializes operations
on those events via the context lock.

Therefore, two CPUs *won't* try to access the registers simultaneously.

If events could be active on multiple CPUs simultaneously, I agree that
the lock would be necessary. However, there would also be other problems
to deal with in that case.

If we want to allow pmu::read() from arbitrary CPUs the DSU is affine
to, I agree we'd need the lock to serialize accesses to the registers
and data structures.

Thanks,
Mark.
