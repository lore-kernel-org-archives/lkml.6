Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbeDCJXi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:23:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbeDCJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:23:37 -0400
Date: Tue, 3 Apr 2018 11:23:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org,
        cmetcalf@mellanox.com, cl@linux.com, lcapitulino@redhat.com,
        efault@gmx.de, riel@redhat.com, tglx@linutronix.de,
        kernellwp@gmail.com, mingo@kernel.org
Subject: Re: NO_HZ_FULL and tick running within a reasonable amount of time
Message-ID: <20180403092328.GA4082@hirez.programming.kicks-ass.net>
References: <20180402220438.GA15885@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402220438.GA15885@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 03:04:38PM -0700, Paul E. McKenney wrote:

> The WARN_ON_ONCE() triggering is this guy:
> 
> 	delta = rq_clock_task(rq) - curr->se.exec_start;
> 	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> 
> But given that ->se.exec_start is zeroed from time to time, for example,
> in migrate_task_rq_fair(), I am a bit suspicious of this check.
> 
> What am I missing here?

We clear it on migration, but set it when we schedule a task back in.
The above checks that the 'current' task of that CPU had a tick at least
3 seconds ago (to ensure tasks don't go too long without ticks).

The 'current' task is obviously scheduled in and thus must have !0
exec_start time.
