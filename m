Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964927AbeBMNv2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:51:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964846AbeBMNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:51:27 -0500
Date: Tue, 13 Feb 2018 14:51:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] atomic/bitops: Clarify ordering semantics for failed
 test_and_{}_bit()
Message-ID: <20180213135124.GL25201@hirez.programming.kicks-ass.net>
References: <1518528619-20049-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518528619-20049-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:30:19PM +0000, Will Deacon wrote:
> A test_and_{}_bit() operation fails if the value of the bit is such that
> the modification does not take place. For example, if test_and_set_bit()
> returns 1. In these cases, follow the behaviour of cmpxchg and allow the
> operation to be unordered. This also applies to test_and_set_bit_lock()
> if the lock is found to be be taken already.

You also looked at a bunch of users, right? And while you found some
dodgy ones, they were not more broken because of this IIRC.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/atomic_bitops.txt   | 7 ++++++-
>  include/asm-generic/bitops/lock.h | 3 ++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
> index 5550bfdcce5f..be70b32c95d9 100644
> --- a/Documentation/atomic_bitops.txt
> +++ b/Documentation/atomic_bitops.txt
> @@ -58,7 +58,12 @@ Like with atomic_t, the rule of thumb is:
>  
>   - RMW operations that have a return value are fully ordered.
>  
> -Except for test_and_set_bit_lock() which has ACQUIRE semantics and
> + - RMW operations that are conditional are unordered on FAILURE,
> +   otherwise the above rules apply. In the case of test_and_{}_bit() operations,
> +   if the bit in memory is unchanged by the operation then it is deemed to have
> +   failed.
> +
> +Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics and
>  clear_bit_unlock() which has RELEASE semantics.
>  
>  Since a platform only has a single means of achieving atomic operations
> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
> index bc397573c43a..67ab280ad134 100644
> --- a/include/asm-generic/bitops/lock.h
> +++ b/include/asm-generic/bitops/lock.h
> @@ -7,7 +7,8 @@
>   * @nr: Bit to set
>   * @addr: Address to count from
>   *
> - * This operation is atomic and provides acquire barrier semantics.
> + * This operation is atomic and provides acquire barrier semantics if
> + * the returned value is 0.
>   * It can be used to implement bit locks.
>   */
>  #define test_and_set_bit_lock(nr, addr)	test_and_set_bit(nr, addr)
> -- 
> 2.1.4
> 
