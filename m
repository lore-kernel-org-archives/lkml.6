Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E59C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8E5206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8E5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJBTvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:51:43 -0400
Received: from foss.arm.com ([217.140.101.70]:36908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbeJBTvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8FFE7A9;
        Tue,  2 Oct 2018 06:08:26 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC1B3F5B7;
        Tue,  2 Oct 2018 06:08:22 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:08:21 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 05/14] sched: Introduce a sched_feat for Energy Aware
 Scheduling
Message-ID: <20181002130818.fciw7cmlwggymxrz@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-6-quentin.perret@arm.com>
 <20181002123416.GA3439@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002123416.GA3439@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Oct 2018 at 14:34:16 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:13:00AM +0100, Quentin Perret wrote:
> > In order to make sure Energy Aware Scheduling (EAS) doesn't hurt
> > systems not using it, add a new sched_feat, called ENERGY_AWARE,
> > guarding the access to EAS code paths.
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  kernel/sched/features.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index 85ae8488039c..26ff6752e492 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -90,3 +90,10 @@ SCHED_FEAT(WA_BIAS, true)
> >   * UtilEstimation. Use estimated CPU utilization.
> >   */
> >  SCHED_FEAT(UTIL_EST, true)
> > +
> > +/*
> > + * Energy-Aware Scheduling. Whether or not tasks will be placed into an
> > + * energy-aware fashion depends on this feature being enabled and on the
> > + * root domain having an Energy Model attached.
> > + */
> > +SCHED_FEAT(ENERGY_AWARE, false)
> 
> So these are debug knobs.. I would expect there to be a regular
> static_key that is controlled by the presence of EM data.

Right, the issue I'm trying to solve with this is basically that _some_
users will want to have an EM for the thermal stuff, but they will want
EAS disabled. Some people (not very many that's true, but still) use
big.little and don't care much about energy ...

So, there is a need for an EAS knob on the scheduler side. I don't mind
it being something else than a sched_feat, but I couldn't see a better
option. Another Kconfig (CONFIG_SCHED_ENERGY) ? A sysctl ?

FWIW, the Android kernel has had an ENERGY_AWARE sched_feat since the
very beginning of EAS.

> Remember, if you compile with SCHED_DEBUG=n, this becomes a compile time
> constant: false, and the compiler gets to do lots of DCE.

Indeed, and what happens in the mobile market sometimes is that people
play with those options as needed and then they put patches in their
device kernels to change the defaults before compiling with
!SCHED_DEBUG.

I'd say it's not the worst kind of device-specific out-of-tree changes
to Linux. That's debatable however

Thanks,
Quentin
