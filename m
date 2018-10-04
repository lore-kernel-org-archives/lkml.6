Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A3EC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE2521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xKsFBRwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE2521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJDReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:34:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeJDReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H4gRuls+kG2VQiTG/Tri5+mvjeK8am+NCBfTafKVPic=; b=xKsFBRwDaqcHyUHVhB0US6L2U
        su1OXGtczjHf3u2rjy8saSpZWTTnG7SxqJMRkazJs4enNIWR81/Lwv1fRAAIlQlZ5D1sxfjLI/yKc
        0gRK9bs7TYu7TURyN8/ZbI/PxgRiYDl1I0S+Sb8SMtfH5/tdetbkkIJyYH1IeApgGIrRxEWoHlZcX
        lxzisA8Avp4dCMfNMRAwZtJ4ar+66VrUu8sIHwejpzR4oDUHuoXVTuSkTdQULgZv2Fs+DIElO/14W
        xk1tbgiR4GqTiXrwsDjJPWmYZcLN50duo4ps7235hngQm4CtsHjmpBGz+kVNkWPXYfpTBKyfh6x17
        z+E2b5nFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g814F-000064-44; Thu, 04 Oct 2018 10:41:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F049202C1A0B; Thu,  4 Oct 2018 12:41:07 +0200 (CEST)
Date:   Thu, 4 Oct 2018 12:41:07 +0200
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
Subject: Re: [PATCH v7 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20181004104107.GN19272@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-13-quentin.perret@arm.com>
 <20181004094412.GD19252@hirez.programming.kicks-ass.net>
 <20181004102722.izp7y42cvayq4pqg@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004102722.izp7y42cvayq4pqg@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:27:22AM +0100, Quentin Perret wrote:
> > > +		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
> > 
> > Which of the two masks do we expect to be the smallest?
> 
> Typically, perf_domain_span is smaller.

OK, then the above expression is in the right order :-)

> > > +			if (spare_cap > max_spare_cap) {
> > > +				max_spare_cap = spare_cap;
> > > +				max_spare_cap_cpu = cpu;
> > > +			}
> > 
> > Sometimes I wonder if something like:
> > 
> > #define min_filter(varp, val)		\
> > ({					\
> > 	typeof(varp) _varp = (varp);	\
> > 	typeof(val)  _val  = (val);	\
> > 	bool f = false;			\
> > 					\
> > 	if (_val < *_varp) {		\
> > 		*_varp = _val;		\
> > 		f = true;		\
> > 	}				\
> > 					\
> > 	f;				\
> > })
> > 
> > and the corresponding max_filter() are worth the trouble; it would allow
> > writing:
> > 
> > 	if (max_filter(&max_spare_cap, spare_cap))
> > 		max_spare_cap_cpu = cpu;
> > 
> > and:
> > 
> > > +		}
> > > +
> > > +		/* Evaluate the energy impact of using this CPU. */
> > > +		if (max_spare_cap_cpu >= 0) {
> > > +			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
> > > +			if (cur_energy < best_energy) {
> > > +				best_energy = cur_energy;
> > > +				best_energy_cpu = max_spare_cap_cpu;
> > > +			}
> > 
> > 	if (min_filter(&best_energy, cur_energy))
> > 		best_energy_cpu = max_spare_cap_cpu;
> > 
> > But then I figure, it is not... dunno. We do lots of this stuff.
> 
> If there are occurrences of this stuff all over the place, we could do
> that in a separate clean-up patch that does just that, for the entire
> file. Or maybe more ?

Sure, not something that needs done now. I just always think of this
when I see this pattern repeated, but never seem to get around to doing
anything about it.

I figured I'd mention it ;-)

> > I would much prefer this to be something like:
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a8f601edd958..5475a885ec9f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6299,12 +6299,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >  {
> >  	struct sched_domain *tmp, *sd = NULL;
> >  	int cpu = smp_processor_id();
> > -	int new_cpu = prev_cpu;
> > +	unsigned int new_cpu = prev_cpu;
> >  	int want_affine = 0;
> >  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> >  
> >  	if (sd_flag & SD_BALANCE_WAKE) {
> >  		record_wakee(p);
> > +
> > +		if (static_branch_unlikely(sched_eas_balance)) {
> > +			new_cpu = select_task_rq_eas(p, prev_cpu, sd_flags, wake_flags);
> > +			if (new_cpu < nr_cpu_ids)
> > +				return new_cpu;
> > +		}
> > +
> >  		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> >  			      && cpumask_test_cpu(cpu, &p->cpus_allowed);
> >  	}
> > and then hide everything (including that giant comment) in
> > select_task_rq_eas().
> 
> So you think we should rename find_energy_efficient_cpu and put all the
> checks in there ? Or should select_task_rq_eas do the checks and then
> call find_energy_efficient_cpu ?
> 
> Not a huge deal, but that'll save some time if we agree on that one
> upfront.

Not sure, see what it looks like ;-) My main concern here was to get rid
of that giant blob in select_task_rq_fair().
