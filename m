Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12114C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BD02077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BD02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeICViu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeICViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:50 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BF7FD13;
        Mon,  3 Sep 2018 17:17:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, zhong.weidong@zte.com.cn,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 049/165] sched/rt: Restore rt_runtime after disabling RT_RUNTIME_SHARE
Date:   Mon,  3 Sep 2018 18:55:35 +0200
Message-Id: <20180903165657.584723037@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hailong Liu <liu.hailong6@zte.com.cn>

[ Upstream commit f3d133ee0a17d5694c6f21873eec9863e11fa423 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/rt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -837,6 +837,8 @@ static int do_sched_rt_period_timer(stru
 		 * can be time-consuming. Try to avoid it when possible.
 		 */
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
+		if (!sched_feat(RT_RUNTIME_SHARE) && rt_rq->rt_runtime != RUNTIME_INF)
+			rt_rq->rt_runtime = rt_b->rt_runtime;
 		skip = !rt_rq->rt_time && !rt_rq->rt_nr_running;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		if (skip)


