Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CAC20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6uFPO04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfARQJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:09:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iX8VW9HjgFXT7Ii2QEevfwIhExiKmVnAFwBnYZ0K2tw=; b=l6uFPO04/Q7PWBF7g0c1NObHQ
        yQON4kjC6prOLFimKVoHYoVe1+V5Q4SURU8gSlcZlnysvOF35N1tH2175YsULIrkAC7D/RaRy3gqI
        tuzJxrbKyI9WfIg9gpDof1ebaKrcVJwKJhqRqxClqK12ed3oJdj3kxFBCUJajfCG4mmA9qUjT5FqN
        BP2JNY4mC0h5wX8Qhigv0CrED03BkQrZ5aSORzYdOdHhoGWrmirfJXrC/3CQsLo58HsiibqmrBLve
        G8q45iJr6X83/0tp6ASSnHPxeSr5NVJokZGK73TO6piKipLSMvLVEkqRG4gbyPXosCWxBdazxdVWW
        Vtz2uOONQ==;
Received: from [89.200.44.227] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkWiJ-00043T-5Z; Fri, 18 Jan 2019 16:09:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 065D99818FF; Fri, 18 Jan 2019 16:58:15 +0100 (CET)
Date:   Fri, 18 Jan 2019 16:58:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
Message-ID: <20190118155814.GC14054@worktop.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air>
 <alpine.DEB.2.21.1901101246340.3358@macbook-air>
 <alpine.DEB.2.21.1901101500030.3717@macbook-air>
 <alpine.DEB.2.21.1901111649580.6487@macbook-air>
 <20190118120149.GC27931@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901180905090.5762@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901180905090.5762@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:09:04AM -0500, Vince Weaver wrote:
> On Fri, 18 Jan 2019, Peter Zijlstra wrote:
> 
> > On Fri, Jan 11, 2019 at 04:52:22PM -0500, Vince Weaver wrote:
> > > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > > 
> > > > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > > > 
> > > > > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > > > > 
> > > > > > However if you create an all-process attached to CPU event:
> > > > > > 	perf_event_open(attr, -1, X, -1, 0);
> > > > > > the mmap event index is set as if this were a valid event and so the rdpmc
> > > > > > succeeds even though it shouldn't (we're trying to read an event value
> > > > > > on a remote cpu with a local rdpmc).
> > > 
> > > so on further looking at the code, it doesn't appear that rdpmc events are 
> > > explicitly marked as unavailable in the attach-cpu or attach-pid case, 
> > > it's just by luck the check for PERF_EVENT_STATE_ACTIVE catches most of 
> > > the cases?
> > > 
> > > should an explicit check be added to zero out userpg->index in cases where 
> > > the event being measured is running on a different core?
> > 
> > And how would we konw? We don't know what CPU will be observing the
> > mmap().
> > 
> > RDPMC fundamentally only makes sense on 'self' (either task or CPU).
> 
> so is this a "don't do that then" thing and I should have PAPI 
> userspace avoid using rdpmc() whenever a proc/cpu was attached to?

You can actually use rdpmc when you attach to a CPU, but you have to
ensure that the userspace component is guaranteed to run on that very
CPU (sched_setaffinity(2) comes to mind).

> Or is there a way to have the kernel indicate this?  Does the kernel track 
> current CPU and original CPU of the mmap and could zero out the index 
> field in this case?  Or would that add too much overhead?

Impossible I'm afraid. Memory is not associated with a CPU; it's
contents is the same whatever CPU reads from it.

The best we could possibly do is put the (target, not current) cpu
number in the mmap page; but userspace should already know this, for it
created the event and therefore knows this already.
