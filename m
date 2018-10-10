Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD2CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F8921479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ceitY1ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJJSov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:44:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8VP2OhUAIfWoaz7iej4cE+Z1YVIvqGEQQNjTdH96U64=; b=ceitY1niyTtuxoVE7X5TJEfeN
        SGNx1xQkTTvGpX1U8zAEYU/u5RDV/DMHbTNphsLUiArCFGMIAj/EMImIWSU28uqJJ1nYyWCGp6tzk
        0kMpwyZhknNJDr1Spj6+ob6XUVQ91WGBra1e9xs/3wZkkszMWKcbD3v/o8FWy4C2cdWzXVUdG4jRS
        2UUSC8WFl5yud/cDnD5x7D2ZWPlqwNxp68SOEs+8f79zGToL1JRVT+4MuGhnov0ViehRWphiiUm/D
        srXtdsUOm86E/L/5x9eJq5bTy9/M1uhkSWIg1p306GJN7OjAKGKgvLH0cYRnOJoAZv6LNe6oYtTnf
        jlKoK8Gfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gACZy-0004eJ-TI; Wed, 10 Oct 2018 11:23:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA7D2202A40A9; Wed, 10 Oct 2018 13:23:00 +0200 (CEST)
Date:   Wed, 10 Oct 2018 13:23:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010112300.GQ5728@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010123417.26c682ef@luca64>
 <20181010105710.GP5728@hirez.programming.kicks-ass.net>
 <20181010131629.6623ddb4@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010131629.6623ddb4@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:16:29PM +0200, luca abeni wrote:
> On Wed, 10 Oct 2018 12:57:10 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Oct 10, 2018 at 12:34:17PM +0200, luca abeni wrote:
> > > So, I would propose to make the proxy() function of patch more
> > > generic, and not strictly bound to mutexes. Maybe a task structure
> > > can contain a list of tasks for which the task can act as a proxy,
> > > and we can have a function like "I want to act as a proxy for task
> > > T" to be invoked when a task blocks?  
> > 
> > Certainly possible, but that's something I'd prefer to look at after
> > it all 'works'.
> 
> Of course :)
> I was mentioning this idea because maybe it can have some impact on the
> design.
> 
> BTW, here is another "interesting" issue I had in the past with changes
> like this one: how do we check if the patchset works as expected?
> 
> "No crashes" is surely a requirement, but I think we also need some
> kind of testcase that fails if the inheritance mechanism is not working
> properly, and is successful if the inheritance works.
> 
> Maybe we can develop some testcase based on rt-app (if noone has such a
> testcase already)

Indeed; IIRC there is a test suite that mostly covers the FIFO-PI stuff,
that should obviously still pass. Steve, do you know where that lives?

For the extended DL stuff, we'd need new tests.
