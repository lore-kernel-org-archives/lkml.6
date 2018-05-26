Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032123AbeEZPsJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:48:09 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:41983 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031908AbeEZPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:48:07 -0400
From: Paul Burton <paul.burton@mips.com>
To: <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 2/2] sched: Warn if we fail to migrate a task
Date: Sat, 26 May 2018 08:46:48 -0700
Message-ID: <20180526154648.11635-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180526154648.11635-1-paul.burton@mips.com>
References: <20180526154648.11635-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1527349614-321459-6793-23952-3
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193394
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__set_cpus_allowed_ptr() makes use of stop_one_cpu() to call
migration_cpu_stop() in order to perform migration of a task away from
the CPU it's currently running on. If all is as expected then this
shouldn't fail, but as the preceding patch shows it's possible for this
assumption to be broken fairly subtly.

Add a warning to ensure that if stop_one_cpu() returns an error
(-ENOENT is the only one it can currently return) then we warn about it
in the kernel log, since this isn't expected to happen.

I considered propogating the error upwards, but this would require a
change to the return values allowed from the sched_setaffinity() syscall
and would require that user programs handle errors other than those
caused by their own bad input to the syscall. So for now this patch
simply warns, which is an improvement over the silent error & incorrect
scheduling we had before.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org

---

 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2380bc228dd0..cda3affd45b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1127,7 +1127,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		struct migration_arg arg = { p, dest_cpu };
 		/* Need help from migration thread: drop lock and wait. */
 		task_rq_unlock(rq, p, &rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+		ret = stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+		WARN_ON(ret);
 		tlb_migrate_finish(p->mm);
 		return 0;
 	} else if (task_on_rq_queued(p)) {
-- 
2.17.0
