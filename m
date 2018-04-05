Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeDERHR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:07:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDERHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:07:16 -0400
Date: Thu, 5 Apr 2018 19:07:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Message-ID: <20180405170706.GC4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:58:59PM +0100, Will Deacon wrote:
> The qspinlock locking slowpath utilises a "pending" bit as a simple form
> of an embedded test-and-set lock that can avoid the overhead of explicit
> queuing in cases where the lock is held but uncontended. This bit is
> managed using a cmpxchg loop which tries to transition the uncontended
> lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
> 
> Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
> indefinitely if the lock word is seen to oscillate between unlocked
> (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
> able to take the lock in the cmpxchg loop without queuing and pass it
> around amongst themselves.
> 
> This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
> using atomic_fetch_or, 

Of course, LL/SC or cmpxchg implementations of fetch_or do not in fact
get anything from this ;-)
