Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeCLI46 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:56:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeCLI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:56:57 -0400
Date: Mon, 12 Mar 2018 09:56:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        will.deacon@arm.com, torvalds@linux-foundation.org, npiggin@gmail.com,
        mingo@kernel.org, mpe@ellerman.id.au, oleg@redhat.com,
        benh@kernel.crashing.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: smp_mb__after_spinlock requirement too strong?
Message-ID: <20180312085646.GE4064@hirez.programming.kicks-ass.net>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
 <20180312054412.yqyde34ly3kjoajj@tardis>
 <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
 <20180312085600.aczjkpn73axzs2sb@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312085600.aczjkpn73axzs2sb@tardis>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:56:00PM +0800, Boqun Feng wrote:
> So I think the purpose of smp_mb__after_spinlock() is to provide RCsc
> locks, it's just the comments before that may be misleading. We want
> RCsc locks in schedule code because we want writes in different critical
> section are ordered even outside the critical sections, for case like:
> 
> 	CPU 0		CPU 1		CPU 2
> 
> 	{A =0 , B = 0}
> 	lock(rq0);
> 	write A=1;
> 	unlock(rq0);
> 
> 			lock(rq0);
> 			read A=1;
> 			write B=2;
> 			unlock(rq0);
> 
> 					read B=2;
> 					smp_rmb();
> 					read A=1;
> 
> I think we need to fix the comments rather than loose the requirement.
> Peter?

Yes, ISTR people relying on schedule() being RCsc, and I just picked a
bad exmaple.
