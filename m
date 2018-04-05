Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDELWt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:22:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDELWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:22:48 -0400
Date: Thu, 5 Apr 2018 13:22:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] locking/mutex: Optimize __mutex_trylock_fast
Message-ID: <20180405112243.GN4082@hirez.programming.kicks-ass.net>
References: <20180405093716.GR4043@hirez.programming.kicks-ass.net>
 <20180405095544.GB23485@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405095544.GB23485@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 10:55:45AM +0100, Will Deacon wrote:

> > +#define atomic_long_try_cmpxchg_relaxed(l, old, new) \
> > +	(ATOMIC_LONG_PFX(_try_cmpxchg_relaxed)((ATOMIC_LONG_PFX(_t) *)(l), \
> > +					   (ATOMIC_LONG_TYPE *)(old), (ATOMIC_LONG_TYPE)(new)))
> 
> Are the casts on old and new strictly needed? We don't have them for the
> non-try versions...

It was required for the pointer; it doesn't want to convert (unsigned
long *) into (s64 *) without complaining about it :/
