Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeDGIrj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 04:47:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeDGIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 04:47:38 -0400
Date: Sat, 7 Apr 2018 10:47:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Waiman Long <longman@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180407084732.GO4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180406210953.GA24165@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406210953.GA24165@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 02:09:53PM -0700, Paul E. McKenney wrote:
> It would indeed be good to not be in the position of having to trade off
> forward-progress guarantees against performance, but that does appear to
> be where we are at the moment.

Depends of course on how unfair cmpxchg is. On x86 we trade one cmpxchg
loop for another so the patch doesn't cure anything at all there. And
our cmpxchg has 'some' hardware fairness to it.

So while the patch is 'good' for platforms that have native fetch-or,
it doesn't help (or in our case even hurts) those that do not.
