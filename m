Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB8923FFC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VzJwmkMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB8923FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeGFNYn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:24:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45792 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbeGFNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wBSwoWMD452SUlEmPs3mINQ7lU9GeVodElxhIWOzlB8=; b=VzJwmkMUp3yEnfCa/uIOW/3RR
        cFsz2QGRTCqzGvP3S5JthPOzTL4lu0zUWSAIug5Wq0Z19efExy0fWp8MMJkdC+ZPm7nynwv2nH/Vg
        rdVA8bsTKvCwfcMY0MyutY9yf/yJZK4Pou7No/2ykweQcNDNTbQxVnLvxIwevQaMkV5NGeuYZ/laV
        UvI+ASWoXSXwcXQ9moY9/puClEK3O+EvmXBFU1MWtpOLu1eE1+nWEEM5up9MKBZGbEfhpImVmZEcD
        8tvazEol+gqQRW5qoUTg1oJ4CXoCdQVbzsXcaiA4VULE5HEPBTPRp2l3jpWur9pFIBIhjutrssqNd
        mjR/l6NKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbQis-0001N8-Dg; Fri, 06 Jul 2018 13:24:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D0AB20289CE4; Fri,  6 Jul 2018 15:24:29 +0200 (CEST)
Date:   Fri, 6 Jul 2018 15:24:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180706132428.GY2476@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
 <20180706113208.GS2458@hirez.programming.kicks-ass.net>
 <20180706132056.GA17577@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706132056.GA17577@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:20:57PM +0100, Quentin Perret wrote:
> On Friday 06 Jul 2018 at 13:32:08 (+0200), Peter Zijlstra wrote:
> > On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
> > > @@ -5384,6 +5402,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  {
> > >  	struct cfs_rq *cfs_rq;
> > >  	struct sched_entity *se = &p->se;
> > > +	int task_new = !(flags & ENQUEUE_WAKEUP);
> > >  
> > >  	/*
> > >  	 * The code below (indirectly) updates schedutil which looks at
> > > @@ -5431,8 +5450,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  		update_cfs_group(se);
> > >  	}
> > >  
> > > -	if (!se)
> > > +	if (!se) {
> > >  		add_nr_running(rq, 1);
> > > +		if (!task_new)
> > > +			update_overutilized_status(rq);
> > 
> > I'm confused... why only for !ENQUEUE_WAKEUP
> 
> So, what we try to do here is to _not_ set the overutilized flag based
> on the utilization of a new task, because its utilization is 'wrong'.
> That should help avoiding spurious transitions above the overutilized
> threshold.

That most certainly deserves a comment, also didn't util_est fix some of
that wrong-ness?

