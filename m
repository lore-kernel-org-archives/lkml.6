Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166DD20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166DD20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeIGNmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:42:09 -0400
Received: from foss.arm.com ([217.140.101.70]:57186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeIGNmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:42:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 655627A9;
        Fri,  7 Sep 2018 02:02:10 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8F33F557;
        Fri,  7 Sep 2018 02:02:06 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:02:04 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180907090202.6cmbm7wyr2uumkhu@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180906143842.xlxcg5notwdaflww@queper01-lin>
 <1545744.fI5ZvP8FO0@aspire.rjw.lan>
 <4111046.18AB1cFGcU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4111046.18AB1cFGcU@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 Sep 2018 at 10:56:12 (+0200), Rafael J. Wysocki wrote:
> On Friday, September 7, 2018 10:52:01 AM CEST Rafael J. Wysocki wrote:
> > On Thursday, September 6, 2018 4:38:44 PM CEST Quentin Perret wrote:
> > > Hi Rafael,
> > > 
> > > On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> > > > I'm not a particular fan of notifiers to be honest and you don't need
> > > > to add an extra chain just in order to be able to register a callback
> > > > from a single user.
> > > 
> > > Right. I agree there are alternatives to using notifiers. I used them
> > > because they're existing infrastructure, and because they let me do what
> > > I want without too much troubles, which are two important points.
> > > 
> > > > That can be achieved with a single callback
> > > > pointer too, but also you could just call a function exported by the
> > > > scheduler directly from where in the cpufreq code it needs to be
> > > > called.
> > > 
> > > Are you thinking about something comparable to what is done in
> > > cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
> > > That would probably have the same drawback as my current implementation,
> > > that is that the scheduler is notified of _all_ governor changes, not
> > > only changes to/from sugov although this is the only thing we care about
> > > for EAS.
> > 
> > Well, why don't you implement it as something like "if the governor changes
> > from sugov to something else (or the other way around), call this function
> > from the scheduler"?

Yes that work too ...

> That said, governors are stopped and started in a few cases other than just
> changing the governor, so maybe you want the EAS side to be notified whenever
> sugov is stopped and started after all?

Right, so sugov_start/sugov_stop could be an option in this case ... And
that would leave the CPUFreq core untouched. I'll try to write something :-)

Thanks,
Quentin
