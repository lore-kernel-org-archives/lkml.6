Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YY4PIUWGHls4NAAAmS7hNA
	; Mon, 11 Jun 2018 14:25:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7A866607A4; Mon, 11 Jun 2018 14:25:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0488760541;
	Mon, 11 Jun 2018 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0488760541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934433AbeFKOZH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:25:07 -0400
Received: from foss.arm.com ([217.140.101.70]:52352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934184AbeFKOYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:24:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A89F21529;
        Mon, 11 Jun 2018 07:24:35 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96E073F318;
        Mon, 11 Jun 2018 07:24:34 -0700 (PDT)
Date: Mon, 11 Jun 2018 15:24:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
Message-ID: <20180611142431.4svc26y27scgzfcg@lakrids.cambridge.arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
 <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
 <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
 <847dfe5c-665c-6398-f87f-3ca56e73f5aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <847dfe5c-665c-6398-f87f-3ca56e73f5aa@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 02:54:16PM +0100, Suzuki K Poulose wrote:
> On 08/06/18 15:46, Suzuki K Poulose wrote:
> > On 06/06/2018 07:01 PM, Mark Rutland wrote:
> > > On Tue, May 29, 2018 at 11:55:56AM +0100, Suzuki K Poulose wrote:
> 
> > > > -        value |= 0xffffffff00000000ULL;
> > > > +        if (!armv8pmu_event_is_64bit(event))
> > > > +            value |= 0xffffffff00000000ULL;
> > > >           write_sysreg(value, pmccntr_el0);
> > > > -    } else if (armv8pmu_select_counter(idx) == idx)
> > > > -        write_sysreg(value, pmxevcntr_el0);
> > > > +    } else
> > > > +        armv8pmu_write_hw_counter(event, value);
> > > >   }
> > > 
> > > > +static inline void armv8pmu_write_event_type(struct perf_event *event)
> > > > +{
> > > > +    struct hw_perf_event *hwc = &event->hw;
> > > > +    int idx = hwc->idx;
> > > > +
> > > > +    /*
> > > > +     * For chained events, write the the low counter event type
> > > > +     * followed by the high counter. The high counter is programmed
> > > > +     * with CHAIN event code with filters set to count at all ELs.
> > > > +     */
> > > > +    if (armv8pmu_event_is_chained(event)) {
> > > > +        u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
> > > > +                ARMV8_PMU_INCLUDE_EL2;
> > > > +
> > > > +        armv8pmu_write_evtype(idx - 1, hwc->config_base);
> > > > +        isb();
> > > > +        armv8pmu_write_evtype(idx, chain_evt);
> > > 
> > > The ISB isn't necessary here, AFAICT. We only do this while the PMU is
> > > disabled; no?
> > 
> > You're right. I was just following the ARM ARM.
> 
> Taking another look, it is not clear about the semantics of "pmu->enable()"
> and pmu->disable() callbacks. 

I was talking about pmu::{pmu_disable,pmu_enable}(), so I'm not sure I
follow how arm_pmu::{enable,disable}() are relevant here.

The arm_pmu::{enable,disable}() callbacks enable or disable individual
counters. For example, leaving unused counters disabled may save power,
even if the PMU as a whole is enabled.

> I don't see any reference to them in the perf core
> driver anymore. The perf core uses add() / del () instead, with the PMU
> turned off. Do you have any idea about the enable()/disable() callbacks ?

I'm not sure I understand what you're asking here.

Thanks,
Mark.
