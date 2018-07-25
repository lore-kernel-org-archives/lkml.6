Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF6FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3FF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3FF2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeGYPmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:42:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:42:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEUI3e402800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:30:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEUIWQ402797;
        Wed, 25 Jul 2018 07:30:18 -0700
Date:   Wed, 25 Jul 2018 07:30:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-b6a60cf36d497e7fbde9dd5b86fabd96850249f6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, tglx@linutronix.de, riel@surriel.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        peterz@infradead.org, srikar@linux.vnet.ibm.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de,
          riel@surriel.com, linux-kernel@vger.kernel.org,
          srikar@linux.vnet.ibm.com, peterz@infradead.org,
          mgorman@techsingularity.net, mingo@kernel.org
In-Reply-To: <1529514181-9842-20-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-20-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Move task_numa_placement() closer to
 numa_migrate_preferred()
Git-Commit-ID: b6a60cf36d497e7fbde9dd5b86fabd96850249f6
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

Commit-ID:  b6a60cf36d497e7fbde9dd5b86fabd96850249f6
Gitweb:     https://git.kernel.org/tip/b6a60cf36d497e7fbde9dd5b86fabd96850249f6
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:33:00 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:08 +0200

sched/numa: Move task_numa_placement() closer to numa_migrate_preferred()

numa_migrate_preferred() is called periodically or when task preferred
node changes. Preferred node evaluations happen once per scan sequence.

If the scan completion happens just after the periodic NUMA migration,
then we try to migrate to the preferred node and the preferred node might
change, needing another node migration.

Avoid this by checking for scan sequence completion only when checking
for periodic migration.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25862.6     26158.1     1.14258
1     74357       72725       -2.19482

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     117019      113992      -2.58
1     179095      174947      -2.31

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      449.46      770.77      615.22      101.70
numa01.sh       Sys:      132.72      208.17      170.46       24.96
numa01.sh      User:    39185.26    60290.89    50066.76     6807.84
numa02.sh      Real:       60.85       61.79       61.28        0.37
numa02.sh       Sys:       15.34       24.71       21.08        3.61
numa02.sh      User:     5204.41     5249.85     5231.21       17.60
numa03.sh      Real:      785.50      916.97      840.77       44.98
numa03.sh       Sys:      108.08      133.60      119.43        8.82
numa03.sh      User:    61422.86    70919.75    64720.87     3310.61
numa04.sh      Real:      429.57      587.37      480.80       57.40
numa04.sh       Sys:      240.61      321.97      290.84       33.58
numa04.sh      User:    34597.65    40498.99    37079.48     2060.72
numa05.sh      Real:      392.09      431.25      414.65       13.82
numa05.sh       Sys:      229.41      372.48      297.54       53.14
numa05.sh      User:    33390.86    34697.49    34222.43      556.42

Testcase       Time:         Min         Max         Avg      StdDev 	%Change
numa01.sh      Real:      424.63      566.18      498.12       59.26 	 23.50%
numa01.sh       Sys:      160.19      256.53      208.98       37.02 	 -18.4%
numa01.sh      User:    37320.00    46225.58    42001.57     3482.45 	 19.20%
numa02.sh      Real:       60.17       62.47       60.91        0.85 	 0.607%
numa02.sh       Sys:       15.30       22.82       17.04        2.90 	 23.70%
numa02.sh      User:     5202.13     5255.51     5219.08       20.14 	 0.232%
numa03.sh      Real:      823.91      844.89      833.86        8.46 	 0.828%
numa03.sh       Sys:      130.69      148.29      140.47        6.21 	 -14.9%
numa03.sh      User:    62519.15    64262.20    63613.38      620.05 	 1.740%
numa04.sh      Real:      515.30      603.74      548.56       30.93 	 -12.3%
numa04.sh       Sys:      459.73      525.48      489.18       21.63 	 -40.5%
numa04.sh      User:    40561.96    44919.18    42047.87     1526.85 	 -11.8%
numa05.sh      Real:      396.58      454.37      421.13       19.71 	 -1.53%
numa05.sh       Sys:      208.72      422.02      348.90       73.60 	 -14.7%
numa05.sh      User:    33124.08    36109.35    34846.47     1089.74 	 -1.79%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-20-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9c9e54ea65d9..309c93fcc604 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2180,9 +2180,6 @@ static void task_numa_placement(struct task_struct *p)
 		/* Set the new preferred node */
 		if (max_nid != p->numa_preferred_nid)
 			sched_setnuma(p, max_nid);
-
-		if (task_node(p) != p->numa_preferred_nid)
-			numa_migrate_preferred(p);
 	}
 
 	update_task_scan_period(p, fault_types[0], fault_types[1]);
@@ -2385,14 +2382,14 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 				numa_is_active_node(mem_node, ng))
 		local = 1;
 
-	task_numa_placement(p);
-
 	/*
 	 * Retry task to preferred node migration periodically, in case it
 	 * case it previously failed, or the scheduler moved us.
 	 */
-	if (time_after(jiffies, p->numa_migrate_retry))
+	if (time_after(jiffies, p->numa_migrate_retry)) {
+		task_numa_placement(p);
 		numa_migrate_preferred(p);
+	}
 
 	if (migrated)
 		p->numa_pages_migrated += pages;
