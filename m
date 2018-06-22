Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67B7243CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67B7243CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeFVOga (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:36:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751284AbeFVOg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:36:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C669280D;
        Fri, 22 Jun 2018 07:36:28 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D9103F2EA;
        Fri, 22 Jun 2018 07:36:27 -0700 (PDT)
Date:   Fri, 22 Jun 2018 15:36:24 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/9] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180622143624.GD8461@e105550-lin.cambridge.arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
 <1529485549-5191-2-git-send-email-morten.rasmussen@arm.com>
 <20180622082222.GD23168@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622082222.GD23168@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 09:22:22AM +0100, Quentin Perret wrote:
> Hi Morten,
> 
> On Wednesday 20 Jun 2018 at 10:05:41 (+0100), Morten Rasmussen wrote:
> > +static void update_asym_cpucapacity(int cpu)
> > +{
> > +	int enable = false;
> > +
> > +	rcu_read_lock();
> > +	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
> > +		enable = true;
> > +	rcu_read_unlock();
> > +
> > +	if (enable) {
> > +		/* This expects to be hotplug-safe */
> > +		static_branch_enable_cpuslocked(&sched_asym_cpucapacity);
> > +	}
> > +}
> 
> What would happen if you hotplugged an entire cluster ? You'd loose the
> SD_ASYM_CPUCAPACITY flag but keep the static key is that right ? Should
> we care ?

I don't think we should care. The static key enables additional checks
and tweaks but AFAICT none of them requires the SD_ASYM_CPUCAPACITY to
be set and they should all be have no effect if that is the case. I
added the static key just avoid the overhead on systems where they would
have no effect. At least that is intention, I could course have broken
things by mistake.

> And also, Peter mentioned an issue with the EAS patches with multiple
> root_domains. Does that apply here as well ? What if you had a
> configuration with big and little CPUs in different root_domains for ex?
> 
> Should we disable the static key in the above cases ?

Exclusive cpusets are more tricky as the flags will be the same for
sched_domains at the same level. So we can't set the flag correctly if
someone configures the exclusive cpusets such that you have one
root_domain spanning big and a subset of little, and one spanning the
remaining little cpus if all topology levels are preserved. If we
imagine a three cluster system where 0-3 and 4-7 little clusters, and
8-11 is a big cluster with cpusets configured as 0-5 and 6-11. The first
set should _not_ have SD_ASYM_CPUCAPACITY set, while the second should.

I'm tempted to say we shouldn't care in this situation. Setting the
flags correctly in the three cluster example would require knowledge
about the cpuset configuration which we don't have in the arch code so
SD_ASYM_CPUCAPACITY flag detection would have be done by the
sched_domain build code. However, not setting the flag according to the
actual members of the exclusive cpuset means that homogeneous
sched_domains might have SD_ASYM_CPUCAPACITY set enabling potentially
wrong scheduling decisions.

We can actually end up with this problem just by hotplugging too. If you
unplug the entire big cluster in the three cluster example above, you
preserve DIE level which would have SD_ASYM_CPUCAPACITY set even though
we only have little cpus left.

As I see it, we have two choices: 1) Set the flags correctly for
exclusive cpusets which means some additional "fun" in the sched_domain
hierarchy set up, or 2) ignore it and make sure that setting
SD_ASYM_CPUCAPACITY on homogeneous sched_domains works fairly okay. The
latter seems easier.

Morten
