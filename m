Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeDTHpY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:45:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeDTHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:45:23 -0400
Date: Fri, 20 Apr 2018 09:44:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] kernel/sched/core: busy wait before going idle
Message-ID: <20180420074456.GA4064@hirez.programming.kicks-ass.net>
References: <20180415133149.24112-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415133149.24112-1-npiggin@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 11:31:49PM +1000, Nicholas Piggin wrote:
> This is a quick hack for comments, but I've always wondered --
> if we have a short term polling idle states in cpuidle for performance
> -- why not skip the context switch and entry into all the idle states,
> and just wait for a bit to see if something wakes up again.

Is that context switch so expensive?

And what kernel did you test on? We recently merged a bunch of patches
from Rafael that avoided disabling the tick for short idle predictions.
This also has a performance improvements for such workloads.  Did your
kernel include those?

> It's not uncommon to see various going-to-idle work in kernel profiles.
> This might be a way to reduce that (and just the cost of switching
> registers and kernel stack to idle thread). This can be an important
> path for single thread request-response throughput.

So I feel that _if_ we do a spin here, it should only be long enough to
amortize the schedule switch context.

However, doing busy waits here has the downside that the 'idle' time is
not in fact fed into the cpuidle predictor.
