Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2588C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5BF20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5BF20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeGYPme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:42:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:42:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PETDUx402563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:29:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PETDOZ402560;
        Wed, 25 Jul 2018 07:29:13 -0700
Date:   Wed, 25 Jul 2018 07:29:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-30619c89b17d46808b4cdf5b3f81b6a01ade1473@git.kernel.org>
Cc:     mgorman@techsingularity.net, srikar@linux.vnet.ibm.com,
        peterz@infradead.org, mingo@kernel.org, riel@surriel.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: srikar@linux.vnet.ibm.com, mingo@kernel.org,
          peterz@infradead.org, mgorman@techsingularity.net,
          riel@surriel.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1529514181-9842-15-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-15-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Update the scan period without holding
 the numa_group lock
Git-Commit-ID: 30619c89b17d46808b4cdf5b3f81b6a01ade1473
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

Commit-ID:  30619c89b17d46808b4cdf5b3f81b6a01ade1473
Gitweb:     https://git.kernel.org/tip/30619c89b17d46808b4cdf5b3f81b6a01ade1473
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:55 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:08 +0200

sched/numa: Update the scan period without holding the numa_group lock

The metrics for updating scan periods are local or task specific.
Currently this update happens under the numa_group lock, which seems
unnecessary. Hence move this update outside the lock.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25355.9     25645.4     1.141
1     72812       72142       -0.92

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-15-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bcf0e864613..fc33a4b40a09 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2170,8 +2170,6 @@ static void task_numa_placement(struct task_struct *p)
 		}
 	}
 
-	update_task_scan_period(p, fault_types[0], fault_types[1]);
-
 	if (p->numa_group) {
 		numa_group_count_active_nodes(p->numa_group);
 		spin_unlock_irq(group_lock);
@@ -2186,6 +2184,8 @@ static void task_numa_placement(struct task_struct *p)
 		if (task_node(p) != p->numa_preferred_nid)
 			numa_migrate_preferred(p);
 	}
+
+	update_task_scan_period(p, fault_types[0], fault_types[1]);
 }
 
 static inline int get_numa_group(struct numa_group *grp)
