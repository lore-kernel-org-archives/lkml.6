Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22835C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B220823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xQKjTJzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBGJ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:56:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39964 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2hGrFye3mi4llSwKlr6YkBEzQq5cWOP/x/JiZCSL8PA=; b=xQKjTJzVOSp53CrQy4RHCDARy
        xfpouf+6CSjAIbsfRZimh5KY6CWKw1qFhvwDQMqkT0CN0B7z6YSvjZmAhcz5g1rnoflKribVQ2rVn
        EEgLSGMMjKgZPuX+oFgFBATD+ru10MDPnkFh/fDZviX7AoYRETojH4cj6x0oKA/fjJafp+hW7sjj6
        HZVftzTyg1lpX//aJ6Xnweq4xXaYFS0anTl4MbECcsl/1W0R0C/q4XemBSYBkD4Y4B0I3Xev6wrrM
        CE3lgXs8KWhIBbq9vXREEGkUnuTkiL59tpsQj0BfRNi4cuBS+Dc/bYU4JHiQ826arNbU+oW7eZ8xO
        Ze8n/liLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grgQE-0003kH-2w; Thu, 07 Feb 2019 09:56:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D05A201A1B24; Thu,  7 Feb 2019 10:56:39 +0100 (CET)
Date:   Thu, 7 Feb 2019 10:56:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 5/5] sched/fair: Skip LLC nohz logic for asymmetric
 systems
Message-ID: <20190207095639.GA32494@hirez.programming.kicks-ass.net>
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-6-valentin.schneider@arm.com>
 <20190206161452.GL17550@hirez.programming.kicks-ass.net>
 <5010b09f-6954-fda6-a10f-a8aa05806866@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5010b09f-6954-fda6-a10f-a8aa05806866@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:26:06PM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 06/02/2019 16:14, Peter Zijlstra wrote:
> [...]
> >> @@ -9545,6 +9545,17 @@ static void nohz_balancer_kick(struct rq *rq)
> >>  	}
> >>  
> >>  	rcu_read_lock();
> >> +
> >> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
> >> +		/*
> >> +		 * For asymmetric systems, we do not want to nicely balance
> >> +		 * cache use, instead we want to embrace asymmetry and only
> >> +		 * ensure tasks have enough CPU capacity.
> >> +		 *
> >> +		 * Skip the LLC logic because it's not relevant in that case.
> >> +		 */
> >> +		goto check_capacity;
> >> +
> >>  	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> >>  	if (sds) {
> >>  		/*
> > 
> > Since (before this) the actual order of the various tests doesn't
> > matter, it's a logical cascade of conditions for which to KICK_MASK.
> > 
> 
> Ah, I assumed the order did matter somewhat with the "cheaper" LLC check
> first and the more costly loops further down in case we are still looking
> for a reason to do a kick.

I did not in fact consider that; I only looked at the logical structure
of the thing. You might want to double check :-)

> > We can easily reorder and short-circuit the cascase like so, no?
> > 
> > The only concern is if sd_llc_shared < sd_asym_capacity; in which case
> > we just lost a balance opportunity. Not sure how to best retain that
> > though.
> > 
> 
> I'm afraid I don't follow - we don't lose a balance opportunity with the
> below change (compared to the original patch), do we?

What if each big/little cluster would have multiple cache domains? Would
we not want to spread the cache usage inside the big/little resp. ?
