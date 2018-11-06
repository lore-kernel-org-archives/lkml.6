Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB58C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25612086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25612086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbeKGAU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:20:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60519 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388908AbeKGAU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:20:26 -0500
Received: from 79.184.254.59.ipv4.supernova.orange.pl (79.184.254.59) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 4976b71bd06d0710; Tue, 6 Nov 2018 15:54:49 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 06 Nov 2018 15:55:06 +0100
Message-ID: <6592350.ldnZvJegIa@aspire.rjw.lan>
In-Reply-To: <1541446371.3441.9.camel@suse.cz>
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <1541446371.3441.9.camel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 5, 2018 8:32:51 PM CET Giovanni Gherdovich wrote:
> On Sun, 2018-11-04 at 17:31 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 

[cut]

> > +
> > +/**
> > + * teo_update - Update CPU data after wakeup.
> > + * @drv: cpuidle driver containing state data.
> > + * @dev: Target CPU.
> > + */
> > +static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > +{
> > +       struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > +       unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
> > +       int i, idx_hit = -1, idx_timer = -1;
> > +       unsigned int measured_us;
> > +
> > +       if (cpu_data->time_span_ns == cpu_data->sleep_length_ns) {
> > +               /* One of the safety nets has triggered (most likely). */
> > +               measured_us = sleep_length_us;
> > +       } else {
> > +               measured_us = dev->last_residency;
> > +               i = cpu_data->last_state;
> > +               if (measured_us >= 2 * drv->states[i].exit_latency)
> > +                       measured_us -= drv->states[i].exit_latency;
> > +               else
> > +                       measured_us /= 2;
> > +       }
> > +
> 
> I haven't read this v3 yet,

The pattern detection code in it has a minor issue that needs addressing, so
I'm going to send a v4 later today (after testing it somewhat).

> so just a little comment on the bit above (which
> is there since v1).

To be precise, this piece is there in the menu governor too and I thought that
it made sense, so I copied it from there. :-)

> When you check for measured_us >= 2 * exit_latency, is that because
> dev->last_residency is composed by an "entry" latency, then the actual
> residency, and finally the exit_latency? I'm asking about the 2x factor
> there.

If measured_us is less than twice the state's exit latency, the difference
between it and the exit latency may be very small, so it is better to take a
half of it then as an upper bound estimate of it in case there are some
inaccuracies in the measurement.

> If that succeeds, you proceed to remove the exit_latency from
> measured_us... just once. Given how the condition is formulated, I expected
> measured_us -= 2 * exit_latency there.

The exit latency is subtracted once, because we are interested in the time
between asking the hardware to enter the idle state and the wakeup event.

The exit latency is the time between the wakeup event and the first instruction,
so it shouldn't be counted, roughly speaking.

> More: you acknowledge, in that snippet of code, that there can be
> dev->last_residency's smaller than twice the exit_latency, i.e. not even the
> time to entry/exit the state. Am I reading this right? Is that because both
> exit_latency and dev->last_residency are only approximations?

Yes, they are just approximations.

> I actually see quite a few of those extra-short residencies in my traces, even
> with dev->last_residency < exit_latency.

Well, they are expected to occur at least occasionally.

Cheers,
Rafael

