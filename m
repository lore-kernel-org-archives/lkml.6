Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeEDQif (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:38:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:38:33 -0400
Date: Fri, 4 May 2018 18:38:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: Introduce atomic_dec_and_lock_irqsave()
Message-ID: <20180504163826.GR12217@hirez.programming.kicks-ass.net>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180504155446.GP12217@hirez.programming.kicks-ass.net>
 <20180504160726.ikotgmd5fbix7b6b@linutronix.de>
 <20180504162102.GQ12217@hirez.programming.kicks-ass.net>
 <20180504162640.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504162640.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:26:40PM +0100, Al Viro wrote:
> On Fri, May 04, 2018 at 06:21:02PM +0200, Peter Zijlstra wrote:
> > On Fri, May 04, 2018 at 06:07:26PM +0200, Sebastian Andrzej Siewior wrote:
> > 
> > > do you intend to kill refcount_dec_and_lock() in the longterm?
> > 
> > You meant to say atomic_dec_and_lock() ? Dunno if we ever get there, but
> > typically dec_and_lock is fairly refcounty, but I suppose it is possible
> > to have !refcount users, in which case we're eternally stuck with it.
> 
> Yes, there are - consider e.g.
> 
> void iput(struct inode *inode)
> { 
>         if (!inode)
>                 return;
>         BUG_ON(inode->i_state & I_CLEAR);
> retry:
>         if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> 
> inode->i_count sure as hell isn't refcount_t fodder...

Yeah, I should've remembered, I tried to convert that once ;-) i_count is
a usage count, not a refcount.
