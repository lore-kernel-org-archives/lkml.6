Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA26C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19262156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C94Ha9mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19262156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI0NrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:47:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0NrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m9MVQbR/JWpYgSlTVBv4mPTLo5xSZapF3twV2vdOXZs=; b=C94Ha9mg3DaBnb14pgVpbeqql
        /AeLMNFOKnDbwFcVBz8jF+BoA+UHSN/yerUsZtYFqQEmQIWskIv2SBvVQV5C6/9MMqo61ez3TJ2eR
        DKq6GmP8cEl9NNwdv/aBJIH21nyRZhE9upjlIZLezhwpmYiNyDRhFJZaEKFHyNl9YI3cuc+I8TLVC
        WOD9QCnGdy9WCvnVM4wAs+ESQbqolSb+C4eQewAe0n7WE70vQC/Zq3i+WmPrVKPw4gCGnApoQTJ6r
        R+xzioLBCqTuk0Kyxs2VbYOhVrpvcwB5YXY747Pb2RIwiqMoTqzRP5UNtabodL4pjm99kBQAOzRDN
        qNPDCyXyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5QkT-0004WK-Ex; Thu, 27 Sep 2018 07:30:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 116F620696FC8; Thu, 27 Sep 2018 09:29:52 +0200 (CEST)
Date:   Thu, 27 Sep 2018 09:29:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180927072952.GB7455@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <396f7363-0f28-0fdb-7a48-ae16b0c8e82f@redhat.com>
 <20180926175418.GB5254@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926175418.GB5254@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:54:18PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 26, 2018 at 12:30:36PM -0400, Waiman Long wrote:
> > On 09/26/2018 07:01 AM, Peter Zijlstra wrote:
> > > On x86 we cannot do fetch_or with a single instruction and end up
> > > using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> > > with a very tricky composite xchg8 + load.
> > >
> > > The basic idea is that we use xchg8 to test-and-set the pending bit
> > > (when it is a byte) and then a load to fetch the whole word. Using
> > > two instructions of course opens a window we previously did not have.
> > > In particular the ordering between pending and tail is of interrest,
> > > because that is where the split happens.
> > >
> > > The claim is that if we order them, it all works out just fine. There
> > > are two specific cases where the pending,tail state changes:
> > >
> > >  - when the 3rd lock(er) comes in and finds pending set, it'll queue
> > >    and set tail; since we set tail while pending is set, the ordering
> > >    is split is not important (and not fundamentally different form
> > >    fetch_or). [*]
> > 
> > The split can cause some changes in behavior. The 3rd locker observes
> > the pending bit and set tail. The split load of the 2nd locker may make
> > it observe the tail and backout of the pending loop. As a result, the
> > 2nd locker will acquire the lock after the third locker in this case.
> > That won't happen with the original code.
> > 
> > I am not saying this is a problem. It is just something we should take
> > note on.
> 
> Right, good one. Yes that can happen.

I think I remember why I 'discounted' that scenario; the same can happen
with the fetch_or() but in a timing scenario.

Consider:

  CPU 0		CPU 1		CPU 2		CPU 3

  lock (->0,0,1)
		lock
		  trylock (fail)
		  tas-pending (->0,1,1)
		  wait-!locked
				lock
				  trylock (fail)
				  tas-pending (fail)
  unlock (->0,1,0)
		  acquire (->0,0,1)
						lock
						  trylock (fail)
				  (A) xchg-tail
						  tas-pending -> (x,1,1)
				  (B) xchg-tail

And then, depending on A/B x is either 0 or !0.

So the ordering of the concurrent lock attempts is always (obviously)
subject to timing, the split xchg-load thing just makes it 'worse'.
