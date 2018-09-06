Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ACAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81212075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeIFTOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:14:42 -0400
Received: from foss.arm.com ([217.140.101.70]:46780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbeIFTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:14:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B4F7A9;
        Thu,  6 Sep 2018 07:38:50 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E54FC3F614;
        Thu,  6 Sep 2018 07:38:45 -0700 (PDT)
Date:   Thu, 6 Sep 2018 15:38:44 +0100
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
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20180906143842.xlxcg5notwdaflww@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-14-quentin.perret@arm.com>
 <20180904105906.t5i7twyyt2omc45b@queper01-lin>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> I'm not a particular fan of notifiers to be honest and you don't need
> to add an extra chain just in order to be able to register a callback
> from a single user.

Right. I agree there are alternatives to using notifiers. I used them
because they're existing infrastructure, and because they let me do what
I want without too much troubles, which are two important points.

> That can be achieved with a single callback
> pointer too, but also you could just call a function exported by the
> scheduler directly from where in the cpufreq code it needs to be
> called.

Are you thinking about something comparable to what is done in
cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
That would probably have the same drawback as my current implementation,
that is that the scheduler is notified of _all_ governor changes, not
only changes to/from sugov although this is the only thing we care about
for EAS.

We could also hook things in sugov_start & sugov_stop directly, and keep
all changes into the scheduler ... That is slightly harder to implement
on the scheduler topology side, though.

Thoughts ?

> > Also, is there any hope that the 12 first patches could make it in 4.20
> > on their own ? Or is it already too late ?
> 
> I'm walking through them right now, albeit somewhat slowly due to
> various distractions, so we'll see.

Thanks !
Quentin
