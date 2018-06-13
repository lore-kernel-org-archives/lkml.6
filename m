Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5D199C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141D220020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141D220020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935628AbeFMNFc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:05:32 -0400
Received: from foss.arm.com ([217.140.101.70]:47378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935481AbeFMNFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:05:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A370F1529;
        Wed, 13 Jun 2018 06:05:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0838C3F25D;
        Wed, 13 Jun 2018 06:05:28 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:05:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Agustin Vega-Frias <agustinv@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        timur@codeaurora.org
Subject: Re: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
Message-ID: <20180613130526.y3xgqm5qjrke6vto@lakrids.cambridge.arm.com>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
 <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
 <9957219b64252d3b2e19724db04a1179@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9957219b64252d3b2e19724db04a1179@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:41:32PM -0400, Agustin Vega-Frias wrote:
> On 2018-06-12 10:40, Mark Rutland wrote:
> > On Thu, Jun 07, 2018 at 09:56:48AM -0400, Agustin Vega-Frias wrote:
> > > +/*
> > > + * Qualcomm Technologies CPU PMU IMPLEMENTATION DEFINED extensions
> > > support
> > > + *
> > > + * Current extensions supported:
> > > + *
> > > + * - Matrix-based microarchitectural events support
> > > + *
> > > + *   Selection of these events can be envisioned as indexing them
> > > from
> > > + *   a 3D matrix:
> > > + *   - the first index selects a Region Event Selection Register
> > > (PMRESRx_EL0)
> > > + *   - the second index selects a group from which only one event
> > > at a time
> > > + *     can be selected
> > > + *   - the third index selects the event
> > > + *
> > > + *   The event is encoded into perf_event_attr.config as 0xPRCCG,
> > > where:
> > > + *     P  [config:16   ] = prefix   (flag that indicates a
> > > matrix-based event)
> > > + *     R  [config:12-15] = register (specifies the PMRESRx_EL0
> > > instance)
> > > + *     G  [config:0-3  ] = group    (specifies the event group)
> > > + *     CC [config:4-11 ] = code     (specifies the event)
> > > + *
> > > + *   Events with the P flag set to zero are treated as common PMUv3
> > > events
> > > + *   and are directly programmed into PMXEVTYPERx_EL0.
> > 
> > When PMUv3 is given a raw event code, the config fields should be the
> > PMU event number, and this conflicts with RESERVED encodings.
> > 
> > I'd rather we used a separate field for the QC extension events. e.g.
> > turn config1 into a flags field, and move the P flag there.
> > 
> > We *should* add code to sanity check those fields are zero in the PMUv3
> > driver, even though it's a potential ABI break to start now.
> 
> I should have stated clearly that in this case the event code is directly
> programmed into PMXEVTYPERx_EL0.evtCount, not by this code, but by the PMUv3
> code, which will do the masking and ensure reserved bits are not touched.

I understand this may be fine on the HW side; it's more to do with the
userspace ABI expected with PMUv3. The config encoding should be the
(PMUv3) type field, and I don't want a potential clash if/when PMUv3
gets extended in future beyond the current 16 bits.

I'd very much like to keep the QC extension bits separate from that.

> IOW, that case is no different from the raw event or a common event case.
> 
> I would prefer to keep the flag in config because it allows the use of
> raw code encodings to access these events more easily, and given that
> the flag is never propagated to any register I believe it is safe.

You can easily add sysfs fields to make this easy, e.g. have reg map to
config1:x-y, and the user can specify the event based on that, e.g.

  perf ${cmd} -e qcom_pmuv3/reg=0xf,.../

Which means they're *explicitly* asking for the QC extension bits, and
we can be sure they're not asking for something from baseline PMUv3.

We *might* want to namespace the qc fields, in case we want to add
anything similar to PMUv3 in future.

[...]

> > > +/*
> > > + * Check if e1 and e2 conflict with each other
> > > + *
> > > + * e1 is a matrix-based microarchitectural event we are checking
> > > against e2.
> > > + * A conflict exists if the events use the same reg, group, and a
> > > different
> > > + * code. Events with the same code are allowed because they could
> > > be using
> > > + * different filters (e.g. one to count user space and the other to
> > > count
> > > + * kernel space events).
> > > + */

> > Does the filter matter at all? When happens if I open two identical
> > events, both counting the same reg, group, and code, with the same
> > filter?
> 
> That is possible and allowed, similar to counting the same common event
> in two configurable counters. Only problem is wasting a counter resource.

Ok. Please drop the mention of filtering from the comment -- it makes it
sound like there's a potential problem, and it isn't relevant.

[...]

> > > +		/* Matrix event, program the appropriate PMRESRx_EL0 */
> > > +		struct arm_pmu *pmu = to_arm_pmu(event->pmu);
> > > +		struct pmu_hw_events *events = this_cpu_ptr(pmu->hw_events);
> > > +		u64 reg = QC_EVT_REG(event->attr.config);
> > > +		u64 code = QC_EVT_CODE(event->attr.config);
> > > +		u64 group = QC_EVT_GROUP(event->attr.config);
> > > +		unsigned long flags;
> > > +
> > > +		raw_spin_lock_irqsave(&events->pmu_lock, flags);
> > > +		falkor_set_resr(reg, group, code);
> > > +		raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> > 
> > Why is the spinlock required?
> > 
> > AFACIT this should only ever be called in contexts where IRQs are
> > disabled already.
> > 
> 
> falkor_set_resr is a read-modify-write operation. The PMUv3 code uses
> the spinlock to protect the counter selection too (armv8pmu_enable_event).

As I mention, that only happens in contexts where IRQs are disabled, so
that shouldn't be a problem.

> I believe this is to deal with event rotation which can potentially
> be active when we are creating new events.

Event rotation happens off the back of a hrtimer callback, with IRQs
disabled. There's a lockdep assert to that effect in
perf_mux_hrtimer_handler(), before it calls perf_rotate_context().

> > > +	}
> > > +
> > > +	/* Let the original op handle the rest */
> > > +	def_ops->enable(event);
> > > +}
> > > +
> > > +/*
> > > + * Disable the given event
> > > + */
> > > +static void falkor_disable(struct perf_event *event)
> > > +{
> > > +	/* Use the original op to disable the counter and interrupt  */
> > > +	def_ops->enable(event);
> > > +
> > > +	if (!!(event->attr.config & QC_EVT_PFX_MASK)) {
> > > +		/* Matrix event, de-program the appropriate PMRESRx_EL0 */
> > > +		struct arm_pmu *pmu = to_arm_pmu(event->pmu);
> > > +		struct pmu_hw_events *events = this_cpu_ptr(pmu->hw_events);
> > > +		u64 reg = QC_EVT_REG(event->attr.config);
> > > +		u64 group = QC_EVT_GROUP(event->attr.config);
> > > +		unsigned long flags;
> > > +
> > > +		raw_spin_lock_irqsave(&events->pmu_lock, flags);
> > > +		falkor_clear_resr(reg, group);
> > > +		raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
> > > +	}
> > > +}
> > 
> > Same comments as with falkor_enable().
> > 
> > > +
> > > +PMU_FORMAT_ATTR(event,  "config:0-15");
> > > +PMU_FORMAT_ATTR(prefix, "config:16");
> > > +PMU_FORMAT_ATTR(reg,    "config:12-15");
> > > +PMU_FORMAT_ATTR(code,   "config:4-11");
> > > +PMU_FORMAT_ATTR(group,  "config:0-3");
> > 
> > What sort of events are available? Do you plan to add anything to the
> > userspace event database in tools/perf/pmu-events/ ?
> > 
> 
> Yes, we are still doing some internal work to see what we can put in
> the driver or as JSON events.

