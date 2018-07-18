Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA5ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A5C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A5C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGRBjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:39:37 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:18860 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731096AbeGRBjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:39:36 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2018 21:39:36 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 397D620B8D3E534455A1;
        Wed, 18 Jul 2018 08:48:15 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6I0mAt0020984;
        Wed, 18 Jul 2018 08:48:10 +0800 (GMT-8)
        (envelope-from liu.hailong6@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071808481435-765318 ;
          Wed, 18 Jul 2018 08:48:14 +0800 
From:   Hailong Liu <liu.hailong6@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] sched/rt: restore rt_runtime after disabling RT_RUNTIME_SHARE
Date:   Wed, 18 Jul 2018 08:46:55 +0800
Message-Id: <1531874815-39357-1-git-send-email-liu.hailong6@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-18 08:48:14,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-18 08:48:02,
        Serialize complete at 2018-07-18 08:48:02
X-MAIL: mse01.zte.com.cn w6I0mAt0020984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_RT_RUNTIME_SHARE feature is used to prevent a CPU borrow enough
runtime with a spin-rt-task.

However, if RT_RUNTIME_SHARE feature is enabled and rt_rq has borrowd
enough rt_runtime at the beginning, rt_runtime can't be restored to
its initial bandwidth rt_runtime after we disable RT_RUNTIME_SHARE.

E.g. on my PC with 4 cores, procedure to reproduce:
1) Make sure  RT_RUNTIME_SHARE is enabled
 cat /sys/kernel/debug/sched_features
  GENTLE_FAIR_SLEEPERS START_DEBIT NO_NEXT_BUDDY LAST_BUDDY
  CACHE_HOT_BUDDY WAKEUP_PREEMPTION NO_HRTICK NO_DOUBLE_TICK
  LB_BIAS NONTASK_CAPACITY TTWU_QUEUE NO_SIS_AVG_CPU SIS_PROP
  NO_WARN_DOUBLE_CLOCK RT_PUSH_IPI RT_RUNTIME_SHARE NO_LB_MIN
  ATTACH_AGE_LOAD WA_IDLE WA_WEIGHT WA_BIAS
2) Start a spin-rt-task
 ./loop_rr &
3) set affinity to the last cpu
 taskset -p 8 $pid_of_loop_rr
4) Observe that last cpu have borrowed enough runtime.
 cat /proc/sched_debug | grep rt_runtime
  .rt_runtime                    : 950.000000
  .rt_runtime                    : 900.000000
  .rt_runtime                    : 950.000000
  .rt_runtime                    : 1000.000000
5) Disable RT_RUNTIME_SHARE
 echo NO_RT_RUNTIME_SHARE > /sys/kernel/debug/sched_features
6) Observe that rt_runtime can not been restored
 cat /proc/sched_debug | grep rt_runtime
  .rt_runtime                    : 950.000000
  .rt_runtime                    : 900.000000
  .rt_runtime                    : 950.000000
  .rt_runtime                    : 1000.000000

This patch help to restore rt_runtime after we disable 
RT_RUNTIME_SHARE.
 
Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5725670..eaaec83 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -836,6 +836,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		 * can be time-consuming. Try to avoid it when possible.
 		 */
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
+		if (!sched_feat(RT_RUNTIME_SHARE) && rt_rq->rt_runtime != RUNTIME_INF)
+			rt_rq->rt_runtime = rt_b->rt_runtime;
 		skip = !rt_rq->rt_time && !rt_rq->rt_nr_running;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		if (skip)
-- 
2.7.4

