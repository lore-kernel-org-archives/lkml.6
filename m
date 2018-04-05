Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeDEJRh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:17:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeDEJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:17:35 -0400
Date: Thu, 5 Apr 2018 02:16:58 -0700
From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-d29a20645d5e929aa7e8616f28e5d8e1c49263ec@git.kernel.org>
Cc: matt@codeblueprint.co.uk, dbueso@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, efault@gmx.de, dave@stgolabs.net,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: efault@gmx.de, dave@stgolabs.net, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, dbueso@suse.de,
        matt@codeblueprint.co.uk, peterz@infradead.org,
        torvalds@linux-foundation.org
In-Reply-To: <20180402164954.16255-1-dave@stgolabs.net>
References: <20180402164954.16255-1-dave@stgolabs.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt: Fix rq->clock_update_flags <
 RQCF_ACT_SKIP warning
Git-Commit-ID: d29a20645d5e929aa7e8616f28e5d8e1c49263ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d29a20645d5e929aa7e8616f28e5d8e1c49263ec
Gitweb:     https://git.kernel.org/tip/d29a20645d5e929aa7e8616f28e5d8e1c49263ec
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Mon, 2 Apr 2018 09:49:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 09:20:46 +0200

sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

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
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 86b77987435e..ad13e6242481 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -839,6 +839,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 			continue;
 
 		raw_spin_lock(&rq->lock);
+		update_rq_clock(rq);
+
 		if (rt_rq->rt_time) {
 			u64 runtime;
 
