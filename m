Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bln/YDQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeIGRZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:25:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIGRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=119+pvNU79vGuxof8DLa1VB17ARPHN7FSjlDSiKECL4=; b=Bln/YDQIYgX2+529kZhq6indO
        y7CXDVh30bVmDWyP6haiYM1uEWjp44Z3E9OziSdn6TxA3SdjqORmg5ERM9tkh+k9ClsKVGf7sk8au
        gUfheMn/H/Jv1j6pYhANpTZy6sWjGfCGwzAnfItuZWpHy14a5hozl2AfedWsMKvWWGxn9Cr0UBY2H
        0sSJN1xq85JBHBYmhF/OEDAzT8+lB4UM0UGmZ8m6oZBL7ka3EPb4ChtwQR0fRfMqkIYS2ssizwi6u
        JwHpuHIv1qddR7WwGcHOAlaaYc3hsPAVo7kfmoizdFk2yXcXGcs2BVNPJdMuPCnRpZFR6SQ8w7xeN
        PlrEDegTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyG7l-0006Cc-Pn; Fri, 07 Sep 2018 12:44:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A24A20210310; Fri,  7 Sep 2018 14:44:32 +0200 (CEST)
Date:   Fri, 7 Sep 2018 14:44:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180907124432.GN24082@hirez.programming.kicks-ass.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907123739.GE1719@techsingularity.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:37:39PM +0100, Mel Gorman wrote:
> On Fri, Sep 07, 2018 at 01:33:09PM +0200, Peter Zijlstra wrote:
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
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

Yeah, I was afraid it would.. Srikar, can you also evaluate, I suspect
we'll have to pick one of these two patches.
