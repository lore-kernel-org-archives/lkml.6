Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeEKIcx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:32:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEKIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:32:52 -0400
Date: Fri, 11 May 2018 10:32:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        Lai Jiangshan <jiangshanlai@gmail.com>, stefani@seibold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Is read barrier missed in kfifo?
Message-ID: <20180511083242.GJ12217@hirez.programming.kicks-ass.net>
References: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5382d3a8-08e0-5429-0cd3-36f9c69197e1@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:25:18PM +0800, Xiao Guangrong wrote:
> 
> Hi,
> 
> Currently, there is no read barrier between reading the index
> (kfifo.in) and fetching the real data from the fifo.
> 
> I am afraid that will cause the vfifo is observed as not empty
> however the data is not actually ready for read. Right?

That code is decidedly dodgy indeed. I can only see smp_wmb() but no
matching barriers at all -- therefore the code is almost certainly as
good as not having any barriers at all.

I would suggest you try and convert the code to smp_store_release() and
smp_load_acquire() while you're at it.
