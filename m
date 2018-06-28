Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B66C43148
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9CA275D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITYvi8Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9CA275D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967007AbeF1PGY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:06:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40964 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966685AbeF1PGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YF4vYGoomWMUC7ZOCmAanjHxzwN3WKGDdG0DBFS0cn8=; b=ITYvi8VsiwUKq1c3LJMfsqzGz
        JAUcbgbhjelhgn4/iuzRZYgSmAY4jHHKZn7Ij70jC/HlikXf0eYkHHk72QGTFiYiYPRxzlugGrxtd
        PiMk2pU5CsycPFI4odCEvV5+hs/dsE/pKDHZ49qc3avfoUrc0+BNV5xPzf3T0CDfPp0HpZ1vl/he8
        ooyY5q1Ccw5/cbOFf0faHyFR1n1OTP4UojuL/vRnI+KvtD7WAnRza4fhA5N1JyEoebcHYV1N+kar/
        zGZ6JhPmPr9APSkkL111NI1GR/VRBahPF9VZOxaLMkzMiLtMhK/CiwTw2aLR5IahITbq4YsZqZIiF
        DZtm448HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYYUb-0007dx-As; Thu, 28 Jun 2018 15:05:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8B1020289CA1; Thu, 28 Jun 2018 17:05:50 +0200 (CEST)
Date:   Thu, 28 Jun 2018 17:05:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180628150550.GI2494@hirez.programming.kicks-ass.net>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:41:19PM +0200, Andrea Parri wrote:
> - * This barrier must provide two things:
> - *
> - *   - it must guarantee a STORE before the spin_lock() is ordered against a
> - *     LOAD after it, see the comments at its two usage sites.
> - *
> - *   - it must ensure the critical section is RCsc.
> - *
> - * The latter is important for cases where we observe values written by other
> - * CPUs in spin-loops, without barriers, while being subject to scheduling.
> - *
> - * CPU0			CPU1			CPU2
> - *
> - *			for (;;) {
> - *			  if (READ_ONCE(X))
> - *			    break;
> - *			}
> - * X=1
> - *			<sched-out>
> - *						<sched-in>
> - *						r = X;
> - *
> - * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
> - * we get migrated and CPU2 sees X==0.

Please don't remove that; that explains _why_ we need a full memory
barrier here.

If anything, move it into __schedule() to explain the
smp_mb__after_spinlock() usage there.
