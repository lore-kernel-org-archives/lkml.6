Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEAHLU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 03:11:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeEAHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 03:11:19 -0400
Date: Tue, 1 May 2018 09:11:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: make CFS bandwidth slice per cpu group
Message-ID: <20180501071112.GD12217@hirez.programming.kicks-ass.net>
References: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
 <20180430194251.GB12217@hirez.programming.kicks-ass.net>
 <CAM_iQpXPNKyCGzY3=9HaQYXCXx3hsU3a_6BsFM+6Hw--v5QZUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXPNKyCGzY3=9HaQYXCXx3hsU3a_6BsFM+6Hw--v5QZUQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 01:37:16PM -0700, Cong Wang wrote:
> On Mon, Apr 30, 2018 at 12:42 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Apr 30, 2018 at 12:29:25PM -0700, Cong Wang wrote:
> >> Currently, the sched_cfs_bandwidth_slice_us is a global setting which
> >> affects all cgroups. Different groups may want different values based
> >> on their own workload, one size doesn't fit all. The global pool filled
> >> periodically is per cgroup too, they should have the right to distribute
> >> their own quota to each local CPU with their own frequency.
> >
> > Why.. what happens? This doesn't really tell us anything.
> 
> We saw tasks in a container got throttled for many times even
> when they don't apparently over-burn the CPU's. I tried to reduce
> the sched_cfs_bandwidth_slice_us from the default 5ms to 1ms,
> it solved the problem as no tasks got throttled after this change.
> This is why I want to change it.

The 1ms slice distributes time better at the cost of higher overhead,
right?

> And I don't think 1ms will be good for all containers, so in order to
> minimize the impact, I would like to keep the slice change within
> each container. This is why I propose this patch rather just
> `sysctl  -w`. Do you think otherwise?

Well, I think I don't quite remember everything and a Changelog that
tells me why you want stuff in a little more detail and helps me
remember some things is a lot more useful than me having to go dig
through the code myself (which I'll invariably postpone because I'm a
busy sort of person).

> BTW, people reported a similar (if not same) issue here before:
> https://gist.github.com/bobrik/2030ff040fad360327a5fab7a09c4ff1

That's not a report, that's a random person on the interweb posting
random crap. A report lands in my inbox.
