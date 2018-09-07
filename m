Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3590C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F3C2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F3C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIGNip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:38:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49675 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeIGNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:38:44 -0400
Received: from 79.184.254.186.ipv4.supernova.orange.pl (79.184.254.186) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id 0f8cfcde9a2521a0; Fri, 7 Sep 2018 10:58:45 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
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
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling depend on schedutil
Date:   Fri, 07 Sep 2018 10:56:12 +0200
Message-ID: <4111046.18AB1cFGcU@aspire.rjw.lan>
In-Reply-To: <1545744.fI5ZvP8FO0@aspire.rjw.lan>
References: <20180820094420.26590-1-quentin.perret@arm.com> <20180906143842.xlxcg5notwdaflww@queper01-lin> <1545744.fI5ZvP8FO0@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 7, 2018 10:52:01 AM CEST Rafael J. Wysocki wrote:
> On Thursday, September 6, 2018 4:38:44 PM CEST Quentin Perret wrote:
> > Hi Rafael,
> > 
> > On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> > > I'm not a particular fan of notifiers to be honest and you don't need
> > > to add an extra chain just in order to be able to register a callback
> > > from a single user.
> > 
> > Right. I agree there are alternatives to using notifiers. I used them
> > because they're existing infrastructure, and because they let me do what
> > I want without too much troubles, which are two important points.
> > 
> > > That can be achieved with a single callback
> > > pointer too, but also you could just call a function exported by the
> > > scheduler directly from where in the cpufreq code it needs to be
> > > called.
> > 
> > Are you thinking about something comparable to what is done in
> > cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
> > That would probably have the same drawback as my current implementation,
> > that is that the scheduler is notified of _all_ governor changes, not
> > only changes to/from sugov although this is the only thing we care about
> > for EAS.
> 
> Well, why don't you implement it as something like "if the governor changes
> from sugov to something else (or the other way around), call this function
> from the scheduler"?

That said, governors are stopped and started in a few cases other than just
changing the governor, so maybe you want the EAS side to be notified whenever
sugov is stopped and started after all?

