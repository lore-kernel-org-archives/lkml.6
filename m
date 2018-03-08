Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935782AbeCHLmb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:42:31 -0500
Received: from foss.arm.com ([217.140.101.70]:36460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbeCHLm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:42:29 -0500
Date: Thu, 8 Mar 2018 11:42:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: robh@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, peterz@infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jonathan.cameron@huawei.com, frowand.list@gmail.com,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
Message-ID: <20180308114223.fsuwyejw4pb3gyoy@lakrids.cambridge.arm.com>
References: <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A90B77E.8040105@codeaurora.org>
 <20180225143653.peb4quk3ha5h3t5x@salmiak>
 <5A972A7D.9020301@codeaurora.org>
 <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
 <5A986425.9080007@codeaurora.org>
 <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com>
 <5A99A3DC.9020400@codeaurora.org>
 <20180305105925.4cjiqejfid7rswe6@lakrids.cambridge.arm.com>
 <5A9DC03B.8020201@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A9DC03B.8020201@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 02:10:03PM -0800, Saravana Kannan wrote:
> On 03/05/2018 02:59 AM, Mark Rutland wrote:
> > On Fri, Mar 02, 2018 at 11:19:56AM -0800, Saravana Kannan wrote:
> > > On 03/02/2018 02:42 AM, Mark Rutland wrote:
> > > > It's important to note that the DSU PMU's event_init() ensures events
> > > > are affine to a single CPU, and the perf core code serializes operations
> > > > on those events via the context lock.
> > > 
> > > Ah, I see that now. Thanks!
> > > 
> > > > Therefore, two CPUs *won't* try to access the registers simultaneously.
> > > 
> > > Right, and this driver seems to be going through a lot of work to make sure
> > > all events are read in one CPU.
> > > 
> > > Do you even have an upstream target where there are multiple DSU's in a
> > > system?
> > 
> > I have no idea, though I do beleive that it's possible for a system to
> > have multiple DSUs.
> > 
> > > If not, we can simplify a ton of this code (no hotplug notifiers, no
> > > migrating PMUs, no SMP calls, etc) by just adding a spinlock and letting any
> > > CPU read these DSU counters.
> > 
> > Regardless of whether we allow arbitrary CPUs to read the counters,
> > other logic still needs to be CPU affine, and we'll still need hotplug
> > notifiers and event migration.
> 
> If you have to support multiple DSUs in a system, then the need is obvious.
> But if you don't have to support multiple DSU, it's not obvious to me on why
> you still need CPU affining or hotplug notifiers. Could you please provide
> me pointers for general understanding?

There are a number of reasons. From the top of my head:

* The perf core relies on the interrupt handler being serialised w.r.t.
  operations on the relevant perf_event_context and
  perf_event_cpu_context by way of these being affine to the same CPU.
  For this to be the case, events *must* be managed on the CPU the
  interrupt handler is affine to.

* The perf core rotates events on a per-cpu basis. To keep this fair and
  reasonable, the perf core needs to manage *all* events for a PMU on
  the same CPU.

* We expose a cpumask to userspace, so that it attempts to open events
  on a single CPU (and doesn't open redundant events that would result
  in misleading figures).

  This must be an online CPU for the perf core to allow events to be
  created, so this must be updated when assocaited CPUs are hotplugged.
  We must choose *some* arbitrary associated CPU for this.

* If the arbitrarily-chosen CPU is hotplugged out, but other associated
  CPUs are online, we should keep the events active by choosing another
  arbitrary associated CPU, and migrating the events (see
  perf_pmu_migrate_context). Note that we must also fiddle with the
  interrupt affinity.

* If a hotplug event occurs between userspace reading the cpumask and
  opening an event, it may try to open events on a CPU that is not the
  currently arbitrarily chosen CPU. To ameliorate this, in
  pmu::even_init we re-write event->cpu so long as the CPU was *some*
  valid CPU.

There might be some other reasons, too...

Thanks,
Mark.
