Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D34C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEF920861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEF920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeIGOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:51:56 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:33312 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbeIGOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:51:56 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 8ECD31C326E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 11:11:40 +0100 (IST)
Received: (qmail 19910 invoked from network); 7 Sep 2018 10:11:40 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPA; 7 Sep 2018 10:11:40 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/4] sched/numa: Remove redundant numa_stats nr_running field
Date:   Fri,  7 Sep 2018 11:11:36 +0100
Message-Id: <20180907101139.20760-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180907101139.20760-1-mgorman@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nr_running field has not been used since commit 2d4056fafa19
("sched/numa: Remove numa_has_capacity()") so remove it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..2472aeaff92e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1454,8 +1454,6 @@ struct numa_stats {
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
-
-	unsigned int nr_running;
 };
 
 /*
@@ -1470,7 +1468,6 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
-		ns->nr_running += rq->nr_running;
 		ns->load += weighted_cpuload(rq);
 		ns->compute_capacity += capacity_of(cpu);
 
-- 
2.16.4

