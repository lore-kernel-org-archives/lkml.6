Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELtv+dK/NzVX1R5wu23pbQ0zBoHys10ta7mlt4pRCqu53PiDz3yEDGpZ030rL1jTnQNTt3sc
ARC-Seal: i=1; a=rsa-sha256; t=1521032716; cv=none;
        d=google.com; s=arc-20160816;
        b=0fBNJbffsUAHQG5RZh6lUJLyty011k+5W9rwGt1XxvF6XC8jVo4LlkBGebODQ3KWrI
         lcmIjbbUrRQYV+2LadyMBpD4SDq4MafsaOikFuytYcqQNNm2zXrr9KfUZNvNYt7BnCK7
         xfUp0XtUG+PHKvzT7fpLdMeLWjLahS5t+difrP8/3FwI0yItaphrOHEL1w348GE56h9H
         OJ3OMG7FH/K8qpGqHRWGXC4oKG/p0zL663cUWuE024LoHUJOVKk62Jv1i2YC+6QjCmjA
         vIpp4+GnQuhoN4uGt/FSLcKszQIU2enjRek2n2UzHSpaUFFCG1h6i7L19uop18NnZ51f
         UL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lshwiXWTxJsThuf4WaLmhZ2RIzSv54iZ4TTZarkS304=;
        b=JGKWvl442vLm6ZxvAV6HXq5WAOEd6RdfQRRfPci3P+8LyJ3b6Ig25vBs+gGgOKKn33
         wmqXhvHiBujmlsTguhWUNCZUCYsJC8Xm7Bi5aDN1dqLwlIzaWqInSn54htQiI0r3kqhq
         UsBkEzUg4JXvG4pyYYDP0X5Hnl9mMBta/BbHDqbSyZTnS1yzS+UxqzXK5MHQmbGWY8Fd
         QO/NWQIhfnslPNWWOVg2Dvj9AyHls2r7o1pJa6o8x+N1burctaxQaL76xuoiMMx/jFRY
         bgWbAH5FQP73gTjC4mfQv3l53XxqTHpcfAy1KZRsGgsocR7GTqTgivCh0mkBqAQHavLw
         RuBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Wed, 14 Mar 2018 13:05:09 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, lorenzo.pieralisi@arm.com,
	catalin.marinas@arm.com, tnowicki@caviumnetworks.com,
	gregkh@linuxfoundation.org, will.deacon@arm.com,
	dietmar.eggemann@arm.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, ahs3@redhat.com,
	linux-acpi@vger.kernel.org, palmer@sifive.com,
	hanjun.guo@linaro.org, sudeep.holla@arm.com,
	austinwc@codeaurora.org, linux-riscv@lists.infradead.org,
	john.garry@huawei.com, wangxiongfeng2@huawei.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Subject: Re: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
Message-ID: <20180314130509.GM4589@e105550-lin.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
 <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
 <8ac3567c-9fd8-4b0c-121c-287a027b5156@arm.com>
 <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
 <4e7fd404-fb7b-ee38-4a78-8ee091ae07cf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7fd404-fb7b-ee38-4a78-8ee091ae07cf@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1594918401387230916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:19:50AM -0600, Jeremy Linton wrote:
