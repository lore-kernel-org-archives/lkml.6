Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E832177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfAKLJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:09:21 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51645 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfAKLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:09:21 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0a8fb58d82abfe8c; Fri, 11 Jan 2019 12:09:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date:   Fri, 11 Jan 2019 12:08:32 +0100
Message-ID: <2260944.bWjCqvLuxn@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org> <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 17, 2018 5:12:54 PM CET Ulf Hansson wrote:
> Rafael, Sudeep, Lorenzo, Mark,
> 
> On Thu, 29 Nov 2018 at 18:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Over the years this series have been iterated and discussed at various Linux
> > conferences and LKML. In this new v10, a quite significant amount of changes
> > have been made to address comments from v8 and v9. A summary is available
> > below, although let's start with a brand new clarification of the motivation
> > behind this series.
> >
> > For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
> > From a CPU idle state perspective, this means some states may be shared among a
> > group of CPUs (aka CPU cluster).
> >
> > To deal with idle management of a group of CPUs, sometimes the kernel needs to
> > be involved to manage the last-man standing algorithm, simply because it can't
> > rely solely on power management FWs to deal with this. Depending on the
> > platform, of course.
> >
> > There are a couple of typical scenarios for when the kernel needs to be in
> > control, dealing with synchronization of when the last CPU in a cluster is about
> > to enter a deep idle state.
> >
> > 1)
> > The kernel needs to carry out so called last-man activities before the
> > CPU cluster can enter a deep idle state. This may for example involve to
> > configure external logics for wakeups, as the GIC may no longer be functional
> > once a deep cluster idle state have been entered. Likewise, these operations
> > may need to be restored, when the first CPU wakes up.
> >
> > 2)
> > Other more generic I/O devices, such as an MMC controller for example, may be a
> > part of the same power domain as the CPU cluster, due to a shared power-rail.
> > For these scenarios, when the MMC controller is in use dealing with an MMC
> > request, a deeper idle state of the CPU cluster may needs to be temporarily
> > disabled. This is needed to retain the MMC controller in a functional state,
> > else it may loose its register-context in the middle of serving a request.
> >
> > In this series, we are extending the generic PM domain (aka genpd) to be used
> > for also CPU devices. Hence the goal is to re-use much of its current code to
> > help us manage the last-man standing synchronization. Moreover, as we already
> > use genpd to model power domains for generic I/O devices, both 1) and 2) can be
> > address with its help.
> >
> > Moreover, to address these problems for ARM64 DT based platforms, we are
> > deploying support for genpd and runtime PM to the PSCI FW driver - and finally
> > we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
> > layout.
> >
> > The series has been tested on the QCOM 410c dragonboard and the Hisilicon Hikey
> > board. You may also find the code at:
> >
> > git.linaro.org/people/ulf.hansson/linux-pm.git next
> 
> It's soon been three weeks since I posted this and I would really
> appreciate some feedback.
> 
> Rafael, I need your feedback on patch 1->4.

Sorry for the delay, I've replied to the patches.

The bottom line is that the mechanism introduced in patch 3 and used
in patch 4 doesn't look particularly clean to me.

Cheers,
Rafael

