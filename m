Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33915C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0822E21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfBKSAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:00:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55126 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbfBKSAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:00:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16940EBD;
        Mon, 11 Feb 2019 10:00:17 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4BFA3F675;
        Mon, 11 Feb 2019 10:00:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH v2 1/3] sched/fair: Comment some nohz_balancer_kick() kick conditions
Date:   Mon, 11 Feb 2019 17:59:44 +0000
Message-Id: <20190211175946.4961-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211175946.4961-1-valentin.schneider@arm.com>
References: <20190211175946.4961-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have a comment explaining the first sched_domain based NOHZ kick,
so might as well comment them all.

While at it, unwrap a line that fits under 80 characters.

Co-authored-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 17fcd15400e1..0f32e9830ec3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9612,8 +9612,12 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
-		if ((rq->cfs.h_nr_running >= 1) &&
-		    check_cpu_capacity(rq, sd)) {
+		/*
+		 * If there's a CFS task and the current CPU has reduced
+		 * capacity; kick the ILB to see if there's a better CPU to run
+		 * on.
+		 */
+		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9621,6 +9625,11 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU
+		 * currently idle; in which case, kick the ILB to move tasks
+		 * around.
+		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
--
2.20.1

