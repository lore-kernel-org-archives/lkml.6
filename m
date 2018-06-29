Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD027F3D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADD027F3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935011AbeF2O36 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:29:58 -0400
Received: from foss.arm.com ([217.140.101.70]:35126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933566AbeF2O34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:29:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD74780D;
        Fri, 29 Jun 2018 07:29:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E983F5C0;
        Fri, 29 Jun 2018 07:29:54 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:29:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 4/7] arm_pmu: Tidy up clear_event_idx call backs
Message-ID: <20180629142951.lzuzvw6oisrnjjgn@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-5-git-send-email-suzuki.poulose@arm.com>
 <20180629134049.b6sppasr7j32h37g@lakrids.cambridge.arm.com>
 <109b2082-f4ae-9095-7d6f-9daf78b38144@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109b2082-f4ae-9095-7d6f-9daf78b38144@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:18:23PM +0100, Suzuki K Poulose wrote:
> 
> Hi Mark,
> 
> On 29/06/18 14:40, Mark Rutland wrote:
> > On Tue, Jun 19, 2018 at 11:15:39AM +0100, Suzuki K Poulose wrote:
> > > The armpmu uses get_event_idx callback to allocate an event
> > > counter for a given event, which marks the selected counter
> > > as "used". Now, when we delete the counter, the arm_pmu goes
> > > ahead and clears the "used" bit and then invokes the "clear_event_idx"
> > > call back, which kind of splits the job between the core code
> > > and the backend. Tidy this up by relying on the clear_event_idx
> > > to do the book keeping, if available. Otherwise, let the core
> > > driver do the default "clear" bit operation. This will be useful
> > > for adding the chained event support, where we leave the event
> > > idx maintenance to the backend.
> > > 
> > > Also, when an event is removed from the PMU, reset the hw.idx
> > > to indicate that a counter is not allocated for this event,
> > > to help the backends do better checks. This will be also used
> > > for the chain counter support.
> > > 
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > > Changes since v2:
> > >   - Reset the event counter after an event is removed.
> > > ---
> > >   arch/arm/kernel/perf_event_v7.c |  2 ++
> > >   drivers/perf/arm_pmu.c          | 17 +++++++++++++----
> > >   2 files changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> > > index fd7ce01..765d265 100644
> > > --- a/arch/arm/kernel/perf_event_v7.c
> > > +++ b/arch/arm/kernel/perf_event_v7.c
> > > @@ -1637,6 +1637,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> > >   	bool venum_event = EVENT_VENUM(hwc->config_base);
> > >   	bool krait_event = EVENT_CPU(hwc->config_base);
> > > +	clear_bit(hwc->idx, cpuc->used_mask);
> > >   	if (venum_event || krait_event) {
> > >   		bit = krait_event_to_bit(event, region, group);
> > >   		clear_bit(bit, cpuc->used_mask);
> > > @@ -1966,6 +1967,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> > >   	bool venum_event = EVENT_VENUM(hwc->config_base);
> > >   	bool scorpion_event = EVENT_CPU(hwc->config_base);
> > > +	clear_bit(hwc->idx, cpuc->used_mask);
> > >   	if (venum_event || scorpion_event) {
> > >   		bit = scorpion_event_to_bit(event, region, group);
> > >   		clear_bit(bit, cpuc->used_mask);
> > 
> > As an aside, I think there's an existing problem with krait and
> > cpu_pm_pmu_setup(), and we'll end up with the same issue when chained
> > counters use multiple counters for one event.
> > 
> > The krait code sets multiple bits in the PMU's pmu_hw_events::used_mask,
> > but only one of these will have a corresponding (non-NULL) entry in
> > pmu_hw_events::events[].
> 
> The Krait pmu allocates the "krait" specific event bit beyond the armpmu->num_events.
> See krait_event_to_bit(). And we don't go beyond armpmu->num_events for the "events"
> check. So we should be safe. And it passes on the idx within the num_events back
> to armpmu. So whatever krait pmu does is invisible to the generic driver.

Ah; I had missed that, sorry for the noise.

> > I guess the best thing to do would be to avoid the test_bit(), and just
> > skip an idx if hw_events->events[idx] is NULL.
> > 
> > Would you mind spinning a patch to that effect?
> 
> Eitherway, I could split that change to a new one.

No need -- sorry for the noise.

Thanks,
Mark.
