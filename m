Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA520849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAA520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLKMYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:24:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbeLKMYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:24:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D66AEBD;
        Tue, 11 Dec 2018 04:24:30 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70D333F6A8;
        Tue, 11 Dec 2018 04:24:26 -0800 (PST)
Date:   Tue, 11 Dec 2018 12:24:24 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v10 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Message-ID: <20181211122422.x4xt3kde54wqncvw@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-3-quentin.perret@arm.com>
 <CAJZ5v0iygh1Kh4FnOE=2GzcUHW+FBV+9ZrotAfmXtgdk==6tNg@mail.gmail.com>
 <20181211121742.d6ujfyccwn7t63b3@queper01-lin>
 <CAJZ5v0hP4iEQAFOA2AzcgVUzWS5FeQpCza4Ly-esw0qkYwqrLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hP4iEQAFOA2AzcgVUzWS5FeQpCza4Ly-esw0qkYwqrLw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Dec 2018 at 13:22:41 (+0100), Rafael J. Wysocki wrote:
> On Tue, Dec 11, 2018 at 1:17 PM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > On Tuesday 11 Dec 2018 at 13:01:24 (+0100), Rafael J. Wysocki wrote:
> > > On Mon, Dec 3, 2018 at 10:56 AM Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > [cut]
> > >
> > > >  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > > > +/**
> > > > + * enum schedutil_type - CPU utilization type
> > > > + * @FREQUENCY_UTIL:    Utilization used to select frequency
> > > > + * @ENERGY_UTIL:       Utilization used during energy calculation
> > > > + *
> > > > + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> > > > + * need to be aggregated differently depending on the usage made of them. This
> > > > + * enum is used within schedutil_freq_util() to differentiate the types of
> > > > + * utilization expected by the callers, and adjust the aggregation accordingly.
> > > > + */
> > > > +enum schedutil_type {
> > > > +       FREQUENCY_UTIL,
> > > > +       ENERGY_UTIL,
> > > > +};
> > >
> > > Why not to use bool instead of this?  Do you expect to have more than
> > > just two values in the future?  If so, what would be the third one?
> >
> > Indeed, the only reason is that an enum is easier to extend, if need be.
> > I think you mentioned some time ago that CPUIdle could be, in principle,
> > interested in having access to aggregated utilization signals of CPUs:
> >
> > https://lore.kernel.org/lkml/CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com/
> >
> > So yeah, I kept Peter's original enum and went for documenting the type,
> > as you suggested on v7 :-)
> 
> OK, so please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to this patch.

Thanks !
Quentin
