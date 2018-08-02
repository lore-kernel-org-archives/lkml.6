Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF307C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C5E214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDQQ3JpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C5E214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbeHBO7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:59:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbeHBO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+mC/Gr92ceeEJZ2eWmgL0wup3w3dYwdunoxJ19WBSdE=; b=HDQQ3JpJqjWSQEhrCHWcAfr3V
        j1Br1UIWjv8QcBl4UJXIqlzvCsj7HC5HLFlZGavv2U80p2Z170duHXzB1IH7rcTFZ0FVnzK4mf4XV
        Xfk3Q+Lov80FkQviKFK2fr6329KhawvSqB2GGkaaTutQ2vvwjKak6vW9lh6/F23bsitPCG7Fds7ql
        Umga3UqmgO+VPVLMHgYHJTVV/tJxVX+jl5DjRQWd5T1Bu6kiyLyRHurWV5SzewKEZqHhscL/spnPt
        jl6ELRmZOtrOI9SrOJZI3Txeb3tzZ21N5v9DCdQJME0tO9RMm0phl7EXkbVQzv/nqd9t2K+coilyH
        gqIw5rU1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flDKl-0007cp-5Z; Thu, 02 Aug 2018 13:08:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A786E20267E4D; Thu,  2 Aug 2018 15:08:01 +0200 (CEST)
Date:   Thu, 2 Aug 2018 15:08:01 +0200
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
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180802130801.GL2494@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 02:03:38PM +0100, Quentin Perret wrote:
> On Thursday 02 Aug 2018 at 14:26:29 (+0200), Peter Zijlstra wrote:
> > On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> > > @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  		update_cfs_group(se);
> > >  	}
> > >  
> > > -	if (!se)
> > > +	if (!se) {
> > >  		add_nr_running(rq, 1);
> > > +		/*
> > > +		 * The utilization of a new task is 'wrong' so wait for it
> > > +		 * to build some utilization history before trying to detect
> > > +		 * the overutilized flag.
> > > +		 */
> > > +		if (flags & ENQUEUE_WAKEUP)
> > > +			update_overutilized_status(rq);
> > > +
> > > +	}
> > >  
> > >  	hrtick_update(rq);
> > >  }
> > 
> > That is a somewhat dodgy hack. There is no guarantee what so ever that
> > when the task wakes next its history is any better. The comment doesn't
> > reflect this I feel.
> 
> AFAICT the main use-case here is to avoid re-enabling the load balance
> and ruining all the task placement because of a tiny task. I don't
> really see how we can do that differently ...

Sure I realize that.. but it doesn't completely avoid it. Suppose this
new task instantly blocks and wakes up again. Then its util signal will
be exactly what you didn't want but we'll account it and cause the above
scenario you wanted to avoid.

Now, I suppose in practise it works well enough.

The alternative is trying to track when a running signal has converged,
but that's not a simple problem either I suppose.
