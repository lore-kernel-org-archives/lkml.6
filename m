Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0D208A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C0D208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeGFKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:06:58 -0400
Received: from foss.arm.com ([217.140.101.70]:33996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbeGFKFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:05:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0EE5ED1;
        Fri,  6 Jul 2018 03:05:29 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80793F2EA;
        Fri,  6 Jul 2018 03:05:25 -0700 (PDT)
Date:   Fri, 6 Jul 2018 11:05:20 +0100
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
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Message-ID: <20180706100520.GA11862@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCxt-O8uMOYgAjY7daujXwXyZQ-3BYe=DONL7R95T7nmQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Friday 06 Jul 2018 at 11:57:37 (+0200), Vincent Guittot wrote:
> On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
> > +static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> > +                               unsigned long max_util, unsigned long sum_util)
> > +{
> > +       struct em_cs_table *cs_table;
> > +       struct em_cap_state *cs;
> > +       unsigned long freq;
> > +       int i;
> > +
> > +       cs_table = rcu_dereference(fd->cs_table);
> > +       if (!cs_table)
> > +               return 0;
> > +
> > +       /* Map the utilization value to a frequency */
> > +       cs = &cs_table->state[cs_table->nr_cap_states - 1];
> > +       freq = map_util_freq(max_util, cs->frequency, cs->capacity);
> 
> The 2 lines above deserve more explanation:
> 1st, you get the max capacity of the freq domain
> Then, you estimate what will be the selected frequency according to
> the max_utilization.
> Might worth to mention that we must keep sync how sched_util and EM
> select a freq for a given capacity which is the reason of patch 02

Agreed, this could benefit from more explanations. I'll comment that
better in the next version.

> 
> > +
> > +       /* Find the lowest capacity state above this frequency */
> > +       for (i = 0; i < cs_table->nr_cap_states; i++) {
> > +               cs = &cs_table->state[i];
> > +               if (cs->frequency >= freq)
> > +                       break;
> > +       }
> > +
> > +       return cs->power * sum_util / cs->capacity;
> 
> IIUC the formula above, you consider that all CPUs in a frequency
> domain has the same capacity. This sounds a reasonable assumption but
> it would be good to write that somewhere

That's correct, we agreed on the assumption that CPUs in the same freq
domain must have the same micro-arch, and consequently the same capacity.

But you're right, that needs at the very least to be documented. Or even
better, I should check that when the EM is created and bail out with an
error message if that's not the case. That shouldn't be too hard to
implement, I think.

Thanks,
Quentin