> Hi,
> 
> On 03/07/2018 07:06 AM, Morten Rasmussen wrote:
> >On Tue, Mar 06, 2018 at 04:22:18PM -0600, Jeremy Linton wrote:
> >>>>>>To do this correctly, we should really base that on the cache
> >>>>>>topology immediately below the NUMA node (for NUMA in socket) >> or below the physical package for normal NUMA configurations.
> >>>>>
> >>>>>That means we wouldn't support multi-die NUMA nodes?
> >>>>
> >>>>You mean a bottom level NUMA domain that crosses multiple sockets/dies? That
> >>>>should work. This patch is picking the widest cache layer below the smallest
> >>>>of the package or numa grouping. What actually happens depends on the
> >>>>topology. Given a case where there are multiple dies in a socket, and the
> >>>>numa domain is at the socket level the MC is going to reflect the caching
> >>>>topology immediately below the socket. In the case of multiple dies, with a
> >>>>cache that crosses them in socket, then the MC is basically going to be the
> >>>>socket, otherwise if the widest cache is per die, or some narrower grouping
> >>>>(cluster?) then that is what ends up in the MC. (this is easier with some
> >>>>pictures)
> >>>
> >>>That is more or less what I meant. I think I got confused with the role
> >>>of "DIE" level, i.e. that top non-NUMA level, in this. The DIE level
> >>>cpumask spans exactly the NUMA node, so IIUC we have three scenarios:
> >>>
> >>>1. Multi-die/socket/physical package NUMA node
> >>>    Top non-NUMA level (DIE) spans multiple packages. Bottom NUMA level
> >>>    spans multiple multi-package nodes. The MC mask reflects the last-level
> >>>    cache within the NUMA node which is most likely per-die or per-cluster
> >>>    (inside each die).
> >>>
> >>>2. physical package == NUMA node
> >>>    The top non-NUMA (DIE) mask is the same as the core sibling mask.
> >>>    If there is cache spanning the entire node, the scheduler topology
> >>>    will eliminate a layer (DIE?), so bottom NUMA level would be right on
> >>>    top of MC spanning multiple physical packages. If there is no
> >>>    node-wide last level cache, DIE is preserved and MC matches the span
> >>>    of the last level cache.
> >>>
> >>>3. numa-in-package
> >>>    Top non-NUMA (DIE) mask is not reflecting the actual die, but is
> >>>    reflecting the NUMA node. MC has a span equal to the largest share
> >>>    cache span smaller than or equal to the the NUMA node. If it is
> >>>    equal, DIE level is eliminated, otherwise DIE is preserved, but
> >>>    doesn't really represent die. Bottom non-NUMA level spans multiple
> >>>    in-package NUMA nodes.
> >>>
> >>>As you said, multi-die nodes should work. However, I'm not sure if
> >>>shrinking MC to match a cache could cause us trouble, or if it should
> >>>just be shrunk to be the smaller of the node mask and core siblings.
> >>
> >>Shrinking to the smaller of the numa or package is fairly trivial change,
> >>I'm good with that change too.. I discounted it because there might be an
> >>advantage in case 2 if the internal hardware is actually a case 3 (or just
> >>multiple rings/whatever each with a L3). In those cases the firmware vendor
> >>could play around with whatever representation serves them the best.
> >
> >Agreed. Distributed last level caches and interconnect speeds makes it
> >virtually impossible to define MC in a way that works well for everyone
> >based on the topology information we have at hand.
> >
> >>
> >>>Unless you have a node-wide last level cache DIE level won't be
> >>>eliminated in scenario 2 and 3, and could cause trouble. For
> >>>numa-in-package, you can end up with a DIE level inside the node where
> >>>the default flags don't favour aggressive spreading of tasks. The same
> >>>could be the case for per-package nodes (scenario 2).
> >>>
> >>>Don't we end up redefining physical package to be last level cache
> >>>instead of using the PPTT flag for scenario 2 and 3?
> >>
> >>I'm not sure I understand, core_siblings isn't changing (its still per
> >>package). Only the MC mapping which normally is just core_siblings. For all
> >>intents right now this patch is the same as v6, except for the
> >>numa-in-package where the MC domain is being shrunk to the node siblings.
> >>I'm just trying to setup the code for potential future cases where the LLC
> >>isn't equal to the node or package.
> >
> >Right, core_siblings remains the same. The scheduler topology just looks
> >a bit odd as we can have core_siblings spanning the full true physical
> >package and have DIE level as a subset of that with an MC level where
> >the MC siblings is a much smaller subset of cpus than core_siblings.
> >
> >IOW, it would lead to having one topology used by the scheduler and
> >another used by the users of topology_core_cpumask() (which is not
> >many I think).
> >
> >Is there a good reason for diverging instead of adjusting the
> >core_sibling mask? On x86 the core_siblings mask is defined by the last
> >level cache span so they don't have this issue.
> 
> I'm overwhelmingly convinced we are doing the right thing WRT the core
> siblings at the moment. Its exported to user space, and the general
> understanding is that its a socket. Even with numa in package/on die if you
> run lscpu, lstopo, etc... They all understand the system topology correctly
> doing it this way (AFAIK).

Right. As said in my reply to Brice, I thought MC level and sysfs were
aligned, but they clearly aren't. I agree that treating them different
is the right thing to do.

> >I would prefer this simpler solution as it should eliminate DIE level
> >for all numa-in-package configurations. Although, I think we should consider
> >just shrinking the core_sibling mask instead of having a difference MC
> >mask (cpu_coregroup_mask). Do you see any problems in doing that?I'm
> My strongest opinion is leaning toward core_siblings being correct as it
> stands. How the scheduler deals with that is less clear. I will toss the
> above as a separate patch, and we can forget this one. I see dropping DIE as
> a larger patch set defining an arch specific scheduler topology and tweaking
> the individual scheduler level/flags/tuning. OTOH, unless there is something
> particularly creative there, I don't see how to avoid NUMA domains pushing
> deeper into the cache/system topology. Which means filling the MC layer (and
> possible others) similarly to the above snippit.

Agreed that core_siblings is correct. With the simple solution DIE
shouldn't show up for any numa_in_package configurations allowing NUMA
to sit directly on top of MC, which should mean that flags should be
roughly okay.
