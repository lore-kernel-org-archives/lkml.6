Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A417BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6097425B95
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6097425B95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965017AbeGBIgW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:36:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55512 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964876AbeGBIgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:36:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D043780D;
        Mon,  2 Jul 2018 01:36:15 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5842C3F5AD;
        Mon,  2 Jul 2018 01:36:14 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:36:11 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org,
        mingo@redhat.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/9] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180702083611.GB8596@e105550-lin.cambridge.arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
 <1529485549-5191-2-git-send-email-morten.rasmussen@arm.com>
 <20180622082222.GD23168@e108498-lin.cambridge.arm.com>
 <20180622143624.GD8461@e105550-lin.cambridge.arm.com>
 <4208ea5d-0c00-d17a-5524-b5d9caa70273@arm.com>
 <20180628084852.GA8596@e105550-lin.cambridge.arm.com>
 <5dd8e47a-ebee-9c47-be4f-1c127f72834f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd8e47a-ebee-9c47-be4f-1c127f72834f@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 07:16:46PM +0200, Dietmar Eggemann wrote:
> On 06/28/2018 10:48 AM, Morten Rasmussen wrote:
> >On Wed, Jun 27, 2018 at 05:41:22PM +0200, Dietmar Eggemann wrote:
> >>On 06/22/2018 04:36 PM, Morten Rasmussen wrote:
> >>>On Fri, Jun 22, 2018 at 09:22:22AM +0100, Quentin Perret wrote:
> 
> [...]
> 
> >>>>What would happen if you hotplugged an entire cluster ? You'd loose the
> >>>>SD_ASYM_CPUCAPACITY flag but keep the static key is that right ? Should
> >>>>we care ?
> >>>
> >>>I don't think we should care. The static key enables additional checks
> >>>and tweaks but AFAICT none of them requires the SD_ASYM_CPUCAPACITY to
> >>>be set and they should all be have no effect if that is the case. I
> >>>added the static key just avoid the overhead on systems where they would
> >>>have no effect. At least that is intention, I could course have broken
> >>>things by mistake.
> >>
> >>I tent to agree for misfit but it would be easy to just add an
> >>static_branch_disable_cpuslocked() into the else path of if(enable).
> >
> >Depending on how we address the exclusive cpuset mess Quentin pointed
> >out, it isn't as simple as that. As it is with our current
> >not-yet-posted patches we would never remove the SD_ASYM_CPUCAPACITY
> >flag, so we would never do a static_branch_disable_cpuslocked().
> 
> I was referring rather to the 'hotplug out an entire cluster' mentioned
> above. Looking closer into the code, I see that this will only work for
> traditional big.LITTLE (one big, one little cluster) since on them the DIE
> level vanishes and so the SD_ASYM_CPUCAPACITY flag.

Agreed, disabling the branch in that case should be possible but only if
we know that there aren't any exclusive cpusets.

> Currently we only detect the flags when the system comes up (in the
> init_cpu_capacity_callback()) and not when we hotplug cpus. That's why it
> doesn't work for your 'three cluster system where 0-3 and 4-7 little
> clusters, and 8-11 is a big cluster' example.
> So we don't re-detect the flags every time we call from the scheduler into
> the arch code and so the the DIE level arch topology flag function will
> return SD_ASYM_CPUCAPACITY.

It would fairly easy to re-detect every time we hotplug a cpu in/out but
that won't help us with exclusive cpuset issue.

> 
> >However, I'm currently thinking that we should probably set the flag
> >according to the cpus in each root_domain. If we do that, we can't just
> >disable the static_key because one root_domain is SMP, so we would have
> >to track if _any_ root_domain (exclusive cpuset topology) has the flag
> >set.
> 
> This is then in sync with the energy model where the static key should be
> enabled if any root domain can do EAS. The static key would be system wide,
> not per root domain.

The static_key can only be system wide :-)

> 
> >Is it worth it to iterate over all the exclusive cpuset with all
> >the locking implications to disable the static_key in the corner case
> >where exclusive cpuset are set up for all cpu capacities in the system?
> 
> Don't know either? But if the code to do this would include 'exclusive
> cpusets' and platforms like your three cluster example then maybe ...

