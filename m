Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965183AbeEXMrN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:47:13 -0400
Received: from foss.arm.com ([217.140.101.70]:43900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964926AbeEXMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:47:12 -0400
Date: Thu, 24 May 2018 13:47:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180524124734.GE8689@arm.com>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
 <20180524124410.GF12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524124410.GF12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 02:44:10PM +0200, Peter Zijlstra wrote:
> On Thu, May 24, 2018 at 11:59:43AM +0100, Will Deacon wrote:
> > +static inline void set_bit(unsigned int nr, volatile unsigned long *p)
> >  {
> > +	p += BIT_WORD(nr);
> > +	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> >  }
> >  
> > +static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
> >  {
> > +	p += BIT_WORD(nr);
> > +	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> >  }
> >  
> > +static inline void change_bit(unsigned int nr, volatile unsigned long *p)
> >  {
> > +	p += BIT_WORD(nr);
> > +	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
> >  }
> 
> Why use the fetch variants here?

I noticed the same thing just now; I'll drop that and just use the
non-value-returning variants. It's shame that I can't do the same for
the lock.h unlock code, but we don't have non-returning release variants.

Will