Please put them in userspace. Events living in the kernel is really a
legacy thing, and we've placed all other IMP-DEF events in userspace for
ACPI systems.

[...]

> > > +	pmu->name = "qcom_pmuv3";
> > 
> > All the other CPU PMUs on an ARM ACPI system will have an index suffix,
> > e.g. "armv8_pmuv3_0". I can see why we might want to change the name to
> > indicate the QC extensions, but I think we should keep the existing
> > pattern, with a '_0' suffix here.
> 
> This overrides the name before the suffix is added, so the PMU name will be
> qcom_pmuv3_0 for Centriq 2400 which has only Falkor CPUs.

Ok.

[...]

> > > +	/* Override the necessary ops */
> > > +	pmu->map_event     = falkor_map_event;
> > > +	pmu->get_event_idx = falkor_get_event_idx;
> > > +	pmu->reset         = falkor_reset;
> > > +	pmu->enable        = falkor_enable;
> > > +	pmu->disable       = falkor_disable;
> > 
> > I'm somewhat concerned by hooking into the existing PMU code at this
> > level, but I don't currently have a better suggestion.
> > 
> 
> IMO this is no different from other PMUs implemented on top of the arm_pmu
> framework. The difference is of course that I'm calling back into the base
> PMUv3 ops, 

Yup, the latter is what I'm concerned about. e.g. when you take the
pmu_lock, if PMUv3 code has already taken this, there'll be a deadlock,
and it means that we can't consider the PMUv3 code in isolation.

As long as we can keep this *simple*, that'll just leave me uneasy.

Thanks,
Mark.
