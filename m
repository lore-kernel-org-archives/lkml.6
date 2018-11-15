Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F13221582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F13221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeKONC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:02:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48008 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKONCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:02:55 -0500
Received: from 64.114.255.114 (64.114.255.114) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id e082395fb6166fcd; Thu, 15 Nov 2018 03:56:56 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 15 Nov 2018 03:57:05 +0100
Message-ID: <13917501.YLdTytznDL@aspire.rjw.lan>
In-Reply-To: <20181111152034.GC3021@worktop>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <20181111152034.GC3021@worktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 11, 2018 4:20:34 PM CET Peter Zijlstra wrote:
> On Thu, Nov 08, 2018 at 06:25:07PM +0100, Rafael J. Wysocki wrote:
> > +/*
> > + * The SPIKE value is added to metrics when they grow and the DECAY_SHIFT value
> > + * is used for decreasing metrics on a regular basis.
> > + */
> > +#define SPIKE		1024
> > +#define DECAY_SHIFT	3
> 
> > +	if (idx_timer >= 0) {
> > +		unsigned int hits = cpu_data->states[idx_timer].hits;
> > +		unsigned int misses = cpu_data->states[idx_timer].misses;
> > +
> > +		hits -= hits >> DECAY_SHIFT;
> > +		misses -= misses >> DECAY_SHIFT;
> > +
> > +		if (idx_timer > idx_hit) {
> > +			misses += SPIKE;
> > +			if (idx_hit >= 0)
> > +				cpu_data->states[idx_hit].early_hits += SPIKE;
> > +		} else {
> > +			hits += SPIKE;
> > +		}
> > +
> > +		cpu_data->states[idx_timer].misses = misses;
> > +		cpu_data->states[idx_timer].hits = hits;
> > +	}
> 
> That's a pulse-density-modulator, with a signal bound of:
> 
>   1024 == x/8 -> x := 8192
> 
> Anyway; I would suggest s/SPIKE/PULSE/ because of that.

OK


