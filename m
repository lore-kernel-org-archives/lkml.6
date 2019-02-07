Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BAFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A3E21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JuJOuaZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGJ5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:57:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bdWOaDGK0cw489WjIoj6KRbLUOyfWRTMrll3tP/0mXU=; b=JuJOuaZ1B0PRhZYxpBbL/Dkou
        oGIZYW/4s120nSO38LS5LaMLS9BUAeRTsfemb3wI4kKG6tlntHoMgYdMkecGvoDJdwykACuYvl9Ny
        BxupIQDuYr7kR6sHcyjwv44G85oZNVpYPzHmq0mI1BiZjz/8Zne8wigXhPczG5RP26YZe6wH2+3yd
        bNWwLKD3ca5S26Jspgp/zKgol1g4JQ4sy4gpY3YPb7Mrb0n9sag8CsJQT1uR4MpLfhelpdUd+1UfF
        H7zQSuwyId0WsKJNs3BYl3OkmgSDVafJJ+Zfn5Wpx7RqkT0m26m4MkAIM5DBHy6aG7ON/aR2diKA1
        huf12RAuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grgRF-0003kZ-K7; Thu, 07 Feb 2019 09:57:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66A0E201A1B22; Thu,  7 Feb 2019 10:57:43 +0100 (CET)
Date:   Thu, 7 Feb 2019 10:57:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 4/5] sched/fair: Tune down misfit nohz kicks
Message-ID: <20190207095743.GB32494@hirez.programming.kicks-ass.net>
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-5-valentin.schneider@arm.com>
 <20190206160413.GK17550@hirez.programming.kicks-ass.net>
 <2d9c0edd-d00a-ddb1-d81f-f8da11f24304@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9c0edd-d00a-ddb1-d81f-f8da11f24304@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:25:31PM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 06/02/2019 16:04, Peter Zijlstra wrote:
> [...]
> >> @@ -9561,6 +9573,14 @@ static void nohz_balancer_kick(struct rq *rq)
> > 
> > 	sd = rcu_dereference(rq->sd);
> > 	if (sd) {
> > 		if ((rq->cfs.h_nr_running >= 1) &&
> > 		    check_cpu_capacity(rq, sd)) {
> > 			flags = NOHZ_KICK_MASK;
> > 			goto unlock;
> >>  		}
> >>  	}
> >>  
> >> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
> >> +	if (sd) {
> >> +		if (check_misfit_status(rq, sd)) {
> >> +			flags = NOHZ_KICK_MASK;
> >> +			goto unlock;
> >> +		}
> >> +	}
> > 
> > So while the exact @sd to use for check_cpu_capacity() likely doesn't
> > matter; this is a 'implicit' test for actually having asym_capacity.
> > 
> 
> I did feel compelled to use the "right" @sd to have a coherent
> imbalance_pct being used - on big.LITTLE, the @sd above this hunk would be
> MC (117 imbalance_pct) whereas the sd_asym_cpucapacity one would be
> DIE (125 imbalance_pct).

Fair enough.

> > @@ -9606,6 +9614,10 @@ static void nohz_balancer_kick(struct rq
> >  
> >  	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
> >  	if (sd) {
> > +		/*
> > +		 * When ASYM_PACKING; see if there's a more preferred CPU going
> > +		 * idle; in which case, kick the ILB to move tasks around.
> > +		 */
> 
> s/going idle/currently idle/, no?

Yah.. D'0h..

> >  		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> >  			if (sched_asym_prefer(i, cpu)) {
> >  				flags = NOHZ_KICK_MASK;
> > 
