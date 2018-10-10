Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5819B2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5819B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJJXft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:35:49 -0400
Received: from foss.arm.com ([217.140.101.70]:54662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeJJXft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:35:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34AFBED1;
        Wed, 10 Oct 2018 09:12:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05D673F5B3;
        Wed, 10 Oct 2018 09:12:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B41281AE088A; Wed, 10 Oct 2018 17:12:57 +0100 (BST)
Date:   Wed, 10 Oct 2018 17:12:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [PATCH v2 4/4] locking/qspinlock, x86: Provide liveness guarantee
Message-ID: <20181010161257.GD17340@arm.com>
References: <20181003130257.156322446@infradead.org>
 <20181003130957.183726335@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003130957.183726335@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:03:01PM +0200, Peter Zijlstra wrote:
> On x86 we cannot do fetch_or with a single instruction and thus end up
> using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> with a composite operation: tas-pending + load.
> 
> Using two instructions of course opens a window we previously did not
> have. Consider the scenario:
> 
> 
> 	CPU0		CPU1		CPU2
> 
>  1)	lock
> 	  trylock -> (0,0,1)
> 
>  2)			lock
> 			  trylock /* fail */
> 
>  3)	unlock -> (0,0,0)
> 
>  4)					lock
> 					  trylock -> (0,0,1)
> 
>  5)			  tas-pending -> (0,1,1)
> 			  load-val <- (0,1,0) from 3
> 
>  6)			  clear-pending-set-locked -> (0,0,1)
> 
> 			  FAIL: _2_ owners
> 
> where 5) is our new composite operation. When we consider each part of
> the qspinlock state as a separate variable (as we can when
> _Q_PENDING_BITS == 8) then the above is entirely possible, because
> tas-pending will only RmW the pending byte, so the later load is able
> to observe prior tail and lock state (but not earlier than its own
> trylock, which operates on the whole word, due to coherence).
> 
> To avoid this we need 2 things:
> 
>  - the load must come after the tas-pending (obviously, otherwise it
>    can trivially observe prior state).
> 
>  - the tas-pending must be a full word RmW, it cannot be an xchg8 for
>    example, such that we cannot observe other state prior to setting
>    pending.
> 
> On x86 we can realize this by using "LOCK BTS m32, r32" for
> tas-pending followed by a regular load.
> 
> Note that observing later state is not a problem:
> 
>  - if we fail to observe a later unlock, we'll simply spin-wait for
>    that store to become visible.
> 
>  - if we observe a later xchg_tail, there is no difference from that
>    xchg_tail having taken place before the tas-pending.
> 
> Cc: mingo@kernel.org
> Cc: tglx@linutronix.de
> Cc: longman@redhat.com
> Cc: andrea.parri@amarulasolutions.com
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/qspinlock.h |   15 +++++++++++++++
>  kernel/locking/qspinlock.c       |   16 +++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)

I've failed to break this by thinking really hard, so I've updated Catalin's
TLA model to see if the tools are still happy. I'll get back to you once
they've finished chewing on it.

Will
