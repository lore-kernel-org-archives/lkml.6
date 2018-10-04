Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A81213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XwsHl+Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A81213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeJDQb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:31:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u7sC124KIfJt5Z3yO1gC336nP2Cq0NjjiL+U5osnltA=; b=XwsHl+OiIHPfqlr8/vFiqL0j1
        xp4cHtbBlqGx1g0nETkV2rlNQPF1WX/RLbEydIcW5ZXptl3m9OR4RJxD5F1tKsfYb9pGNwAznFuHA
        7uiyxdymXfol8TeHbsZhZniTnr94mWwhQ9UCeJ9WTb3qS51x3JS24f/u4zkitCztXBZ97PnX6WO53
        ykxx5gWM4ZBoXJ4x9z4eE2N/Z/pQzRGREpKhHa1bNiEmB5BL7WjIM31+ZDzModGgfRbCmwNw9OO44
        hl2ubGiwG9+zOiP8J67/UQcDbC2tZXh3PJ6u3XjPPZa88nRuLoBtPCr3uP2xtM4ShAgytxfq8Dbov
        JBYx8/Xew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g805q-0001rG-Nu; Thu, 04 Oct 2018 09:38:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45E52202695A2; Thu,  4 Oct 2018 11:38:48 +0200 (CEST)
Date:   Thu, 4 Oct 2018 11:38:48 +0200
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
Subject: Re: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate
 platforms
Message-ID: <20181004093848.GM19272@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-9-quentin.perret@arm.com>
 <20181003162719.GB19252@hirez.programming.kicks-ass.net>
 <20181004091046.7nn2odqrjy7tp5vx@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004091046.7nn2odqrjy7tp5vx@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:10:48AM +0100, Quentin Perret wrote:
> On Wednesday 03 Oct 2018 at 18:27:19 (+0200), Peter Zijlstra wrote:
> > On Wed, Sep 12, 2018 at 10:13:03AM +0100, Quentin Perret wrote:
> > > @@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
> > >  			goto free;
> > >  		tmp->next = pd;
> > >  		pd = tmp;
> > > +
> > > +		/*
> > > +		 * Count performance domains and capacity states for the
> > > +		 * complexity check.
> > > +		 */
> > > +		nr_pd++;
> > > +		nr_cs += em_pd_nr_cap_states(pd->obj);
> > > +	}
> > > +
> > > +	/* Bail out if the Energy Model complexity is too high. */
> > > +	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
> > > +		if (sched_debug())
> > > +			pr_info("rd %*pbl: EM complexity is too high\n ",
> > > +						cpumask_pr_args(cpu_map));
> > > +		goto free;
> > >  	}
> > 
> > I would make than an unconditional WARN, we do not really expect that to
> > trigger, but then it does, we really don't want to hide it.
> 
> OTOH that also means that some people with big asymmetric machines can
> get a WARN message every time they boot, and even if they don't want to
> use EAS.
> 
> Now, that shouldn't happen any time soon, so it's maybe a good thing if
> we get reports when/if people start to hit that one, so why not ...

Right, and if becomes a real problem we can think of a solution (like
maybe a DT thingy that says to not use EAS, or a 'better' EAS
algorithm).
