Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC19FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E5C20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W0pI8oTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E5C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeINRGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:06:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeINRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vHg8VORCODyeVP8U2W5S7fuglDv92go+PrmTD6yUjhI=; b=W0pI8oTikRoT3Ce7NSCEMAjVf
        enkuBfi+mwni1qImN5NNZgZabyiXZjyBoJcr20M7rU51kWR9AWrBDKcFWC1nVVjSRKeJ8tcFE4XHg
        q0EpaQDDb5a6GIsjMSotx//P/hWNfkg8iopHboLgrmzXAA2VzlYrqv0rr2rhrqVLob5SBcMED0xme
        AjsDZ2AGPvlVP5hJro+ksC0QOl8gj6urC0mcHCVZGIJhd1tawjHnRc6ip1MMvws5B8yB1/kRzQA8f
        agEvPSqzFcTVJIi8RKvpEBPYd+cWM6rlSBwmGbDAnmAz8Jp4drWHQBPYTxQE+KfaqhtFgvrHdFIlW
        RndVBD3rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0me4-0002DW-3O; Fri, 14 Sep 2018 11:52:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E00C202C1A09; Fri, 14 Sep 2018 13:52:17 +0200 (CEST)
Date:   Fri, 14 Sep 2018 13:52:17 +0200
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
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180914115217.GI24124@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
 <20180913191209.GY24082@hirez.programming.kicks-ass.net>
 <20180914090751.GN1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914090751.GN1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:07:51AM +0100, Patrick Bellasi wrote:
> On 13-Sep 21:12, Peter Zijlstra wrote:
> > On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> > > +static inline void uclamp_cpu_get_id(struct task_struct *p,
> > > +				     struct rq *rq, int clamp_id)
> > > +{
> > > +	struct uclamp_group *uc_grp;
> > > +	struct uclamp_cpu *uc_cpu;
> > > +	int clamp_value;
> > > +	int group_id;
> > > +
> > > +	/* Every task must reference a clamp group */
> > > +	group_id = p->uclamp[clamp_id].group_id;
> > 
> > > +}
> > > +
> > > +static inline void uclamp_cpu_put_id(struct task_struct *p,
> > > +				     struct rq *rq, int clamp_id)
> > > +{
> > > +	struct uclamp_group *uc_grp;
> > > +	struct uclamp_cpu *uc_cpu;
> > > +	unsigned int clamp_value;
> > > +	int group_id;
> > > +
> > > +	/* New tasks don't have a previous clamp group */
> > > +	group_id = p->uclamp[clamp_id].group_id;
> > > +	if (group_id == UCLAMP_NOT_VALID)
> > > +		return;
> > 
> > *confused*, so on enqueue they must have a group_id, but then on dequeue
> > they might no longer have?
> 
> Why not ?

That's what it says on the tin, right? enqueue: "every task must reference clamp
group" while on dequeue: "new tasks don't have a (previous) clamp group"
and we check for NOT_VALID.

