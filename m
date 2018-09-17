Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B03ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803FF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELqZJXDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803FF2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeIQRAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:00:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeIQRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EA6Nf0fYn1AK6GeVV3Kp3wCyzts6mhBWR/hAaZKU/rc=; b=ELqZJXDhse+pMMinsNpEDpqr7N
        bfoaH3WMSpJZMAWZdlzUj7NWd3MJeDJDG2zMb8/DKJfFNZb8HepLIbFkqo9KNL5FixF2UkCOeYuAa
        VhHddCausVn/P4eqXhzvVeCfIA7UJwyvldXr3sLFkyX2X8FePQcEw8TLV4wUc3pFATA1ivb3VtdXd
        yMpNMgRI8HflMORp6Fe4YUKhU28fKmrs0Tfdl1m1vkVH1p08C6AmM5fje6ne1k9OFQPnFv7KATvA8
        60W8gE/yiDLa8DMMD5bPvI9AmrYnszXHzXcxgV5a9Gs3KhPxxFLwqJIsWZl/17uuPHQEB0eDNerbN
        dScmymJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1rmI-0003Mq-I1; Mon, 17 Sep 2018 11:33:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDFEB2058A20A; Mon, 17 Sep 2018 13:33:15 +0200 (CEST)
Date:   Mon, 17 Sep 2018 13:33:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180917113315.GS24124@hirez.programming.kicks-ass.net>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
> On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
> > On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:

> >> B) Why would I want this?
> > 
> >>    In the L1TF context, it prevents other applications from loading
> >>    additional data into the L1 cache, while one application tries to leak
> >>    data.
> > 
> > That is the whole and only reason you did this;
> It really isn't. But as your mind seems made up, I'm not going to bother
> to argue.

> >> D) What can I *not* do with this?
> >> ---------------------------------
> >>
> >> Besides the missing load-balancing within coscheduled task-groups, this
> >> implementation has the following properties, which might be considered
> >> short-comings.
> >>
> >> This particular implementation focuses on SCHED_OTHER tasks managed by CFS
> >> and allows coscheduling them. Interrupts as well as tasks in higher
> >> scheduling classes are currently out-of-scope: they are assumed to be
> >> negligible interruptions as far as coscheduling is concerned and they do
> >> *not* cause a preemption of a whole group. This implementation could be
> >> extended to cover higher scheduling classes. Interrupts, however, are an
> >> orthogonal issue.
> >>
> >> The collective context switch from one coscheduled set of tasks to another
> >> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
> >> that all tasks of the previous set have stopped executing before any task
> >> of the next set starts executing, an additional hand-shake/barrier needs to
> >> be added.
> > 
> > IOW it's completely friggin useless for L1TF.
> 
> Do you believe me now, that L1TF is not "the whole and only reason" I did this? :D

You did mention this work first to me in the context of L1TF, so I might
have jumped to conclusions here.

Also, I have, of course, been looking at (SMT) co-scheduling,
specifically in the context of L1TF, myself. I came up with a vastly
different approach. Tim - where are we on getting some of that posted?

Note; that even though I wrote much of that code, I don't particularly
like it either :-)
