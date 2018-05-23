Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932991AbeEWMzy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:55:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbeEWMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:55:52 -0400
Date: Wed, 23 May 2018 14:55:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH 3/8] md: raid5: use refcount_t for reference counting
 instead atomic_t
Message-ID: <20180523125542.GT12198@hirez.programming.kicks-ass.net>
References: <20180509193645.830-1-bigeasy@linutronix.de>
 <20180509193645.830-4-bigeasy@linutronix.de>
 <20180523123615.GY12217@hirez.programming.kicks-ass.net>
 <20180523125007.pbxcxef622cde3jz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523125007.pbxcxef622cde3jz@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 02:50:07PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-23 14:36:15 [+0200], Peter Zijlstra wrote:
> > > Most changes are 1:1 replacements except for
> > > 	BUG_ON(atomic_inc_return(&sh->count) != 1);
> > 
> > That doesn't look right, 'inc_return == 1' implies inc-from-zero, which
> > is not allowed by refcount.
> > 
> > > which has been turned into
> > >         refcount_inc(&sh->count);
> > >         BUG_ON(refcount_read(&sh->count) != 1);
> > 
> > And that is racy, you can have additional increments in between.
> 
> so do we stay with the atomic* API here or do we extend refcount* API?

Stay with the atomic; I'll look at the rest of these patches, but raid5
looks like a usage-count, not a reference count.

I'll probably ack your initial set and parts of this.. but let me get to
the end of this first.
