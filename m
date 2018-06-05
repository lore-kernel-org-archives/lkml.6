Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeFEMQ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:16:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeFEMQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:16:26 -0400
Date: Tue, 5 Jun 2018 14:16:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 2/7] atomics/treewide: rework ordering barriers
Message-ID: <20180605121623.GI12258@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529180746.29684-3-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:07:41PM +0100, Mark Rutland wrote:
> +#ifndef __atomic_mb__after_acquire
> +#define __atomic_mb__after_acquire	smp_mb__after_atomic
> +#endif
> +
> +#ifndef __atomic_mb__before_release
> +#define __atomic_mb__before_release	smp_mb__before_atomic
> +#endif
> +
> +#ifndef __atomic_mb__before_fence
> +#define __atomic_mb__before_fence	smp_mb__before_atomic
> +#endif
> +
> +#ifndef __atomic_mb__after_fence
> +#define __atomic_mb__after_fence	smp_mb__after_atomic
> +#endif

I really _really_ dislike those names.. because they imply providing an
MB before/after something else.

But that is exactly what they do not.

How about:

	__atomic_acquire_fence
	__atomic_release_fence

for the acquire/release things, and simply using
smp_mb__{before,after}_atomic for the full fence, its exactly what they
were made for.