Iterating over all root_domains should work for any platform. IMHO, it
might be a lot of additional complexity to disable some optimizations in
a few corner cases.

> 
> [...]
> 
> >>>I'm tempted to say we shouldn't care in this situation. Setting the
> >>>flags correctly in the three cluster example would require knowledge
> >>>about the cpuset configuration which we don't have in the arch code so
> >>>SD_ASYM_CPUCAPACITY flag detection would have be done by the
> >>>sched_domain build code. However, not setting the flag according to the
> >>>actual members of the exclusive cpuset means that homogeneous
> >>>sched_domains might have SD_ASYM_CPUCAPACITY set enabling potentially
> >>>wrong scheduling decisions.
> >>
> >>We could easily pass the CPU as an argument to all these
> >>sched_domain_flags_f functions.
> >>
> >>-typedef int (*sched_domain_flags_f)(void);
> >>+typedef int (*sched_domain_flags_f)(int cpu);
> >>
> >>In this case, the arch specific flag functions on a sched domain (sd) level
> >>could use the corresponding sched_domain_mask_f function to iterate over the
> >>span of the sd seen by CPU instead of all online cpus.
> >
> >Yeah, but I'm afraid that doesn't solve the problem. The
> >sched_domain_mask_f function doesn't tell us anything about any
> >exclusive cpusets. We need sched_domain_span(sd) which is
> 
> You're right, I checked again and even if we hotplug, the flag function
> tl->mask(cpu) like cpu_coregroup_mask() always return the initial set of
> cpus. So we are only save if the DIE sd vanishes and with it the
> SD_ASYM_CPUCAPACITY flag since nobody will call the appropriate arch
> topology flag function.

Yeah, that isn't really solving the problem, it is more like working by
accident ;-)

> 
> >sched_domain_mask_f & cpu_map where cpu_map is the cpumask of the
> >exclusive cpuset. So we either need to pass the sched_domain_span() mask
> >through sched_domain_flags_f or work our way back to that information
> >based on the cpu id. I'm not sure if the latter is possible.
> 
> Agreed.
> 
> [...]
> 
> >>We could also say that systems with 2 clusters with the same uArch and same
> >>max CPU frequency and additional clusters are insane, like we e.g. do with
> >>the Energy Model and CPUs with different uArch within a frequency domain?
> >
> >I fail to get the point here. Are you saying that SMP is insane? ;-)
> 
> The '... and additional clusters' is important, a system like your three
> cluster system you describe above.
> 
> But the problem that if you hotplug-out the big cluster, the DIE level is
> still there with the SD_ASYM_CPUCAPACITY flag is due to the fact that we
> don't start the flag detection mechanism during hotplug, right?

True, flag detection is currently only done once (well, twice: when the
secondary cpus come up, and again at cpufreq init). We can't rely on
sched_domains being elemitated to get the flags right in the general
case. It just appears to work on systems we have considered so far.

> 
> >>>We can actually end up with this problem just by hotplugging too. If you
> >>>unplug the entire big cluster in the three cluster example above, you
> >>>preserve DIE level which would have SD_ASYM_CPUCAPACITY set even though
> >>>we only have little cpus left.
> 
> IMHO, again that's because we do flag detection only at system startup.

Yes.

> 
> >>>As I see it, we have two choices: 1) Set the flags correctly for
> >>>exclusive cpusets which means some additional "fun" in the sched_domain
> >>>hierarchy set up, or 2) ignore it and make sure that setting
> >>
> >>I assume you refer to this cpu parameter for sched_domain_flags_f under 1).
> >
> >No, what I had in mind was to let sd_init() set SD_ASYM_CPUCAPACITY
> >flag as the arch-code doesn't know about the exclusive cpusets as
> >discussed above. In the meantime I have thought about a different
> >approach where sd_init() only disables the flag when it is no longer
> >needed due to exclusive cpusets.
> 
> In this case sd_init() has to know the cpu capacity values. I assume that
> the arch still has to call rebuild_sched_domains() after cpufreq is up and
> running due to the max cpu frequency dependency for cpu capacity.

Yes, sd_init() will just access rq->cpu_capacity_orig which should be
straightforward. There is no change in when we rebuild the sched_domain
hierarchy. It will be rebuild once cpufreq is up, and every time we mess
with exclusive cpusets.
