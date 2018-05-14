Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeENG6J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 02:58:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbeENG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 02:58:02 -0400
Date: Mon, 14 May 2018 08:57:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, rostedt@goodmis.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, stefani@seibold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Is read barrier missed in kfifo?
Message-ID: <20180514065755.GM12217@hirez.programming.kicks-ass.net>
References: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
 <20180511083242.GJ12217@hirez.programming.kicks-ass.net>
 <20180511162053.GY26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511162053.GY26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 09:20:53AM -0700, Paul E. McKenney wrote:
> On Fri, May 11, 2018 at 10:32:42AM +0200, Peter Zijlstra wrote:
> > On Fri, May 11, 2018 at 03:25:18PM +0800, Xiao Guangrong wrote:
> > > 
> > > Hi,
> > > 
> > > Currently, there is no read barrier between reading the index
> > > (kfifo.in) and fetching the real data from the fifo.
> > > 
> > > I am afraid that will cause the vfifo is observed as not empty
> > > however the data is not actually ready for read. Right?
> > 
> > That code is decidedly dodgy indeed. I can only see smp_wmb() but no
> > matching barriers at all -- therefore the code is almost certainly as
> > good as not having any barriers at all.
> > 
> > I would suggest you try and convert the code to smp_store_release() and
> > smp_load_acquire() while you're at it.
> 
> Isn't this one of the places where we rely on control dependencies?

Then it bloody well should have a comment. But at least one side of the
fifo needs a read barrier I think. We can rely on a ctrl-dep on the
write side, where we read the head/tail values, compute space and then
conditionally allow writes to happen.

But on the read side it's all reads and ctrl-dep doesn't help anything.
