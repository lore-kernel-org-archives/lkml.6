Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65008C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335AB20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAQPhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:37:40 -0500
Received: from foss.arm.com ([217.140.101.70]:41990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfAQPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:37:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930611596;
        Thu, 17 Jan 2019 07:37:37 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D0313F694;
        Thu, 17 Jan 2019 07:37:36 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH 1/5] sched/fair: Use for_each_cpu_and for asym-packing nohz kicks
Date:   Thu, 17 Jan 2019 15:34:07 +0000
Message-Id: <20190117153411.2390-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117153411.2390-1-valentin.schneider@arm.com>
References: <20190117153411.2390-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling 'nohz_balance_exit_idle(rq)' will always clear 'rq->cpu' from
'nohz.idle_cpus_mask' if it is set. Since it is called at the top of
'nohz_balancer_kick()', 'rq->cpu' will never be set in
'nohz.idle_cpus_mask' if it is accessed in the rest of the function.

"And" the 'sched_domain_span()' with 'nohz.idle_cpus_mask' and drop the
'(i == cpu)' check since 'rq->cpu' will never be iterated over.

While at it, clean up a condition alignment.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca469646ebe1..380a72e42678 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9557,7 +9557,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		if ((rq->cfs.h_nr_running >= 1) &&
-				check_cpu_capacity(rq, sd)) {
+		    check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9565,11 +9565,7 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
-			if (i == cpu ||
-			    !cpumask_test_cpu(i, nohz.idle_cpus_mask))
-				continue;
-
+		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
 				goto unlock;
-- 
2.20.1

