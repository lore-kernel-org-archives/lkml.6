Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B88C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B278F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B278F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeGYPiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:38:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbeGYPiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:38:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEPwZ8402112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:25:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEPwLq402109;
        Wed, 25 Jul 2018 07:25:58 -0700
Date:   Wed, 25 Jul 2018 07:25:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-f03bb6760b8e5e2bcecc88d2a2ef41c09adcab39@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, mgorman@techsingularity.net,
        srikar@linux.vnet.ibm.com, peterz@infradead.org, riel@surriel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, riel@surriel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
          mingo@kernel.org
In-Reply-To: <1529514181-9842-6-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-6-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Use task faults only if numa_group is
 not yet set up
Git-Commit-ID: f03bb6760b8e5e2bcecc88d2a2ef41c09adcab39
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

Commit-ID:  f03bb6760b8e5e2bcecc88d2a2ef41c09adcab39
Gitweb:     https://git.kernel.org/tip/f03bb6760b8e5e2bcecc88d2a2ef41c09adcab39
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:46 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:06 +0200

sched/numa: Use task faults only if numa_group is not yet set up

When numa_group faults are available, task_numa_placement only uses
numa_group faults to evaluate preferred node. However it still accounts
task faults and even evaluates the preferred node just based on task
faults just to discard it in favour of preferred node chosen on the
basis of numa_group.

Instead use task faults only if numa_group is not set.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25549.6     25215.7     -1.30
1     73190       72107       -1.47

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     113437      113372      -0.05
1     196130      177403      -9.54

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      506.35      794.46      599.06      104.26
numa01.sh       Sys:      150.37      223.56      195.99       24.94
numa01.sh      User:    43450.69    61752.04    49281.50     6635.33
numa02.sh      Real:       60.33       62.40       61.31        0.90
numa02.sh       Sys:       18.12       31.66       24.28        5.89
numa02.sh      User:     5203.91     5325.32     5260.29       49.98
numa03.sh      Real:      696.47      853.62      745.80       57.28
numa03.sh       Sys:       85.68      123.71       97.89       13.48
numa03.sh      User:    55978.45    66418.63    59254.94     3737.97
numa04.sh      Real:      444.05      514.83      497.06       26.85
numa04.sh       Sys:      230.39      375.79      316.23       48.58
numa04.sh      User:    35403.12    41004.10    39720.80     2163.08
numa05.sh      Real:      423.09      460.41      439.57       13.92
numa05.sh       Sys:      287.38      480.15      369.37       68.52
numa05.sh      User:    34732.12    38016.80    36255.85     1070.51

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      478.45      565.90      515.11       30.87 	 16.29%
numa01.sh       Sys:      207.79      271.04      232.94       21.33 	 -15.8%
numa01.sh      User:    39763.93    47303.12    43210.73     2644.86 	 14.04%
numa02.sh      Real:       60.00       61.46       60.78        0.49 	 0.871%
numa02.sh       Sys:       15.71       25.31       20.69        3.42 	 17.35%
numa02.sh      User:     5175.92     5265.86     5235.97       32.82 	 0.464%
numa03.sh      Real:      776.42      834.85      806.01       23.22 	 -7.47%
numa03.sh       Sys:      114.43      128.75      121.65        5.49 	 -19.5%
numa03.sh      User:    60773.93    64855.25    62616.91     1576.39 	 -5.36%
numa04.sh      Real:      456.93      511.95      482.91       20.88 	 2.930%
numa04.sh       Sys:      178.09      460.89      356.86       94.58 	 -11.3%
numa04.sh      User:    36312.09    42553.24    39623.21     2247.96 	 0.246%
numa05.sh      Real:      393.98      493.48      436.61       35.59 	 0.677%
numa05.sh       Sys:      164.49      329.15      265.87       61.78 	 38.92%
numa05.sh      User:    33182.65    36654.53    35074.51     1187.71 	 3.368%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-6-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0532195c38d0..a10c4f8f47e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2110,8 +2110,8 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 
 static void task_numa_placement(struct task_struct *p)
 {
-	int seq, nid, max_nid = -1, max_group_nid = -1;
-	unsigned long max_faults = 0, max_group_faults = 0;
+	int seq, nid, max_nid = -1;
+	unsigned long max_faults = 0;
 	unsigned long fault_types[2] = { 0, 0 };
 	unsigned long total_faults;
 	u64 runtime, period;
@@ -2190,15 +2190,15 @@ static void task_numa_placement(struct task_struct *p)
 			}
 		}
 
-		if (faults > max_faults) {
-			max_faults = faults;
+		if (!p->numa_group) {
+			if (faults > max_faults) {
+				max_faults = faults;
+				max_nid = nid;
+			}
+		} else if (group_faults > max_faults) {
+			max_faults = group_faults;
 			max_nid = nid;
 		}
-
-		if (group_faults > max_group_faults) {
-			max_group_faults = group_faults;
-			max_group_nid = nid;
-		}
 	}
 
 	update_task_scan_period(p, fault_types[0], fault_types[1]);
@@ -2206,7 +2206,7 @@ static void task_numa_placement(struct task_struct *p)
 	if (p->numa_group) {
 		numa_group_count_active_nodes(p->numa_group);
 		spin_unlock_irq(group_lock);
-		max_nid = preferred_group_nid(p, max_group_nid);
+		max_nid = preferred_group_nid(p, max_nid);
 	}
 
 	if (max_faults) {
