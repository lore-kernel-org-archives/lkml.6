Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033438AbeE1KV6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033393AbeE1KVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:21:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        dave@stgolabs.net, rostedt@goodmis.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 173/268] sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning
Date: Mon, 28 May 2018 12:02:27 +0200
Message-Id: <20180528100221.993481294@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit d29a20645d5e929aa7e8616f28e5d8e1c49263ec ]

While running rt-tests' pi_stress program I got the following splat:

  rq->clock_update_flags < RQCF_ACT_SKIP
  WARNING: CPU: 27 PID: 0 at kernel/sched/sched.h:960 assert_clock_updated.isra.38.part.39+0x13/0x20

  [...]

  <IRQ>
  enqueue_top_rt_rq+0xf4/0x150
  ? cpufreq_dbs_governor_start+0x170/0x170
  sched_rt_rq_enqueue+0x65/0x80
  sched_rt_period_timer+0x156/0x360
  ? sched_rt_rq_enqueue+0x80/0x80
  __hrtimer_run_queues+0xfa/0x260
  hrtimer_interrupt+0xcb/0x220
  smp_apic_timer_interrupt+0x62/0x120
  apic_timer_interrupt+0xf/0x20
  </IRQ>

  [...]

  do_idle+0x183/0x1e0
  cpu_startup_entry+0x5f/0x70
  start_secondary+0x192/0x1d0
  secondary_startup_64+0xa5/0xb0

We can get rid of it be the "traditional" means of adding an
update_rq_clock() call after acquiring the rq->lock in
do_sched_rt_period_timer().

The case for the RT task throttling (which this workload also hits)
can be ignored in that the skip_update call is actually bogus and
quite the contrary (the request bits are removed/reverted).

By setting RQCF_UPDATED we really don't care if the skip is happening
or not and will therefore make the assert_clock_updated() check happy.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave@stgolabs.net
Cc: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org
Link: http://lkml.kernel.org/r/20180402164954.16255-1-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/rt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -822,6 +822,8 @@ static int do_sched_rt_period_timer(stru
 		struct rq *rq = rq_of_rt_rq(rt_rq);
 
 		raw_spin_lock(&rq->lock);
+		update_rq_clock(rq);
+
 		if (rt_rq->rt_time) {
 			u64 runtime;
 
