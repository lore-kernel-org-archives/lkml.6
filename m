Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAB7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D2120861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D2120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIGOv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:51:57 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:52878 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbeIGOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:51:56 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id B47C61C327E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 11:11:40 +0100 (IST)
Received: (qmail 19933 invoked from network); 7 Sep 2018 10:11:40 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPA; 7 Sep 2018 10:11:40 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched/numa: Remove unused calculations in update_numa_stats
Date:   Fri,  7 Sep 2018 11:11:37 +0100
Message-Id: <20180907101139.20760-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180907101139.20760-1-mgorman@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2d4056fafa19 ("sched/numa: Remove numa_has_capacity()") removed
the the has_free_capacity field but did not remove calculations
related to it in update_numa_stats. This patch removes the unused
code.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2472aeaff92e..5b2f1684e96e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1461,8 +1461,7 @@ struct numa_stats {
  */
 static void update_numa_stats(struct numa_stats *ns, int nid)
 {
-	int smt, cpu, cpus = 0;
-	unsigned long capacity;
+	int cpu;
 
 	memset(ns, 0, sizeof(*ns));
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
@@ -1470,26 +1469,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 
 		ns->load += weighted_cpuload(rq);
 		ns->compute_capacity += capacity_of(cpu);
-
-		cpus++;
 	}
-
-	/*
-	 * If we raced with hotplug and there are no CPUs left in our mask
-	 * the @ns structure is NULL'ed and task_numa_compare() will
-	 * not find this node attractive.
-	 *
-	 * We'll detect a huge imbalance and bail there.
-	 */
-	if (!cpus)
-		return;
-
-	/* smt := ceil(cpus / capacity), assumes: 1 < smt_power < 2 */
-	smt = DIV_ROUND_UP(SCHED_CAPACITY_SCALE * cpus, ns->compute_capacity);
-	capacity = cpus / smt; /* cores */
-
-	capacity = min_t(unsigned, capacity,
-		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
 }
 
 struct task_numa_env {
-- 
2.16.4

