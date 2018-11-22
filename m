Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF62C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F5C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+3wDzzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391566AbeKWAft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:35:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbeKWAft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5a2LqsCdGJOKGLI+ozOYHganhhU+CTNqkX5uajpFs5k=; b=j+3wDzziYk+cYHgmzLluq8/PT
        MPW40qEgdclgD2a+sr6CVSHSYkOgd5Atj0jBj8sC2bTbWXaPxt+xhsSenH96tPX5GQ5IifvGaLe/C
        4oHDgljPtwYntx0dJmM1Q4GIXGvKKkkHaQkJQm+ZYlutSlffPErCVhFqRSC/TABUUsQi5QVUSKkb+
        Dk01TIPyLoB2JTDixsfRImXdE2EjKao6yvjUJjQcyRVJeDLxDuYXOKhgdvkCdRTKK7dA9EbTkRKSF
        X4UCzEW0+M3ozZggDGpvFGEP8i+hAzmJdpw5q1i3QJP+OxaKHem4RRS1vVmv95ro9gVRgnbn2fQ5O
        6nzrld2GQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpSo-0005ax-DR; Thu, 22 Nov 2018 13:56:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A262D2029FD58; Thu, 22 Nov 2018 14:56:06 +0100 (CET)
Date:   Thu, 22 Nov 2018 14:56:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v9 13/15] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20181122135606.GG2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-14-quentin.perret@arm.com>
 <20181121142803.GF2113@hirez.programming.kicks-ass.net>
 <20181121160524.ulj6n3shb2fdwboj@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121160524.ulj6n3shb2fdwboj@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:05:27PM +0000, Quentin Perret wrote:
> On Wednesday 21 Nov 2018 at 15:28:03 (+0100), Peter Zijlstra wrote:
> > On Mon, Nov 19, 2018 at 02:18:55PM +0000, Quentin Perret wrote:
> > > +static long
> > > +compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> > > +{
> > > +	long util, max_util, sum_util, energy = 0;
> > > +	int cpu;
> > > +
> > > +	for (; pd; pd = pd->next) {
> > > +		max_util = sum_util = 0;
> > > +		/*
> > > +		 * The capacity state of CPUs of the current rd can be driven by
> > > +		 * CPUs of another rd if they belong to the same performance
> > > +		 * domain. So, account for the utilization of these CPUs too
> > > +		 * by masking pd with cpu_online_mask instead of the rd span.
> > > +		 *
> > > +		 * If an entire performance domain is outside of the current rd,
> > > +		 * it will not appear in its pd list and will not be accounted
> > > +		 * by compute_energy().
> > > +		 */
> > > +		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
> > 
> > Should that not be cpu_active_mask ?
> 
> Hmm, I must admit I'm sometimes a bit confused by the exact difference
> between these masks, so maybe yeah ...
> 
> IIUC, cpu_active_mask is basically the set of CPUs on which the
> scheduler is actually allowed to migrate tasks. Is that correct ?

Yep. Which is a strict subset of online. The difference only matters
during hotplug. We take a CPU out of active before we take if offline
and we add it to active only after the CPU is fully online and
scheduling.

> I have always seen cpu_online_mask as a superset of cpu_active_mask
> which can also include CPUs which are still running 'special' tasks
> (kthreads and things like that I assume) although not allowed for
> migration any more (or not yet) because we're in the process of
> hotplugging that CPU.

Right.

> So, the thing is, I'm not trying to select a CPU candidate for my task
> here, I'm trying to understand what's the energy impact of a migration.
> That involves all CPUs that are running _something_ in a perf domain
> no matter if they're allowed to run more tasks or not. I mean, raising
> the OPP will make running online && !active CPUs more expensive as well.
> That's why I thought cpu_online_mask was good match here.

Ah, fair enough. Thanks!
