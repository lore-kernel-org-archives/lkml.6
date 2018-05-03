Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeECOwa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:52:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43670 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeECOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:52:27 -0400
Date: Thu, 3 May 2018 16:52:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503145221.GE12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
 <20180420095005.GH4064@hirez.programming.kicks-ass.net>
 <20180424133325.GA3179@codeblueprint.co.uk>
 <1525349542.9956.2.camel@gmx.de>
 <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <20180503143941.GH26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503143941.GH26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 07:39:41AM -0700, Paul E. McKenney wrote:
> Huh.
> 
> No, RCU_NONIDLE() only works for idle, not for offline.

Oh bummer..

> Maybe...  Let me take a look.  There must be some way to mark a
> specific lock acquisition and release as being lockdep-invisible...

But I suspect it flags a real issue. Shutting it up isn't the issue as
such. There could be a concurrent sched domain rebuild while we do this
setup, and if we free that domain while we're looking at it, bad things
happen.

... I wonder what brought this failure to pass now. This code has been
like this a for a long time.
