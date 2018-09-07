Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A42EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4E92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeIGOwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:52:07 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:48840 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbeIGOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:51:57 -0400
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 0E2D61C3306
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 11:11:41 +0100 (IST)
Received: (qmail 19969 invoked from network); 7 Sep 2018 10:11:40 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPA; 7 Sep 2018 10:11:40 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on the basis of an idle CPU
Date:   Fri,  7 Sep 2018 11:11:39 +0100
Message-Id: <20180907101139.20760-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180907101139.20760-1-mgorman@techsingularity.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 305c1fac3225 ("sched/numa: Evaluate move once per node")
restructured how task_numa_compare evaluates load but there is an anomaly.
task_numa_find_cpu() checks if the load balance between too nodes is too
imbalanced with the intent of only swapping tasks if it would improve
the balance overall. However, if an idle CPU is encountered, the task is
still moved if it's the best improvement but an idle cpu is always going
to appear to be the best improvement.

If a machine is lightly loaded such that all tasks can fit on one node then
the idle CPUs are found and the tasks migrate to one socket.  From a NUMA
perspective, this seems intuitively great because memory accesses are all
local but there are two counter-intuitive effects.

First, the load balancer may move tasks so the machine is more evenly
utilised and conflict with automatic NUMA balancing which may respond by
scanning more frequently and increasing overhead.  Second, sockets usually
have their own memory channels so using one socket means that fewer
channels are available yielding less memory bandwidth overall. For
memory-bound tasks, it can be beneficial to migrate to another socket and
migrate the data to increase bandwidth even though the accesses are remote
in the short term.

The second observation is not universally true for all workloads but some
of the computational kernels opf NAS benefit when paralellised with openMP.

NAS C class 2-socket
                         4.19.0-rc1             4.19.0-rc1
                    oneselect-v1r18           nomove-v1r19
Amean     bt       62.26 (   0.00%)       53.03 (  14.83%)
Amean     cg       27.85 (   0.00%)       27.82 (   0.09%)
Amean     ep        8.94 (   0.00%)        8.58 (   4.09%)
Amean     ft       11.89 (   0.00%)       12.00 (  -0.93%)
Amean     is        0.87 (   0.00%)        0.86 (   0.92%)
Amean     lu       41.77 (   0.00%)       38.95 (   6.76%)
Amean     mg        5.30 (   0.00%)        5.26 (   0.64%)
Amean     sp      105.39 (   0.00%)       63.80 (  39.46%)
Amean     ua       47.42 (   0.00%)       43.99 (   7.24%)

Active balancing for NUMA still happens but it greatly reduced. When
running with D class (so it runs longer), the relevant unpatched stats are

           3773.21	Elapsed time in seconds
            489.24	Mops/sec/thread
            38,918      cpu-migrations
         3,817,238      page-faults
            11,197      sched:sched_move_numa
                 0      sched:sched_stick_numa
                23      sched:sched_swap_numa

With the patch applied

           2037.92      Elapsed time in seconds
            905.83      Mops/sec/thread
               147      cpu-migrations
           552,529      page-faults
                26      sched:sched_move_numa
                 0      sched:sched_stick_numa
                16      sched:sched_swap_numa

Note the large drop in CPU migrations, the calls to sched_move_numa and
page faults.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d59d3e00a480..d4c289c11012 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1560,7 +1560,7 @@ static bool task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 	if (!cur) {
-		if (maymove || imp > env->best_imp)
+		if (maymove)
 			goto assign;
 		else
 			goto unlock;
-- 
2.16.4

