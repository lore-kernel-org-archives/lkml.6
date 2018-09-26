Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9864C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610202154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M5ly/YeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610202154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeI0AIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:08:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeI0AIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+MIOiMP1122Npzlm1e0KQS0q7okGEzFqYL09H6bK8N0=; b=M5ly/YeRGebWmpUTay6y+NXBt
        b3YgBZOl+g7M4eGKQ/KniSGnzFJ3VKTEgqQn4oRJZvBJRzQDxFnJt1rNtBNgPb89F8BBdgNXVQC2V
        R2LXbteATq2jqPxMJ+P6Faj7jvlpT0EqpMDPiNZF2+1Ss8MwfsCo36Hd02e5tJZEfafZWi78XJ2Gk
        2vf9QQNnaI2yvDttf6/jxP0v0SZNCusah1q7WYTxoIvXBFZ9jakHvzkBk38d76GQFH/fFEzyBjXYP
        SnmA8daxu7rZE/T/idRlf0h9zSxlNqre/0wLWx9JBzAaJVJ64dXQsxWWWTUqPetA2CvJ5HgxtrX+G
        U7lGu687g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5E0x-0001w2-GM; Wed, 26 Sep 2018 17:54:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39894205A76D4; Wed, 26 Sep 2018 19:54:18 +0200 (CEST)
Date:   Wed, 26 Sep 2018 19:54:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180926175418.GB5254@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <396f7363-0f28-0fdb-7a48-ae16b0c8e82f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396f7363-0f28-0fdb-7a48-ae16b0c8e82f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:30:36PM -0400, Waiman Long wrote:
> On 09/26/2018 07:01 AM, Peter Zijlstra wrote:
> > On x86 we cannot do fetch_or with a single instruction and end up
> > using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> > with a very tricky composite xchg8 + load.
> >
> > The basic idea is that we use xchg8 to test-and-set the pending bit
> > (when it is a byte) and then a load to fetch the whole word. Using
> > two instructions of course opens a window we previously did not have.
> > In particular the ordering between pending and tail is of interrest,
> > because that is where the split happens.
> >
> > The claim is that if we order them, it all works out just fine. There
> > are two specific cases where the pending,tail state changes:
> >
> >  - when the 3rd lock(er) comes in and finds pending set, it'll queue
> >    and set tail; since we set tail while pending is set, the ordering
> >    is split is not important (and not fundamentally different form
> >    fetch_or). [*]
> 
> The split can cause some changes in behavior. The 3rd locker observes
> the pending bit and set tail. The split load of the 2nd locker may make
> it observe the tail and backout of the pending loop. As a result, the
> 2nd locker will acquire the lock after the third locker in this case.
> That won't happen with the original code.
> 
> I am not saying this is a problem. It is just something we should take
> note on.

Right, good one. Yes that can happen.
