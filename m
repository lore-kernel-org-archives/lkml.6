Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8392087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8392087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJJPuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:50:50 -0400
Received: from foss.arm.com ([217.140.101.70]:48332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbeJJPur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:50:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126AD80D;
        Wed, 10 Oct 2018 01:29:43 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A383F5D3;
        Wed, 10 Oct 2018 01:29:40 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:29:35 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010061751.GA37224@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Wednesday 10 Oct 2018 at 08:17:51 (+0200), Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
> > Thermal governors can respond to an overheat event for a cpu by
> > capping the cpu's maximum possible frequency. This in turn
> > means that the maximum available compute capacity of the
> > cpu is restricted. But today in linux kernel, in event of maximum
> > frequency capping of a cpu, the maximum available compute
> > capacity of the cpu is not adjusted at all. In other words, scheduler
> > is unware maximum cpu capacity restrictions placed due to thermal
> > activity. This patch series attempts to address this issue.
> > The benefits identified are better task placement among available
> > cpus in event of overheating which in turn leads to better
> > performance numbers.
> > 
> > The delta between the maximum possible capacity of a cpu and
> > maximum available capacity of a cpu due to thermal event can
> > be considered as thermal pressure. Instantaneous thermal pressure
> > is hard to record and can sometime be erroneous as there can be mismatch
> > between the actual capping of capacity and scheduler recording it.
> > Thus solution is to have a weighted average per cpu value for thermal
> > pressure over time. The weight reflects the amount of time the cpu has
> > spent at a capped maximum frequency. To accumulate, average and
> > appropriately decay thermal pressure, this patch series uses pelt
> > signals and reuses the available framework that does a similar
> > bookkeeping of rt/dl task utilization.
> > 
> > Regarding testing, basic build, boot and sanity testing have been
> > performed on hikey960 mainline kernel with debian file system.
> > Further aobench (An occlusion renderer for benchmarking realworld
> > floating point performance) showed the following results on hikey960
> > with debain.
> > 
> >                                         Result          Standard        Standard
> >                                         (Time secs)     Error           Deviation
> > Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> > Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> 
> Wow, +13% speedup, impressive! We definitely want this outcome.
> 
> I'm wondering what happens if we do not track and decay the thermal load at all at the PELT 
> level, but instantaneously decrease/increase effective CPU capacity in reaction to thermal 
> events we receive from the CPU.

+1, it's not that obvious (to me at least) that averaging the thermal
pressure over time is necessarily what we want. Say the thermal governor
caps a CPU and 'removes' 70% of its capacity, it will take forever for
the PELT signal to ramp-up to that level before the scheduler can react.
And the other way around, if you release the cap, it'll take a while
before we actually start using the newly available capacity. I can also
imagine how reacting too fast can be counter-productive, but I guess
having numbers and/or use-cases to show that would be great :-)

Thara, have you tried to experiment with a simpler implementation as
suggested by Ingo ?

Also, assuming that we do want to average things, do we actually want to
tie the thermal ramp-up time to the PELT half life ? That provides
nice maths properties wrt the other signals, but it's not obvious to me
that this thermal 'constant' should be the same on all platforms. Or
maybe it should ?

Thanks,
Quentin

> 
> You describe the averaging as:
> 
> > Instantaneous thermal pressure is hard to record and can sometime be erroneous as there can 
> > be mismatch between the actual capping of capacity and scheduler recording it.
> 
> Not sure I follow the argument here: are there bogus thermal throttling events? If so then
> they are hopefully not frequent enough and should average out over time even if we follow
> it instantly.
> 
> I.e. what is 'can sometimes be erroneous', exactly?
> 
> Thanks,
> 
> 	Ingo
