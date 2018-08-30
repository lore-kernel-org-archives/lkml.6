Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31639C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51BC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51BC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeH3Os6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:48:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39386 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbeH3Os6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:48:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8559280D;
        Thu, 30 Aug 2018 03:47:26 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9034D3F721;
        Thu, 30 Aug 2018 03:47:22 -0700 (PDT)
Date:   Thu, 30 Aug 2018 11:47:21 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 05/14] sched/topology: Reference the Energy Model of
 CPUs when available
Message-ID: <20180830104718.lvkkhyi3dtwkfjr7@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-6-quentin.perret@arm.com>
 <20180829162238.GQ2960@e110439-lin>
 <20180829165603.astg32z3ep2qldfu@queper01-lin>
 <20180830100019.GT2960@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830100019.GT2960@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 Aug 2018 at 11:00:20 (+0100), Patrick Bellasi wrote:
> Dunno... but, in any case, probably we don't care about using EAS until
> the boot complete, isn't it?

So, as of now, EAS will typically start soon after CPUFreq. I don't see a
point in starting before, and I'm not sure if starting it later is
really what we want either ... It probably makes sense to start the
DVFS-related features (CPUFreq, EAS, ...) together.

> Just to better understand, what is the most common activation path we expect ?
> 
>   1. system boot
>   2. CPUs online
>   3. CPUFreq initialization
>   4. EM registered
>   X. ???

X is sort of arch dependent (like the EM registration actually). For
arm/arm64, the arch topology driver (see drivers/base/arch_topology.c)
will rebuild the sched_domains once the capacities of CPU are
discovered. In previous versions, I had a patch that did that explicitly:

https://lore.kernel.org/lkml/20180724122521.22109-14-quentin.perret@arm.com/

However, I dropped this patch for v6 because I rebased the series on top
of Morten's automatic flag detection patches, which happen to already do
that for me. More precisely, Morten's patches will rebuild the sched
domains if the SD_ASYM_CPUCAPACITY flag needs to be set somewhere in the
hierarchy. EAS depends on this flag anyway, so I guess it's fine to rely
on this rebuild to start EAS at the same time.

I have been wondering for a while if such a 'loose' way of starting EAS
was alright or not. My conclusion was that it should be OK for now,
because that should suit all the users I can see in the short/medium
term. An alternative could be to introduce something like a notifier in
the EM framework in order to let other subsystems know that the EM is
complete or something along those lines. And then we could register a
callback on this notifier to rebuild the sched_domains. But that's added
complexity, which isn't really needed (yet). If that needs to be done to
accomodate the needs of new users/archs, we can still implement that
later :-)

>   N. partition_sched_domains
>         build_perf_domains
> 
> IOW, who do we expect to call build_perf_domains for the first time ?

On arm/arm64, when the arch_topology driver calls rebuild_sched_domains.

Thanks !
Quentin
