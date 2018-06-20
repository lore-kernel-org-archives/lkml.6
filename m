Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE190C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804AB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804AB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754855AbeFTJGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:06:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754826AbeFTJGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:06:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB684165C;
        Wed, 20 Jun 2018 02:06:48 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 748B43F246;
        Wed, 20 Jun 2018 02:06:47 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv3 6/9] sched: Change root_domain->overload type to int
Date:   Wed, 20 Jun 2018 10:05:46 +0100
Message-Id: <1529485549-5191-7-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

sizeof(_Bool) is implementation defined, so let's just go with 'int' as
is done for other structures e.g. sched_domain_shared->has_idle_cores.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 7 +++----
 kernel/sched/sched.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b29d53d1e22a..545fa3600894 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8170,7 +8170,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
 			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+			int *overload)
 {
 	unsigned long load;
 	int i, nr_running;
@@ -8195,7 +8195,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
-			*overload = true;
+			*overload = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -8354,8 +8354,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
-	bool overload = false;
+	int load_idx, prefer_sibling, overload = 0;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5ed67122cf59..f945edadd2c5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -689,7 +689,7 @@ struct root_domain {
 	cpumask_var_t		online;
 
 	/* Indicate more than one runnable task for any CPU */
-	bool			overload;
+	int			overload;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -1666,7 +1666,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
 		if (!rq->rd->overload)
-			rq->rd->overload = true;
+			rq->rd->overload = 1;
 #endif
 	}
 
-- 
2.7.4

