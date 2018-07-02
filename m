Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52924FAC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B52924FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeGBH37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:29:59 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60196 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753354AbeGBH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:29:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T3mQfo7_1530516579;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0T3mQfo7_1530516579)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Jul 2018 15:29:40 +0800
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [RFC PATCH] tg: count the sum wait time of an task group
Message-ID: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
Date:   Mon, 2 Jul 2018 15:29:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we can rely on cpuacct to present the cpu usage of task
group, it is hard to tell how intense the competition is between
these groups on cpu resources.

Monitoring the wait time of each process could cost too much, and
there is no good way to accurately represent the conflict with
these info, we need the wait time on group dimension.

Thus we introduced group's wait_sum provided by kernel to represent
the conflict between task groups, whenever a group's cfs_rq ends
waiting, it's wait time accounted to the sum.

The cpu.stat is modified to show the new statistic, like:

   nr_periods 0
   nr_throttled 0
   throttled_time 0
   wait_sum 2035098795584

Now we can monitor the changing on wait_sum to tell how suffering
a task group is in the fight of cpu resources.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
  kernel/sched/core.c  | 2 ++
  kernel/sched/fair.c  | 4 ++++
  kernel/sched/sched.h | 1 +
  3 files changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8fac..ac27b8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6787,6 +6787,8 @@ static int cpu_cfs_stat_show(struct seq_file *sf, 
void *v)
  	seq_printf(sf, "nr_periods %d\n", cfs_b->nr_periods);
  	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
  	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
+	if (schedstat_enabled())
+		seq_printf(sf, "wait_sum %llu\n", tg->wait_sum);

  	return 0;
  }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1866e64..ef82ceb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -862,6 +862,7 @@ static void update_curr_fair(struct rq *rq)
  static inline void
  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
  {
+	struct task_group *tg;
  	struct task_struct *p;
  	u64 delta;

@@ -882,6 +883,9 @@ static void update_curr_fair(struct rq *rq)
  			return;
  		}
  		trace_sched_stat_wait(p, delta);
+	} else {
+		tg = group_cfs_rq(se)->tg;
+		__schedstat_add(tg->wait_sum, delta);
  	}

  	__schedstat_set(se->statistics.wait_max,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6601baf..bb9b4fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -358,6 +358,7 @@ struct task_group {
  	/* runqueue "owned" by this group on each CPU */
  	struct cfs_rq		**cfs_rq;
  	unsigned long		shares;
+	u64			wait_sum;

  #ifdef	CONFIG_SMP
  	/*
-- 
1.8.3.1

