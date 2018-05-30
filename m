Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeE3Ohc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbeE3OhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:25 -0400
Message-Id: <20180530143106.029493355@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 03/11] sched/fair: Only use time once
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-3.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal is to not spend more time scanning for idle CPUs than we're
idle for. Otherwise we're inhibiting work.

This means that we need to consider the cost over all the wakeups
between consequtive idle periods.

Combined AGE+ONCE work better than the old code:

ORIG

1:        0.559639567 seconds time elapsed    ( +-  1.44% )
2:        0.630091207 seconds time elapsed    ( +-  2.93% )
5:        2.329768398 seconds time elapsed    ( +-  1.21% )
10:       3.920248646 seconds time elapsed    ( +-  2.39% )
20:       6.501776759 seconds time elapsed    ( +-  1.02% )
40:      10.482109619 seconds time elapsed    ( +-  2.16% )

AGE+ONCE

1:        0.546238431 seconds time elapsed    ( +-  0.84% )
2:        0.620581405 seconds time elapsed    ( +-  1.26% )
5:        2.161288964 seconds time elapsed    ( +-  1.90% )
10:       3.514636966 seconds time elapsed    ( +-  1.82% )
20:       6.228234657 seconds time elapsed    ( +-  0.67% )
40:       9.755615438 seconds time elapsed    ( +-  2.20% )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   15 +++++++++++++++
 kernel/sched/features.h |    1 +
 2 files changed, 16 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6429,6 +6429,21 @@ static int select_idle_cpu(struct task_s
 	}
 
 	time = local_clock() - time;
+
+	if (sched_feat(SIS_ONCE)) {
+		struct rq *this_rq = this_rq();
+
+		/*
+		 * We need to consider the cost of all wakeups between
+		 * consequtive idle periods. We can only use the predicted
+		 * idle time once.
+		 */
+		if (this_rq->wake_avg > time)
+			this_rq->wake_avg -= time;
+		else
+			this_rq->wake_avg = 0;
+	}
+
 	time = div_u64(time, loops);
 	cost = this_sd->avg_scan_cost;
 	delta = (s64)(time - cost) / 8;
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -59,6 +59,7 @@ SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
 
 SCHED_FEAT(SIS_AGE, true)
+SCHED_FEAT(SIS_ONCE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
