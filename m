Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166E20BEC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6166E20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934695AbeGDKTV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:19:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934162AbeGDKS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980AE1529;
        Wed,  4 Jul 2018 03:18:28 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F226A3F5AD;
        Wed,  4 Jul 2018 03:18:26 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 10/12] sched/fair: Don't move tasks to lower capacity cpus unless necessary
Date:   Wed,  4 Jul 2018 11:17:48 +0100
Message-Id: <1530699470-29808-11-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Redpath <chris.redpath@arm.com>

When lower capacity CPUs are load balancing and considering to pull
something from a higher capacity group, we should not pull tasks from a
cpu with only one task running as this is guaranteed to impede progress
for that task. If there is more than one task running, load balance in
the higher capacity group would have already made any possible moves to
resolve imbalance and we should make better use of system compute
capacity by moving a task if we still have more than one running.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Chris Redpath <chris.redpath@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index de84f5a9a65a..06beefa02420 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8793,6 +8793,17 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 		capacity = capacity_of(i);
 
+		/*
+		 * For ASYM_CPUCAPACITY domains, don't pick a cpu that could
+		 * eventually lead to active_balancing high->low capacity.
+		 * Higher per-cpu capacity is considered better than balancing
+		 * average load.
+		 */
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+			capacity_of(env->dst_cpu) < capacity &&
+			rq->nr_running == 1)
+			continue;
+
 		wl = weighted_cpuload(rq);
 
 		/*
-- 
2.7.4

