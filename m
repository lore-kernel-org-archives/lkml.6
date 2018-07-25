Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0617520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0617520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeGYPhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:37:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:37:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEPP41402072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:25:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEPPXC402069;
        Wed, 25 Jul 2018 07:25:25 -0700
Date:   Wed, 25 Jul 2018 07:25:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-8cd45eee43bd46b933158b25aa7c742e0f3e811f@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, riel@surriel.com,
        torvalds@linux-foundation.org, srikar@linux.vnet.ibm.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          torvalds@linux-foundation.org, srikar@linux.vnet.ibm.com,
          mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net
In-Reply-To: <1529514181-9842-5-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-5-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Set preferred_node based on best_cpu
Git-Commit-ID: 8cd45eee43bd46b933158b25aa7c742e0f3e811f
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

Commit-ID:  8cd45eee43bd46b933158b25aa7c742e0f3e811f
Gitweb:     https://git.kernel.org/tip/8cd45eee43bd46b933158b25aa7c742e0f3e811f
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:45 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:06 +0200

sched/numa: Set preferred_node based on best_cpu

Currently preferred node is set to dst_nid which is the last node in the
iteration whose group weight or task weight is greater than the current
node. However it doesn't guarantee that dst_nid has the numa capacity
to move. It also doesn't guarantee that dst_nid has the best_cpu which
is the CPU/node ideal for node migration.

Lets consider faults on a 4 node system with group weight numbers
in different nodes being in 0 < 1 < 2 < 3 proportion. Consider the task
is running on 3 and 0 is its preferred node but its capacity is full.
Consider nodes 1, 2 and 3 have capacity. Then the task should be
migrated to node 1. Currently the task gets moved to node 2. env.dst_nid
points to the last node whose faults were greater than current node.

Modify to set the preferred node based of best_cpu. Earlier setting
preferred node was skipped if nr_active_nodes is 1. This could result in
the task being moved out of the preferred node to a random node during
regular load balancing.

Also while modifying task_numa_migrate(), use sched_setnuma to set
preferred node. This ensures out numa accounting is correct.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25122.9     25549.6     1.698
1     73850       73190       -0.89

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     105930      113437      7.08676
1     178624      196130      9.80047

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      435.78      653.81      534.58       83.20
numa01.sh       Sys:      121.93      187.18      145.90       23.47
numa01.sh      User:    37082.81    51402.80    43647.60     5409.75
numa02.sh      Real:       60.64       61.63       61.19        0.40
numa02.sh       Sys:       14.72       25.68       19.06        4.03
numa02.sh      User:     5210.95     5266.69     5233.30       20.82
numa03.sh      Real:      746.51      808.24      780.36       23.88
numa03.sh       Sys:       97.26      108.48      105.07        4.28
numa03.sh      User:    58956.30    61397.05    60162.95     1050.82
numa04.sh      Real:      465.97      519.27      484.81       19.62
numa04.sh       Sys:      304.43      359.08      334.68       20.64
numa04.sh      User:    37544.16    41186.15    39262.44     1314.91
numa05.sh      Real:      411.57      457.20      433.29       16.58
numa05.sh       Sys:      230.05      435.48      339.95       67.58
numa05.sh      User:    33325.54    36896.31    35637.84     1222.64

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      506.35      794.46      599.06      104.26 	 -10.76%
numa01.sh       Sys:      150.37      223.56      195.99       24.94 	 -25.55%
numa01.sh      User:    43450.69    61752.04    49281.50     6635.33 	 -11.43%
numa02.sh      Real:       60.33       62.40       61.31        0.90 	 -0.195%
numa02.sh       Sys:       18.12       31.66       24.28        5.89 	 -21.49%
numa02.sh      User:     5203.91     5325.32     5260.29       49.98 	 -0.513%
numa03.sh      Real:      696.47      853.62      745.80       57.28 	 4.6339%
numa03.sh       Sys:       85.68      123.71       97.89       13.48 	 7.3347%
numa03.sh      User:    55978.45    66418.63    59254.94     3737.97 	 1.5323%
numa04.sh      Real:      444.05      514.83      497.06       26.85 	 -2.464%
numa04.sh       Sys:      230.39      375.79      316.23       48.58 	 5.8343%
numa04.sh      User:    35403.12    41004.10    39720.80     2163.08 	 -1.153%
numa05.sh      Real:      423.09      460.41      439.57       13.92 	 -1.428%
numa05.sh       Sys:      287.38      480.15      369.37       68.52 	 -7.964%
numa05.sh      User:    34732.12    38016.80    36255.85     1070.51 	 -1.704%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-5-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 226837960ec0..0532195c38d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1765,7 +1765,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 * elsewhere, so there is no point in (re)trying.
 	 */
 	if (unlikely(!sd)) {
-		p->numa_preferred_nid = task_node(p);
+		sched_setnuma(p, task_node(p));
 		return -EINVAL;
 	}
 
@@ -1824,15 +1824,13 @@ static int task_numa_migrate(struct task_struct *p)
 	 * trying for a better one later. Do not set the preferred node here.
 	 */
 	if (p->numa_group) {
-		struct numa_group *ng = p->numa_group;
-
 		if (env.best_cpu == -1)
 			nid = env.src_nid;
 		else
-			nid = env.dst_nid;
+			nid = cpu_to_node(env.best_cpu);
 
-		if (ng->active_nodes > 1 && numa_is_active_node(env.dst_nid, ng))
-			sched_setnuma(p, env.dst_nid);
+		if (nid != p->numa_preferred_nid)
+			sched_setnuma(p, nid);
 	}
 
 	/* No better CPU than the current one was found. */
