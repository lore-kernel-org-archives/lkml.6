Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeDDQx3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:53:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeDDQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:53:27 -0400
Date: Wed, 4 Apr 2018 18:53:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Message-ID: <20180404165310.GJ4082@hirez.programming.kicks-ass.net>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
 <20180403185829.yteixqsb5zazmav6@agluck-desk>
 <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
 <20180404072513.GF4082@hirez.programming.kicks-ass.net>
 <20180404163855.3obxjshmrlppzhdp@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404163855.3obxjshmrlppzhdp@agluck-desk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:38:56AM -0700, Luck, Tony wrote:
> On Wed, Apr 04, 2018 at 09:25:13AM +0200, Peter Zijlstra wrote:
> > Right, I remember being careful with that. Which again brings me to the
> > RANDSTRUCT thing, which will mess that up.
> 
> No RANDSTRUCT config options set for my build.

Weird though, with or without that patch, my ia64-defconfig gives the
below layout.

$ pahole -EC sched_avg ia64-defconfig/kernel/sched/core.o
die__process_function: tag not supported (INVALID)!
struct sched_avg {
        /* typedef u64 */ long long unsigned int     last_update_time;                   /*     0     8 */
        /* typedef u64 */ long long unsigned int     load_sum;                           /*     8     8 */
        /* typedef u64 */ long long unsigned int     runnable_load_sum;                  /*    16     8 */
        /* typedef u32 */ unsigned int               util_sum;                           /*    24     4 */
        /* typedef u32 */ unsigned int               period_contrib;                     /*    28     4 */
        long unsigned int          load_avg;                                             /*    32     8 */
        long unsigned int          runnable_load_avg;                                    /*    40     8 */
        long unsigned int          util_avg;                                             /*    48     8 */
        struct util_est {
                unsigned int       enqueued;                                             /*    56     4 */
                unsigned int       ewma;                                                 /*    60     4 */
        } util_est; /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */

        /* size: 64, cachelines: 1, members: 9 */
};

> > Does the below cure things? It makes absolutely no difference for my
> > x86_64-defconfig build, but it puts more explicit alignment constraints
> > on things.
> 
> Yes. That fixes it. No unaligned traps with this patch applied.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>

Awesome, I'll go get it merged, even though I don't understand where it
went wobbly.
