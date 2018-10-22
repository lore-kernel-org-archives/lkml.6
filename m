Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED34C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B1D20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B1D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeJVVeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:34:18 -0400
Received: from foss.arm.com ([217.140.101.70]:46588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJVVeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E41BC80D;
        Mon, 22 Oct 2018 06:15:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F833F627;
        Mon, 22 Oct 2018 06:15:41 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:15:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Hu <nickhu@andestech.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, deanbo422@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, arnd@arndb.de, sboyd@codeaurora.org,
        geert@linux-m68k.org, zong@andestech.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, devicetree@vger.kernel.org,
        green.hu@gmail.com
Subject: Re: [PATCH 1/5] nds32: Perf porting
Message-ID: <20181022131537.k6zonbn53pwee74h@lakrids.cambridge.arm.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <ab5f07d5b518ef2374f2c1ebd15d81dfa17b2c9a.1539745993.git.nickhu@andestech.com>
 <20181018142359.xzsxwghjgb7lmzwk@lakrids.cambridge.arm.com>
 <20181022101826.GA24110@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022101826.GA24110@andestech.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:18:26PM +0800, Nick Hu wrote:
> On Thu, Oct 18, 2018 at 03:23:59PM +0100, Mark Rutland wrote:
> > On Thu, Oct 18, 2018 at 04:43:13PM +0800, Nickhu wrote:

> > > +static irqreturn_t nds32_pmu_handle_irq(int irq_num, void *dev)
> > > +{
> > > +     u32 pfm;
> > > +     struct perf_sample_data data;
> > > +     struct nds32_pmu *cpu_pmu = (struct nds32_pmu *)dev;
> > > +     struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
> > > +     struct pt_regs *regs;
> > > +     int idx;
> > > +     /*
> > > +      * Get and reset the IRQ flags
> > > +      */
> > > +     pfm = nds32_pfm_getreset_flags();
> > > +
> > > +     /*
> > > +      * Did an overflow occur?
> > > +      */
> > > +     if (!nds32_pfm_has_overflowed(pfm))
> > > +             return IRQ_NONE;
> > > +
> > > +     /*
> > > +      * Handle the counter(s) overflow(s)
> > > +      */
> > > +     regs = get_irq_regs();
> > > +
> > > +     for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
> > > +             struct perf_event *event = cpuc->events[idx];
> > > +             struct hw_perf_event *hwc;
> > > +
> > > +             /* Ignore if we don't have an event. */
> > > +             if (!event)
> > > +                     continue;
> > > +
> > > +             /*
> > > +              * We have a single interrupt for all counters. Check that
> > > +              * each counter has overflowed before we process it.
> > > +              */
> > > +             if (!nds32_pfm_counter_has_overflowed(pfm, idx))
> > > +                     continue;
> > > +
> > > +             hwc = &event->hw;
> > > +             nds32_pmu_event_update(event);
> > > +             perf_sample_data_init(&data, 0, hwc->last_period);
> > > +             if (!nds32_pmu_event_set_period(event))
> > > +                     continue;
> > > +
> > > +             if (perf_event_overflow(event, &data, regs))
> > > +                     cpu_pmu->disable(event);
> > > +     }
> > > +
> > > +     /*
> > > +      * Handle the pending perf events.
> > > +      *
> > > +      * Note: this call *must* be run with interrupts disabled. For
> > > +      * platforms that can have the PMU interrupts raised as an NMI, this
> > > +      * will not work.
> > > +      */
> > > +     irq_work_run();
> > > +
> > > +     return IRQ_HANDLED;
> > > +}
> > 
> > You'll want to stop all counters over the IRQ handler to ensure that
> > groups are consistent.
> > 
> > [...]
> 
> Our implementation of IRQ handler references the irq_handler of
> arch/arm/kernel/perf_event_v7.c.

Ah, it looks like we forgot to fix that up when we fixed arm64 in
commit:

  3cce50dfec4a5b04 ("arm64: perf: Disable PMU while processing counter overflows")

... we should do that for all the arch/arm PMU IRQ handlers.

> Do you mean that when one counter overflowed, other counters do not
> count the events caused by the counter overflow handler?

The problem is that counters are still counting while they're being
read/modified, so there is skew.

Groups of counters should be scheduled atomically (i.e. at any point in
time, all counters are counting, or all are not counting). This isn't
true if they're read one-by-one in the IRQ handler (and maybe
reprogrammed afterwards).

Consider a group of three events, programmed with the same event (e.g.
bus-cycles). You would expect that all three events read the same value,
since they're identical.

In the IRQ handler we do something like:

	count0 = read_counter(0);  // reads N
	< X bus cycles occur >
	count1 = read_counter(1);  // reads N + X
	< Y bus cycles occur >
	count2 = read_counter(2);  // reads N + X + Y

We read the first counter, and before we read the next counter, more
events occur. Likewise for the next pair of counters. This leads to
surprising results, especially if counters are reprogrammed on overflow.

That means that you can't necessarily derive a meaningful ratio between
counter values.

The simplest way to solve this is to stop the PMU before reading the
counters, and start it again afterwards. It leaves a small window where
the counters aren't counting, but it ensures the ratio between counters
is meaningful.

See commit:

  3cce50dfec4a5b04 ("arm64: perf: Disable PMU while processing counter overflows")

... for how we did that on arm64.

Thanks,
Mark.
