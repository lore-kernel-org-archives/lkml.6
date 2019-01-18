Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB83FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AE22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2QUHo4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfARUHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:07:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbfARUHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bHjbrvtdU6CrPUk89GCBDU4LVJNmWhYTlrCLtZRBcPs=; b=f2QUHo4pL53dLQi/z9+sCmeX9
        8vkB/UO6buu/oSkxnfyfJbqUmenZSS+tEzn2TwWVU5noLLGQzD4m4D16omnnjAetqPT18QqppelAa
        1Nr/bVapfNNXCTz3gsQPy6vFEUYjjqbtiO7k4z1lMO3pcSF5pn6zvaJ2Lf4rQjZCBXnsL3i8iDU/k
        Z1LmlGuIuJeHhWcdewajoxGqIJMH3zzs7yRK8jKi+EwTMk0o4bcOO+0n2doRZcfjgoGVvAA9EW4o1
        yEpPtgNJ17UJVjCNyu2APMWcRHzYNz2GncrrtMz1NA/8hnnM9zsLclfo5wcTQCujRDuVg++6UTN7G
        iC+7t1pFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkaPs-00012H-4n; Fri, 18 Jan 2019 20:07:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5F25201955B8; Fri, 18 Jan 2019 21:06:57 +0100 (CET)
Date:   Fri, 18 Jan 2019 21:06:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Question about qspinlock nest
Message-ID: <20190118200657.GE27931@hirez.programming.kicks-ass.net>
References: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
 <910e9fb6-d0df-4711-fe2b-244b3c20eb82@redhat.com>
 <d06126a1-1db8-f937-2084-2c1234b6f56f@arm.com>
 <20190110201217.GH2861@worktop.programming.kicks-ass.net>
 <a270215d-ec5a-8b8a-3786-c0480b640abc@arm.com>
 <20190114131613.GB10486@hirez.programming.kicks-ass.net>
 <830db851-d5cb-4081-8d72-e3f3a0a282df@arm.com>
 <20190118100229.GB27931@hirez.programming.kicks-ass.net>
 <abf2dfe7-e148-b011-764d-b9effa573d5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf2dfe7-e148-b011-764d-b9effa573d5d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:50:12AM -0500, Waiman Long wrote:
> On 01/18/2019 05:02 AM, Peter Zijlstra wrote:
> >
> >> e.g. We can't take an SError during the SError handler.
> >>
> >> But we can take this SError/NMI on another CPU while the first one is still
> >> running the handler.
> >>
> >> These multiple NMIlike notifications mean having multiple locks/fixmap-slots,
> >> one per notification. This is where the qspinlock node limit comes in, as we
> >> could have more than 4 contexts.
> > Right; so Waiman was going to do a patch that reverts to test-and-set or
> > something along those lines once we hit the queue limit, which seems
> > like a good way out. Actually hitting that nesting level should be
> > exceedingly rare.
> 
> Yes, I am working on a patch to support arbitrary levels of nesting. It
> is easy for PV qspinlock as lock stealing is supported.
> 
> For native qspinlock, we cannot do lock stealing without incurring a
> certain amount of overhead in the regular slowpath code. It was up to
> 10% in my own testing. So I am exploring an alternative that can do the
> job without incurring any noticeable performance degradation in the
> slowpath. I ran into a race condition which I am still trying to find
> out where that comes from. Hopefully, I will have something to post next
> week.

Where does the overhead come from? Surely that's not just checking that
bound?
