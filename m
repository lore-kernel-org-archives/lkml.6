Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeBBRau (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:30:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeBBRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:21:59 -0500
Date: Fri, 2 Feb 2018 18:21:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180202172153.GO2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
> It might be interesting to add a tunable for the number of random choices to
> make, and clamp it at the max nr computed from avg_cost in select_idle_cpu.

This needs a fairly complicated PRNG for it would need to visit each
possible CPU once before looping. A LFSR does that, but requires 2^n-1
elements and we have topology masks that don't match that.. The trivial
example is something with 6 cores.

> Or, choose a random starting point and then search for nr sequential 
> candidates; possibly limited by a tunable.

And this is basically what we already do. Except with the task-cpu
instead of a per-cpu rotor.
