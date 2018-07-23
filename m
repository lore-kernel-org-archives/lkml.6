Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9621920856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9621920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbeGWOdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:33:04 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36443 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388083AbeGWOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:33:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T5AWNMp_1532352703;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0T5AWNMp_1532352703)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Jul 2018 21:31:44 +0800
Subject: [PATCH v3] tg: show the sum wait time of an task group
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <5c4c978d-e8fb-4bcb-b942-3c6d3dcfc13e@linux.alibaba.com>
 <b9e74571-87d0-ef27-3f14-ebd21d72ee15@linux.alibaba.com>
 <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
Message-ID: <336c292e-be0a-f03d-d992-9f55b969ed12@linux.alibaba.com>
Date:   Mon, 23 Jul 2018 21:31:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ff7dae3b-e5f9-7157-1caa-ff02c6b23dc1@linux.alibaba.com>
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

Monitoring the wait time of each process or sched_debug could cost
too much, and there is no good way to accurately represent the
conflict with these info, we need the wait time on group dimension.

Thus we introduced group's wait_sum represent the conflict between
task groups, which is simply sum the wait time of group's cfs_rq.

The 'cpu.stat' is modified to show the statistic, like:

   nr_periods 0
   nr_throttled 0
   throttled_time 0
   wait_sum 2035098795584

Now we can monitor the changing on wait_sum to tell how suffering
a task group is in the fight of cpu resources.

For example:
   (wait_sum - last_wait_sum) * 100 / (nr_cpu * period_ns) == X%

means the task group paid X percentage of period on waiting
for the cpu.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---

Since v2:
   Declare variables inside branch (From Peter).


  kernel/sched/core.c | 9 +++++++++
  1 file changed, 9 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8fac..2a7bb7c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6788,6 +6788,15 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
  	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
  	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);

+	if (schedstat_enabled() && tg != &root_task_group) {
+		int i;
+		u64 ws = 0;
+
+		for_each_possible_cpu(i)
+			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+		seq_printf(sf, "wait_sum %llu\n", ws);
+	}
+
  	return 0;
  }
  #endif /* CONFIG_CFS_BANDWIDTH */
-- 
1.8.3.1

