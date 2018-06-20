Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA3620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA3620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbeFTJG4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:06:56 -0400
Received: from foss.arm.com ([217.140.101.70]:34018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754813AbeFTJGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE2311682;
        Wed, 20 Jun 2018 02:06:50 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36D893F246;
        Wed, 20 Jun 2018 02:06:49 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv3 7/9] sched: Wrap rq->rd->overload accesses with READ/WRITE_ONCE
Date:   Wed, 20 Jun 2018 10:05:47 +0100
Message-Id: <1529485549-5191-8-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

This variable can be read and set locklessly within update_sd_lb_stats().
As such, READ/WRITE_ONCE are added to make sure nothing terribly wrong
can happen because of the compiler.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 545fa3600894..9dd147c71dd0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8431,8 +8431,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (env->dst_rq->rd->overload != overload)
-			env->dst_rq->rd->overload = overload;
+		if (READ_ONCE(env->dst_rq->rd->overload) != overload)
+			WRITE_ONCE(env->dst_rq->rd->overload, overload);
 	}
 }
 
@@ -9875,7 +9875,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rq_unpin_lock(this_rq, rf);
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	    !READ_ONCE(this_rq->rd->overload)) {
 
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f945edadd2c5..791d9badad31 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1665,8 +1665,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
-		if (!rq->rd->overload)
-			rq->rd->overload = 1;
+		if (!READ_ONCE(rq->rd->overload))
+			WRITE_ONCE(rq->rd->overload, 1);
 #endif
 	}
 
-- 
2.7.4

