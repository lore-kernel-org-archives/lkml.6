Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125B62147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8HXnoSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfBZJae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:30:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49442 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfBZJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7fevLfVOGO6K4dW2os+6ny8+MQw8ukFYvYWI39MfD+Q=; b=e8HXnoSn/xKVYVKVu1y9fCCwB
        HeNZnlScoSwuUaRS1Bx2PwSq+NquICNfeMt5v+RVFNaW6h3YIXP60oiOqt8p/UtLjzCacSO9lOrKI
        VXDi2VoHVo1UbwAEwvAaNRklC1srCUU9tjgp++IQjLjnmR/AB38YBAaOfo7ezRe+RYnVYSZyiY9z3
        0QIcY2EnMma4h+Kil8C1WK842wjmi+kbgMVFN7B+YAQ8a3FUqUrI/C1+Pjob6dsR89m/eXyDhLttc
        5SjZbRIK0PihIZxOp5W4W/WH6Q46Vxf80NgkI+2IWjJMgdvz9dm0UV0m//qPFOflMwd9ErlydS7XC
        7PBn8yrJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyZ41-0004ik-05; Tue, 26 Feb 2019 09:30:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E321F2030C202; Tue, 26 Feb 2019 10:30:09 +0100 (CET)
Date:   Tue, 26 Feb 2019 10:30:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226093009.GS32477@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225175517.GK4072@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:55:17AM -0800, Paul E. McKenney wrote:
> But if you know of any code in the Linux kernel that needs to compare
> pointers, one of which might be in the process of being freed, please
> do point me at it.

I'm having the utmost difficulty of understanding why that would be a
problem. It's just a value. Freeing memory does not affect the actual
memory or any pointers to it.

*confusion*

None of this makes any kind of sense.
