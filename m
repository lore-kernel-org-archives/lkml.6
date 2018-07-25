Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A6BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0252088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0252088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeGYPfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:35:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44929 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:35:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PENFqk400317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:23:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PENFab400314;
        Wed, 25 Jul 2018 07:23:15 -0700
Date:   Wed, 25 Jul 2018 07:23:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yun Wang <tipbot@zytor.com>
Message-ID: <tip-3d6c50c27bd6418dceb51642540ecfcb8ca708c2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, yun.wang@linux.alibaba.com,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, yun.wang@linux.alibaba.com,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
References: <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Show the sum wait time of a task
 group
Git-Commit-ID: 3d6c50c27bd6418dceb51642540ecfcb8ca708c2
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

Commit-ID:  3d6c50c27bd6418dceb51642540ecfcb8ca708c2
Gitweb:     https://git.kernel.org/tip/3d6c50c27bd6418dceb51642540ecfcb8ca708c2
Author:     Yun Wang <yun.wang@linux.alibaba.com>
AuthorDate: Wed, 4 Jul 2018 11:27:27 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:05 +0200

sched/debug: Show the sum wait time of a task group

Although we can rely on cpuacct to present the CPU usage of task
groups, it is hard to tell how intense the competition is between
these groups on CPU resources.

Monitoring the wait time or sched_debug of each process could be
very expensive, and there is no good way to accurately represent the
conflict with these info, we need the wait time on group dimension.

Thus we introduce group's wait_sum to represent the resource conflict
between task groups, which is simply the sum of the wait time of
the group's cfs_rq.

The 'cpu.stat' is modified to show the statistic, like:

   nr_periods 0
   nr_throttled 0
   throttled_time 0
   wait_sum 2035098795584

Now we can monitor the changes of wait_sum to tell how much a
a task group is suffering in the fight of CPU resources.

For example:

   (wait_sum - last_wait_sum) * 100 / (nr_cpu * period_ns) == X%

means the task group paid X percentage of period on waiting
for the CPU.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc177c06e490..2bc391a574e6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6748,6 +6748,16 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
 
+	if (schedstat_enabled() && tg != &root_task_group) {
+		u64 ws = 0;
+		int i;
+
+		for_each_possible_cpu(i)
+			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+
+		seq_printf(sf, "wait_sum %llu\n", ws);
+	}
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
