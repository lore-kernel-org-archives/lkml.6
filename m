Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeE3Ohr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:37:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50268 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeE3OhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:37:24 -0400
Message-Id: <20180530143106.186431612@infradead.org>
User-Agent: quilt/0.63-1
Date: Wed, 30 May 2018 16:22:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        umgwanakikbuti@gmail.com, matt@codeblueprint.co.uk, riel@surriel.com,
        peterz@infradead.org
Subject: [RFC 06/11] sched/fair: Make select_idle_cpu() proportional to cores
References: <20180530142236.667774973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sis-again-7.patch
X-Bad-Reply: References but no 'Re:' in Subject.
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calculating how many (logical) CPUs to scan, compute how
many cores to scan.

This changes behaviour for anything !SMT2.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6352,6 +6352,8 @@ static int select_idle_smt(struct task_s
 
 #else /* CONFIG_SCHED_SMT */
 
+#define sched_smt_weight	1
+
 static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
@@ -6381,6 +6383,8 @@ static int __select_idle_cpu(struct task
 	return cpu;
 }
 
+#define sis_min_cores		2
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6429,15 +6433,15 @@ static int select_idle_cpu(struct task_s
 
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > sis_min_cores * avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = sis_min_cores;
 	}
 
 	time = local_clock();
 
-	cpu = __select_idle_cpu(p, sd, target, nr, &loops);
+	cpu = __select_idle_cpu(p, sd, target, nr * sched_smt_weight, &loops);
 
 	time = local_clock() - time;
 
