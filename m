Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeE3OhU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeE3OhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:17 -0400
Message-Id: <20180530143106.133840135@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 05/11] sched/fair: Re-arrange select_idle_cpu()
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-5.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of the next patch, move the actual scanning of the LLC
out of the whole proportional/cost metric stuff, so we can change it
out in a next patch.

Should not actually change anything.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6364,6 +6364,23 @@ static inline int select_idle_smt(struct
 
 #endif /* CONFIG_SCHED_SMT */
 
+static int __select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
+			     int target, int nr, int *ploops)
+{
+	int cpu;
+
+	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+		if ((*ploops)++ >= nr)
+			return -1;
+		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+			continue;
+		if (available_idle_cpu(cpu))
+			break;
+	}
+
+	return cpu;
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6420,16 +6437,7 @@ static int select_idle_cpu(struct task_s
 
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
-		if (loops++ >= nr) {
-			cpu = -1;
-			break;
-		}
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-			continue;
-		if (available_idle_cpu(cpu))
-			break;
-	}
+	cpu = __select_idle_cpu(p, sd, target, nr, &loops);
 
 	time = local_clock() - time;
 
