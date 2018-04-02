Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeDBRDQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:03:16 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:50520 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeDBRDN (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 2 Apr 2018 13:03:13 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org
Cc: efault@gmx.de, rostedt@goodmis.org, matt@codeblueprint.co.uk,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning
Date: Mon,  2 Apr 2018 09:49:54 -0700
Message-Id: <20180402164954.16255-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running rt-tests' pi_stress program I got the following splat:

  444.884597] ------------[ cut here ]------------
[  444.894784] rq->clock_update_flags < RQCF_ACT_SKIP
[  444.894798] WARNING: CPU: 27 PID: 0 at kernel/sched/sched.h:960 assert_clock_updated.isra.38.part.39+0x13/0x20
[  444.927419] Modules linked in: ...
[  445.141336] CPU: 27 PID: 0 Comm: swapper/27 Kdump: loaded Tainted: G            E     4.16.0-rc7-next-20180329-13.5-default+ #1
[  445.168197] Hardware name: QCI QSSC-S4R/QSSC-S4R, BIOS QSSC-S4R.QCI.01.00.S013.032920111005 03/29/2011
[  445.188728] RIP: 0010:assert_clock_updated.isra.38.part.39+0x13/0x20
[  445.202739] RSP: 0018:ffff9af37fb03e98 EFLAGS: 00010092
[  445.214258] RAX: 0000000000000026 RBX: ffff9af37faa1bc0 RCX: ffffffffbd064a68
[  445.229994] RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000083
[  445.245732] RBP: 0000000000000017 R08: 00000000000005f1 R09: ffffffffbd864ca0
[  445.261468] R10: 000000003cdf0977 R11: 0000000000000000 R12: ffff9af186178180
[  445.277206] R13: ffffffffbd2396a0 R14: ffff9af37faa1bc0 R15: 0000000000000017
[  445.292944] FS:  0000000000000000(0000) GS:ffff9af37fb00000(0000) knlGS:0000000000000000
[  445.310790] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  445.323457] CR2: 0000556773e17968 CR3: 0000000b3d00a002 CR4: 00000000000206e0
[  445.339193] Call Trace:
[  445.344578]  <IRQ>
[  445.349001]  enqueue_top_rt_rq+0xf4/0x150
[  445.357839]  ? cpufreq_dbs_governor_start+0x170/0x170
[  445.368974]  sched_rt_rq_enqueue+0x65/0x80
[  445.378000]  sched_rt_period_timer+0x156/0x360
[  445.387792]  ? sched_rt_rq_enqueue+0x80/0x80
[  445.397204]  __hrtimer_run_queues+0xfa/0x260
[  445.406614]  hrtimer_interrupt+0xcb/0x220
[  445.415451]  smp_apic_timer_interrupt+0x62/0x120
[  445.425629]  apic_timer_interrupt+0xf/0x20
[  445.434654]  </IRQ>
[  445.439269] RIP: 0010:cpuidle_enter_state+0x9d/0x2b0
[  445.450212] RSP: 0018:ffffac274642fec0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  445.466908] RAX: ffff9af37fb21bc0 RBX: 00000067952f9fb7 RCX: 000000000000001f
[  445.482645] RDX: 00000067952f9fb7 RSI: 00000000389cb571 RDI: 0000000000000000
[  445.498380] RBP: 0000000000000004 R08: 000000000000bc01 R09: 000000000000c04c
[  445.514116] R10: ffffac274642fea0 R11: 0000000000000eed R12: ffffcc273fb10ff0
[  445.529853] R13: ffffffffbd1813b8 R14: 0000000000000000 R15: 00000067923bdc5a
[  445.545595]  do_idle+0x183/0x1e0
[  445.552703]  cpu_startup_entry+0x5f/0x70
[  445.561350]  start_secondary+0x192/0x1d0
[  445.569995]  secondary_startup_64+0xa5/0xb0
[  445.579212] Code: 00 48 0f a3 05 9f 85 17 01 0f 83 74 ff ff ff e9 d4 b6 fe ff 0f 1f 40 00 48 c7 c7 f0 fd e6 bc c6 05 2e 08 14 01 01 e8 cd 2b fc ff <0f> 0b c3 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 83 ea 08
[  445.620864] ---[ end trace 0183b70f54a7f4ba ]---

We can get rid of it be the "traditional" means of adding an update_rq_clock() call
after acquiring the rq->lock in do_sched_rt_period_timer().

The case for the rt task throttling (which this workload also hits) can be ignored in
that the skip_update call is actually bogus and quite the contrary (the request bits
are removed/reverted). By setting RQCF_UPDATED we really don't care if the skip is
happening or not and will therefore make the assert_clock_updated() check happy.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
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
 
-- 
2.13.6
