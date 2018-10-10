Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF30D2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF30D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJJUdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:33:39 -0400
Received: from foss.arm.com ([217.140.101.70]:52232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeJJUdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:33:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1920AED1;
        Wed, 10 Oct 2018 06:11:31 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0693F5D3;
        Wed, 10 Oct 2018 06:11:28 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:11:26 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010131124.isexblzzvkcp26q4@queper01-lin>
References: <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
 <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010125033.GP9130@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Oct 2018 at 14:50:33 (+0200), Juri Lelli wrote:
> On 10/10/18 14:34, Vincent Guittot wrote:
> > Hi  Juri,
> > 
> > On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
> > >
> > > On 10/10/18 14:04, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > > The problem was the same with RT, the cfs utilization was lower than
> > > > reality because RT steals soem cycle to CFS
> > > > So schedutil was selecting a lower frequency when cfs was running
> > > > whereas the CPU was fully used.
> > > > The same can happen with thermal:
> > > > cap the max freq because of thermal
> > > > the utilization with decrease.
> > > > remove the cap
> > > > the utilization is still low and you will select a low OPP because you
> > > > don't take into account cycle stolen by thermal like with RT
> > >
> > > What if we scale frequency component considering the capped temporary
> > > max?
> > 
> > Do you mean using a kind of scale_thermal_capacity in accumulate_sum
> > when computing utilization ?
> 
> Yeah, something like that I guess. So that we account for temporary
> "fake" 1024..

But wouldn't that break frequency invariance ? A task would look bigger
on a capped CPU than a non-capped one no ?
