Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02182086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNz5OqLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfARMB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:01:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58030 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfARMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ELgBI6i2Bpmn7X3LY1bhxhBSqNEAuOmsAJTJ9IieA5U=; b=bNz5OqLmO9pFEh4raDdM0Wpit
        p4ekGr0RCzboOIIdCBo3Yg+tdgfMVi8xOrGbhIVf7FfVciqGDVeb6Zaz0+diwQTb0EPL8PBZZfTTq
        Czyt9fztBHWc8caZY2hELM5wLWpfYxYWXzf4t8BrSaRuW45oASBJ6qsvXwyGGin5maqqpimXyVnR5
        2Tux9OpB5Nk5sBnWCLVxQKpeJ0e28+X16zRUY0Ht+ncPialI6pNGFk5G2jrBaRYluLxlMxFvKVMsQ
        wXZ9Jeum/QoqCKJombvXtkgy6vZ5kfR5jr9CkICtD7RFxFuLRVEWzez9U7eUIK+K6/ycA5nxOboJ+
        ib2oFKQug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkSqO-00029C-2H; Fri, 18 Jan 2019 12:01:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20B1220289CC4; Fri, 18 Jan 2019 13:01:49 +0100 (CET)
Date:   Fri, 18 Jan 2019 13:01:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
Message-ID: <20190118120149.GC27931@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air>
 <alpine.DEB.2.21.1901101246340.3358@macbook-air>
 <alpine.DEB.2.21.1901101500030.3717@macbook-air>
 <alpine.DEB.2.21.1901111649580.6487@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901111649580.6487@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 04:52:22PM -0500, Vince Weaver wrote:
> On Thu, 10 Jan 2019, Vince Weaver wrote:
> 
> > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > 
> > > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > > 
> > > > However if you create an all-process attached to CPU event:
> > > > 	perf_event_open(attr, -1, X, -1, 0);
> > > > the mmap event index is set as if this were a valid event and so the rdpmc
> > > > succeeds even though it shouldn't (we're trying to read an event value
> > > > on a remote cpu with a local rdpmc).
> 
> so on further looking at the code, it doesn't appear that rdpmc events are 
> explicitly marked as unavailable in the attach-cpu or attach-pid case, 
> it's just by luck the check for PERF_EVENT_STATE_ACTIVE catches most of 
> the cases?
> 
> should an explicit check be added to zero out userpg->index in cases where 
> the event being measured is running on a different core?

And how would we konw? We don't know what CPU will be observing the
mmap().

RDPMC fundamentally only makes sense on 'self' (either task or CPU).
