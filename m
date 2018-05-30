Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeE3Ohh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50288 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeE3OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:24 -0400
Message-Id: <20180530143106.291552903@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 08/11] sched/fair: Optimize SIS_FOLD
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-11.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing showed that the per-cpu scanning cost of __select_idle_core()
(~120ns) was significantly higher than that of __select_idle_cpu()
(~40ns).

This means that, even when reduced to the minimal scan, we're still 3x
more expensive than the simple search.

perf annotate suggested this was mostly due to cache-misses on the
additional cpumasks used.

However, we can mitigate this by only doing the more expensive search
when there is a good chance it is beneficial. After all, when there
are no idle cores to be had, there's no point in looking for any
(SMT>2 might want to try without this).

Clearing has_idle_cores early (without an exhaustive search) should be
fine because we're eager to set it when a core goes idle again.

FOLD

1:        0.568188455 seconds time elapsed    ( +-  0.40% )
2:        0.643264625 seconds time elapsed    ( +-  1.27% )
5:        2.385378263 seconds time elapsed    ( +-  1.12% )
10:       3.808555491 seconds time elapsed    ( +-  1.46% )
20:       6.431994272 seconds time elapsed    ( +-  1.21% )
40:       9.423539507 seconds time elapsed    ( +-  2.07% )

FOLD+

1:        0.554694881 seconds time elapsed    ( +-  0.42% )
2:        0.632730119 seconds time elapsed    ( +-  1.84% )
5:        2.230432464 seconds time elapsed    ( +-  1.17% )
10:       3.549957778 seconds time elapsed    ( +-  1.55% )
20:       6.118364255 seconds time elapsed    ( +-  0.72% )
40:       9.515406550 seconds time elapsed    ( +-  1.74% )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |    5 ++++-
 kernel/sched/features.h |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6382,6 +6382,8 @@ static int __select_idle_core(struct tas
 		}
 	}
 
+	set_idle_cores(target, 0);
+
 	return best_cpu;
 }
 
@@ -6477,7 +6479,8 @@ static int select_idle_cpu(struct task_s
 	time = local_clock();
 
 #ifdef CONFIG_SCHED_SMT
-	if (sched_feat(SIS_FOLD) && static_branch_likely(&sched_smt_present))
+	if (sched_feat(SIS_FOLD) && static_branch_likely(&sched_smt_present) &&
+	    test_idle_cores(target, false))
 		cpu = __select_idle_core(p, sd, target, nr, &loops);
 	else
 #endif
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -60,7 +60,7 @@ SCHED_FEAT(SIS_PROP, true)
 
 SCHED_FEAT(SIS_AGE, true)
 SCHED_FEAT(SIS_ONCE, true)
-SCHED_FEAT(SIS_FOLD, false)
+SCHED_FEAT(SIS_FOLD, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
