Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DC9C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9C920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9C920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeGYPeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:34:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:34:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEMBPY400230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:22:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEMBqb400227;
        Wed, 25 Jul 2018 07:22:11 -0700
Date:   Wed, 25 Jul 2018 07:22:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hailong Liu <tipbot@zytor.com>
Message-ID: <tip-f3d133ee0a17d5694c6f21873eec9863e11fa423@git.kernel.org>
Cc:     liu.hailong6@zte.com.cn, peterz@infradead.org,
        jiang.biao2@zte.com.cn, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, jiang.biao2@zte.com.cn,
          hpa@zytor.com, tglx@linutronix.de, liu.hailong6@zte.com.cn,
          peterz@infradead.org
In-Reply-To: <1531874815-39357-1-git-send-email-liu.hailong6@zte.com.cn>
References: <1531874815-39357-1-git-send-email-liu.hailong6@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/rt: Restore rt_runtime after disabling
 RT_RUNTIME_SHARE
Git-Commit-ID: f3d133ee0a17d5694c6f21873eec9863e11fa423
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

Commit-ID:  f3d133ee0a17d5694c6f21873eec9863e11fa423
Gitweb:     https://git.kernel.org/tip/f3d133ee0a17d5694c6f21873eec9863e11fa423
Author:     Hailong Liu <liu.hailong6@zte.com.cn>
AuthorDate: Wed, 18 Jul 2018 08:46:55 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:29:08 +0200

sched/rt: Restore rt_runtime after disabling RT_RUNTIME_SHARE

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/1531874815-39357-1-git-send-email-liu.hailong6@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 572567078b60..eaaec8364f96 100644
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
