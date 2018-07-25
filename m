Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E434FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E5C2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E5C2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeGYPjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:39:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeGYPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:39:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PER1WO402184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:27:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PER11W402181;
        Wed, 25 Jul 2018 07:27:01 -0700
Date:   Wed, 25 Jul 2018 07:27:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-0ee7e74dc0dc64d9900751d03c5c22dfdd173fb8@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com,
        mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
        riel@surriel.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
          hpa@zytor.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, tglx@linutronix.de, riel@surriel.com
In-Reply-To: <1529514181-9842-8-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-8-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Skip nodes that are at 'hoplimit'
Git-Commit-ID: 0ee7e74dc0dc64d9900751d03c5c22dfdd173fb8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0ee7e74dc0dc64d9900751d03c5c22dfdd173fb8
Gitweb:     https://git.kernel.org/tip/0ee7e74dc0dc64d9900751d03c5c22dfdd173fb8
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:48 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:07 +0200

sched/numa: Skip nodes that are at 'hoplimit'

When comparing two nodes at a distance of 'hoplimit', we should consider
nodes only up to 'hoplimit'. Currently we also consider nodes at 'oplimit'
distance too. Hence two nodes at a distance of 'hoplimit' will have same
groupweight. Fix this by skipping nodes at hoplimit.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25375.3     25308.6     -0.26
1     72617       72964       0.477

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     113372      108750      -4.07684
1     177403      183115      3.21979

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      478.45      565.90      515.11       30.87
numa01.sh       Sys:      207.79      271.04      232.94       21.33
numa01.sh      User:    39763.93    47303.12    43210.73     2644.86
numa02.sh      Real:       60.00       61.46       60.78        0.49
numa02.sh       Sys:       15.71       25.31       20.69        3.42
numa02.sh      User:     5175.92     5265.86     5235.97       32.82
numa03.sh      Real:      776.42      834.85      806.01       23.22
numa03.sh       Sys:      114.43      128.75      121.65        5.49
numa03.sh      User:    60773.93    64855.25    62616.91     1576.39
numa04.sh      Real:      456.93      511.95      482.91       20.88
numa04.sh       Sys:      178.09      460.89      356.86       94.58
numa04.sh      User:    36312.09    42553.24    39623.21     2247.96
numa05.sh      Real:      393.98      493.48      436.61       35.59
numa05.sh       Sys:      164.49      329.15      265.87       61.78
numa05.sh      User:    33182.65    36654.53    35074.51     1187.71

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      414.64      819.20      556.08      147.70 	 -7.36%
numa01.sh       Sys:       77.52      205.04      139.40       52.05 	 67.10%
numa01.sh      User:    37043.24    61757.88    45517.48     9290.38 	 -5.06%
numa02.sh      Real:       60.80       63.32       61.63        0.88 	 -1.37%
numa02.sh       Sys:       17.35       39.37       25.71        7.33 	 -19.5%
numa02.sh      User:     5213.79     5374.73     5268.90       55.09 	 -0.62%
numa03.sh      Real:      780.09      948.64      831.43       63.02 	 -3.05%
numa03.sh       Sys:      104.96      136.92      116.31       11.34 	 4.591%
numa03.sh      User:    60465.42    73339.78    64368.03     4700.14 	 -2.72%
numa04.sh      Real:      412.60      681.92      521.29       96.64 	 -7.36%
numa04.sh       Sys:      210.32      314.10      251.77       37.71 	 41.74%
numa04.sh      User:    34026.38    45581.20    38534.49     4198.53 	 2.825%
numa05.sh      Real:      394.79      439.63      411.35       16.87 	 6.140%
numa05.sh       Sys:      238.32      330.09      292.31       38.32 	 -9.04%
numa05.sh      User:    33456.45    34876.07    34138.62      609.45 	 2.741%

While there is a regression with this change, this change is needed from a
correctness perspective. Also it helps consolidation as seen from perf bench
output.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-8-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a10c4f8f47e8..e5f39e8dfe53 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1312,7 +1312,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * of each group. Skip other nodes.
 		 */
 		if (sched_numa_topology_type == NUMA_BACKPLANE &&
-					dist > maxdist)
+					dist >= maxdist)
 			continue;
 
 		/* Add up the faults from nearby nodes. */
