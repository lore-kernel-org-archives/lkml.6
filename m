Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E498C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026D820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026D820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeIJOfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:35:01 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:37861 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbeIJOfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:35:00 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 13B1A1C313A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:41:49 +0100 (IST)
Received: (qmail 12986 invoked from network); 10 Sep 2018 09:41:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Sep 2018 09:41:48 -0000
Date:   Mon, 10 Sep 2018 10:41:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180910094147.GH1719@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180907123739.GE1719@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:37:39PM +0100, Mel Gorman wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d59d3e00a480..d4c289c11012 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1560,7 +1560,7 @@ static bool task_numa_compare(struct task_numa_env *env,
> > >  		goto unlock;
> > >  
> > >  	if (!cur) {
> > > -		if (maymove || imp > env->best_imp)
> > > +		if (maymove)
> > >  			goto assign;
> > >  		else
> > >  			goto unlock;
> > 
> > Srikar's patch here:
> > 
> >   http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > 
> > Also frobs this condition, but in a less radical way. Does that yield
> > similar results?
> 
> I can check. I do wonder of course if the less radical approach just means
> that automatic NUMA balancing and the load balancer simply disagree about
> placement at a different time. It'll take a few days to have an answer as
> the battery of workloads to check this take ages.
> 

Tests completed over the weekend and I've found that the performance of
both patches are very similar for two machines (both 2 socket) running a
variety of workloads. Hence, I'm not worried about which patch gets picked
up. However, I would prefer my own on the grounds that the additional
complexity does not appear to get us anything. Of course, that changes if
Srikar's tests on his larger ppc64 machines show the more complex approach
is justified.

-- 
Mel Gorman
SUSE Labs
