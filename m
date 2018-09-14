Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9AEECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04C3206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tvv2L4Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04C3206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeINSve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:51:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeINSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iIlT1/P7i83i1XCOMlt6xYGWvQXrVjHzL20Qu/825/o=; b=Tvv2L4PzzP6pJBjD6/jVe5yYF
        gtbp8N0yyKJId0tyYw1MiVfYlhCzx5istoIIHTmcIEND0aH5sBUMouaoCYZKrpzj7kDQkK7FRlIED
        xdYO6h9xoGj+3T0wGLEqTRTiiXFNQ6eHCwUxOut2EiCnBMUTIrxlnOLhUFQnMuA7FpDdCEO1YfJXt
        GZ08O7criGljC2WwcaqslB1TXLTbLgfklxukVjiSwBTiuU78Jg+H/l5QiKQRDxxLpekJLwNdVNpsv
        Ra5XypCGWvojICLnwc1NtKwrLyWuqkizyHsbDZcveDgZ2ip77Z0dOWxqplWQqNDf3gFXM2UPgnqMz
        f/wZX4ysw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0oHH-0007j2-RJ; Fri, 14 Sep 2018 13:36:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F683202B2E3D; Fri, 14 Sep 2018 15:36:54 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:36:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Message-ID: <20180914133654.GL24124@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
 <20180914093240.GB24082@hirez.programming.kicks-ass.net>
 <20180914131919.GO1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914131919.GO1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 02:19:19PM +0100, Patrick Bellasi wrote:
> On 14-Sep 11:32, Peter Zijlstra wrote:

> > Should that not be:
> > 
> > 	util = clamp_util(rq, cpu_util_cfs(rq));
> > 
> > Because if !util might we not still want to enforce the min clamp?
> 
> If !util CFS tasks should have been gone since a long time
> (proportional to their estimated utilization) and thus it probably
> makes sense to not affect further energy efficiency for tasks of other
> classes.

I don't remember what we do for util for new tasks; but weren't we
talking about setting that to 0 recently? IIRC the problem was that if
we start at 1 with util we'll always run new tasks on big cores, or
something along those lines.

So new tasks would still trigger this case until they'd accrued enough
history.

Either way around, I don't much care at this point except I think it
would be good to have a comment to record the assumptions.

> > Would that not be more readable as:
> > 
> > static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
> > {
> > 	unsigned int val = rq->uclamp.value[clamp_id];
> > 
> > 	if (unlikely(val == UCLAMP_NOT_VALID))
> > 		val = uclamp_none(clamp_id);
> > 
> > 	return val;
> > }
> 
> I'm trying to keep consistency in variable names usages by always
> accessing the rq's clamps via a *uc_cpu to make it easy grepping the
> code. Does this argument make sense ?
> 
> On the other side, what you propose above is more easy to read
> by looking just at that function.... so, if you prefer it better, I'll
> update it on v5.

I prefer my version, also because it has a single load of the value (yes
I know about CSE passes). I figure one can always grep for uclamp or
something.

> > And how come NOT_VALID is possible? I thought the idea was to always
> > have all things a valid value.
> 
> When we update the CPU's clamp for a "newly idle" CPU, there are not
> tasks refcounting clamps and thus we end up with UCLAMP_NOT_VALID for
> that CPU. That's how uclamp_cpu_update() is currently encoded.
> 
> Perhaps we can set the value to uclamp_none(clamp_id) from that
> function, but I was thinking that perhaps it could be useful to track
> explicitly that the CPU is now idle.

IIRC you added an explicit flag to track idle somewhere.. to keep the
last max clamp in effect or something.

I think, but haven't overly thought about this, that if you always
ensure these things are valid you can avoid a bunch of NOT_VALID
conditions. And less conditions is always good, right? :-)
