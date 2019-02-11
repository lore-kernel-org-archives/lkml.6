Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69727C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4572221B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfBKSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:00:25 -0500
Received: from foss.arm.com ([217.140.101.70]:55154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbfBKSAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:00:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D58EBD;
        Mon, 11 Feb 2019 10:00:22 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A74733F675;
        Mon, 11 Feb 2019 10:00:20 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH v2 3/3] sched/fair: Skip LLC nohz logic for asymmetric systems
Date:   Mon, 11 Feb 2019 17:59:46 +0000
Message-Id: <20190211175946.4961-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211175946.4961-1-valentin.schneider@arm.com>
References: <20190211175946.4961-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLC nohz condition will become true as soon as >=2 CPUs in a
single LLC domain are busy. On big.LITTLE systems, this translates to
two or more CPUs of a "cluster" (big or LITTLE) being busy.

Issuing a nohz kick in these conditions isn't desired for asymmetric
systems, as if the busy CPUs can provide enough compute capacity to
the running tasks, then we can leave the nohz CPUs in peace.

Skip the LLC nohz condition for asymmetric systems, and rely on
nr_running & capacity checks to trigger nohz kicks when the system
actually needs them.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 65 ++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f9f11e140ba3..a34e1610e21a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9603,24 +9603,6 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 	}
 
 	rcu_read_lock();
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds) {
-		/*
-		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
-		 * domain to pull some load. Likewise, we may need to spread
-		 * load within the current LLC domain (e.g. packed SMT cores but
-		 * other CPUs are idle). We can't really know from here how busy
-		 * the others are - so just get a nohz balance going if it looks
-		 * like this LLC domain has tasks we could move.
-		 */
-		nr_busy = atomic_read(&sds->nr_busy_cpus);
-		if (nr_busy > 1) {
-			flags = NOHZ_KICK_MASK;
-			goto unlock;
-		}
-
-	}
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
@@ -9635,6 +9617,21 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
+	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU
+		 * currently idle; in which case, kick the ILB to move tasks
+		 * around.
+		 */
+		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
+			if (sched_asym_prefer(i, cpu)) {
+				flags = NOHZ_KICK_MASK;
+				goto unlock;
+			}
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
@@ -9645,20 +9642,32 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
+
+		/*
+		 * For asymmetric systems, we do not want to nicely balance
+		 * cache use, instead we want to embrace asymmetry and only
+		 * ensure tasks have enough CPU capacity.
+		 *
+		 * Skip the LLC logic because it's not relevant in that case.
+		 */
+		goto unlock;
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
-	if (sd) {
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
 		/*
-		 * When ASYM_PACKING; see if there's a more preferred CPU
-		 * currently idle; in which case, kick the ILB to move tasks
-		 * around.
+		 * If there is an imbalance between LLC domains (IOW we could
+		 * increase the overall cache use), we need some less-loaded LLC
+		 * domain to pull some load. Likewise, we may need to spread
+		 * load within the current LLC domain (e.g. packed SMT cores but
+		 * other CPUs are idle). We can't really know from here how busy
+		 * the others are - so just get a nohz balance going if it looks
+		 * like this LLC domain has tasks we could move.
 		 */
-		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym_prefer(i, cpu)) {
-				flags = NOHZ_KICK_MASK;
-				goto unlock;
-			}
+		nr_busy = atomic_read(&sds->nr_busy_cpus);
+		if (nr_busy > 1) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
 		}
 	}
 unlock:
-- 
2.20.1

