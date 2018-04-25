Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeDYPgR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:36:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeDYPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:36:15 -0400
Date: Wed, 25 Apr 2018 17:36:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
Message-ID: <20180425153600.GA4043@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
 <20180424125349.GU4082@hirez.programming.kicks-ass.net>
 <d7efc4d3-7c50-752e-a1ae-a164d991dbcc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7efc4d3-7c50-752e-a1ae-a164d991dbcc@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 05:10:34PM -0700, Subhra Mazumdar wrote:
> On 04/24/2018 05:53 AM, Peter Zijlstra wrote:

> > Why do you need to put a max on? Why isn't the proportional thing
> > working as is? (is the average no good because of big variance or what)

> Firstly the choosing of 512 seems arbitrary.

It is; it is a crud attempt to deal with big variance. The comment says
as much.

> Secondly the logic here is that the enqueuing cpu should search up to
> time it can get work itself.  Why is that the optimal amount to
> search?

1/512-th of the time in fact, per the above random number, but yes.
Because searching for longer than we're expecting to be idle for is
clearly bad, at that point we're inhibiting doing useful work.

But while thinking about all this, I think I've spotted a few more
issues, aside from the variance:

Firstly, while avg_idle estimates the average duration for _when_ we go
idle, it doesn't give a good measure when we do not in fact go idle. So
when we get wakeups while fully busy, avg_idle is a poor measure.

Secondly, the number of wakeups performed is also important. If we have
a lot of wakeups, we need to look at aggregate wakeup time over a
period. Not just single wakeup time.

And thirdly, we're sharing the idle duration with newidle balance.

And I think the 512 is a result of me not having recognised these
additional issues when looking at the traces, I saw variance and left it
there.


This leaves me thinking we need a better estimator for wakeups. Because
if there really is significant idle time, not looking for idle CPUs to
run on is bad. Placing that upper limit, especially such a low one, is
just an indication of failure.


I'll see if I can come up with something.
