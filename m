Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0B2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB0B2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeHCRwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:52:49 -0400
Received: from foss.arm.com ([217.140.101.70]:44776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeHCRwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:52:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A9F80D;
        Fri,  3 Aug 2018 08:55:55 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527E43F2EA;
        Fri,  3 Aug 2018 08:55:51 -0700 (PDT)
Date:   Fri, 3 Aug 2018 16:55:49 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180803155547.sxlhxpmhwcoappit@queper01-lin>
References: <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
 <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
 <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
 <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
 <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 Aug 2018 at 15:49:24 (+0200), Vincent Guittot wrote:
> On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
> > > On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
> > > I'm not really concerned about re-enabling load balance but more that
> > > the effort of packing of tasks in few cpus/clusters that EAS tries to
> > > do can be broken for every new task.
> >
> > Well, re-enabling load balance immediately would break the nice placement
> > that EAS found, because it would shuffle all tasks around and break the
> > packing strategy. Letting that sole new task go in find_idlest_cpu()
> 
> Sorry I was not clear in my explanation. Re enabling load balance
> would be a problem of course. I wanted to say that there is few chance
> that this will re-enable the load balance immediately and break EAS
> and I'm not worried by this case. But i'm only concerned by the new
> task being put outside EAS policy.
> 
> For example, if you run on hikey960 the simple script below, which
> can't really be seen as a fork bomb IMHO, you will see threads
> scheduled on big cores every 0.5 seconds whereas everything should be
> packed on little core

I guess that also depends on what's running on the little cores, but I
see your point.

I think we're discussing two different things right now:
    1. Should forkees go in find_energy_efficient_cpu() ?
    2. Should forkees have 0 of initial util_avg when EAS is enabled ?

For 1, that would mean all forkees go on prev_cpu. I can see how that
can be more energy-efficient in some use-cases (the one you described
for example), but that also has drawbacks. Placing the task on a big
CPU can have an energy cost, but that should also help the task build
it's utilization faster, which is what we want to make smart decisions
with EAS. Also, it isn't always true that going on the little CPUs is
more energy efficient, only the Energy Model can tell. There is just no
perfect solution, so I'm still not fully decided on that one ...

For 2, I'm a little bit more reluctant, because that has more
implications ... That could probably harm some fairly standard use
cases (an simple app-launch for example). Enqueueing something new on a
CPU would go unnoticed, which might be fine for a very small task, but
probably a major issue if the task is actually big. I'd be more
comfortable with 2 only if we also speed-up the PELT half-life TBH ...

Is there a 3 that I missed ?

Thanks,
Quentin
