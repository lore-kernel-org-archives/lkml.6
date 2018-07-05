Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B1FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63471240B0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63471240B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeGEPDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:03:16 -0400
Received: from foss.arm.com ([217.140.101.70]:51496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbeGEPDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:03:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CBA18A;
        Thu,  5 Jul 2018 08:03:14 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F05B3F5BA;
        Thu,  5 Jul 2018 08:03:13 -0700 (PDT)
Date:   Thu, 5 Jul 2018 16:03:11 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/12] sched/core: Disable SD_ASYM_CPUCAPACITY for
 root_domains without asymmetry
Message-ID: <20180705150311.GE32579@e108498-lin.cambridge.arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-12-git-send-email-morten.rasmussen@arm.com>
 <20180705133142.GD32579@e108498-lin.cambridge.arm.com>
 <20180705141349.GD8596@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705141349.GD8596@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 Jul 2018 at 15:13:49 (+0100), Morten Rasmussen wrote:
> On Thu, Jul 05, 2018 at 02:31:43PM +0100, Quentin Perret wrote:
> > If SD_ASYM_CPUCAPACITY means that some CPUs have different
> > arch_scale_cpu_capacity() values, we could also automatically _set_
> > the flag in sd_init() no ? Why should we let the arch set it and just
> > correct it later ?
> > 
> > I understand the moment at which we know the capacities of CPUs varies
> > from arch to arch, but the arch code could just call
> > rebuild_sched_domain when the capacities of CPUs change and let the
> > scheduler detect things automatically. I mean, even if the arch code
> > sets the flag in its topology level table, it will have to rebuild
> > the sched domains anyway ...
> > 
> > What do you think ?
> 
> We could as well set the flag here so the architecture doesn't have to
> do it. It is a bit more complicated though for few reasons:
> 
> 1. Detecting when to disable the flag is a lot simpler than checking
> which level is should be set on. You basically have to work you way up
> from the lowest topology level until you get to a level spanning all the
> capacities available in the system to figure out where the flag should
> be set. I don't think this fits easily with how we build the
> sched_domain hierarchy. It can of course be done.

Ah, that is something I missed. I see in 1f6e6c7cb9bc ("sched/core:
Introduce SD_ASYM_CPUCAPACITY sched_domain topology flag") that this
flag should be set only at the _lowest_ level at which there is
asymmetry. I had the wrong impression that the flag was supposed to be
set at _all_ level where there is some asymmetry. And actually having
'some asymmetry' isn't enough, we want to see the full range of CPU
capacities. Hmmm, that is indeed more complex than I thought ... :/

> 
> 2. As you say, we still need the arch code (or cpufreq?) to rebuild the
> whole thing once we know that the capacities have been determined. That
> currently implies implementing arch_update_cpu_topology() which is
> arch-specific. So we would need some arch code to make rebuild happen at
> the right point in time. If the rebuild should be triggering the rebuild
> we need another way to force a full rebuild. This can also be done.

Yeah, with just this patch the arch code will have to:
   1. update the arch_scale_cpu_capacity() of the CPUs;
   2. detect the asymmetry to set the flag in the topology table;
   3. rebuild the sched domains to let the scheduler know about the new
      topology information.

By doing what I suggest we would just save 2 from the arch side and do
it in the scheduler. So actually, I really start to wonder if it's worth
it given the added complexity ...

> 3. Detecting the flag in generic kernel/sched/* code means that all
> architectures will pay the for the overhead when building/rebuilding the
> sched_domain hierarchy, and all architectures that sets the cpu
> capacities to asymmetric will set the flag whether they like it or not.
> I'm not sure if this is a problem.

That is true as well ...

> 
> In the end it is really about how much of this we want in generic code
> and how much we hide in arch/, and if we dare to touch the sched_domain
> build code ;-)

Right so you can argue that the arch code is here to give you a
system-level information, and that if the scheduler wants to virtually
split that system, then it's its job to make sure that happens properly.
That is exactly what your patch does (IIUC), and I now think that this
is a very sensible middle-ground option. But this is debatable so I'm
interested to see what others think :-)

Thanks,
Quentin
